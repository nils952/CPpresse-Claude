# Checklist /redaction — Validation Complète

À cocher avant de lancer la commande, et après exécution.

---

## ✅ AVANT LANCEMENT

### Vérifications préalables

- [ ] **Site reconnu** : GEH, Escapade, ou MAV
- [ ] **Config site existe** : `CP-PRESSE-AI/01_CONFIG/sites/{site}.json` présent (source unique)
- [ ] **Credentials présents** : `.claude/wp-credentials-{site}.local.json`
- [ ] **Docs locaux** : `CP-PRESSE-AI/02_RULES/CHARTE_V8.md` + `CP-PRESSE-AI/03_VOIX/{site}.md` présents
- [ ] **Accès IONOS** : Lien public archives (voir [[../../../01_CONFIG/IONOS_ARCHIVES.md]])
- [ ] **Accès WordPress API** : Endpoint `/wp-json/` répondant

### Sujet article

- [ ] **Sujet défini** : Pertinent, tendance ou actu
- [ ] **Pas doublon** : Recherche articles existants
- [ ] **Angle unique** : Différent articles passés
- [ ] **Focuskw choisi** : 1-2 mots clés principaux

---

## ✅ PHASE RÉDACTION

### Titre

- [ ] **Longueur** : 30-60 caractères
- [ ] **Focuskw inclus** : Au moins une fois
- [ ] **Accrocheur** : Donne envie de lire
- [ ] **Format correct** : Pas de point final

### Chapô

- [ ] **Longueur** : 2-3 lignes
- [ ] **Résumé angle** : Explique "pourquoi" article
- [ ] **Accroche** : Premier phrase captive

### Structure

- [ ] **H1 présent** : Une seule (= titre article)
- [ ] **H2 présents** : 2-3 sections minimum
- [ ] **H3 si besoin** : Sous-sections (optionnel)
- [ ] **Hiérarchie OK** : Pas de saut (H1 → H3 interdit)

### Contenu

- [ ] **Longueur** : 500-1200 mots minimum
- [ ] **Densité** : Pas wall-of-text (paragraphes < 150 mots)
- [ ] **Liaisons internes** : Minimum 2 liens vers articles site
- [ ] **Phrases courtes** : < 20 mots moyenne
- [ ] **Pas de — (tiret long)** : Remplacer par virgule/point/dois-points/parenthèses (voir [[../../../02_RULES/STYLE_GUIDE.md]])

### Voix & Style

- [ ] **Ton respecté** : Applique voix {site}
- [ ] **Vocabulaire cohérent** : Mots clés de la fiche voix
- [ ] **Angle éditorial** : Service/reportage/critique selon site
- [ ] **Pas de jargon obscur** : Accessible lecteur moyen
- [ ] **Pas de formules creuses** : "À noter", "On peut dire" bandies

### Éléments techniques (si applicable)

- [ ] **Fiche technique incluse** : Motorisation/Dimensions/Perf (GEH auto)
- [ ] **Encadré au moins 1** : Comparatif/avis/angle complémentaire
- [ ] **Tableaux lisibles** : Mobile-friendly
- [ ] **Specs à jour** : Vérifiées sources officielles

### Vérifications finales

- [ ] **Pas erreurs ortho** : Relecture manuelle
- [ ] **Pas erreurs grammaire** : Temps, accords
- [ ] **Accents français OK** : é, è, ê, ç présents sans problème
- [ ] **Pas de doublons phrases** : Idées répétées
- [ ] **Conclusion présente** : Résumé + CTA doux

---

## ✅ PHASE IMAGES

### Sourcing

- [ ] **1 image trouvée** : "À la une"
- [ ] **Source documentée** : Envato/IONOS/web/IA
- [ ] **Droit d'utilisation** : Licence, crédit, approbation

### Préparation

- [ ] **Poids optimisé** : < 2 MB
- [ ] **Format correct** : JPG/PNG/WebP
- [ ] **Nom descriptif** : `sujet-description.jpg`
- [ ] **Encodage UTF-8** : Accents OK dans nom

### Métadonnées

- [ ] **Alt text** : Concis, descriptif, SEO
- [ ] **Caption** : Optionnel, plus détaillé
- [ ] **Crédit** : Si source externe (web/IA)

---

## ✅ PHASE YOAST SEO

### Focus Keyword

- [ ] **Défini** : 1-2 mots clés
- [ ] **Dans titre** : Au moins une occurrence
- [ ] **Dans contenu** : Naturellement (2-3×)
- [ ] **Pas de overstuffing** : Lisible, pas forcé

### Page Title (Métabalise <title>)

- [ ] **Longueur** : < 60 caractères
- [ ] **Focuskw inclus** : Pour SEO
- [ ] **Unique** : Différent autres articles site
- [ ] **Lisible** : Pas de jargon

### Meta Description

