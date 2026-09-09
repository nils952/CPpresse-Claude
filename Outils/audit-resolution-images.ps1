<#
.SYNOPSIS
  Audit de la résolution des images à la une sur un site WordPress CP Presse.

.DESCRIPTION
  Parcourt tous les articles (publiés + brouillons) d'un site, récupère la largeur
  réelle de l'image à la une (media_details.width, l'image source uploadée, pas
  une taille générée par WordPress), et classe chaque article :
    - OK       : largeur >= $SeuilIdeal (1600 px par défaut) -> bon pour un hero plein écran
    - LIMITE   : entre $SeuilPlancher et $SeuilIdeal (1200-1600 px) -> correct pour la plupart
                 des designs mais pas pour un hero plein cadre
    - A_REMPLACER : < $SeuilPlancher (1200 px) -> visiblement flou/pixelisé si agrandi
    - SANS_IMAGE  : aucune image à la une définie

  Standards retenus (usage éditorial web classique, pas de norme officielle) :
    - 1600 px de large minimum pour une image "hero" en plein cadre (design Zeen
      plein écran / duo bandeau)
    - 1200 px = plancher absolu en dessous duquel l'agrandissement devient visible
    - Compression cible : JPEG qualité ~82-85%, ce qui donne un bon compromis
      netteté/poids pour le web (voir preparer-image.ps1)

.PARAMETER Site
  Domaine du site (ex: escapade-mag.fr). Doit correspondre à un fichier
  .claude/wp-credentials-<slug>.local.json quelque part si des identifiants sont
  nécessaires -- ce script utilise l'API REST publique (lecture seule des posts
  publiés) sauf si -Username/-AppPassword sont fournis pour inclure les brouillons.

.EXAMPLE
  ./audit-resolution-images.ps1 -Site escapade-mag.fr -Username "nils+claude@cppresse.fr" -AppPassword "xxxx xxxx xxxx xxxx" -OutFile ../audit-images-escapade.md
#>

param(
    [Parameter(Mandatory=$true)] [string]$Site,
    [string]$Username,
    [string]$AppPassword,
    [int]$SeuilIdeal = 1600,
    [int]$SeuilPlancher = 1200,
    [string]$OutFile = "audit-resolution-images-$($Site).md"
)

$ErrorActionPreference = "Stop"

$headers = @{}
$statusFilter = "publish"
if ($Username -and $AppPassword) {
    $pair = "$($Username):$($AppPassword)"
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($pair)
    $headers["Authorization"] = "Basic " + [System.Convert]::ToBase64String($bytes)
    $statusFilter = "publish,draft,pending,future"
}

$base = "https://$Site/wp-json/wp/v2"

function Invoke-WP($url) {
    return Invoke-RestMethod -UseBasicParsing -Uri $url -Headers $headers -Method Get
}

Write-Host "Récupération de la liste des articles sur $Site ..."

# 1) Récupérer tous les posts (id, title, featured_media, status, link)
$allPosts = @()
$page = 1
do {
    $url = "$base/posts?per_page=100&page=$page&status=$statusFilter&_fields=id,title,featured_media,status,link"
    try {
        $resp = Invoke-WebRequest -UseBasicParsing -Uri $url -Headers $headers -Method Get
    } catch {
        break
    }
    $posts = $resp.Content | ConvertFrom-Json
    $allPosts += $posts
    $totalPages = [int]($resp.Headers["X-WP-TotalPages"] | Select-Object -First 1)
    $page++
} while ($page -le $totalPages)

Write-Host "  $($allPosts.Count) articles récupérés."

# 2) Récupérer les media_details des images à la une utilisées (par lots de 100)
$mediaIds = $allPosts | Where-Object { $_.featured_media -gt 0 } | ForEach-Object { $_.featured_media } | Select-Object -Unique
Write-Host "Récupération de la résolution de $($mediaIds.Count) images ..."

