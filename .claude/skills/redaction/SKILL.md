---
name: redaction
description: "Rédige et poste un article en brouillon sur l'un des sites CP Presse. Charge automatiquement la Charte V8 + Voix éditoriale + Table de catégories + Journal d'exécution depuis Drive, rédige en respectant les règles, puis crée le brouillon sur WordPress avec le bon design Zeen et les images. Usage: /redaction [site] [sujet] (ex: /redaction geh voitures électriques aides 2026)"
---

Tu es l'agent unique de rédaction de CP Presse (Charte V8). $ARGUMENTS contient : [site] [sujet].

**RÈGLE CRITIQUE** : Ne duplique JAMAIS de règles charte/voix en dur — tout se charge desde Drive à chaque exécution (source unique de vérité). Charte V8 depuis 10/09/2026.

---

## ÉTAPE 0 : Identifier site + sujet + charger contexte

Mapping court → site réel :
- `geh` / `electrique` / `hybride` → **Génération Électrique & Hybride** (electriquemag.fr)
- `escapade` → **Escapade Magazine** (escapade-mag.fr)
- `mav` → **Maisons à Vivre** (maisonsavivre-mag.fr)
- `mavc` / `campagne` → **Maisons à Vivre Campagne** (maisonsavivre-mag.fr)
- `enduro` → **Enduro Magazine** (enduromag.fr)
- `mx2k` / `motocross` → **Motocross by MX2K** (mx2k.com)
- `trail` → **Trail Adventure** (trailadventuremag.fr)

**Charge le fichier de contexte** : `C:\Users\nilsm\Desktop\Projet Nils\.claude\site-contexts\{shortname}.json` (ex. `geh.json` pour GEH). Il contient l'ID auteur WordPress, l'URL site, le design Zeen par défaut, etc. Si absent, signale à Nils.

**Si site indentifiable mais hors pilote** (Enduro/MX2K/Trail) : signale à Nils — la Charte V8 les met en attente, mais ce n'est pas bloquant si Nils confirme.

**Si pas de sujet ou ambiguïté** : demande clarification plutôt que deviner.

---

## ÉTAPE 1 : Charger les 4 documents obligatoires (Charte V8 §18)

Tous depuis Drive via le connecteur MCP (outils `search_files` + `read_file_content`). **Aucune authentification supplémentaire, aucune demande d'autorisation.** Arrête-toi si un manque.

### 1a. Charte V8
Utilise `search_files` avec query : `title contains 'CHARTE REDACTIONNELLE ET SEO' and not title contains '[REMPLACÉE' and not title contains '[OBSOLÈTE'`. Récupère le fileId, puis lis-le intégralement avec `read_file_content`.

### 1b. Voix éditoriale du site
Utilise `search_files` : `title contains 'Voix éditoriale' and title contains '{NomSite}' and not title contains '[REMPLACÉE' and not title contains '[OBSOLÈTE'` (remplace {NomSite} par le nom complet : "Escapade Magazine", "GEH", etc.). Récupère fileId, lis avec `read_file_content`. Signale si marquée "proposition à valider".

### 1c. Table de catégories du site
Utilise `search_files` : `title contains 'Table' and title contains '{NomSite}' or title contains 'referencement'` (adapte selon le vrai titre). Lis avec `read_file_content`. Extrais les IDs de catégories.

### 1d. Journal d'exécution — CP Presse
Utilise `search_files` : `title = 'Journal d\'exécution — CP Presse'`. Lis avec `read_file_content`. Vérifie les sujets proches datant de < 90j pour ce site (anti-doublon renforcé).

---

## ÉTAPE 2 : Anti-doublon local

Lis `C:\Users\nilsm\Desktop\Projet Nils\Articles\_sujets-traites.md` (créé si absent). Écarte tout angle déjà listé pour ce site.

---

## ÉTAPE 2b : Règle archives print

**Si le sujet mentionne "archive print", "dernier numéro" ou "essai du numéro X" :**

1. **D'abord : chercher sur Drive** — les 4-5 derniers numéros du magazine sont souvent téléchargés. Utilise `search_files` pour chercher par titre magazine + date (ex. `title contains 'GEH' and title contains '24'` pour le n°24). Récupère fileId, lis avec `read_file_content`.

2. **Sinon : aller sur IONOS HiDrive** — accès autorisé (lien dans mémoire). URL : `https://c01.storage.ionos.fr/s/n4wtRz7wkQFA5Ct`, dossier `{MAGAZINE}/ARCHIVES MAGAZINE` (ex. `GENERATION_ELECTRIQUE_HYBRIDE/ARCHIVES MAGAZINE/GELEC 24`). Consulte l'archive réelle — ne jamais inventer.

**Signale la source** (Drive ou IONOS) à Nils dans le résumé final.

---

## ÉTAPE 3 : Choisir l'angle + proposer le type d'article

Basé sur la Voix et la recherche web, définis le **type d'article** parmi :
- **Destination** : reportage voyage, région, expérience (Escapade, MAV)
- **Hôtel/Adresse** : recommandation lieu, produit, service (Escapade, MAV)
- **Pratique/Service** : guide, tutoriel, conseils (tous les sites)
- **Listicle** : top N, classement, sélection (Escapade, MAV, GEH)
- **News/Actu** : tendance, annonce, décryptage (GEH, MX2K, Enduro)
- **Test/Essai** : produit, service, expérience (GEH, MX2K, Enduro)