- [ ] **Longueur** : 150-160 caractères
- [ ] **Focuskw** : 1-2 occurrences naturelles
- [ ] **Appel à l'action** : "Découvrez", "Lire la suite", etc.
- [ ] **Unique** : Différent autres descriptions

### Readability

- [ ] **Yoast score** : Green (objectif)
- [ ] **Phrases courtes** : < 20 mots moyenne
- [ ] **Paragraphes courts** : < 150 mots
- [ ] **Transitions** : Naturelles entre sections
- [ ] **Passive limitée** : Préférer actif

---

## ✅ PHASE WORDPRESS

### Catégorie

- [ ] **Valide** : Existe dans WordPress site
- [ ] **Pertinente** : Thème article correspond
- [ ] **ID correct** : Vérifier en config

### Tags

- [ ] **Minimum 2** : Pour circulation interne
- [ ] **Pertinents** : Mot-clés article
- [ ] **Pas doublons** : Pas "Auto Auto"
- [ ] **IDs valides** : Existent dans WordPress

### Image "À la une"

- [ ] **Uploadée** : Media ID obtenu
- [ ] **Attachée** : featured_media = media_id
- [ ] **Lisible** : Alt text + caption OK
- [ ] **Responsive** : Bon mobile + desktop

### Statut & Publication

- [ ] **Statut : DRAFT** : Jamais publish automatique
- [ ] **Pas encore publié** : Brouillon uniquement
- [ ] **Modifiable** : Nettement pour approuver/modifier

### Encodage

- [ ] **UTF-8 explicite** : Header `Content-Type: application/json; charset=utf-8`
- [ ] **Accents français OK** : É, È, Ç affichés correctement
- [ ] **Pas alertes encoding** : Pas warning console

---

## ✅ APRÈS EXÉCUTION COMPLÈTE

### Validation immédiate

- [ ] **Brouillon créé** : HTTP 201 + `status: "draft"`
- [ ] **Lien OK** : `link` présent et accessible
- [ ] **Images chargées** : Featured media visible
- [ ] **Yoast rempli** : focuskw, title, metadesc visibles
- [ ] **Accents OK** : Pas garniture (é → é)

### Accès WordPress

1. Ouvrir brouillon (lien reçu)
2. Vérifier contenu :
   - [ ] Titre correct
   - [ ] Contenu complet (tous H2 présents)
   - [ ] Image à la une visible
   - [ ] Liens internes OK
   - [ ] Pas "..." incomplets

### Yoast Final Check

- [ ] **Focuskw** : Présent et comptabilisé
- [ ] **Title** : Correct et < 60 char
- [ ] **Meta desc** : Correct et 150-160 char
- [ ] **Green indicator** : Readability Green

### Jour nalisation

- [ ] **Inscrit Charte V8 §18** : Date/titre/lien/auteur
- [ ] **Traçabilité complète** : Auditable

---

## 🔴 EN CAS D'ERREUR

### Erreur 401 (Credentials)

- [ ] Vérifier `.claude/wp-credentials-{site}.local.json`
- [ ] Vérifier username/password corrects
- [ ] Vérifier user a droits "Author" ou "Editor"
- [ ] Tester curl manuel (debug)

### Erreur 403 (Droits User)

- [ ] Vérifier author_id dans config
- [ ] Vérifier user peut créer posts
- [ ] Vérifier categor_id accessible par user

### Docs locaux introuvables (Charte V8 / Voix)

- [ ] Vérifier `CP-PRESSE-AI/02_RULES/CHARTE_V8.md` existe
- [ ] Vérifier `CP-PRESSE-AI/03_VOIX/{site}.md` existe
- [ ] Vérifier chemin `local_docs` dans config site
- [ ] Si absent : Drive MCP en fallback, ou signaler à Nils

### Image 404 (IONOS)

- [ ] Vérifier lien IONOS actif
- [ ] Essayer navigateur direct
- [ ] Fallback web/IA
- [ ] Valider dossier structure

### UTF-8 Alerte

- [ ] Ajouter header explicite : `charset=utf-8`
- [ ] Vérifier fichiers sourcés UTF-8
- [ ] Vérifier HTML pas BOM-d

---

## 📊 Statuts d'avancement

| Phase | ☐ TODO | 🔄 IN PROGRESS | ✅ DONE |
|-------|--------|----------------|--------|
| Préparation | - | - | - |
| Rédaction | - | - | - |
| Images | - | - | - |
| Yoast | - | - | - |
| WordPress | - | - | - |
| Journalisation | - | - | - |

---

## 🎯 Résumé finalisation

**Avant validation finale** :
- [ ] Toutes cases cochées (Rédaction + Images + Yoast + WordPress)
- [ ] Zéro erreur WordPress
- [ ] Brouillon lisible
- [ ] Prêt relecture Nils

**Post-validation Nils** :
- [ ] Relecture éditoriale
- [ ] Corrections si requis
- [ ] Publik (manuel, après OK)

---

**Référence** : [[README.md]] | [[workflow.md]]
