# Guide d'introduction — Rédaction automatisée pour CP Presse

**Pour un nouvel agent IA qui doit reproduire le même processus de rédaction sur un autre site CPpresse.**

---

## Avant de commencer

Tu dois avoir accès à **trois sources d'information et un système** :

1. **Google Drive du groupe** (`00-Pilotage`) : tous les documents de référence y sont stockés.
2. **WordPress REST API** : pour créer les brouillons directement.
3. **Archives IONOS HiDrive** : pour accéder aux vrais numéros papier (exemples, archives, style).
4. **Contexte du site** : informations spécifiques au site sur lequel tu travailles.

---

## Étape 0 — Avant chaque article, charge les 4 documents obligatoires

**À faire EN PREMIER, pour chaque nouvel article** (non négociable — la Charte V8 l'impose) :

1. **Charte V8** (Drive, dossier `00-Pilotage`)
   - Titre exact : "CHARTE REDACTIONNELLE ET SEO V8" 
   - Exclure les versions périmées (`[PÉRIMÉE]`, `[REMPLACÉE]`, `[OBSOLÈTE]`, `[FUSIONNÉ]`)
   - Jamais utiliser un ID de document figé — toujours chercher par titre
   - Elle contient : règles de rédaction, plafonds de style, interdictions SEO, zones taboues

2. **Fiche Voix éditoriale du site** (Drive, dossier `Voix éditoriales par site`)
   - La fiche doit correspondre exactement au magazine demandé (GEH ≠ Escapade ≠ MAV ≠ MAVC)
   - Elle contient : tone, vocabulaire à éviter, exemples "à privilégier" vs "à éviter", section sur les formats (news, essai, pratique, etc.)
   - Ne jamais inventer une fiche, demander à Nils avant d'écrire

3. **Table de catégories du site** (Drive, dossier `Catégories`)
   - Fichier JSON ou doc par site listant : catégorie, ID WordPress, slug
   - Utilisée pour remplir le champ `categories` dans l'API WordPress

4. **Journal d'exécution — CP Presse** (Drive, dossier `00-Pilotage`)
   - Nouveau document obligatoire depuis la Charte V8 (§18)
   - À remplir après publication du brouillon (pas avant, même si ça semble logique)
   - Une ligne par article : date, site, titre, ID WordPress, lien edit, source papier, type contenu, statut, notes

**STOP si l'un des quatre manque.** Signaler à Nils — ne jamais deviner ni inventer de remplacement.

---

## Étape 1 — Comprendre le site et la rédaction exigée

Avant de rédiger, tu dois savoir :

### Infos du site (stockées en `.claude/site-contexts/{shortname}.json` ou à demander à Nils)

```json
{
  "name": "GEH",
  "url_api": "https://electriquemag.fr/wp-json",
  "author_id": 19,
  "author_name": "Nils Martin",
  "zeen_hero_design_default": 21,
  "wordpress_credentials_file": "./.claude/wp-credentials-geh.local.json"
}
```

- **`url_api`** : endpoint WordPress pour cet article. Toujours en HTTPS.
- **`author_id`** : ID WordPress du compte qui signe l'article (dédié "claude editorial" ou compte perso). Si absent, **STOP** — demander à Nils.
- **`zeen_hero_design_default`** : quel design appliquer. Designs courants : **21** (plein cadre destination), **42** (bandeau noir + image), **1** (image + sidebar).

### Règles de rédaction imposées (lire la Charte V8)

- **Paragraphes max 3 phrases** (exception MAVC seulement : 4 phrases)
- **Phrases max 25 mots** (exception MAVC : 35 mots)
- **Jamais "très", "découvrez", "plongez", "en effet", "il est important de"** sauf exception site
- **Jamais 3 phrases consécutives** commençant par le même mot
- **Min 2 liens internes** dans le corps du texte (ancrage naturel, pas liste)
- **Prix et chiffres sourcés** (web, presse, kits médias constructeurs)
- **Conclusion : 2 phrases max, zéro CTA** (pas d'appel à l'action)

---

## Étape 2 — Trouver le contenu source

### Option 1 : Archive papier (magazine)

- Chercher dans **IONOS HiDrive** (lien de partage fourni par Nils)
- Dossier par site/magazine, puis par numéro/PDF
- **Règle** : adapter librement le contenu papier (pas du copier-coller), changer l'angle si besoin, ajouter du contexte web/recherche récente
- Pas de crainte doublon : si le contenu papier a 3 ans et que tu ajoutes des données 2026, ce n'est plus un doublon

### Option 2 : Actualité / tendances

- Recherche web obligatoire pour tout chiffre nouveau (visiteurs, prix, dates, stats)
- Sources : presse FR/US, médias spécialisés, sites officiels
- Ne jamais inventer de données, **tout chiffre doit avoir une source citée**

### Option 3 : Communiqué de presse

- Format mail d'une marque/partenaire
- À adapter (jamais recopier tel quel)
- Crédit obligatoire en bas d'article si source directe

---

## Étape 3 — Rédiger les 9 sections (structure fixe)

Chaque article = 9 sections toujours dans cet ordre :

1. **Titre** (H1, accrocheur, pas plus de 65 caractères) — souvent formé du mot-clé principal + angle
2. **Résumé éditorial** (2-3 phrases, résume le fond sans donner la fin) — pas visible sur le site, juste pour WordPress
3. **Corps** (3-8 paragraphes selon article)
   - 1ère phrase clé + contexte
   - 2-3 paragraphes développement (prix, caractéristiques, contexte, chiffres)
   - 1 paragraphe enjeux/implications
   - 1-2 paragraphes détails/exemples
4. **Conclusion** (2 phrases max, pas de CTA)
5. **Métadonnées** (remplies avec Yoast SEO — voir Étape 4)

Structure type : `H1 titre > paragraphes corps > H2 sections (si besoin) > conclusion`

---

## Étape 4 — Obligatoire : SEO Yoast (avant de poster)

**Chaque article doit passer les 3 vérifications Yoast** avant d'être posté en brouillon.

### Focus Keyword (mot-clé principal)

- **Où l'insérer** :
  - Dans le H1 (idéalement début ou fin)
  - Dans les 100 premiers mots du corps
  - En H2 d'au moins une section
  - Dans la métadescription
  - Dans l'ALT de l'image à la une
- **Exemple** : article "City trips automne" → mot-clé = "city trips automne"

### Titre SEO (50-60 caractères)

- Pas plus de 60 caractères (y compris espaces)
- Contient le mot-clé si possible
- Lisible et attractif
- **Exemple** : "`City trips automne : 4 capitales à découvrir`" (56 caractères)

### Métadescription (150-160 caractères)

- Pas plus de 160 caractères
- Contient le mot-clé
- Incite au clic (appel court à l'action OK ici)
- **Exemple** : "`Copenhague, Gothenburg, Vilnius, Lyon... 4 city trips d'automne accessibles et hors des sentiers battus. Guides pratiques inclus.`"

### Slug

- Propre, sans accents, sans stopwords inutiles
- Basé sur le titre : "City trips automne : 4 capitales" → slug = `city-trips-automne`

### Score Yoast

- **SEO** : vert (feu vert) avant de poster
- **Lisibilité** : vert idéal, orange acceptable (jamais rouge)

---

## Étape 5 — Images : format et métadonnées

### Format obligatoire

- **Résolution minimale** : 1600×900 px (16:9) pour une image hero plein cadre
- **Compression** : JPEG ~85% qualité
- Pas d'agrandissement : si l'image source fait 1000×600, la garder telle quelle (pas étirer)

### Métadonnées image (WordPress Médias)

Chaque image uploadée DOIT avoir :

1. **ALT** (alternative text pour accessibilité + SEO)
   - Inclut le mot-clé principal + description précise de ce que montre l'image
   - Exemples :
     - ❌ "Photo d'Édimbourg"
     - ✅ "City trip Édimbourg : façades colorées du quartier de Leith, automne 2026"
     - ❌ "Crédit : Constructeur"
     - ✅ "Cupra Born 2026 vue de face, extérieur urbain" (crédit en légende, pas dans l'ALT)

2. **Titre** (nom affiché au survol)
   - Lisible, pas le nom de fichier brut
   - Exemples :
     - ❌ "DSC_4521.jpg"
     - ✅ "Édimbourg — vue depuis Arthur's Seat"
     - ✅ "Cupra Born 2026 — avant"

3. **Légende** (optionnel, visible en bas de l'image si affiché)
   - Crédit si nécessaire
   - Exemples :
     - "© Office du tourisme Édimbourg"
     - "© Cupra / Kit presse"

4. **Description** (optionnel, invisible, pour traçabilité interne)
   - Source/provenance de l'image
   - Exemple : "Kit presse Cupra Born 2026 — Drive CP Presse"

---

## Étape 6 — Créer le brouillon WordPress

Une fois le texte + image prêts, tu dois **POST** un nouvel article sur WordPress.

### Authentification

- Récupérer le mot de passe d'application dans `./.claude/wp-credentials-{site}.local.json`
- Auth : Basic Auth (username : email, password : mot de passe app)
- Endpoint : `POST {site_url}/wp-json/wp/v2/posts`

### Payload JSON minimal

```json
{
  "title": "City trips automne : 4 capitales à découvrir",
  "content": "<p>Corps de l'article en HTML brut ou bloc WordPress JSON</p>",
  "excerpt": "Résumé éditorial 2-3 phrases",
  "slug": "city-trips-automne",
  "status": "draft",
  "author": 13,
  "categories": [44, 51],
  "featured_media": 12345,
  "_yoast_wpseo_focuskw": "city trips automne",
  "_yoast_wpseo_title": "City trips automne : 4 capitales à découvrir",
  "_yoast_wpseo_metadesc": "Copenhague, Gothenburg, Vilnius, Lyon... 4 city trips d'automne...",
  "_zeen_hero_design": 21,
  "tags": [125, 134]
}
```

### Points critiques

- **`status: "draft"`** — JAMAIS `"publish"`. Nils relit et publie lui-même.
- **`author`** — ID exact depuis le contexte site. Si absent ou faux, l'article sera attribué à l'admin WP par défaut.
- **`categories`** — IDs exacts depuis la table de catégories. Pas de noms, que des IDs.
- **`featured_media`** — ID de la media image uploadée. **Pas 0, pas vide.**
- **`_zeen_hero_design`** — design appliqué au brouillon (21, 42, 1, etc.)
- **Vérifier après POST** : l'API renvoie l'ID créé + le slug réel. Si le slug est devenu `city-trips-automne-2` ou autre, c'est qu'un doublon existait — corriger la règle "anti-doublon" (voir ci-dessous).

### Règle anti-doublon (avant de poster)

- Chercher un article existant au même slug : `GET /wp/v2/posts?search={slug}&status=any`
- Si un draft existe déjà : ne pas créer de doublon.
- Si un article publié existe : changer l'angle ou signaler à Nils.

---

## Étape 7 — Journaliser (OBLIGATOIRE après POST réussi)

Une fois le brouillon créé sur WordPress :

1. Récupérer : **ID du post**, **lien d'édition** (format `https://site.com/wp-admin/post.php?post={ID}&action=edit`)
2. Ajouter une ligne au **Journal d'exécution** (Drive, `00-Pilotage`) :
   - **Date** : aujourd'hui
   - **Site** : GEH / Escapade / MAV / MAVC / etc.
   - **Titre** : titre complet de l'article
   - **ID WordPress** : numéro retourné par l'API
   - **Lien édition** : URL ci-dessus
   - **Source** : numéro papier (ex. "Escapade 20") ou actu (ex. "Actu IFTM 2026")
   - **Type contenu** : News / Archive papier / Evergreen / Communiqué
   - **Statut** : Brouillon (toujours, pour une session 1)
   - **Notes** : image à ajouter / tags manquants / autre blocage connu

**Pas de journalisation = article compte comme non produit** (Charte V8 §18).

---

## Étape 8 (Optionnel) — Si tu dois ajouter images/tags avant de finir

### Télécharger et uploader une image

- Récupérer l'image (Drive, IONOS, web) → enregistrer en local
- Vérifier résolution (1600×900 min pour hero)
- `POST /wp/v2/media` avec le binaire image + métadonnées (alt, title, description)
- Récupérer l'ID retourné
- Attacher à l'article : `POST /wp/v2/posts/{post_id}` avec `featured_media: {media_id}`

### Créer/récupérer des tags

- `GET /wp/v2/tags?search={tag_name}` — chercher si le tag existe déjà
- Si absent : `POST /wp/v2/tags` → créer, récupérer l'ID
- Attacher à l'article : `POST /wp/v2/posts/{post_id}` avec `tags: [id1, id2, ...]`

---

## Checklist avant de livrer à Nils

- [ ] Les 4 docs obligatoires (Charte, Voix, Catégories, Journal) chargés et lus
- [ ] Structuré en 9 sections (H1 + résumé + corps + conclusion + metas)
- [ ] Pas de "très", "découvrez", "plongez"
- [ ] Pas de 3 phrases consécutives identiques
- [ ] Min 2 liens internes (anchors naturels)
- [ ] Yoast SEO vert (focuskw + title 50-60 + metadesc 150-160)
- [ ] Image 1600×900 min, ALT + titre + légende remplies
- [ ] Brouillon créé sur WordPress (`status: draft`)
- [ ] Lien edit + ID fournis à Nils
- [ ] Journalisation complétée dans le Journal d'exécution Drive

---

## Questions fréquentes

### "Quelle version de la Charte utiliser ?"
**V8** depuis le 10/09/2026. V7 et antérieures sont archivées. Chercher par titre dans Drive, pas par ID.

### "Je n'arrive pas à créer la media/tag via l'API, pourquoi ?"
Vérifie l'authentification (credentials OK ?) et les permissions du compte. Si c'est un compte Éditeur standard, les tags/media pourraient être restreints. Essayer en GET en premier pour valider l'auth.

### "L'article est dans WordPres mais le slug a changé (-2 ajouté)."
Ça signifie qu'un article existait déjà avec le même slug. Avant de poster à nouveau, vérifier qu'il n'existe pas en doublon, puis renommer le brouillon dans WordPress (changer le slug en direct dans l'éditeur).

### "Comment je fais pour les images si je n'ai pas d'ImageMagick ?"
Demander à Nils de les uploader lui-même (copier-coller depuis Drive ou IONOS), ou utiliser une simple API online de redimensionnement. L'important : c'est fait, pas comment.

### "Et si le site WordPress n'a pas de mot de passe d'application ?"
S'arrêter et signaler à Nils. Il doit le créer en Admin > Profil > Mots de passe d'application. Puis enregistrer le `.local.json`.

---

## Prochaines étapes pour un nouvel agent

Pour lancer un nouvel agent sur un nouveau site (exemple : **Enduro Magazine**) :

1. **Infos de base à demander à Nils** :
   - URL WordPress (ex. `https://enduromag.fr`)
   - Mot de passe application (`nils+claude@cppresse.fr`)
   - Author ID (chercher le compte WordPress correct)
   - Design Zeen par défaut (si applicable)

2. **Vérifier l'accès** :
   - `GET /wp-json/wp/v2/users/me` → doit retourner 200 (auth OK)
   - `GET /wp-json/wp/v2/posts?status=draft&per_page=1` → voir des brouillons existants

3. **Créer le contexte site** :
   - Fichier `.claude/site-contexts/enduro.json` (même format GEH/Escapade/MAV)

4. **Charger la voix éditoriale** :
   - Chercher la fiche dans Drive
   - Si absente, l'écrire (ou demander à Nils de le faire)

5. **Lancer la rédaction** :
   - Sujets à traiter : demander à Nils (numéro papier / actu / tendances)
   - Suivre ce guide étape par étape

---

**C'est tout ce qu'il faut savoir pour démarrer.** Nils est là pour clarifier, débloquer (credentials manquants, accès Drive, etc.), et valider avant publication.

Bon courage ! 🚀
