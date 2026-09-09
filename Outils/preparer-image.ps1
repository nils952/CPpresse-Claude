<#
.SYNOPSIS
  Prépare une image (reçue par mail, communiqué de presse, banque d'images) pour
  upload WordPress : bonne résolution, bonne compression, poids raisonnable.

.DESCRIPTION
  Corrige le problème rencontré sur les gros visuels de communiqués de presse
  (ex: 1,6 Mo -> erreur 413 à l'upload) sans sacrifier la netteté :
    - Redimensionne en conservant les proportions, avec interpolation
      bicubique haute qualité (pas de plus-proche-voisin flou/crénelé)
    - Ne redimensionne QUE si l'image dépasse la largeur cible (jamais
      d'agrandissement -- un agrandissement ne fait qu'ajouter du flou,
      il faut une meilleure image source, pas un algorithme)
    - Ré-encode en JPEG qualité 85% (bon compromis netteté/poids, standard
      éditorial web)

.PARAMETER InPath
  Chemin de l'image source.
.PARAMETER OutPath
  Chemin de sortie (par défaut : <nom>-web.jpg à côté de la source).
.PARAMETER LargeurCible
  Largeur max en pixels. 1920 par défaut (confortable pour un hero plein cadre
  sur écran desktop standard, sans être inutilement lourd).
.PARAMETER Qualite
  Qualité JPEG 1-100. 85 par défaut.

.EXAMPLE
  ./preparer-image.ps1 -InPath "C:\...\communique-eleveit.jpg"
  ./preparer-image.ps1 -InPath photo.jpg -LargeurCible 2400 -Qualite 88
#>

param(
    [Parameter(Mandatory=$true)] [string]$InPath,
    [string]$OutPath,
    [int]$LargeurCible = 1920,
    [int]$Qualite = 85
)

Add-Type -AssemblyName System.Drawing

if (-not (Test-Path $InPath)) {
    Write-Error "Fichier introuvable : $InPath"
    exit 1
}

if (-not $OutPath) {
    $dir = Split-Path -Parent (Resolve-Path $InPath)
    $name = [System.IO.Path]::GetFileNameWithoutExtension($InPath)
    $OutPath = Join-Path $dir "$name-web.jpg"
}

$img = [System.Drawing.Image]::FromFile((Resolve-Path $InPath))
$origW = $img.Width
$origH = $img.Height

if ($origW -le $LargeurCible) {
    Write-Host "Image déjà à $origW`px de large (<= $LargeurCible) : pas de redimensionnement, juste ré-encodage à qualité $Qualite%."
    $newW = $origW
    $newH = $origH
} else {
    $ratio = $LargeurCible / $origW
    $newW = $LargeurCible
    $newH = [int]([Math]::Round($origH * $ratio))
}

$bitmap = New-Object System.Drawing.Bitmap($newW, $newH)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# Réglages qualité maximale -- c'est ça qui évite l'effet "éclaté"/crénelé
# d'un redimensionnement fait avec les réglages par défaut de GDI+.
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

$graphics.DrawImage($img, 0, 0, $newW, $newH)

# Encodage JPEG avec contrôle explicite de la qualité
$jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [int64]$Qualite)

$bitmap.Save($OutPath, $jpegCodec, $encParams)

$graphics.Dispose()
$bitmap.Dispose()
$img.Dispose()

$origSize = (Get-Item $InPath).Length
$newSize = (Get-Item $OutPath).Length

Write-Host ""
Write-Host "Source  : ${origW}x${origH}px, $([Math]::Round($origSize/1KB))Ko"
Write-Host "Sortie  : ${newW}x${newH}px, $([Math]::Round($newSize/1KB))Ko  -> $OutPath"
if ($newW -lt 1200) {
    Write-Warning "Largeur finale sous 1200px : trop petit pour un hero plein cadre. Il faut une meilleure image source, pas un redimensionnement plus poussé."
}
