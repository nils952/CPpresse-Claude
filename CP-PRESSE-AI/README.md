# CP-PRESSE-AI — Agent éditorial autonome

Système complètement transférable et agent-agnostique pour automatiser la production éditoriale du groupe CP Presse.

## Architecture

```
CP-PRESSE-AI/

00_CORE/              ← Constitution permanente de l'agent
01_CONFIG/            ← Configuration des sites + contextes
02_RULES/             ← Références aux règles (Drive)
03_VOIX/              ← Références aux voix éditoriaux (Drive)
04_COMMANDES/         ← Les 7 skills (commandes)
05_WORKFLOWS/         ← Processus standardisés
06_ARCHIVES/          ← Versions obsolètes (jamais charger)
07_LOGS/              ← Journalisation + traçabilité

README.md             ← Ce fichier
MIGRATION_PLAN.md     ← Plan de migration depuis l'ancienne archi
```

## Démarrage rapide

### Pour Nils
```bash
cd Projet Nils
# Lire 00_CORE/AGENT_CORE_CP_PRESSE.md
# Lancer /redaction GEH "Sujet"
# Lancer /status
```

### Pour un nouvel agent
```bash
1. Lire CP-PRESSE-AI/00_CORE/README.md
2. Lire CP-PRESSE-AI/00_CORE/AGENT_CORE_CP_PRESSE.md
3. Consulter 01_CONFIG/sites/ pour les paramètres
4. Lancer une commande : /redaction [site]
```

## Principes

- ✅ **Autonome** : fonctionne sans Claude, Drive, ou plateforme externe
- ✅ **Transférable** : lisible par n'importe quel agent IA
- ✅ **Modulaire** : charger uniquement ce qui est nécessaire
- ✅ **Documenté** : chaque section a un README
- ✅ **Conservateur** : jamais de suppression (archives seulement)

## Commandes

| Commande | Rôle | Fichier |
|---|---|---|
| `/redaction` | Créer un article | `04_COMMANDES/redaction/SKILL.md` |
| `/veille` | Trouver des sujets | `04_COMMANDES/veille/SKILL.md` |
| `/brouillons` | Analyser les brouillons WP | `04_COMMANDES/brouillons/SKILL.md` |
| `/seo` | Optimiser Yoast | `04_COMMANDES/seo/SKILL.md` |
| `/audit` | Vérifier la santé du site | `04_COMMANDES/audit/SKILL.md` |
| `/status` | État du projet | `04_COMMANDES/status/SKILL.md` |
| `/install-site` | Onboarder un site | `04_COMMANDES/install-site/SKILL.md` |

## Workflows

| Processus | Fichier |
|---|---|
| Créer un article | `05_WORKFLOWS/creation-article.md` |
| Valider avant pub | `05_WORKFLOWS/validation.md` |
| Publier | `05_WORKFLOWS/publication.md` |

## Configuration

- **Sites actifs** : GEH, Escapade, MAV
- **Contextes** : `01_CONFIG/sites/*.json`
- **Credentials** : `.claude/wp-credentials-{site}.local.json` (jamais versionné, jamais `~/.claude/`)

## Documentation source

| Document | Localisation |
|---|---|
| Charte V8 | Google Drive / 00-Pilotage |
| Voix éditoriaux | Google Drive / 00-Pilotage / Voix éditoriales par site |
| Table catégories | Google Drive / 00-Pilotage |
| Journal exécution | Google Drive / 00-Pilotage |

## Indépendance

Ce système **ne dépend d'aucune plateforme spécifique** :

- Pas de dépendance Claude
- Pas de dépendance Google (Drive utilisé mais pas obligatoire)
- Pas de dépendance propriétaire
- Format : Markdown + JSON pur

Un autre agent IA peut reprendre ce projet sans modification.

## Historique

Voir `MIGRATION_PLAN.md` pour le passage de l'architecture ancienne à celle-ci.

---

**Version** : 1.0  
**Date création** : 2026-09-12  
**Maintenu par** : Nils Martin (CP Presse)
