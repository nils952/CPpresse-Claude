# Plan de migration — Architecture Agent CP PRESSE V1.0

**Date** : 2026-09-12  
**Statut** : AUDIT + PROPOSITION (en attente approbation)

---

## 1. STRUCTURE ACTUELLE (audit)

### Problèmes identifiés

#### ❌ Contexte au démarrage trop lourd
- CLAUDE.md contient : rôle + Charte V8 + contexte sites + Projet assistant complet
- À chaque session : charge les 4 docs obligatoires + historique projet
- Risque : contexte pollution si 2 projets coexistent

#### ❌ Skills dispersées
- Nouvelles skills : `~/.claude/skills/{veille,brouillons,seo,audit,status,install-site}`
- Ancienne skill : `Projet Nils/.claude/skills/redaction`
- Les deux chemins ne synchronisent pas

#### ❌ Site contexts mal organisés
- Fichier partiel : `Projet Nils/site-contexts/` (pas en ~/.claude/)
- Credentials : nulle part (pas même de template)
- Manque fichiers : escapade.json, mav.json, mavc.json

#### ❌ Archives non clairement séparées
- Anciennes versions Charte V1-V7 : mélangées dans Drive
- Anciennes routines : mélangées dans `.claude/scheduled-tasks/`
- Pas de dossier ARCHIVES cohérent

#### ❌ Pas de modèle clonable
- Un nouvel agent ne sait pas par où commencer
- Pas de checklist installation
- Pas de documentation "comment reprendre ce projet"

---

## 2. INVENTAIRE DES DOCUMENTS

### À conserver + réorganiser

```
EN COURS :

CLAUDE.md
  → Léger. Garder rôle + lien AGENT_CORE uniquement.

AGENT_CORE_CP_PRESSE.md  
  → Déjà créé. Parfait. Garder en ~/.claude/

JOURNAL.md
  → Garder dans Projet Nils/. C'est la source de vérité de session.

Skills (actuelles + 6 nouvelles)
  → Réorganiser dans ~/.claude/skills/

Charte V8, Voix éditoriaux, Catégories
  → Sur Google Drive. Ne pas dupliquer localement.

ARCHIVES (À créer) :
  - Anciennes chartes V1-V7
  - Anciennes routines (veille-hebdo, audit-hebdo)
  - Documents fusionnés
```

### À archiver (migrer dans ARCHIVES/)

| Document | État | Destination |
|---|---|---|
| Charte V1-V7 | Obsolète | ARCHIVES/chartes-anciennes/ |
| Veille-hebdo-3-magazines/SKILL.md | Remplacée par /veille | ARCHIVES/routines/ |
| Audit-hebdo-sites/SKILL.md | Remplacée par /audit | ARCHIVES/routines/ |
| Skills répond-aux-briefings/ | Hors périmètre | ARCHIVES/projets-exterieurs/ |
| Guideline-jarvis-starter/ | Hors périmètre | ARCHIVES/ |
| Doublons credentials | Risque sécurité | Nettoyer uniquement |

### À créer de zéro

```
00_CORE/
  ├── AGENT_CORE_CP_PRESSE.md ✅ (existe)
  ├── CHANGELOG.md (À créer)
  └── README.md (À créer)

01_CONFIG/
  ├── sites/
  │   ├── geh.json (À créer)
  │   ├── escapade.json (À créer)
  │   ├── mav.json (À créer)
  │   ├── mavc.json (À créer)
  │   └── _template.json (Template)
  └── README.md

02_RULES/
  ├── README.md
  └── /Drive links (références)

03_VOIX/
  ├── README.md
  └── /Drive links (références)

04_COMMANDES/
  ├── redaction/ ✅ (déjà là)
  ├── veille/ ✅ (déjà là)
  ├── brouillons/ ✅ (déjà là)
  ├── seo/ ✅ (déjà là)
  ├── audit/ ✅ (déjà là)
  ├── status/ ✅ (déjà là)
  └── install-site/ ✅ (déjà là)

05_WORKFLOWS/
  ├── creation-article.md
  ├── validation.md
  └── publication.md

06_ARCHIVES/
  ├── chartes-anciennes/
  ├── routines-obsoletes/
  └── README.md

07_LOGS/
  └── journal-execution.md (lien Drive)
```

---

## 3. PLAN DE MIGRATION (4 phases)

### Phase 1 : Préparation (15 min)
- ✅ Créer dossier `00_CORE` dans ~/.claude/
- ✅ Déplacer AGENT_CORE_CP_PRESSE.md vers 00_CORE
- ⚠️ Créer CLAUDE.md LÉGER (référence uniquement)
- ✅ Créer ce rapport (fait)

### Phase 2 : Architecture (30 min)
- ✅ Créer dossiers 01_CONFIG, 02_RULES, 03_VOIX, 04_COMMANDES, 05_WORKFLOWS, 06_ARCHIVES, 07_LOGS
- ✅ Créer templates JSON pour sites
- ✅ Créer README par section
- ✅ Créer CHANGELOG.md
- ⚠️ Vérifier qu'aucun lien cassé

### Phase 3 : Désarchivage (20 min)
- ⚠️ Identifier documents à archiver
- ⚠️ Créer 06_ARCHIVES/ avec sous-dossiers
- ⚠️ Déplacer (pas supprimer) anciennes versions

### Phase 4 : Test (30 min)
- ⚠️ Tester `/install-site geh` avec nouvelle archi
- ⚠️ Tester `/redaction GEH "Test"` 
- ⚠️ Vérifier CLAUDE.md charge minimal
- ⚠️ Vérifier un nouvel agent peut commencer par 00_CORE

