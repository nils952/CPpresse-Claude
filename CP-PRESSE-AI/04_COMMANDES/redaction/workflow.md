# Workflow /redaction — Détail Complet

Processus détaillé création article : de la préparation au dépôt WordPress.

---

## Phase 1 : Préparation (Automatisée)

### 1.1 Charger Charte V8

**Source** : Drive (MCP search_files)  
**Objectif** : Références rédaction (longueur, structure, sources images, journal)

```
Charger via MCP :
- search_files("Charte V8", "PDF")
- read_file_content()
```

**Éléments clés extraits** :
- Longueur : 500-1200 mots
- Structure : H1 + 2-3 H2, chapô
- Liens internes : minimum 2
- Images : priorité Envato > IONOS > web > IA
- Journal d'exécution : §18

### 1.2 Charger Voix Éditoriale {site}

**Source** : `CP-PRESSE-AI/03_VOIX/{site}.md`  
**Objectif** : Ton, structure, vocabulaire site

**Éléments clés** :
- Ton général (formel/ludique/expert)
- Structure article type
- Vocabulaire récurrent
- Longueur préférée
- Angle éditorial (service/reportage/critique)

### 1.3 Charger Config Site

**Source** : `CP-PRESSE-AI/01_CONFIG/sites/{site}.json` (source unique)  
**Objectif** : Infos WordPress

```json
{
  "shortname": "geh",
  "display_name": "Génération Électrique & Hybride",
  "wordpress_api": "https://electriquemag.fr/wp-json/wp/v2",
  "author_id": 19,
  "zeen_hero_design_default": 1,
  "credentials_path": ".claude/wp-credentials-geh.local.json",
  "local_docs": {
    "voice": "CP-PRESSE-AI/03_VOIX/GEH.md",
    "rules": "CP-PRESSE-AI/02_RULES/CHARTE_V8.md"
  }
}
```

**Note** : Ne pas utiliser `.claude/site-contexts/` — chemin obsolète.

### 1.4 Charger Catégories WordPress

**Source** : API WordPress (GET `/wp-json/wp/v2/categories`)  
**Objectif** : IDs catégories valides

```bash
curl -u user:pass \
  "https://site.fr/wp-json/wp/v2/categories" \
  | jq '.[] | {id, name, slug}'
```

### 1.5 Charger Credentials

**Source** : `.claude/wp-credentials-{site}.local.json`  
**Objectif** : Auth WordPress

```json
{
  "username": "user_app",
  "password": "app_password"
}
```

### 1.6 Valider prérequis

- [ ] Charte V8 chargée
- [ ] Voix {site} présente
- [ ] Config site valide
- [ ] Catégories récupérées
- [ ] Credentials valides

---

## Phase 2 : Rédaction

### 2.1 Analyser sujet

**Tâches** :
1. Vérifier pertinence (tendance, actu, angle)
2. Chercher articles existants (pas doublon)
3. Déterminer focuskw (1-2 mots clés)
4. Esquisse plan (H1, 2-3 H2)

**Exemple** :
```
Sujet : "Cupra Born 2026 prix France"
Focuskw : "Cupra Born prix"
H1 : "Cupra Born 2026 : prix et disponibilité en France"
H2.1 : "Cupra Born : nouvelle génération électrique"
H2.2 : "Tarifs 2026 : de X à Y€"
H2.3 : "Fiche technique complète"
```

### 2.2 Rédiger contenu

**Structu​re obligatoire** :
- **Titre** : 30-60 char, focuskw inclus → métabalise `<title>`
- **Slug** : URL-friendly, sans accents → métabalise `slug`
- **Chapô** : 2-3 lignes, résumé angle → métabalise `excerpt`
- **H1** : Titre principal (une fois)
- **Sections** : 2-3 H2 + paragraphes
- **Contenu** : 500-1200 mots minimum
- **Liens internes** : Minimum 2 (vers autres articles site)
- **Conclusion** : Résumé + CTA (doux)

**Règles à respecter** :
- Pas de tiret long (—) → voir [[../../../02_RULES/STYLE_GUIDE.md]]
- Appliquer voix {site} (ton, vocabulaire, angle)
- Inclure fiche technique si applicable → voir [[../../../02_RULES/FICHES_TECHNIQUES.md]]
- UTF-8 explicite (accents français OK)

**Exemple brut (HTML)** :
```html
<h1>Cupra Born 2026 : prix et disponibilité France</h1>

<p>Chapô résumé angle et accroche...</p>

<h2>Cupra Born : nouvelle génération électrique</h2>
<p>Description voiture...</p>

<h2>Tarifs 2026</h2>
<p>Détails prix...</p>

<h2>Fiche technique</h2>
<table>...specs...</table>

<p>Conclusion...</p>
```

### 2.3 Valider contenu

- [ ] Titre (30-60 char)
- [ ] Focuskw (1-2 mots, dans titre)
- [ ] Slug (URL-friendly)
- [ ] Chapô (2-3 lignes)
- [ ] H1 + 2-3 H2
- [ ] 500-1200 mots
- [ ] Minimum 2 liens internes
- [ ] Pas de — (tiret long)
- [ ] Voix appliquée
- [ ] Pas de erreurs ortho/grammaire

---

## Phase 3 : Images

### 3.1 Sourcer image "à la une"

