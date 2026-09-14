# Workflow — Publier un article

Étapes finales avant mise en ligne.

## Avant publication (dans WordPress)

1. Relire brouillon complet
2. Lancer validation (voir `validation.md`)
3. Approuver (Nils uniquement)

## Publication

Dans WordPress BO :

1. Ouvrir le brouillon (ID article)
2. Vérifier tous les champs
3. Cliquer "Publier"
4. Vérifier en live (site public)

## Après publication

### Journalisation (obligatoire)

**Google Drive** : 00-Pilotage / Journal d'exécution — CP Presse

Ajouter ligne :
```
Date | Site | Sujet | Titre | ID WP | Lien | Source | Statut: PUBLIÉ | Date publication
```

### Mise à jour _sujets-traites.md

**Fichier** : `Projet Nils/Articles/_sujets-traites.md`

Ajouter :
```
YYYY-MM-DD | [site] | [sujet] | [titre] | [lien]
```

Empêche les doublons.

### Commit Git (si applicable)

```bash
git add JOURNAL.md Articles/_sujets-traites.md
git commit -m "Session YYYY-MM-DD : publication {site} {titre}"
```

**Attribution** :
```
Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

## Suivi post-publication

- [ ] Vérifier article visible en live
- [ ] Vérifier formatting (images, liens)
- [ ] Vérifier pas d'erreur typo en live
- [ ] Attendre indexation Google (24-72h)

## Republication (si correction)

Si erreur trouvée après publication :

1. Corriger dans WordPress
2. Ajouter note dans Journal d'exécution
3. Attendre Google reindex (~24h)

Pas de deuxième publication du même sujet.