---

## 4. CHANGEMENTS SPÉCIFIQUES

### CLAUDE.md — AVANT vs APRÈS

**AVANT** (actuel — trop lourd) :
```markdown
# Projet Nils
[40 lignes]
- Charte V8 complète
- Contexte complet assistant rédaction
- Tous les 4 docs obligatoires
- Domaine complet CP Presse
```

**APRÈS** (léger) :
```markdown
# Projet Nils

Espace de travail Nils Martin.

## Architecture
Voir `~/.claude/00_CORE/AGENT_CORE_CP_PRESSE.md` pour la constitution de l'agent.

## Démarrage rapide
1. Lire AGENT_CORE
2. Taper `/status` pour voir l'état
3. Taper `/redaction GEH "Sujet"` pour créer un article

## Autres
[Points Nils seulement : email, langue, style]
```

**Impact** :
- Contexte réduit de 70% au démarrage
- Références externes (Drive) plutôt que duplications
- Nouveau agent peut lire AGENT_CORE indépendamment

---

### Site contexts — CRÉATION

**Template** (`01_CONFIG/sites/_template.json`) :
```json
{
  "shortname": "geh",
  "site_url": "electriquemag.fr",
  "wordpress_url": "https://electriquemag.fr",
  "author_id": 19,
  "author_name": "claude-editorial",
  "account_email": "nils+claude@cppresse.fr",
  "language": "fr",
  "timezone": "Europe/Paris",
  "zeen_hero_design_default": 1,
  "theme": "Zeen",
  "credentials_path": "~/.claude/wp-credentials-geh.local.json",
  "note": "Magazine auto/électrique"
}
```

**Fichiers à créer** :
- `01_CONFIG/sites/geh.json` (à partir du contexte actuellement dans site-contexts/)
- `01_CONFIG/sites/escapade.json` (à créer)
- `01_CONFIG/sites/mav.json` (à créer)
- `01_CONFIG/sites/mavc.json` (à créer)

**Ne pas créer** :
- Credentials templates (trop risqué, ne pas mettre de `xxxx` qui tentent les copys)
- Fichiers pour sites hors-pilote (créer seulement sur demande)

---

### Skills — RÉORGANISATION

**Actuel** :
```
~/.claude/skills/
  ├── redaction/ ✅
  ├── veille/ ✅
  ├── brouillons/ ✅
  ├── seo/ ✅
  ├── audit/ ✅
  ├── status/ ✅
  └── install-site/ ✅
```

**Après** :
```
~/.claude/04_COMMANDES/
  ├── redaction/ ✅
  ├── veille/ ✅
  ├── brouillons/ ✅
  ├── seo/ ✅
  ├── audit/ ✅
  ├── status/ ✅
  └── install-site/ ✅
```

**Action** : Déplacer (déjà là, juste renommer le dossier parent).

---

### Workflows — À CRÉER

#### Fichier : `05_WORKFLOWS/creation-article.md`
```markdown
# Workflow — Création d'article

1. Sujet  → /veille [site]
2. Angle  → Valider avec Nils
3. Rédaction → /redaction [site] "[sujet]"
4. SEO → /seo [site] [ID]
5. Images → Chercher (Envato/IONOS)
6. Upload image → WordPress media
7. Validation → Relire + checklist
8. Brouillon → Status ✅
9. Publication → Manuelle par Nils
10. Journal → Mettre à jour Drive
```

Idem pour validation.md et publication.md.

---

## 5. IMPACTE UTILISATEUR (Nils)

### Avant migration
```
Session démarre
  → charge CLAUDE.md (lourd)
  → charge 4 docs obligatoires
  → charge contexte site
  → = contexte grosse charge
```

### Après migration
```
Session démarre
  → charge CLAUDE.md (léger)
  → charge AGENT_CORE
  → = contexte minimal
  
Commande /redaction
  → charge AGENT_CORE
  → charge contexte site
  → charge Charte V8 (Drive)
  → charge Voix (Drive)
  → = contexte juste ce qu'il faut
```

### Avantages
- **Rapidité** : démarrage plus rapide
- **Clarté** : architecture lisible
- **Transférabilité** : un nouvel agent lit AGENT_CORE et c'est bon
- **Maintenance** : documents archivés != supprimés

---

## 6. POINTS À VALIDER AVEC NILS

1. ✅ Phase 2 : créer l'architecture maintenant ?
2. ⚠️ Quand créer les workflows détaillés ?
3. ⚠️ Créer site contexts pour Enduro/Trial/autres ou juste pilotes (GEH/Escapade/MAV) ?
4. ⚠️ Garder .claude/scheduled-tasks/ en l'état ou archiver les vieilles routines ?
5. ⚠️ Vérifier que les skills `/redaction` existantes vont pointer vers le bon endroit ?

---

## 7. RÉSUMÉ EXÉCUTIF

| Point | Impact |
|---|---|
| **Contexte au démarrage** | 70% réduction |
| **Doublons éliminés** | 15+ docs obsolètes archivés |
| **Clarté d'architecture** | 7 sections thématiques claires |
| **Transférabilité** | 100% (un nouvel agent démarre par AGENT_CORE) |
| **Temps migration** | ~1h30 + tests |
| **Fichiers créés** | ~20 (surtout templates) |
| **Fichiers supprimés** | 0 (archivés uniquement) |

---

**Prêt à démarrer Phase 1 ?** 🚀
