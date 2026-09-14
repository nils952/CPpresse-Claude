# Projet Nils — CP PRESSE

Espace de travail centralisé de **Nils Martin**.  
Assistant éditorial autonome pour le groupe CP PRESSE.

---

## Démarrage rapide

**1. Lire le cœur du système**
```
CP-PRESSE-AI/00_CORE/AGENT_CORE_CP_PRESSE.md
```

**2. Lancer une commande**
```
/redaction GEH "Sujet"
/veille Escapade
/status
```

**3. Consulter l'architecture**
```
CP-PRESSE-AI/README.md
```

---

## Qui suis-je (Nils)

- Alternance / rédaction CP Presse (marketing, articles web/print)
- Email : nils@cppresse.fr
- Compte partagé : comptacppresse@gmail.com
- Langue : français

---

## Comment travailler

- **Architecture principale** : `CP-PRESSE-AI/` (transférable, autonome)
- **Contexte session** : `JOURNAL.md` (à jour après chaque session)
- **Style** : direct, efficace, honnête. Pas de tirets longs (—).

---

## Structure

| Dossier | Contenu |
|---|---|
| `CP-PRESSE-AI/00_CORE/` | Constitution de l'agent (charge en 1er) |
| `CP-PRESSE-AI/01_CONFIG/` | Config des sites (JSON) |
| `CP-PRESSE-AI/02_RULES/` | Référence aux règles (liens Drive) |
| `CP-PRESSE-AI/03_VOIX/` | Référence aux voix (liens Drive) |
| `CP-PRESSE-AI/04_COMMANDES/` | Les 7 skills |
| `CP-PRESSE-AI/05_WORKFLOWS/` | Processus (création, validation, pub) |
| `CP-PRESSE-AI/06_ARCHIVES/` | Anciennes versions (jamais charger) |
| `CP-PRESSE-AI/07_LOGS/` | Journalisation (liens Drive) |

---

## Commandes principales

- **`/redaction [site] [sujet]`** — Créer un article complet
- **`/veille [site]`** — Trouver des sujets
- **`/brouillons [site]`** — Analyser les brouillons WordPress
- **`/seo [site] [ID]`** — Optimiser Yoast
- **`/audit [site]`** — Santé générale du site
- **`/status`** — État du projet
- **`/install-site [site]`** — Onboarder un site

Détail complet : voir `CP-PRESSE-AI/04_COMMANDES/README.md`

---

## Sites actifs (pilotes)

- **GEH** (electriquemag.fr) — auto/électrique
- **Escapade** (escapade-mag.fr) — voyages
- **MAV** (maisonsavivre-mag.fr) — déco urbaine

Configuration : `CP-PRESSE-AI/01_CONFIG/sites/`

---

## Règles fondamentales

1. **Ne jamais inventer** — Charte V8 + Voix + sources réelles seulement
2. **Charge minimal** — Charger uniquement ce qui est nécessaire
3. **Statut brouillon** — Jamais publier directement (sauf demande explicite)
4. **Indépendance** — Le système fonctionne sans Claude, Drive, ou plateforme externe

---

## Après chaque session

Mettre à jour `JOURNAL.md` :

- Date
- Ce qui a été fait
- Décisions/blocages
- Reste à faire

Première chose à lire en session suivante.

---

## Chargement des documents

**Au démarrage** : AGENT_CORE uniquement.

**Pour une rédaction** : ajouter
- Charte V8 (Drive)
- Voix [site] (Drive)
- Contexte site (JSON local)
- Catégories (API WordPress)

**Ne jamais charger** : autres sites, archives, anciennes versions.

---

## Sécurité

- Credentials WordPress : **jamais** dans Git, ni dans ce fichier
- Stockage : `.claude/wp-credentials-{site}.local.json` (racine projet, jamais `~/.claude/` — voir `CP-PRESSE-AI/01_CONFIG/CREDENTIALS_RULES.md`)
- Pas de template avec `xxxx` — trop tentant

---

**Version** : 1.0  
**Dernière mise à jour** : 2026-09-12  
**Système** : CP-PRESSE-AI v1.0