$mediaWidth = @{}
for ($i = 0; $i -lt $mediaIds.Count; $i += 100) {
    $batch = $mediaIds[$i..([Math]::Min($i+99, $mediaIds.Count-1))]
    $idsParam = ($batch -join ",")
    $url = "$base/media?include=$idsParam&per_page=100&_fields=id,media_details,source_url"
    try {
        $mediaResp = Invoke-WP $url
    } catch {
        continue
    }
    foreach ($m in $mediaResp) {
        $w = $null
        if ($m.media_details -and $m.media_details.width) { $w = $m.media_details.width }
        $mediaWidth[[string]$m.id] = [PSCustomObject]@{ width = $w; url = $m.source_url }
    }
}

# 3) Classer chaque article
$results = foreach ($p in $allPosts) {
    $title = $p.title.rendered -replace '&amp;','&' -replace '&#8217;',"'"
    if ($p.featured_media -gt 0 -and $mediaWidth.ContainsKey([string]$p.featured_media)) {
        $info = $mediaWidth[[string]$p.featured_media]
        $w = $info.width
        if (-not $w) {
            $classe = "INCONNU"
        } elseif ($w -ge $SeuilIdeal) {
            $classe = "OK"
        } elseif ($w -ge $SeuilPlancher) {
            $classe = "LIMITE"
        } else {
            $classe = "A_REMPLACER"
        }
        [PSCustomObject]@{
            id = $p.id; titre = $title; statut = $p.status; lien = $p.link
            largeur = $w; classe = $classe; image = $info.url
        }
    } else {
        [PSCustomObject]@{
            id = $p.id; titre = $title; statut = $p.status; lien = $p.link
            largeur = $null; classe = "SANS_IMAGE"; image = $null
        }
    }
}

# 4) Rapport
$nbOk = ($results | Where-Object { $_.classe -eq "OK" }).Count
$nbLimite = ($results | Where-Object { $_.classe -eq "LIMITE" }).Count
$nbRemplacer = ($results | Where-Object { $_.classe -eq "A_REMPLACER" }).Count
$nbSans = ($results | Where-Object { $_.classe -eq "SANS_IMAGE" }).Count

$md = @()
$md += "# Audit résolution images à la une - $Site"
$md += ""
$md += "Standards : hero plein cadre >= ${SeuilIdeal}px de large (OK) ; ${SeuilPlancher}-${SeuilIdeal}px correct pour designs non plein-cadre (LIMITE) ; < ${SeuilPlancher}px flou si agrandi (A_REMPLACER)."
$md += ""
$md += "**Total articles** : $($allPosts.Count) - OK: $nbOk / LIMITE: $nbLimite / A_REMPLACER: $nbRemplacer / SANS_IMAGE: $nbSans"
$md += ""
$md += "## A remplacer en priorité (image trop petite, effet flou/pixelisé si utilisée en hero)"
$md += ""
foreach ($r in ($results | Where-Object { $_.classe -eq "A_REMPLACER" } | Sort-Object largeur)) {
    $md += "- [$($r.titre)]($($r.lien)) - $($r.largeur)px - $($r.image)"
}
$md += ""
$md += "## Sans image à la une"
$md += ""
foreach ($r in ($results | Where-Object { $_.classe -eq "SANS_IMAGE" })) {
    $md += "- [$($r.titre)]($($r.lien)) - statut: $($r.statut)"
}
$md += ""
$md += "## Limite (correct hors hero plein cadre)"
$md += ""
foreach ($r in ($results | Where-Object { $_.classe -eq "LIMITE" } | Sort-Object largeur)) {
    $md += "- [$($r.titre)]($($r.lien)) - $($r.largeur)px"
}

$md -join "`n" | Out-File -FilePath $OutFile -Encoding utf8
Write-Host ""
Write-Host "Rapport écrit : $OutFile"
Write-Host "OK: $nbOk | LIMITE: $nbLimite | A_REMPLACER: $nbRemplacer | SANS_IMAGE: $nbSans"
