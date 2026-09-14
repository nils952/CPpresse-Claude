# État du projet — CP PRESSE AI

**Dernière mise à jour** : 13/09/2026 (session 14)  
**Statut global** : 🟢 Phase 4 en cours — GEH, Escapade, MAV : credentials alignés et auth confirmée. Prêt pour premier article Escapade.

---

## Ce qui est validé

### Phase 3 — GEH ✅ (12/09/2026)

Workflow /redaction testé de bout en bout sur GEH (electriquemag.fr).

- Brouillon créé : ID 25755 (test workflow — à ne pas supprimer)
- Auth confirmé : user_id=19, rôle=editor
- Catégorie réelle : 57 (Actualités)
- Design Zeen : 1 (validé)
- Statut : draft garanti

### Skill /redaction — Fiabilisé (13/09/2026)

Réécriture complète. Changements critiques :

- **Source config** : `CP-PRESSE-AI/01_CONFIG/sites/{shortname}.json` (source unique — `.claude/site-contexts/` obsolète)
- **Fichiers locaux prioritaires** : Charte V8 et Voix chargées depuis `CP-PRESSE-AI/` — Drive jamais bloquant
- **Reporting** : chaque étape retourne `[ÉTAPE N — OK]` ou `[ÉTAPE N — ERREUR: cause]`
- **Credentials** : champ lu = `application_password` (pas `password`) ; chemin résolu depuis racine projet si `.`, depuis home si `~`

### Escalade pré-audit Escapade ✅ (13/09/2026)

- **Credentials** : fichier `.claude/wp-credentials-escapade.local.json` — HTTP 200 confirmé
- **user_id** : 39 (claude-editorial, rôle=editor)
- **Catégories** : 31 catégories réelles documentées dans `01_CONFIG/sites/escapade.json`
- **Tags** : 18 tags fréquents documentés
- **Config corrigée** : `credentials_path` → `.claude/...`, `author_id` → 39, `status` → active

---

## Problèmes ouverts

### MAV — résolu ✅ (13/09/2026, session 14)

- `credentials_path` corrigé dans `mav.json` : `~/.claude/...` → `.claude/wp-credentials-mav.local.json` (fichier du 09/11, source unique projet)
- Auth testée : HTTP 200
- **user_id réel = 19** (et non 13 comme documenté précédemment dans `CREDENTIALS_RULES.md` et `mav.json` — corrigé), rôle = editor
- `author_id` mis à jour dans `mav.json`

### GEH — harmonisé ✅ (13/09/2026, session 14)

`credentials_path` corrigé dans `geh.json` : `~/.claude/...` → `.claude/wp-credentials-geh.local.json`. Auth re-testée : HTTP 200, user_id=19, editor (cohérent avec la doc existante — les deux fichiers étaient bien identiques).

### Zeen design — validation visuelle en attente

Design ID 21 (Escapade) et 42 (MAV) non vérifiables via API. À valider visuellement sur le premier brouillon réel.

### Skills — source unique établie ✅ (13/09/2026, session 14)

Découverte en testant `/redaction` : Claude Code priorise toujours les skills **personal** (`~/.claude/skills/`) sur les skills **project** (`.claude/skills/`) en cas de conflit de nom. `/redaction` chargeait donc une version home périmée (12/09) malgré la correction projet du 13/09.

**Corrections appliquées** :
- `redaction` : ancien home archivé (`~/.claude/skills/OBSOLETE_ARCHIVE_skills/`), remplacé par une **jonction NTFS** `~/.claude/skills/redaction` → `Projet Nils/.claude/skills/redaction` (symlink impossible sans droits admin sous Windows ; jonction = équivalent fonctionnel pour un dossier). Vérifié par hash : contenu identique au fichier projet.
- `audit`, `brouillons`, `install-site`, `seo`, `status`, `veille` : **déplacés** (pas copiés) de `~/.claude/skills/` vers `.claude/skills/` du projet. Plus aucune copie home. Résolution vérifiée pour les 7 skills.
- `save` (générique, non spécifique CP Presse) : laissé tel quel dans le projet, à rationaliser plus tard.
- Références obsolètes corrigées au passage : `brouillons/SKILL.md`, `status/SKILL.md` (credentials `~/.claude/` → `.claude/`), `install-site/SKILL.md` (credentials + remplacement complet de `~/.claude/site-contexts/` par `CP-PRESSE-AI/01_CONFIG/sites/{site}.json`), `00_CORE/START_HERE.md`, `04_COMMANDES/redaction/README.md`, `CLAUDE.md` (section Sécurité).

**Règle établie** : tout skill spécifique à CP-PRESSE-AI vit exclusivement dans `.claude/skills/` du projet (source unique, versionnée Git). Une jonction/symlink home→projet n'est utilisée que si Claude Code impose la résolution personal (cas `/redaction`, seul skill ayant eu une divergence historique).

---

## Prochaine action

**Étape immédiate — premier article Escapade** :
- Lancer `/redaction escapade "sujet"` (sujet à définir avec Nils)
- Valider visuellement le brouillon (Zeen design 21, Yoast, images)

---

## Fichiers de référence

| Besoin | Fichier |
|--------|---------|
| Comprendre le rôle de l'agent | `CP-PRESSE-AI/00_CORE/ROLE_AGENT_CP_PRESSE.md` |
| Config Escapade (valeurs réelles) | `CP-PRESSE-AI/01_CONFIG/sites/escapade.json` |
| Config MAV (à corriger) | `CP-PRESSE-AI/01_CONFIG/sites/mav.json` |
| Config GEH (valide) | `CP-PRESSE-AI/01_CONFIG/sites/geh.json` |
| Règles credentials | `CP-PRESSE-AI/01_CONFIG/CREDENTIALS_RULES.md` |
| Skill /redaction (source) | `.claude/skills/redaction/SKILL.md` |
| Problèmes ouverts | `CP-PRESSE-AI/08_MEMORY/PROBLEMS.md` |
| Voix Escapade | `CP-PRESSE-AI/03_VOIX/ESCAPADE.md` |

---

## Référence rapide — IDs confirmés

| Site | author_id | Credentials | Statut config |
|------|-----------|-------------|---------------|
| GEH | 19 | `.claude/wp-credentials-geh.local.json` | ✅ Correct |
| Escapade | **39** | `.claude/wp-credentials-escapade.local.json` | ✅ Correct |
| MAV | **19** | `.claude/wp-credentials-mav.local.json` | ✅ Correct |
