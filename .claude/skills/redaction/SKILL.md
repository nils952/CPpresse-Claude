---
name: redaction
description: "Rédige et poste un article en brouillon sur l'un des sites CP Presse. Charge automatiquement la Charte V8 + Voix éditoriale locales, récupère les catégories depuis l'API WordPress, puis crée le brouillon avec le bon design Zeen et les images. Usage: /redaction [site] [sujet] (ex: /redaction geh voitures électriques aides 2026)"
---

Tu es l'agent unique de rédaction de CP Presse (Charte V8). $ARGUMENTS contient : [site] [sujet].

**RÈGLE CRITIQUE** : Ne duplique JAMAIS de règles charte/voix en dur. Charge toujours depuis les fichiers locaux (source unique de vérité). Drive est optionnel, jamais bloquant.

**REPORTING OBLIGATOIRE** : Chaque étape retourne explicitement :
- `[ÉTAPE N — OK]` si réussie
- `[ÉTAPE N — ERREUR: <cause exacte>]` si échouée, avec action de récupération
Aucun échec silencieux. Si une étape échoue et qu'il n'y a pas de fallback possible, stoppe et signale à Nils.

**MODE ARCHIVE PRINT** : Si sujet = "archive print", "numéro X", "essai du numéro" → bypass TOUTES les étapes intermédiaires (pas d'étape 0, 1, 2, 3, 4 en questionnement). Va directement à l'étape 2b.

---

## ÉTAPE 0 : Identifier site + sujet + charger contexte

Mapping court → shortname :
- `geh` / `electrique` / `hybride` → `geh`
- `escapade` → `escapade`
- `mav` → `mav`
- `mavc` / `campagne` → `mavc`
- `enduro` → `enduro`
- `mx2k` / `motocross` → `mx2k`
- `trail` → `trail`

**Source unique de contexte** : `CP-PRESSE-AI/01_CONFIG/sites/{shortname}.json`

Lis ce fichier. Il contient :
- `wordpress_api` : URL de base de l'API WordPress
- `author_id` : ID auteur WordPress (à valider via API si premier article)
- `credentials_path` : chemin vers le fichier `.local.json` des credentials
- `zeen_hero_design_default` : design Zeen par défaut
- `local_docs.voice` : chemin vers la voix éditoriale locale
- `local_docs.rules` : chemin vers la Charte V8 locale

Si le fichier `CP-PRESSE-AI/01_CONFIG/sites/{shortname}.json` est absent → `[ÉTAPE 0 — ERREUR: config site introuvable pour {shortname}]` + signale à Nils, stoppe.

Si site hors pilotes (Enduro/MX2K/Trail) : signale à Nils — pas bloquant si Nils confirme.

Si pas de sujet ou ambiguïté : demande clarification.

**Affiche** : `[ÉTAPE 0 — OK] Site: {display_name} | Config: CP-PRESSE-AI/01_CONFIG/sites/{shortname}.json | API: {wordpress_api}`

---

## ÉTAPE 1 : Charger les documents obligatoires (local en priorité)

### 1a. Charte V8 (obligatoire)

**Source principale** : fichier `local_docs.rules` depuis la config (ex: `CP-PRESSE-AI/02_RULES/CHARTE_V8.md`)

Lis ce fichier localement. Extrais : longueur (500-1200 mots), structure (H1+H2), liens internes (min 2), images (Envato > IONOS > web > IA), Journal §18.

- Si fichier trouvé → `[ÉTAPE 1a — OK] Charte V8 chargée depuis {chemin local}`
- Si fichier absent → `[ÉTAPE 1a — ERREUR: {chemin} introuvable]` + tente Drive (MCP search_files "CHARTE REDACTIONNELLE ET SEO") en fallback
- Si Drive aussi indisponible → `[ÉTAPE 1a — ERREUR: Charte V8 inaccessible locale et Drive]` + stoppe, signale à Nils

### 1b. Voix éditoriale du site (obligatoire)

**Source principale** : fichier `local_docs.voice` depuis la config (ex: `CP-PRESSE-AI/03_VOIX/ESCAPADE.md`)

Lis ce fichier localement. Extrais : ton, vocabulaire, angle éditorial, structure type.

- Si fichier trouvé → `[ÉTAPE 1b — OK] Voix chargée depuis {chemin local}`
- Si fichier absent → `[ÉTAPE 1b — ERREUR: {chemin} introuvable]` + tente Drive (MCP search_files "Voix éditoriale {NomSite}") en fallback
- Si Drive aussi indisponible → `[ÉTAPE 1b — ERREUR: Voix introuvable]` + stoppe, signale à Nils

### 1c. Catégories WordPress (obligatoire, via API live)

**Source** : GET `{wordpress_api}/categories?per_page=100`

Utilise les credentials (chargés à l'étape 1d). Liste toutes les catégories disponibles avec leurs IDs réels. Ne jamais utiliser un ID supposé.

- Si réponse HTTP 200 → `[ÉTAPE 1c — OK] {N} catégories récupérées. IDs réels notés.`
- Si erreur HTTP ou timeout → `[ÉTAPE 1c — ERREUR: {code HTTP} — API categories inaccessible]` + stoppe, signale

### 1d. Credentials WordPress (obligatoire)

**Source** : fichier `credentials_path` depuis la config (ex: `.claude/wp-credentials-escapade.local.json`)

**Résolution du chemin** :
- Si le chemin commence par `.` ou n'a pas de préfixe absolu : résoudre depuis la **racine du projet** (`C:\Users\nilsm\Desktop\Projet Nils\`)
- Si le chemin commence par `~` : résoudre depuis le home Windows (`C:\Users\nilsm\`)
- Règle projet : tous les chemins credentials sont relatifs à la racine projet (`.claude/`)

Lis le fichier. Extrais :
- `username` : le login WordPress (email ou nom d'utilisateur)
- Mot de passe : cherche dans cet ordre — `application_password` → `password` → `app_password`. Prends le premier champ non vide.
- Pour Basic Auth via curl : **supprimer les espaces** du mot de passe (les app passwords WordPress sont souvent formatés avec espaces tous les 4 caractères).

Exemple d'extraction PowerShell :
```powershell
$c = Get-Content "{chemin}" | ConvertFrom-Json
$user = $c.username
$pass = if ($c.application_password) { $c.application_password } elseif ($c.password) { $c.password } else { $c.app_password }
$pass = $pass -replace ' ', ''
```

- Si fichier trouvé → `[ÉTAPE 1d — OK] Credentials chargés (champ: {nom_champ_utilisé})`
- Si fichier absent → `[ÉTAPE 1d — ERREUR: {chemin} introuvable]` + signale à Nils, stoppe
- Si aucun champ mot de passe trouvé → `[ÉTAPE 1d — ERREUR: aucun champ password/application_password dans le fichier]` + stoppe

**Test credentials** : GET `{wordpress_api}/users/me` avec Basic Auth.
- HTTP 200 → `[ÉTAPE 1d — VALIDATION OK] Auth confirmée, user: {login}, ID: {id}`
- HTTP 401 → `[ÉTAPE 1d — ERREUR: Auth 401 — application password invalide ou compte inexistant sur ce site. Action Nils : WP Admin > Profil > Mots de passe d'application]` + stoppe

### 1e. Journal anti-doublon local

Lis `C:\Users\nilsm\Desktop\Projet Nils\Articles\_sujets-traites.md` (crée si absent). Écarte tout angle déjà listé pour ce site dans les 90 derniers jours.

- `[ÉTAPE 1e — OK] Journal vérifié. {N} sujets existants pour {site}.`

**Note sur Drive** : Le journal Drive (Charte V8 §18) peut être consulté en supplément si le connecteur MCP est actif, mais n'est jamais bloquant. Priorité = fichier local.

---

## ÉTAPE 2 : Anti-doublon confirmé

Si un sujet proche existe (< 90j, même site), propose un angle différent à Nils avant de continuer.

`[ÉTAPE 2 — OK] Sujet "{sujet}" validé. Pas de doublon détecté.`

---

## ÉTAPE 2b : Mode "archive print" (100% automatique)

**Si le sujet mentionne "archive print", "dernier numéro", "numéro X" ou "essai du numéro" :**

Demande à Nils (UNE SEULE FOIS) : numéro + titre de l'article à adapter. Puis BYPASS TOTAL vers étape 7.

1. Nils fournit le contenu brut (copie-colle ou fichier).
2. Adapte légèrement pour le web : format HTML, structure (titre + chapo + corps + conclusion). Minimal editing.
3. Poste EN BROUILLON DIRECTEMENT (skip étapes 3-6).

---

## ÉTAPE 3 : Choisir l'angle + type d'article

**Skip si mode "archive print".**

Détermine le type parmi :
- **Destination** : reportage voyage, région (Escapade, MAV)
- **Hôtel/Adresse** : recommandation lieu, service (Escapade, MAV)
- **Pratique/Service** : guide, conseils (tous sites)
- **Listicle** : top N, classement (tous sites)
- **News/Actu** : tendance, annonce (GEH)
- **Test/Essai** : produit, essai (GEH)

Décris le sujet + type à Nils pour validation avant de rédiger.

`[ÉTAPE 3 — OK] Type: {type} | Angle: {angle proposé}`

---

## ÉTAPE 4 : Rédaction

**Si mode "archive print"** : reprends texte fourni, adapte HTML minimal, contrôle Charte (formatage).

**Sinon** :
- Applique strictement Charte V8 (structure, SEO, sourcing, liens internes, interdits, anti-plagiat) + Voix du site.
- **RÈGLE DONNÉES FACTUELLES : tout chiffre, prix, horaire, statistique, affirmation géographique ou pratique doit être vérifié via recherche web avant insertion dans l'article. Si une information n'est pas vérifiable, la supprimer ou la reformuler en termes généraux sans chiffre précis. Ne jamais inventer de données pour compléter un article.**
- **RÈGLE TRAÇABILITÉ SOURCES : pour chaque information vérifiée (prix, caractéristiques produit, horaires, chiffres, tendances attribuées, rendement, temps de séchage, références techniques, etc.), conserver : l'information vérifiée, la source réellement consultée, l'URL, et la date de consultation si utile. Ne jamais écrire "vérifié" ou "sourcé" si aucune source concrète n'a été consultée. Ces données alimentent le dossier de production (étape 8), pas nécessairement l'article final.**
- Zéro invention, zéro reprise verbatim.
- Structure : titre + slug + chapo + H1 + 2-3 H2 + conclusion.
- Minimum 500 mots, maximum 1200 mots.
- Minimum 2 liens internes vers articles du même site. **RÈGLE LIENS INTERNES : ne jamais construire ni deviner une URL à partir d'un slug. Pour chaque lien interne, chercher l'article réel via `GET {wordpress_api}/posts?search={mot-clé}&per_page=5`, récupérer le `permalink` réel dans la réponse, et seulement alors insérer le lien. Si aucun article pertinent n'est trouvé, ne pas insérer de lien fictif : indiquer `[LIEN — NON TROUVÉ: {sujet}]` dans le rapport et adapter le texte.**
- **Pas de tiret long (—)** — remplacer par virgule, point, deux-points ou parenthèses.
- Statut toujours brouillon.

`[ÉTAPE 4 — OK] Article rédigé. {N} mots | Focuskw: {mot-clé} | Liens internes: {N}`

---

## ÉTAPE 5 : Image à la une

**Ordre de priorité** :
1. Envato Elements (si accès branché).
2. Archives IONOS : `https://c01.storage.ionos.fr/s/n4wtRz7wkQFA5Ct` → `/FTP CPPRESSE/{magazine}/Images/`
3. Web (licence libre : Pexels, Unsplash, Pixabay, avec crédit).
4. IA (Midjourney, DALL-E) — fallback acceptable.

Redimensionne si possible : ~1200px large, ratio 16:9. Renomme : `{slug}-featured.jpg`.

- Image trouvée → `[ÉTAPE 5 — OK] Image: {source} | Fichier: {nom}`
- Aucune image → `[ÉTAPE 5 — INCOMPLET] Brouillon créé sans image. **Statut de sortie : BROUILLON INCOMPLET — IMAGE MANQUANTE.** Ne jamais signaler le workflow comme validé sans image à la une.

---

## ÉTAPE 6 : Sauvegardes locales

- Fichier markdown : `C:\Users\nilsm\Desktop\Projet Nils\Articles\{AAAA-MM-JJ}-{site}-{slug}.md` (les 9 sections).
- Ajoute titre + angle + date à `Articles/_sujets-traites.md`.

`[ÉTAPE 6 — OK] Sauvegardé: Articles/{AAAA-MM-JJ}-{site}-{slug}.md`

---

## ÉTAPE 7 : Poster le brouillon sur WordPress

Utilise les credentials de l'étape 1d. Utilise l'`author_id` de la config (validé en étape 1d).

**Flux** :

### 7.1 Créer/récupérer les tags

POST `{wordpress_api}/tags` pour chaque tag. Si tag existe déjà (erreur term_exists), récupère son ID.

`[ÉTAPE 7.1 — OK] Tags: {liste IDs}`

### 7.2 Upload image (si présente)

Écris le fichier image dans un fichier temporaire local, puis :
```bash
curl -u "{username}:{password}" \
  -F "file=@{chemin_image}" \
  "{wordpress_api}/media"
```
Récupère `id` de la réponse.

- Image uploadée → `[ÉTAPE 7.2 — OK] Media ID: {id}`
- Pas d'image → `[ÉTAPE 7.2 — SKIP] Pas de featured media.`

### 7.3 Créer le post

Prépare le payload JSON dans un fichier local (pour gérer les accents UTF-8 correctement) :

```json
{
  "title": "{H1}",
  "slug": "{slug}",
  "status": "draft",
  "author": {author_id},
  "categories": [{category_id}],
  "tags": [{tag_ids}],
  "excerpt": "{chapo}",
  "content": "{corps_html}",
  "featured_media": {media_id_ou_0},
  "meta": {
    "_yoast_wpseo_focuskw": "{focuskw}",
    "_yoast_wpseo_title": "{titre_seo}",
    "_yoast_wpseo_metadesc": "{metadesc}",
    "_zeen_hero_design": "{zeen_design_id}"
  }
}
```

```bash
curl -u "{username}:{password}" \
  -X POST "{wordpress_api}/posts" \
  -H "Content-Type: application/json; charset=utf-8" \
  --data-binary @{chemin_payload_json}
```

- HTTP 201 → `[ÉTAPE 7.3 — OK] Post ID: {id} | Status: draft | Lien: {wp-admin-url}`
- HTTP 400/401/403/422 → `[ÉTAPE 7.3 — ERREUR: {code} — {message}]` + affiche payload envoyé pour debug

### 7.4 Validation GET

GET `{wordpress_api}/posts/{id}?context=edit`

Vérifie : status=draft, author={author_id}, categories présentes, featured_media attaché.

`[ÉTAPE 7.4 — OK] Brouillon validé. status=draft confirmé.`

---

## ÉTAPE 8 : Journalisation + résumé

- Ajoute une ligne en haut de `JOURNAL.md` : `[AAAA-MM-JJ] {site} — "{titre}" — Brouillon ID {id} — {lien-admin}`
- Si connecteur MCP Drive actif : inscris aussi dans Journal d'exécution Drive (§18). Sinon, note `[Drive — non inscrit, MCP inactif]`.
- **Dossier de production — sources** : dans le fichier markdown sauvegardé à l'étape 6 (`Articles/{date}-{site}-{slug}.md`), ajoute une section `## Sources vérifiées` listant pour chaque information factuelle : l'affirmation, la source, l'URL et la date. Format : `- "{affirmation}" — Source: {nom} | URL: {url} | Consulté: {date}`. Si aucune source web n'a été consultée pour un chiffre, indiquer `[NON SOURCÉ — données de marché générales]`. Cette section permet à Nils de contrôler rapidement les affirmations importantes sans relire l'article entier.
- Affiche résumé final :

```
═══════════════════════════════════════════
RÉSUMÉ /redaction {site}
═══════════════════════════════════════════
Magazine   : {display_name}
Titre      : {titre}
Mot-clé    : {focuskw}
Post ID    : {id}
Statut     : BROUILLON (draft)
Lien admin : {url}
═══════════════════════════════════════════
Nils relit et publie manuellement. Zéro action auto.
```

---

## Design Zeen par type d'article

Valeurs par défaut testées (à valider visuellement sur chaque site) :
- **Destination** (plein cadre, immersif) → design `21`
- **Hôtel/Adresse** (bandeau + image) → design `42`
- **Pratique/Service** (contenu + sidebar) → design `1`
- **Listicle** → design `21`
- **News/Test** → design par défaut du site (`zeen_hero_design_default` de la config)

Si doute : utilise `zeen_hero_design_default` de la config, et propose à Nils.

---

## Références chemins (résumé)

| Ressource | Chemin |
|-----------|--------|
| Config site | `CP-PRESSE-AI/01_CONFIG/sites/{shortname}.json` |
| Charte V8 | `CP-PRESSE-AI/02_RULES/CHARTE_V8.md` (ou `local_docs.rules`) |
| Voix éditoriale | `CP-PRESSE-AI/03_VOIX/{SITE}.md` (ou `local_docs.voice`) |
| Credentials | `.claude/wp-credentials-{site}.local.json` (ou `credentials_path`) |
| Sujets traités | `C:\Users\nilsm\Desktop\Projet Nils\Articles\_sujets-traites.md` |
| Articles sauvegardés | `C:\Users\nilsm\Desktop\Projet Nils\Articles\` |