**Priorité** :
1. **Envato** (si accès) : images premium, haute qualité
2. **Archives IONOS** (lien public) : images officielles magazine → voir [[../../../01_CONFIG/IONOS_ARCHIVES.md]]
3. **Web** (licence libre) : Pexels, Unsplash, Pixabay (crédits)
4. **IA** (fallback) : Midjourney, DALL-E

**Processus IONOS** :
```
1. Browser naviguer https://c01.storage.ionos.fr/s/n4wtRz7wkQFA5Ct
2. Ouvrir /FTP CPPRESSE/{magazine}/Images/
3. Sélectionner image appropriée
4. Télécharger localement
```

### 3.2 Préparer image

- Renommer descriptive : `cupra-born-2026-front.jpg`
- Vérifier poids (< 2 MB, optimisé)
- Encodage : UTF-8 (nom fichier)

### 3.3 Récupérer métadonnées

Pour média WordPress :
- URL source (ou fichier local)
- Alt text : description concise (SEO)
- Caption : légèrement plus détaillé

**Exemple** :
```
Alt: "Cupra Born 2026 vue de face"
Caption: "La Cupra Born 2026 combine électrique 100% et design espagnol dynamique"
```

---

## Phase 4 : Yoast SEO

### 4.1 Définir focus keyword

**Règle** : 1-2 mots clés principaux

```
Exemple : "Cupra Born prix"
```

### 4.2 Définir page title

**Règle** : < 60 caractères, inclure focuskw

```
"Cupra Born 2026 : prix et dispo France" (55 char)
```

### 4.3 Définir meta description

**Règle** : 150-160 caractères, focuskw 1-2×

```
"Découvrez le prix de la Cupra Born 2026 en France. Nouvelle électrique espagnole : tarifs, fiche technique et disponibilité."
```

### 4.4 Valider Readability

Objectif : Green (lisible)

**Critères** (automatisés Yoast) :
- Longueur phrases (< 20 mots moyenne)
- Paragraphes (< 150 mots)
- Transitions (phrases tête de paragraphe)
- Utilisation passive (limiter)

---

## Phase 5 : Télécharger Image WordPress

### 5.1 Uploader médias

**Endpoint** : `POST /wp-json/wp/v2/media`

```bash
curl -u user:pass \
  -F "file=@/path/image.jpg" \
  "https://site.fr/wp-json/wp/v2/media"

# Réponse : {"id": 12345, "source_url": "..."}
```

### 5.2 Noter media ID

Utiliser `id` réponse pour featured_media dans post.

---

## Phase 6 : Dépôt WordPress

### 6.1 Préparer payload POST

```json
{
  "title": "Cupra Born 2026 : prix et disponibilité France",
  "slug": "cupra-born-2026-prix-france",
  "content": "<h1>Cupra Born 2026...</h1><p>...",
  "excerpt": "Chapô découvrez...",
  "featured_media": 12345,
  "categories": [5],
  "tags": [2, 3],
  "_yoast_wpseo_focuskw": "Cupra Born prix",
  "_yoast_wpseo_title": "Cupra Born 2026 : prix et dispo France",
  "_yoast_wpseo_metadesc": "Découvrez le prix...",
  "meta": {
    "zeen_theme_post_layout": "1"
  },
  "status": "draft"
}
```

### 6.2 POST article

**Endpoint** : `POST /wp-json/wp/v2/posts`

```bash
curl -u user:pass \
  -X POST \
  -H "Content-Type: application/json; charset=utf-8" \
  -d '{"title":"...","status":"draft",...}' \
  "https://site.fr/wp-json/wp/v2/posts"

# Réponse : {"id": 12053, "link": "...", "status": "draft"}
```

### 6.3 Valider réponse

- [ ] HTTP 201 Created
- [ ] `status: "draft"`
- [ ] `link` présent (URL brouillon)

---

## Phase 7 : Journalisation

### 7.1 Inscrire dans Charte V8 §18

**Où** : Google Drive, Charte V8 §18 (Journal d'exécution)

**Données** :
- Date / Heure
- Site
- Titre article
- Focuskw
- État : BROUILLON
- Lien WordPress (de réponse POST)
- Auteur : {user agent}

**Exemple** :
```
12/09/2026 14:30
GEH
Cupra Born 2026 : prix et disponibilité France
Focuskw: Cupra Born prix
État: BROUILLON
Lien: https://electriquemag.fr/index.php/wp-admin/post.php?post=12053&action=edit
Auteur: Claude Haiku (session nils)
```

---

## Validation Avant Chaque Exécution

```
☑ Charte V8 chargée
☑ Voix {site} chargée
☑ Config site valide
☑ Credentials testés
☑ Sujet non dupliqué
☑ Images disponibles
```

---

## Dépannage Rapide

| Erreur | Cause | Fix |
|--------|-------|-----|
| 401 Unauthorized | Credentials invalides | Vérifier `.local.json` |
| 403 Forbidden | User pas droits | Vérifier author_id dans config |
| Image 404 | IONOS indisponible | Fallback web/IA |
| UTF-8 alerte | Encodage HTTP manquant | Ajouter `; charset=utf-8` header |
| Yoast incomplet | focuskw manquant | Ajouter focuskw avant POST |

---

**Référence** : [[README.md]] | [[checklist.md]]
