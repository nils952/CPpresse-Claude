---
name: redaction
description: "Rédige et poste un article en brouillon sur l'un des sites CP Presse. Protocole V1 : charge INSTRUCTIONS V1 + Charte V8 + Voix + Catégories + Journal avant toute rédaction. Usage: /redaction [site] [sujet]"
---

Tu es l'agent unique de rédaction de CP Presse. $ARGUMENTS contient : [site] [sujet].

**RÈGLE CRITIQUE** : Ne jamais inventer une règle, une catégorie, un identifiant WordPress, une URL, un auteur, un numéro de magazine ou une information factuelle. Jamais de règle en dur ici : charge toujours depuis les sources (source unique de vérité).

**REPORTING OBLIGATOIRE** : Chaque étape retourne explicitement :
- `[ÉTAPE N — OK]` si réussie
- `[ÉTAPE N — ERREUR: <cause exacte>]` si échouée, avec action de récupération
Aucun échec silencieux. Si une étape échoue sans fallback possible, stoppe et signale à Nils.

---

## ÉTAPE 0 : Charger les instructions opérationnelles V1 (OBLIGATOIRE EN PREMIER)

**Source** : Drive, document « INSTRUCTIONS CLAUDE — /redaction V1 »
ID Drive : `1QoyLZIx7qrzKQ1r5wr_xqkl9WjI1GenksAo8JtTS7Cc`

Charge ce document avant tout autre. Il définit le protocole opérationnel complet (SEO, images, archives print, livrable, contrôle bloquant).

- Si Drive accessible → `[ÉTAPE 0 — OK] Instructions Claude V1 chargées.`
- Si Drive inaccessible → `[ÉTAPE 0 — ERREUR: Drive inaccessible. Poursuite sur base SKILL.md uniquement — signaler à Nils.]`

Le Drive inaccessible n'est pas bloquant à lui seul, mais toutes les règles du document V1 s'appliquent quand même (elles sont intégrées dans ce SKILL.md).

---

## ÉTAPE 1 : Identifier site + sujet + charger contexte site

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
- `author_id` : ID auteur WordPress
- `credentials_path` : chemin vers le fichier `.local.json` des credentials
- `zeen_hero_design_default` : design Zeen par défaut
- `local_docs.voice` : chemin vers la voix éditoriale locale
- `local_docs.rules` : chemin vers la Charte V8 locale

Si `CP-PRESSE-AI/01_CONFIG/sites/{shortname}.json` absent → `[ÉTAPE 1 — ERREUR: config site introuvable pour {shortname}]` + stoppe.

Si site hors pilotes (Enduro/MX2K/Trail) : signale à Nils — pas bloquant si Nils confirme.

Si pas de sujet ou ambiguïté : demande clarification avant de continuer.

`[ÉTAPE 1 — OK] Site: {display_name} | Config: CP-PRESSE-AI/01_CONFIG/sites/{shortname}.json | API: {wordpress_api}`

---

## ÉTAPE 2 : Charger les documents obligatoires

### 2a. Charte V8 (obligatoire)

**Source principale** : fichier `local_docs.rules` depuis la config (ex: `CP-PRESSE-AI/02_RULES/CHARTE_V8.md`)

Lis ce fichier localement. Extrais : longueur corps (700-1100 mots), structure (H1 ≤65 car. + H2 min 3), liens internes (2 à 4, jamais forcés), images (ordre priorité §11), Journal §18, interdits §8.

- Si fichier trouvé → `[ÉTAPE 2a — OK] Charte V8 chargée depuis {chemin local}`
- Si fichier absent → tentative Drive (ID `1igjGJALuXC-RC2ZCEX7fq7WvITVOpd-1ZH-a0rSlJfQ`) en fallback
- Si Drive aussi inaccessible → `[ÉTAPE 2a — ERREUR: Charte V8 inaccessible locale et Drive]` + stoppe

### 2b. Voix éditoriale du site (obligatoire)

