# 04_COMMANDES — Skills de l'Agent

Répertoire des commandes agent éditorial.

**Architecture** :
- **Métier** (ce dossier) : Logique, workflows, consignes
- **Technique** : `.claude/skills/{skill}/SKILL.md` (implémentation)

---

## Commandes

### /redaction

**Créer un article complet** : rédaction + images + Yoast SEO + brouillon WordPress

#### Documentation

- **[README.md](./redaction/README.md)** — Syntaxe, entrées/sorties
- **[workflow.md](./redaction/workflow.md)** — Détail 6 phases
- **[checklist.md](./redaction/checklist.md)** — Validation complète

#### Implémentation technique

- **[.claude/skills/redaction/SKILL.md](./../../../.claude/skills/redaction/SKILL.md)**

#### Ressources applicables

- [[../02_RULES/CHARTE_V8.md]] — Règles rédaction
- [[../02_RULES/STYLE_GUIDE.md]] — Pas tiret long
- [[../02_RULES/FICHES_TECHNIQUES.md]] — Fiche technique (GEH auto)
- [[../03_VOIX/]] — Voix par site
- [[../01_CONFIG/IONOS_ARCHIVES.md]] — Sourcer images

#### Statut

🟡 Finalisation (Phase 3 test)

**Lancé par** : `/redaction [site] [sujet]`

---

### /veille

**Identifier sujets d'articles** pour un site (tendances, actu, archives)

#### Ressources

- **[.claude/skills/veille/SKILL.md](./../../../.claude/skills/veille/SKILL.md)** — Implémentation

**Lancé par** : `/veille [site] [nombre]`

---

### /brouillons

**Analyser brouillons WordPress** d'un site (classer par statut)

#### Ressources

- **[.claude/skills/brouillons/SKILL.md](./../../../.claude/skills/brouillons/SKILL.md)** — Implémentation

**Lancé par** : `/brouillons [site]`

---

### /seo

**Optimiser Yoast SEO** : focuskw, title, metadesc, readability

#### Consignes

- Focuskw requis (obligatoire avant brouillon)
- Page title < 60 char
- Meta description 150-160 char
- Readability viser Green

#### Ressources

- **[.claude/skills/seo/SKILL.md](./../../../.claude/skills/seo/SKILL.md)** — Implémentation

**Lancé par** : `/seo [site] [ID|titre]`

---

### /audit

**Analyser santé site** : structure, doublons, contenus, auteurs

#### Ressources

- **[.claude/skills/audit/SKILL.md](./../../../.claude/skills/audit/SKILL.md)** — Implémentation

**Lancé par** : `/audit [site] [--deep]`

---

### /status

**État du projet** : derniers travaux, blocages, prochaines actions

#### Ressources

- **[.claude/skills/status/SKILL.md](./../../../.claude/skills/status/SKILL.md)** — Implémentation

**Lancé par** : `/status [site | --full]`

---

### /install-site

**Onboarder site** : clone config, setup WordPress, checklist

#### Ressources

- **[.claude/skills/install-site/SKILL.md](./../../../.claude/skills/install-site/SKILL.md)** — Implémentation

**Lancé par** : `/install-site [nom-site]`

---

## Lancement Rapide

```bash
/redaction GEH "Nouvelle Tesla électrique"
/veille escapade 3
/brouillons mav
/seo geh 12053
/audit escapade --deep
/status
/install-site newsite
```

---

## Archi tecture

### Séparation Métier / Technique

**Ce dossier (métier)** :
- Logique processus
- Consignes rédactionnelles
- Validations
- Workflows documentés

**.claude/skills/ (technique)** :
- Implémentation Claude Code
- Appels API WordPress
- Gestion MCP/Drive/IONOS
- Gestion credentials

### Avantages

- ✅ Métier indépendant du runtime Claude
- ✅ Transferable (peut fonctionner ailleurs)
- ✅ Documentable sans code
- ✅ Auditabilité tracée

---

## Consignes Globales

Toute commande doit respecter :

1. **[../02_RULES/CHARTE_V8.md](../02_RULES/CHARTE_V8.md)** — Constitution agent
2. **[../02_RULES/STYLE_GUIDE.md](../02_RULES/STYLE_GUIDE.md)** — Pas tiret long
3. **[../02_RULES/FICHES_TECHNIQUES.md](../02_RULES/FICHES_TECHNIQUES.md)** — Enrichissement articles

---

## Nouvelles Commandes

Pour ajouter un skill :

1. Créer dossier : `.claude/skills/{skill}/`
2. Créer fichier technique : `.claude/skills/{skill}/SKILL.md`
3. Créer doc métier : `CP-PRESSE-AI/04_COMMANDES/{skill}/README.md` (si complexe)
4. Lier depuis ce README
5. Documenter dans `[[08_MEMORY/DECISIONS.md]]`

---

## Statut Commandes

| Commande | Version | Statut | Priorité |
|----------|---------|--------|----------|
| **/redaction** | 2.1 | 🟡 Finalisation | HAUTE |
| **/veille** | 1.0 | ✅ Opérationnel | MOYENNE |
| **/brouillons** | 1.0 | ✅ Opérationnel | MOYENNE |
| **/seo** | 1.0 | ✅ Opérationnel | MOYENNE |
| **/audit** | 1.0 | ✅ Opérationnel | BASSE |
| **/status** | 1.0 | ✅ Opérationnel | BASSE |
| **/install-site** | 1.0 | ✅ Opérationnel | BASSE |

---

**Référence** : [[08_MEMORY/DECISIONS.md]] | [[08_MEMORY/PROBLEMS.md]]
