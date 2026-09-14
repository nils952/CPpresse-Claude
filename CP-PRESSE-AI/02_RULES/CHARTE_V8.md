# Charte rédactionnelle et SEO — CP Presse V8

**Source** : Google Drive / 00-Pilotage / CHARTE RÉDACTIONNELLE ET SEO  
**Dernière synchronisation** : 2026-09-12  
**Statut** : ACTIVE  
**Validité** : Actualisée chaque mois (si changement sur Drive, mettre à jour cette copie)

---

## Ton par site

### GEH (Génération Électrique & Hybride)

- **Positionnement** : Référence technique auto-électrique
- **Ton** : Factuel, informatif, orienté utilisateur
- **Cible** : Acheteurs électrique, curieux, comparateurs
- **Spécifique** : Distinguer annonce vs réalité, chiffrer (kWh, prix, autonomie)
- **Vocabulaire interdit** : "révolutionnaire", "miracle", "enfin"
- **Lisibilité** : Phrases courtes (max 25 mots), transitions obligatoires

### Escapade Magazine

- **Positionnement** : Inspiration voyages, destination-first
- **Ton** : Éditorial, narratif, expérience lecteur
- **Cible** : Voyageurs en quête d'inspiration, familles, couples
- **Spécifique** : Destination avant produit/hôtel, récit d'expérience
- **Vocabulaire interdit** : Clichés touristiques ("plongez", "découvrez"), trop "très"
- **Lisibilité** : Rythme narratif, descriptions évocatrices

### Maisons à Vivre (MAV)

- **Positionnement** : Déco urbaine contemporaine, DIY chiffré
- **Ton** : Premium-accessible, expert-bienveillant
- **Cible** : Propriétaires urbains, 30-50 ans, sensibles design
- **Spécifique** : Prix affichés, coûts/temps/difficulté pour projets, marques réelles
- **Vocabulaire interdit** : Flou ("ambiance", "feel") — être précis
- **Lisibilité** : Structuré, listes à puces, données claires

### Maisons à Vivre Campagne (MAVC)

- **Positionnement** : Patrimoine, brocante, matières anciennes
- **Ton** : Narratif, atmosphérique, expertise soft
- **Cible** : Campagnards, collectionneurs, amateurs patrimoine
- **Spécifique** : Histoire des objets, marques anciennes, tendances saisonnières
- **Tolérance style** : Paragraphes 4 phrases/35 mots (vs 3/25 ailleurs), "très" 1x/article accepté
- **Lisibilité** : Prose plus littéraire admise

---

## Règles universelles

### Structure article

**Obligatoire** :
1. H1 unique (mot-clé principal)
2. Chapô max 3 phrases (accrocheuse)
3. Corps : H2 (sous-titres clairs)
4. Minimum 2 liens internes
5. Conclusion : 2 phrases max, pas de CTA

**Longueur** : 600-1200 mots (idéal 800-1000)

### Yoast SEO (obligatoire avant pub)

- **Focuskw** : défini, dans H1, corps (100 premiers mots), métadesc, ≥1 H2, alt image
- **Titre SEO** : 50-60 caractères
- **Métadesc** : 150-160 caractères
- **Slug** : propre, pas de stopwords inutiles
- **Score** : VERT obligatoire (rouge = pas de pub)
- **Lisibilité** : orange minimum, vert idéal

### Images

- **Format hero** : 1600×900px minimum (16:9)
- **Alt** : mot-clé + description précise (ex. "Tesla Model 3 électrique, parking urbain")
- **Titre** : nom lisible du sujet (ex. "Tesla Model 3 2026 vue extérieure")
- **Légende** : crédit si visible (ex. "© Tesla")
- **Description** : source interne (ex. "Kit presse Tesla 2026 — Drive CP Presse")

### Liens internes

- **Minimum** : 2 (idéal 3-4, jamais > 5)
- **Ancrage** : naturel, pertinent
- **Cible** : vérifier URLs existent

### Vocabulaire interdit

**Partout** :
- Tirets longs (—) → remplacer par virgule, point, deux-points
- Emojis
- "Découvrez", "plongez" (Escapade)
- Clichés secteur

**Par site** : voir "Ton par site" ci-dessus

### Lisibilité

- **Phrases passives** : < 10%
- **Mots de transition** : ≥ 20% (entre, cependant, donc, etc.)
- **Phrases consécutives** : jamais 3 commençant par le même mot
- **Paragraphes** : max 3-4 phrases / 25 mots (MAVC exception : 4/35)

### Anti-doublon

- Vérifier `_sujets-traites.md` ou Drive
- Reformulation obligatoire (pas de copier-coller)

### Journalisation

**Après chaque article** : ajouter ligne dans Drive / Journal d'exécution — CP Presse

Champs :
- Date
- Site
- Sujet
- Titre article
- ID WordPress
- Lien édition
- Source matière
- Priorité
- Statut
- Date publication

---

## Règles WordPress

**Statut** : Brouillon par défaut (jamais publier directement)

**Avant création** :
- Vérifier auteur
- Vérifier catégorie (table de ref)
- Vérifier slug (pas de `-2`, `-3`)
- Préparer image

**Après création** :
- Mettre à jour journal d'exécution
- Ajouter dans `_sujets-traites.md`
- Attendre relecture Nils

---

## Gestion des erreurs

**Si** : doc absent / accès impossible / catégorie inconnue / source insuffisante

**Alors** : STOP. Expliquer le blocage. Ne jamais improviser.

---

## Maintenance de cette copie

Cette copie locale doit rester synchronisée avec la source Drive.

**Fréquence** : vérifier mensuellement (ou sur demande).

**Procédure** : comparer avec Drive, mettre à jour CURRENT.md de la session, reporter changements ici.

**Historique** : chaque évolution documentée dans CHANGELOG (CP-PRESSE-AI/00_CORE/).

---

## Notes importantes

- Pas de dépendance Claude — ce document reste lisible par tout agent IA
- Format Markdown pur
- Pas d'interprétation — juste les règles écrites