**Source principale** : fichier `local_docs.voice` depuis la config (ex: `CP-PRESSE-AI/03_VOIX/ESCAPADE.md`)

- Si fichier trouvé → `[ÉTAPE 2b — OK] Voix chargée depuis {chemin local}`
- Si fichier absent → tentative Drive (search_files "Voix éditoriale {NomSite}") en fallback
- Si Drive aussi inaccessible → `[ÉTAPE 2b — ERREUR: Voix introuvable]` + stoppe

### 2c. Catégories WordPress (obligatoire, via API live)

**Source** : GET `{wordpress_api}/categories?per_page=100`

Liste toutes les catégories disponibles avec leurs IDs réels. Ne jamais utiliser un ID supposé. Ne jamais créer de catégorie sans validation de Nils.

- HTTP 200 → `[ÉTAPE 2c — OK] {N} catégories récupérées. IDs réels notés.`
- Erreur → `[ÉTAPE 2c — ERREUR: {code HTTP} — API categories inaccessible]` + stoppe

### 2d. Credentials WordPress (obligatoire)

**Source** : fichier `credentials_path` depuis la config (résoudre depuis la racine projet `C:\Users\nilsm\Desktop\Projet Nils\`)

Extrais `username` et mot de passe (chercher dans l'ordre : `application_password` → `password` → `app_password`). Supprimer les espaces du mot de passe pour Basic Auth.

```powershell
$c = Get-Content "{chemin}" | ConvertFrom-Json
$user = $c.username
$pass = if ($c.application_password) { $c.application_password } elseif ($c.password) { $c.password } else { $c.app_password }
$pass = $pass -replace ' ', ''
```

- Si fichier trouvé → `[ÉTAPE 2d — OK] Credentials chargés (champ: {nom_champ_utilisé})`
- Si absent ou aucun champ password → `[ÉTAPE 2d — ERREUR]` + stoppe

**Test credentials** : GET `{wordpress_api}/users/me` avec Basic Auth.
- HTTP 200 → `[ÉTAPE 2d — VALIDATION OK] Auth confirmée, user: {login}, ID: {id}`
- HTTP 401 → `[ÉTAPE 2d — ERREUR: Auth 401 — application password invalide ou compte inexistant. Action Nils : WP Admin > Profil > Mots de passe d'application]` + stoppe

### 2e. Journal anti-doublon local

Lis `C:\Users\nilsm\Desktop\Projet Nils\Articles\_sujets-traites.md`. Écarte tout angle déjà listé pour ce site dans les 90 derniers jours.

`[ÉTAPE 2e — OK] Journal vérifié. {N} sujets existants pour {site}.`

**Note Drive** : le journal Drive (Charte V8 §18) peut être consulté en supplément si le connecteur MCP est actif, mais n'est jamais bloquant. Priorité = fichier local.

---

## CONFIRMATION OBLIGATOIRE — avant toute rédaction

Après chargement de tous les documents, afficher obligatoirement :

> « Contexte chargé : instructions Claude V1, charte V8, voix [site], catégories [site], journal au [date ou état connu]. Je rédige maintenant l'article demandé sur cette base. »

Si l'un des quatre éléments (V1, V8, voix, catégories) manque ou est inaccessible : s'arrêter et indiquer précisément l'élément manquant. Ne pas continuer.

---

## ÉTAPE 3 : Anti-doublon confirmé

Si un sujet proche existe (< 90j, même site), proposer un angle différent à Nils avant de continuer.

`[ÉTAPE 3 — OK] Sujet "{sujet}" validé. Pas de doublon détecté.`

---

## ÉTAPE 4 : Identifier le type de contenu (BLOQUANT)

Identifier et déclarer le type parmi (liste exclusive) :
- **Actualité** : annonce, tendance, nouvelle collection, communiqué de marque, pressroom récent
- **Communiqué** : basé sur un communiqué de presse (vérifier, hiérarchiser, réécrire — ne jamais recopier)
- **Article sponsorisé** : avec contrepartie (mention obligatoire "Publicité" ou "collaboration commerciale")
- **Essai/Test** : produit ou véhicule testé
- **Guide/Pratique** : conseils, how-to, comparatif
- **Interview** : personne réelle citée
- **Archive print** : adaptation d'un article paru dans un numéro papier
- **Destination** : reportage voyage, région (Escapade, MAV)
- **Adresse** : recommandation lieu, service

**Règle d'autonomie — classification sans demander à Nils :**

Classifier seul si l'un de ces signaux est présent :
- Nils fournit une archive, un PDF magazine, une maquette, des pages numérotées ou précise "extrait" → **Archive print**
- Le sujet porte sur une actualité récente, un communiqué, une nouvelle collection, un pressroom ou une page officielle actuelle → **Actualité Web originale**
- Le sujet demande un guide, un comparatif, un how-to sans source de news précise → **Guide/Pratique**

Ne demander à Nils que si deux types semblent également plausibles après examen des sources, et seulement si le choix a des conséquences éditoriales réellement différentes.

`[ÉTAPE 4 — OK] Type: {type} | Angle: {angle retenu} | Catégorie proposée: {catégorie}`

---

## ÉTAPE 4b : Détection et mode "archive print"

### Règle de détection — sans demander à Nils sauf ambiguïté réelle

| Signal présent | Conclusion |
|---|---|
| Nils fournit un PDF, une maquette, des pages numérotées | **Archive print** |
| Nils écrit "extrait", "numéro X", "article papier", "archive" | **Archive print** |
| Sujet = actualité récente, communiqué, nouvelle collection, pressroom officiel | **Actualité Web** — pas de question |
| Sources fournies clairement ambiguës après examen | **INDÉTERMINÉ** → demander à Nils |

Ne jamais demander "est-ce du print ?" si les sources disponibles permettent une conclusion.

**Si type = Archive print :**

Demande à Nils (une seule fois) : numéro exact + titre de l'article à adapter. Puis :
1. Nils fournit le contenu brut.
2. Adapte pour le web : HTML, structure (titre + chapo + corps + conclusion). Minimal editing.
3. **Ajoute obligatoirement à la fin du corps** la phrase :

   > « Cet article est extrait du numéro [NUMÉRO] de [NOM EXACT DU MAGAZINE]. »

   Cette phrase doit contenir un lien cliquable vers la **fiche exacte du numéro** sur `boutiquecppresse.com`.

**Règles de vérification du lien print :**
- Identifier le numéro exact dans l'archive source
- Utiliser le nom officiel et exact du magazine
- Rechercher la fiche correspondant précisément à ce numéro sur Boutique CPPRESSE
- Vérifier que l'URL ouvre le bon magazine et le bon numéro
- Ne jamais rediriger vers la page d'accueil, une catégorie générale, un autre numéro
- **Si le numéro exact ou l'URL est introuvable : s'arrêter et demander à Nils.** Ne jamais inventer le lien.

Cette mention doit figurer dans le corps HTML final et dans la checklist de contrôle.

4. Poster en brouillon directement (skip étapes 5-7).

---

## ÉTAPE 5 : Rédaction

**Si mode archive print** : reprendre le texte fourni, adapter HTML minimal, contrôler Charte (formatage).

**Sinon** :

### 5.1. Contrôle SEO avant rédaction (BLOQUANT)

**Choisir l'expression clé principale** en respectant ces règles :
- Naturelle, grammaticalement utilisable dans une phrase
- Réellement recherchée (intention de recherche claire)
- Pas d'assemblage artificiel : ~~"salle à manger décoration"~~ → "décoration salle à manger"

**Vérifier la cohérence exacte** entre tous les éléments SEO :

| Élément | Règle | Contient expression clé exacte ? |
|---|---|---|
| Expression clé principale | naturelle, recherchable | — |
| Titre H1 | ≤ 65 caractères, mot-clé dans les 5 premiers mots | oui |
| Titre SEO | ≤ 65 caractères, mot-clé en tête | **oui — obligatoire** |
| Slug | ≤ 5 mots, court, lisible | oui (dans l'esprit) |
| Méta-description | 150-155 caractères, point final | **oui — obligatoire** |
| Chapô | ≤ 40 mots | naturellement |
| H2 (1er) | contient mot-clé principal | oui |
| H2 suivants | contient mot-clé secondaire distinct | — |
| Corps | expression clé utilisée sans répétition artificielle, densité ≤ 3 % | — |

**Un voyant Yoast vert ne suffit pas.** Vérifier la pertinence éditoriale et l'intention de recherche.

**Fournir pour chaque champ SEO le nombre exact de caractères.** Signaler clairement toute non-conformité.

Si l'expression clé est artificielle ou si titre SEO/méta ne la contiennent pas → **corriger avant de continuer.**

### 5.2. Rédaction du corps

- Applique strictement Charte V8 (structure, SEO, sourcing, liens internes, interdits, anti-plagiat) + Voix du site
- **Longueur corps : 700 à 1100 mots** hors chapô et conclusion (V8 §7.1)
- Structure : H1 + chapô + 3 H2 minimum + conclusion (2 phrases, pas de CTA)
- **RÈGLE DONNÉES FACTUELLES** : tout chiffre, prix, horaire, statistique, affirmation géographique ou pratique doit être vérifié via recherche web avant insertion. Si non vérifiable : supprimer ou reformuler sans chiffre précis. Ne jamais inventer.
- **RÈGLE TRAÇABILITÉ SOURCES** : pour chaque information vérifiée, conserver : l'information, la source, l'URL, la date. Alimentent l'étape 9 (sources).
- **LIENS INTERNES : 2 à 4, jamais plus de 5, jamais forcés.** Récupérer les URLs réelles via `GET {wordpress_api}/posts?search={mot-clé}&per_page=5`. Ne jamais construire ni deviner une URL depuis un slug. Si aucun article pertinent : `[LIEN — NON TROUVÉ: {sujet}]` dans le rapport.
- **Pas de tiret long (—)** : remplacer par virgule, point, deux-points ou parenthèses
- Interdits V8 §8 : "découvrez", "plongez", "explorez", "n'hésitez pas", "en effet", "vraiment", emojis, "très" (sauf Escapade/MAVC : 1 max)

`[ÉTAPE 5 — OK] Article rédigé. {N} mots | Type: {type} | Expression clé: {focuskw} | Liens internes: {N}`

---

## ÉTAPE 5b : Passe lisibilité Yoast (AVANT envoi WordPress)

**Objectifs** :
- Phrases > 20 mots : viser < 25 %
- Voix passive : viser < 10 %
- Mots de transition : augmenter naturellement (sans forcer)
- Conserver le ton journalistique — ne pas simplifier pour du vert mécanique

**Méthode** :
1. Repérer les phrases longues (> 20 mots) et couper si le sens y gagne
2. Transformer les voix passives en actif quand c'est naturel
3. Ajouter des connecteurs logiques adaptés au ton du site
4. Recompter avant envoi

```
[ÉTAPE 5b — OK] Lisibilité
  Phrases > 20 mots : {N}% ({avant}% → {après}%)
  Voix passive       : {N}% ({avant}% → {après}%)
  Transitions        : {évaluation qualitative}
```

---

## ÉTAPE 6 : Images (OBLIGATOIRE — 1 à la une + 2 corps)

**Chaque article doit comporter :**
- 1 image à la une (featured image)
- 2 images dans le corps de l'article

**Ordre de priorité des images (V8 §11) :**
1. Visuel du communiqué de presse ou kit média (crédit obligatoire)
2. Envato Elements (si accès branché)
3. Archives IONOS HiDrive : `https://c01.storage.ionos.fr/s/n4wtRz7wkQFA5Ct` → `/FTP CPPRESSE/{magazine}/Images/`
4. Image générée par IA (uniquement si rendu propre, jamais pour objet/lieu/personne réel identifiable)
5. Banques gratuites (Pexels, Unsplash, Pixabay) — illustration générique uniquement

**Format technique (V8 §11) :**
- Largeur : **1 200 px minimum absolu**, **1 600 px visés** pour l'image à la une
- En dessous de 1 200 px : image refusée
- Ratio 16:9, pas de texte incrusté

**Pour chaque image, fournir obligatoirement :**
- Aperçu ou URL directe vérifiable
- Source (rang 1 à 5 ci-dessus)
- Crédit éventuel
- Dimensions (largeur × hauteur)
- Orientation (paysage/portrait)
- Emplacement proposé dans l'article
- Texte ALT (factuel, ≤ 125 caractères, contient le mot-clé si naturel)
- Légende (≤ 15 mots)

**Règles de vérification :**
- Vérifier que l'image correspond exactement au produit, lieu, personne ou sujet traité
- Ne jamais retenir une image générique ou approximative quand le sujet nécessite une correspondance précise
- Ne jamais affirmer que la recherche a été faite sans fournir les résultats ou liens permettant de les vérifier

**Ordre de recherche complet — avant toute déclaration d'échec :**

1. **Pressroom officiel de la marque concernée** — recherche web directe sur le site corporate ou espace presse
2. **Communiqué fourni par Nils ou galerie jointe** — images dans les pièces jointes
3. **Espace presse corporate** — pages /presse, /media, /press-room des marques
4. **Dossier de presse téléchargeable** — PDF avec visuels haute définition
5. **Photothèque salon concerné** (Maison&Objet, Paris Déco Off, etc.)
6. **Archives IONOS** : `https://c01.storage.ionos.fr/s/n4wtRz7wkQFA5Ct` → `/MAV/MAV6X/…/Links/`
7. **Envato Elements** (si accès actif)
8. **Pexels / Unsplash** — navigation web directe (pas uniquement API) ; une erreur API 401 ne prouve pas que le site est inaccessible
9. **IA** — uniquement si le sujet ne porte pas sur un produit, lieu ou personne réels identifiables

**La recherche ne peut être déclarée impossible qu'après avoir vérifié les étapes 1 à 5 pour le sujet concerné.** Une erreur API n'est pas un échec de recherche.

**Si après vérification réelle des étapes 1 à 5 aucune image n'est trouvée :**
Écrire explicitement : `« Recherche d'images impossible : [étapes 1 à 5 vérifiées, résultat : détail]. »`
Ne fabriquer aucun résultat. Fournir les mots-clés précis et les sources à consulter manuellement.

**Nommage avant upload** : renommer le fichier image `{slug}-featured.jpg` (à la une) ou `{slug}-corps-{N}.jpg` (corps) avant l'envoi WordPress.

Résultats :
- Images trouvées → `[ÉTAPE 6 — OK] {N} images | À la une: {source} | Corps 1: {source} | Corps 2: {source}`
- Images manquantes → `[ÉTAPE 6 — INCOMPLET] Brouillon créé sans {N} image(s). Statut: BROUILLON INCOMPLET — IMAGE MANQUANTE. Ne jamais signaler le workflow comme validé sans les 3 images.`

---

## ÉTAPE 7 : Sauvegardes locales

- Fichier markdown : `C:\Users\nilsm\Desktop\Projet Nils\Articles\{AAAA-MM-JJ}-{site}-{slug}.md`
- Ajouter titre + angle + date à `Articles/_sujets-traites.md`

`[ÉTAPE 7 — OK] Sauvegardé: Articles/{AAAA-MM-JJ}-{site}-{slug}.md`

---

## ÉTAPE 8 : Poster le brouillon sur WordPress

Utilise les credentials de l'étape 2d. Utilise l'`author_id` de la config.

### 8.1 Créer/récupérer les tags

POST `{wordpress_api}/tags` pour chaque tag. Si tag existe déjà (erreur term_exists), récupère son ID.

`[ÉTAPE 8.1 — OK] Tags: {liste IDs}`

### 8.2 Upload image à la une (si présente)

```bash
curl -u "{username}:{password}" \
  -F "file=@{chemin_image}" \
  "{wordpress_api}/media"
```

Récupérer `id` de la réponse. Renseigner ALT, légende et crédit.

- Image uploadée → `[ÉTAPE 8.2 — OK] Media ID: {id}`
- Pas d'image → `[ÉTAPE 8.2 — SKIP] Pas de featured media.`

### 8.3 Créer le post

Préparer le payload JSON dans un fichier local (gestion UTF-8) :

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

**Ne jamais** utiliser status=publish, future, private ou pending.

- HTTP 201 → `[ÉTAPE 8.3 — OK] Post ID: {id} | Status: draft | Lien: {wp-admin-url}`
- HTTP 400/401/403/422 → `[ÉTAPE 8.3 — ERREUR: {code} — {message}]` + afficher payload pour debug

### 8.4 Validation GET

GET `{wordpress_api}/posts/{id}?context=edit`

Vérifier : status=draft, author={author_id}, categories présentes, featured_media attaché.
Un succès HTTP ne suffit pas — relire le contenu.

`[ÉTAPE 8.4 — OK] Brouillon validé. status=draft confirmé.`

---

## RÈGLE D'AUTONOMIE — quand décider seul, quand escalader

**Décider seul** dès que les documents, sources et catégories permettent une conclusion fiable :
- Type de contenu (voir étape 4 — règle de classification)
- Origine print vs web (voir étape 4b — signaux suffisants)
- Catégorie WordPress (Tendance si article tendance, Shopping si sélection produits avec prix/liens)
- Expression clé (naturelle et cohérente avec les sources)
- Nombre de liens internes (2 à 4, selon ce qui existe réellement)
- Design Zeen (selon tableau en bas de ce fichier)

**Escalader à Nils uniquement pour :**
- Une information réellement absente que personne d'autre ne peut fournir (numéro print exact introuvable, URL boutique introuvable)
- Une contradiction non résolue entre deux documents de référence
- Une décision commerciale (sponsorisation, partenariat)
- Une action risquant de modifier ou publier un contenu WordPress existant sans instruction explicite
- Un auteur non configuré pour le site (ne jamais inventer ni substituer silencieusement)

**Ne jamais escalader pour :**
- Un type de contenu évident selon les signaux disponibles
- Une catégorie quand une seule correspond clairement à l'angle
- L'origine print quand le sujet est une actualité ou un communiqué récent
- La recherche d'images quand des pressrooms accessibles existent

---

## CONTRÔLE FINAL BLOQUANT — avant livraison

Ne pas terminer le livrable si l'un des points suivants échoue :

- [ ] Le type de contenu n'est pas identifié
- [ ] Une information factuelle importante n'est pas sourcée
- [ ] L'expression clé est artificielle ou incohérente avec les champs SEO
- [ ] Le titre SEO ne contient pas l'expression clé exacte
- [ ] La méta-description ne contient pas l'expression clé exacte
- [ ] Les éléments SEO (H1, titre SEO, slug, méta, chapô, H2) sont incohérents entre eux
- [ ] Il manque l'image à la une sans explication d'accès déclarée
- [ ] Il manque les 2 images de corps sans explication d'accès déclarée
- [ ] Une image ne correspond pas précisément au sujet
- [ ] Une catégorie, un identifiant, un auteur ou une URL a été deviné
- [ ] L'article est issu du print mais la phrase d'extraction est absente
- [ ] L'article est issu du print mais le lien vers le numéro exact sur boutiquecppresse.com est absent ou non vérifié
- [ ] Le HTML, les liens internes ou les textes ALT n'ont pas été vérifiés

---

## ÉTAPE 9 : Journalisation + livrable final

- Ajouter une ligne en haut de `JOURNAL.md` : `[AAAA-MM-JJ] {site} — "{titre}" — Brouillon ID {id} — {lien-admin}`
- Si MCP Drive actif : inscrire aussi dans Journal d'exécution Drive (§18). Sinon : noter `[Drive — non inscrit, MCP inactif]`.
- Dans le fichier markdown sauvegardé (étape 7), ajouter une section `## Sources vérifiées` :
  Format : `- "{affirmation}" — Source: {nom} | URL: {url} | Consulté: {date}`
  Si aucune source web consultée : `[NON SOURCÉ — données générales]`

**Livrable obligatoire (V1 §7) — afficher dans cet ordre :**

```
═══════════════════════════════════════════
LIVRABLE /redaction {site}
═══════════════════════════════════════════
Type de contenu   : {type}
Titre H1          : {titre} ({N} caractères)
Slug              : {slug}
Catégorie         : {nom} — ID {id} — slug {slug-cat}
Étiquettes        : {tag1}, {tag2}, {tag3} (3 max)
Auteur            : {auteur configuré pour le site}
───────────────────────────────────────────
SEO
Expression clé    : {focuskw}
Titre SEO         : {titre_seo} ({N} caractères)
Méta-description  : {metadesc} ({N} caractères)
Cohérence SEO     : [CONFORME / NON CONFORME — détail]
───────────────────────────────────────────
Images
À la une          : {source} | {dim} | {orientation}
  ALT             : {texte}
  Légende         : {légende}
  URL/aperçu      : {url ou déclaration d'impossibilité}
Corps 1           : {source} | {dim} | {emplacement}
  ALT             : {texte}
Corps 2           : {source} | {dim} | {emplacement}
  ALT             : {texte}
───────────────────────────────────────────
Liens internes    : {N} liens (URLs réelles vérifiées)
Mention print     : [NON APPLICABLE / "Cet article..." + URL boutique]
───────────────────────────────────────────
Lisibilité (étape 5b)
  Phrases > 20 mots : {N}%  (cible < 25 %)
  Voix passive      : {N}%  (cible < 10 %)
───────────────────────────────────────────
Contrôle bloquant : [TOUS POINTS CONFORMES / POINTS BLOQUANTS: ...]
Post ID           : {id}
Statut            : BROUILLON (draft)
Lien admin        : {url}
═══════════════════════════════════════════
Nils relit et publie manuellement. Zéro action auto.
```

---

## Design Zeen par type d'article

- **Destination** (plein cadre, immersif) → design `21`
- **Adresse/Hôtel** (bandeau + image) → design `42`
- **Pratique/Service** (contenu + sidebar) → design `1`
- **Listicle** → design `21`
- **News/Test/Actualité** → `zeen_hero_design_default` de la config

Si doute : utiliser `zeen_hero_design_default` et proposer à Nils.

---

## Références chemins

| Ressource | Chemin |
|-----------|--------|
| Instructions V1 | Drive ID `1QoyLZIx7qrzKQ1r5wr_xqkl9WjI1GenksAo8JtTS7Cc` |
| Charte V8 | Drive ID `1igjGJALuXC-RC2ZCEX7fq7WvITVOpd-1ZH-a0rSlJfQ` ou `CP-PRESSE-AI/02_RULES/CHARTE_V8.md` |
| Config site | `CP-PRESSE-AI/01_CONFIG/sites/{shortname}.json` |
| Voix éditoriale | `CP-PRESSE-AI/03_VOIX/{SITE}.md` (ou `local_docs.voice`) |
| Credentials | `.claude/wp-credentials-{site}.local.json` (ou `credentials_path`) |
| Sujets traités | `C:\Users\nilsm\Desktop\Projet Nils\Articles\_sujets-traites.md` |
| Articles sauvegardés | `C:\Users\nilsm\Desktop\Projet Nils\Articles\` |
