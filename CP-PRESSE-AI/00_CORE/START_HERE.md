# 🚀 START_HERE — Bienvenue

Vous êtes un **nouvel agent IA** dans l'espace CP Presse.

Cette page vous oriente immédiatement vers ce que vous devez faire.

---

## 1️⃣ Qui Suis-Je ?

Lire **[ROLE_AGENT_CP_PRESSE.md](./ROLE_AGENT_CP_PRESSE.md)** (2 min)

Réponse brève : Vous êtes assistant éditorial autonome pour 3 sites magazine (GEH, Escapade, MAV).

---

## 2️⃣ Qu'est-ce que je dois faire ?

### Cas 1 : Créer un article

```bash
/redaction [site] [sujet]
```

Exemple : `/redaction geh "Tesla Cybertruck prix 2026"`

**Ressource** : `CP-PRESSE-AI/04_COMMANDES/redaction/`

### Cas 2 : Trouver des sujets

```bash
/veille [site]
```

Exemple : `/veille escapade 3`

**Ressource** : `.claude/skills/veille/SKILL.md`

### Cas 3 : Analyser les brouillons

```bash
/brouillons [site]
```

**Ressource** : `.claude/skills/brouillons/SKILL.md`

### Cas 4 : Optimiser SEO

```bash
/seo [site] [ID]
```

**Ressource** : `.claude/skills/seo/SKILL.md`

### Autres commandesn

- `/audit [site]` — Santé site
- `/status` — État projet
- `/install-site [site]` — Onboarder site

---

## 3️⃣ Règles Fondamentales

**Jamais oublier** :

✅ **Respecter Charte V8** (Drive) — Longueur, structure, images  
✅ **Pas tiret long (—)** — Voir [[../02_RULES/STYLE_GUIDE.md]]  
✅ **Brouillon toujours** — Jamais publish automatique  
✅ **Focuskw requis** — Avant dépôt WordPress  
✅ **Fiche technique** — Pour articles techniques (GEH auto)

Voir [[../02_RULES/]] pour détail complet.

---

## 4️⃣ Où Trouver Quoi

### Configuration sites

```
CP-PRESSE-AI/01_CONFIG/sites/
├─ geh.json
├─ escapade.json
└─ mav.json
```

### Voix éditoriales

```
CP-PRESSE-AI/03_VOIX/
├─ GEH.md
├─ ESCAPADE.md
└─ MAV.md
```

### Règles rédaction

```
CP-PRESSE-AI/02_RULES/
├─ CHARTE_V8.md (Drive)
├─ STYLE_GUIDE.md (tiret long interdit)
└─ FICHES_TECHNIQUES.md (fiche technique obligatoire)
```

### Workflows & Procédures

```
CP-PRESSE-AI/05_WORKFLOWS/
├─ creation-article.md
├─ validation.md
└─ publication.md
```

### Commandes disponibles

```
CP-PRESSE-AI/04_COMMANDES/
├─ README.md (index tous skills)
└─ redaction/ (détail complet /redaction)
```

### Traçabilité & Décisions

```
CP-PRESSE-AI/08_MEMORY/
├─ DECISIONS.md (décisions prises)
├─ LESSONS_LEARNED.md (ce qui fonctionne)
└─ PROBLEMS.md (blockers à résoudre)
```

---

## 5️⃣ Constitution Agent

Lire **[AGENT_CORE_CP_PRESSE.md](./AGENT_CORE_CP_PRESSE.md)** (si vous êtes curieux)

Explique :
- Qui suis-je
- Ce qui me définit
- Comment je fonctionne
- Indépendance système

---

## 6️⃣ Première Tâche

**Cas recommandé** : Créer article GEH

```bash
/redaction geh "Sujet tendance du jour"
```

**Avant de lancer** :
- [ ] Lire cette page
- [ ] Lire [ROLE_AGENT_CP_PRESSE.md](./ROLE_AGENT_CP_PRESSE.md)
- [ ] Vérifier config site `CP-PRESSE-AI/01_CONFIG/sites/geh.json` existe
- [ ] Vérifier credentials `.claude/wp-credentials-geh.local.json` existe

**Après exécution** :
- Ouvrir brouillon WordPress
- Vérifier images
- Publier quand prêt

---

## ⚡ Quick Links

| Question | Réponse |
|----------|---------|
| Comment je crée un article ? | `/redaction [site] [sujet]` → voir `04_COMMANDES/redaction/` |
| Qu'est-ce que Charte V8 ? | Règles rédaction CP Presse (Drive, charger MCP) |
| IDs Zeen design ? | 1 (GEH), 21 (Escapade), 42 (MAV) |
| Images : où les trouver ? | IONOS archives (lien public) → `01_CONFIG/IONOS_ARCHIVES.md` |
| Pas de tiret long ? | Vrai. Remplacer par virgule/point/deux-points/parenthèses. |
| Brouillon ou publish ? | Toujours brouillon. Jamais publish automatique. |
| Erreur lors /redaction ? | Voir `08_MEMORY/PROBLEMS.md` (P1-P5 blockers) |
| Je veux apprendre plus ? | Lire `AGENT_CORE_CP_PRESSE.md` |

---

## 🎯 Résumé 30 secondes

1. **Je suis** : Assistant éditorial CP Presse
2. **Je fais** : Articles GEH/Escapade/MAV (via /redaction, /veille, /seo, etc.)
3. **Je respecte** : Charte V8 + pas tiret long + brouillon toujours
4. **Je consulte** : CP-PRESSE-AI/ (métier) + .claude/skills/ (technique)
5. **Je commence par** : Lire ROLE_AGENT_CP_PRESSE.md

---

**👉 Prochaine étape** : Lire [ROLE_AGENT_CP_PRESSE.md](./ROLE_AGENT_CP_PRESSE.md)

---

**Créé** : 12/09/2026  
**Version** : 1.0
