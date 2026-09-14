# Apprentissages

Ce qui fonctionne bien, ce qui ne marche pas, pièges à éviter.

---

## ✅ Ce qui fonctionne

### Architecture modulaire (CP-PRESSE-AI/)

La séparation claire des dossiers (00_CORE, 01_CONFIG, 02_RULES, etc.) facilite :
- Navigation
- Maintenabilité
- Onboarding nouvel agent
- Transfert de projet

**Leçon** : Garder cette structure. Ajouter `.md` README à chaque niveau d'explication.

### Configuration JSON (sites/)

Stocker config sites en `.json` (pas en YAML, pas en base de données) permet :
- Lecture facile (même outil script ou humain)
- Versioning Git
- Pas de dépendance externe

**Leçon** : Continuer `.json` pour toute config site.

### Charte V8 comme référence unique

Une seule source de vérité pour :
- Style rédactionnel
- Longueur articles
- Structure obligatoire (H1/H2, chapô)
- Sources images
- Journal d'exécution

**Leçon** : Charger Charte V8 dans CHAQUE workflow rédaction (pas mémoriser en dur).

### MCP search_files + read_file_content (pour Drive)

Utiliser connecteur MCP pour accéder Drive plutôt que Chrome réel :
- Zéro alerte d'authentification
- Encodage UTF-8 géré
- Plus rapide

**Leçon** : Préférer MCP quand possible. Chrome réel = dernier recours.

### Credentials en .local.json (non commités)

Stocker credentials WordPress en `.claude/wp-credentials-{site}.local.json` :
- Protégé par `.gitignore`
- Accessible au skill
- Jamais en Git

**Leçon** : Ne JAMAIS mettre creds en dur. Toujours `.local.json` + `.gitignore`.

---

## ⚠️ Ce qui ne marche pas bien

### Stocker règles métier en .claude/memory/

Risques :
- Confusion : c'est technique ou métier ?
- Oubli de consulter (trop de mémoires)
- Duplication (mémoire + CP-PRESSE-AI/)

**Leçon** : Mémoire = technique + références uniquement. Métier = CP-PRESSE-AI/ uniquement.

### WebDAV IONOS (401)

Accès via `/public.php/webdav/` = non fonctionnel (401 auth).

**Leçon** : Utiliser Browser tool directement sur lien public. Pas de WebDAV pour IONOS.

### Alertes UTF-8 sur WordPress

POST avec accents → alertes si encodage non explicite en HTTP headers.

**Leçon** : Toujours spécifier `charset=utf-8` en Content-Type lors POST WordPress.

### Designs Zeen pas standardisés

IDs design Zeen variant par thème. Pas de "design standard" universel.

**Leçon** : Valider IDs design pour chaque site (19 = GEH test OK, 21/42 à vérifier).

---

## 🚨 Pièges à éviter

### ❌ Charger TOUTES les archives IONOS

Risque : Explosion temps/tokens en exploration.

**Prévention** : Limiter à 5 derniers numéros magazines (voir DECISIONS.md 09/09).

### ❌ Publier article directement (pas brouillon)

Risque : Article public sans relecture, impossible annuler.

**Prévention** : Skill /redaction impose `status: draft`. Jamais publish automatique.

### ❌ Oublier focuskw dans Yoast

Risque : Article non optimisé SEO, brouillon incomplet.

**Prévention** : Checklist /redaction : focuskw requis avant dépôt.

### ❌ Utiliser tiret long (—)

Risque : Article rejeté ou modifié post-pub.

**Prévention** : Rechercher/remplacer — avant dépôt. Vérifier dans HTML brut.

### ❌ Credentials dans .gitignore vérification insuffisante

Risque : Accidentellement committer creds (même si `.gitignore` en place).

**Prévention** :
1. Vérifier `.gitignore` à chaque nouvelle cred
2. `git status` avant commit
3. Ne jamais faire `git add .` aveuglément

### ❌ Dépendances externes (Drive, APIs, IONOS)

Risque : Service hors ligne → skill échoue.

**Prévention** : Toujours avoir fallback (ex: images IA si IONOS indisponible).

---

## 📊 Tableau comparatif : Approches testées

| Approche | Avantages | Inconvénients | Verdict |
|----------|-----------|--------------|---------|
| Creds en Git (.gitignore) | Simple | Risque oubli .gitignore | ✅ Acceptable (vigilance) |
| Creds en env vars | Sûr | Complexe setup | ⚠️ À tester |
| Creds en .local.json | Lisible, Git-safe | Fichier manuel | ✅ Actuel |
| Mémoire métier en .claude/ | Centralisé | Confusion rôle | ❌ À éviter |
| Mémoire métier en CP-PRESSE-AI/ | Source unique | Plus de dossiers | ✅ Nouveau standard |
| WebDAV IONOS | Automatisable | 401 non résolu | ❌ Abandonner |
| Browser direct IONOS | Fonctionne | Manuel | ✅ Actuel |
| Charger TOUTES archives | Exhaustif | Coûteux tokens | ❌ À limiter |
| 5 derniers numéros | Équilibre | Pas exhaustif | ✅ Nouveau standard |

---

## 🎯 Recommandations futures

1. **Monitorer coût tokens** — /redaction consomme (rédaction + images + POST). Tracker par exécution.
2. **Valider IDs design Zeen** — Phase 3, faire audit WordPress (quels IDs font quoi).
3. **Tester env vars** — Évaluer si moins risqué que .local.json pour creds.
4. **Documenter API WordPress** — Créer référence interne : endpoints, champs, formats.
5. **Audit credentials régulier** — Vérifier mensuel : aucun cred en .gitignore check fail.

---

**Statut** : Vivant — mettre à jour à chaque apprentissage nouveau.
