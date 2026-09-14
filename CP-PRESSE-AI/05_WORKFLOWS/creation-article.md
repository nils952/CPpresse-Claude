# Workflow — Créer un article

## Étapes

### 1. Sujet
**Commande** : `/veille [site] [N articles]`

Lister 3-5 sujets pertinents pour le site.

**Valider avec Nils** : quel sujet partir en priorité ?

### 2. Angle
Préciser le point de vue unique.

Exemple (Escapade) :
- ❌ "Voyager en Suisse"
- ✅ "Suisse automne : 3 trails dans les Alpes sans foule"

**À vérifier** : pas déjà traité (voir `_sujets-traites.md` ou Drive).

### 3. Rédaction
**Commande** : `/redaction [site] "[sujet]"`

- Charge Charte V8 + Voix du site + Catégories
- Rédige l'article (800-1200 mots)
- Applique Yoast SEO (focuskw, titre, metadesc)
- Génère fiche WordPress (JSON ou .md)

### 4. Relecture (par Nils)
- Lire titre + chapô + conclusion
- Vérifier ton (voix du site)
- Vérifier pas de "très" / emojis / tirets longs
- Vérifier sourçage (pas d'invention)

### 5. Images
- Chercher image hero (1600×900px min)
- Source prioritaire : Envato Elements (abonnement Nils) → IONOS HiDrive → Unsplash
- Préparer alt + titre + crédit
- Uploader dans WordPress media

### 6. Optimisation SEO
**Commande** : `/seo [site] [ID article]`

Valider :
- ✅ Focuskw dans H1 et corps (100 premiers mots)
- ✅ Titre SEO : 50-60 caractères
- ✅ Métadesc : 150-160 caractères
- ✅ Lisibilité Yoast : orange ou vert (jamais rouge)
- ✅ Pas de phrase consécutives identiques

### 7. Brouillon WordPress
Le brouillon est créé automatiquement par `/redaction` (statut "draft").

Vérifier dans WordPress :
- ✅ Catégorie correcte
- ✅ Tags présents
- ✅ Image à la une
- ✅ Auteur : claude-editorial
- ✅ Yoast vert

### 8. Journalisation
**Localisation** : Google Drive / 00-Pilotage / Journal d'exécution — CP Presse

Ajouter une ligne :
```
Date | Site | Sujet | Titre article | ID WP | Lien édit | Source | Priorité | Statut | Nils validé | Publication date
```

## Prêt pour publication
Article est en brouillon, Yoast vert, images ok, journalisé.

Prochaine étape : `/validation` pour la checklist finale avant pub.