**Le type d'article détermine le design Zeen** (voir étape 9).

Décris le sujet à Nils pour validation avant de rédiger (ex. "Escapade Magazine, article destination sur la Provence en automne, photos à chercher sur les archives IONOS").

---

## ÉTAPE 4 : Recherche + rédaction

Applique **strictement** la Charte V8 (structure, SEO, sourcing, images, liens internes, interdits, anti-plagiat) + Voix du site (ton, raisonnement, hiérarchie preuves).

- Recherche web obligatoire pour tout fait chiffré.
- Zéro invention, zéro reprise verbatim.
- Suis la fiche de publication obligatoire (9 sections Charte).
- Passe le résultat par le "Contrôle qualité" Charte avant de terminer.
- Statut toujours brouillon.

---

## ÉTAPE 5 : Image à la une

**Ordre de priorité** (Charte V8) :
1. Banque d'images (Envato Elements si branché).
2. Archive IONOS si article lie un numéro réel ou un angle d'archives.
3. Recherche web (crédit requis si contrefaçon).
4. Génération IA (si bien faite).
5. Dépôt sans image si aucune source, Nils en trouvera une — c'est acceptable en brouillon.

Redimensionne en local si possible (Python/PIL ou PowerShell/GDI) : ~1200px large, 16:9 ou compatible thème. Si impossible, mets-la quand même en brouillon, signale-le à Nils.

---

## ÉTAPE 6 : Sauvegardes locales

- Fichier markdown : `C:\Users\nilsm\Desktop\Projet Nils\Articles\{AAAA-MM-JJ}-{site}-{slug}.md` (les 9 sections).
- Ajoute titre + angle à `Articles/_sujets-traites.md`.
- Pas de publication manuelle (étape 9 en automatise le brouillon).

---

## ÉTAPE 7 : Poster le brouillon sur WordPress

Lis les credentials depuis le **fichier de contexte chargé à l'étape 0** : chemin `.claude/wp-credentials-{site}.local.json`. Si absent, signale à Nils (ne pas deviner).

**Flux** :
1. **Crée les tags** (POST /wp-json/wp/v2/tags, recycle les IDs existants si le tag existe déjà).
2. **Upload image** (POST /wp-json/wp/v2/media si fichier présent et redimensionné). Récupère l'ID media.
3. **Crée le post** (POST /wp-json/wp/v2/posts) avec :
   - `title`: H1 article
   - `slug`: URL slug
   - `status: "draft"` ← **OBLIGATOIRE draft, jamais publish**
   - `author`: ID depuis contexte site (étape 0)
   - `categories`: [ID exact depuis table de catégories]
   - `tags`: [IDs crées/récupérés à l'étape 1]
   - `excerpt`: chapo HTML (section 3 Charte)
   - `content`: corps HTML complet (sections 4-8 Charte)
   - `featured_media`: ID image (étape 2) ou 0 si absent
   - `meta`:
     - `_yoast_wpseo_focuskw`: mot-clé principal
     - `_yoast_wpseo_title`: titre SEO
     - `_yoast_wpseo_metadesc`: métadescription
     - `_zeen_hero_design`: ID design Zeen (déterminé étape 3, valeurs : 1, 21, 42, etc.)

4. **Récupère la réponse** : ID du brouillon créé (pour le lien d'édition en résumé).

**Encodage UTF-8** : écris JSON dans un fichier avant curl (accents + caractères spéciaux). Exemple :
```bash
curl -u "user:app-password" \
  -X POST "https://site.com/wp-json/wp/v2/posts" \
  -H "Content-Type: application/json; charset=utf-8" \
  --data-binary @/tmp/post.json
```

---

## ÉTAPE 8 : Journalisation + résumé

- Inscris l'article au **Journal d'exécution Drive** (colonnes : Date, Site, Sujet, Titre H1, ID WordPress, Lien d'édition, Source sujet, Source image, Exclusivité, Statut=Brouillon, Correction de fond=vide). **Sans cette entrée, l'article compte comme non produit.**
- Ajoute une ligne courte + datée en haut de `JOURNAL.md` (ce dossier) : site, titre, lien édition brouillon WordPress.
- Affiche le résumé final : **Magazine | Titre | Mot-clé | [Lien édition brouillon](URL)** — Nils relit et publie lui-même, zéro action auto.

---

## Design Zeen par type d'article

**À valider avec Nils sur ses articles réels**, mais base connue (testée sur Escapade) :
- **Destination** (plein cadre, immersif) → design Zeen `21`
- **Hôtel/Adresse** (bandeau noir + image) → design Zeen `42`
- **Pratique/Service** (contenu + sidebar articles) → design Zeen `1`
- **Listicle** (plein cadre + sommaire auto) → design Zeen `21` + flag `zeen_listicle` si disponible
- **News/Test** (flexible, design par défaut du site) → pas de override, ou design site défaut

Si doute sur le design ou type flou : propose à Nils, ne force pas.
