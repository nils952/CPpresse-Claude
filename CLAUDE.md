# Projet Nils

Espace de travail centralisé de **Nils Martin**. Compte Claude partagé avec toute l'entreprise (CPpresse) : ce dossier sert à regrouper au même endroit le travail de Nils, séparé de celui des collègues.

## Qui est Nils
- Nils Martin, en alternance / lié à la rédaction CPpresse (marketing, rédaction d'articles web et print).
- Email du compte : comptacppresse@gmail.com
- Langue de travail : français.

## Comment travailler avec moi (Claude)
- Quand j'ouvre Claude Code dans ce dossier, c'est le contexte de Nils.
- Nils peut aussi taper la commande `/nils` depuis n'importe quel dossier : elle recharge cette fiche + `JOURNAL.md` et bascule la session ici (définie dans `~/.claude/commands/nils.md`).
- Tenir à jour `JOURNAL.md` : à chaque session, ajouter en haut une entrée datée avec ce qui a été fait / décidé / ce qui reste à faire.
- Ranger les fichiers de travail (brouillons, notes, docs) dans ce dossier ou des sous-dossiers thématiques.
- Au début d'une session, lire `JOURNAL.md` pour reprendre le fil.

## Comment me parler (style)
- Direct et efficace, sans blabla inutile.
- Pose des questions de clarification avant d'agir si le contexte n'est pas clair, plutôt que de deviner.
- Honnête même quand ce n'est pas agréable à entendre ; pas de flagornerie.
- Pour les décisions importantes, présente le pour/contre plutôt que de trancher à ma place.
- Adapte le niveau de détail à la complexité de la demande.
- Pas de tirets longs (em dashes) dans les réponses.

## Structure
- `CLAUDE.md` — ce fichier (contexte permanent).
- `JOURNAL.md` — journal de travail, entrée la plus récente en haut. Toujours lire l'entrée "FIN DE SESSION" la plus récente en premier : elle récapitule l'état du projet et ce qui reste en attente.

## Projet assistant rédaction (CP Presse)
- Depuis le 10/09/2026 : **Charte V8** = document unique de référence (remplace la V7 et fusionne les deux anciennes routines). Elle vit sur Google Drive (`00-Pilotage`), pas ici. Toujours la chercher par titre (en excluant `[PÉRIMÉ`/`[REMPLACÉE`/`[OBSOLÈTE`/`[FUSIONNÉ`), jamais par ID figé.
- 4 documents obligatoires à charger avant toute rédaction (ordre imposé par la charte) : (1) Charte V8, (2) fiche Voix éditoriale du site, (3) table de catégories du site, (4) **Journal d'exécution — CP Presse** (nouveau, `00-Pilotage`, obligatoire §18). Si un des quatre manque, s'arrêter et signaler — ne jamais deviner.
- Skill `/redaction [site] [sujet]` (`.claude/skills/redaction/SKILL.md`) : charge les 4 documents depuis Drive, écrit l'article, poste le brouillon sur WordPress, puis inscrit une ligne au journal d'exécution (sans ça l'article compte comme non produit).
- Sites pilotes actifs : GEH, Escapade, Maisons à Vivre (+ MAV Campagne, même WordPress, voix différente). Enduro Magazine, MX2K, Trail Adventure restent hors automatisation (publication manuelle uniquement).
- Identifiants WordPress (mots de passe d'application) stockés localement dans `.claude/wp-credentials-{site}.local.json`, jamais à partager ni committer.
- **Alerte sécurité (Charte V8 §19, à traiter par Nils)** : le fichier `Articles Nils.xlsx` sur Drive partagé contient un onglet MDP avec des mots de passe d'application WordPress en clair. La charte demande de les révoquer (pas juste déplacer) depuis WordPress et de les régénérer dans un gestionnaire de mots de passe.
- Archives photos/PDF du groupe : lien de partage IONOS HiDrive Next, accès déjà autorisé en permanence (voir `memory/ionos-hidrive-standing-access.md`).
