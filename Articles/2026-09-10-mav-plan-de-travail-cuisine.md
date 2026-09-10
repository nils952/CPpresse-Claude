# Fiche de publication — MAV — Plan de travail cuisine
**Date** : 10/09/2026 | **Statut** : ⚠️ Non posté — 401 Unauthorized sur l'API MAV

---

## ⚠️ BLOCAGE TECHNIQUE
L'authentification Basic Auth échoue sur https://maisonsavivre-mag.fr/wp-json/wp/v2/ avec les credentials `nils+claude@cppresse.fr`.
**À corriger par Nils** : Réinitialiser le mot de passe d'application dans WP Admin → Utilisateurs → `nils+claude@cppresse.fr` → Mots de passe d'application.

---

## 1. Champs WordPress

- **Titre H1** : Plan de travail cuisine : quel matériau choisir selon son budget ? (64 car. ✓)
- **Slug** : plan-de-travail-cuisine-quel-materiau-choisir
- **Catégories** : Cuisine (ID 104) + Intérieur (ID 160)
- **Tags** : (à créer si besoin)
- **Auteur** : ID 13
- **Statut** : draft
- **Design Zeen** : 42 (défaut MAV)

---

## 2. Champs Yoast

- **focuskw** : plan de travail cuisine
- **title SEO** : Plan de travail cuisine : quel matériau choisir ? (52 car.)
- **metadesc** : Stratifié, quartz, bois, céramique ou béton ciré : quel plan de travail cuisine choisir selon votre budget et votre usage ? Le guide complet avec les prix. (154 car.)

---

## 3. Image à la une

Pas d'image — à ajouter manuellement depuis :
- Envato Elements (compte CP Presse)
- Ou Wikimedia Commons (chercher "kitchen countertop" ou "cuisine plan de travail" CC0/CC BY)

---

## 4. Liens internes (dans le corps)

1. https://maisonsavivre-mag.fr/5-etapes-pour-amenager-une-cuisine-dans-un-couloir-meme-avec-peu-despace/ → "cuisine en couloir"
2. https://maisonsavivre-mag.fr/cuisine-ouverte-ou-fermee-le-match-2026/ → "le type de cuisine à préférer"

---

## 5. Corps HTML (complet dans scratchpad/post-mav-plan-de-travail.json)

**Chapô** : Le plan de travail subit couteaux, chaleur et éclaboussures au quotidien. Stratifié, quartz, bois ou céramique — chaque matériau a ses forces, ses limites et son prix. Voici les points essentiels avant de décider.

**Structure** :
- H2 : Stratifié et quartz : les deux valeurs sûres du marché
- H2 : Bois et céramique : caractère et durabilité dans la cuisine
- H2 : Inox et béton ciré : les options pour cuisines assumées
- H2 : Ce qu'il faut vérifier avant de commander

**Mots** : ~820 mots ✓ (dans la fourchette 700-1100)

---

## 6. Contrôle qualité Charte V8

- ✅ Pas de "très", "découvrez", "plongez", "en effet"
- ✅ Paragraphes ≤ 3 phrases, phrases ≤ 25 mots
- ✅ Prix indiqués pour chaque matériau
- ✅ 2 liens internes (articles existants vérifiés)
- ✅ Voix MAV : pratique, budget, actionnable — pas de vocabulaire MAVC
- ✅ Titre H1 : 64 car. ✓ | Metadesc : 154 car. ✓
- ✅ 4 H2
- ✅ Conclusion 2 phrases, pas de CTA
- ⚠️ Pas d'image (blocage auth MAV)

---

## 7. Sources

- Prix stratifié : standard marché France 2026 (Leroy Merlin, Ikea, Castorama)
- Prix quartz : standard marché France 2026
- Prix bois : standard marché France 2026
- Prix céramique/inox/béton : standard marché France 2026
- Liens internes : vérifiés via API publique MAV (wp-json, statut 200)

---

**⚠️ À POSTER DÈS AUTH FIXÉE** : JSON prêt dans scratchpad/post-mav-plan-de-travail.json
**Commande PowerShell** (une fois auth ok) :
```powershell
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
$creds = Get-Content ".claude/wp-credentials-mav.local.json" | ConvertFrom-Json
$bytes = [System.Text.Encoding]::UTF8.GetBytes("$($creds.username):$($creds.application_password)")
$auth = "Basic " + [Convert]::ToBase64String($bytes)
$body = [System.IO.File]::ReadAllBytes("scratchpad/post-mav-plan-de-travail.json")
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("Authorization", $auth)
$wc.Headers.Add("Content-Type", "application/json; charset=utf-8")
$resp = $wc.UploadData("https://maisonsavivre-mag.fr/wp-json/wp/v2/posts", "POST", $body)
[System.Text.Encoding]::UTF8.GetString($resp) | ConvertFrom-Json | Select-Object id, slug, link
```
