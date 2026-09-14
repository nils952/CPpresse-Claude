# Décisions Stratégiques

Archive des décisions prises qui ont structuré le projet.

---

## 12/09/2026 — Architecture Finale : Séparation .claude/ vs CP-PRESSE-AI/

**Décision** : Clarifier complètement la séparation des rôles.

- `.claude/` = couche technique Claude Code uniquement (commandes, skills, credentials, config)
- `CP-PRESSE-AI/` = source de vérité métier (règles, workflows, voix, configuration sites)

**Rationale** : Clarté, transferabilité (système fonctionne sans Claude), sécurité (pas de secrets en métier).

**Implémentation** :
- Créer `CP-PRESSE-AI/08_MEMORY/` (traçabilité décisions)
- Migrer contenu métier de `.claude/memory/` → `CP-PRESSE-AI/`
- Garder `.claude/memory/` que pour historique technique + références

**Impact** : Projet plus modulaire, indépendant, sécurisé.

**Statut** : ✅ Appliqué (12/09 session 13)

---

## 10/09/2026 — Skill /redaction Corrigée (v2)

**Décision** : Réécrire `/redaction` skill pour automatisation complète.

**Avant** : Alertes continues, pas de gestion Zeen, pas de dépôt WordPress automatique.

**Après (v2.1)** :
- ✅ Charge Charte V8 + Voix via MCP (search_files + read_file_content)
- ✅ Design Zeen automatique (destination→21, hôtel→42, service→1)
- ✅ Dépôt WordPress complet (titre, slug, cat, tags, Yoast, image)
- ✅ Statut brouillon obligatoire (jamais publish automatique)
- ✅ Encodage UTF-8 explicite
- ✅ Fichiers contexte site (`.claude/site-contexts/{site}.json`)

**Test requis** : `/redaction GEH "Voiture électrique 2026"` (Phase 3 du projet)

**Statut** : 🟡 Implémentation en cours (session 13)

---

## 11/09/2026 — Interdiction du Tiret Long

**Décision** : Interdire le tiret long (—) dans tous les articles web CP Presse.

**Motif** : Jugé "non naturel à l'écrit web" par Nils.

**Remplaçants** : virgule, point, deux-points, parenthèses (adapter au contexte).

**Validation** : Vérifier avant dépôt WordPress (correction à rédaction, pas a posteriori).

**Statut** : ✅ Appliqué (codifié dans STYLE_GUIDE.md)

---

## 09/09/2026 — Fiches Techniques Obligatoires

**Décision** : Inclure fiche technique complète + encadrés dans articles techniques.

**Motif** : Mail équipe 27/04/2026 — articles progressivement vidés de contenu enrichi (fiches, encadrés, comparatifs).

**Rubriques obligatoires** :
- MOTORISATION (type, puissance, couple, transmission, carburant/batterie)
- DIMENSIONS/CAPACITÉS (L/l/h, poids, coffre, places)
- PERFORMANCES/CONSO (vitesse, 0-100, autonomie, conso CO₂)

**Encadrés complémentaires** : comparatif concurrence, avis expert, angles supplémentaires.

**Applicable** : Essais auto, tests produit, guides techniques.

**Statut** : ✅ Documenté (FICHES_TECHNIQUES.md)

---

## 09/09/2026 — Limite Archives IONOS : 5 Derniers Numéros

**Décision** : Lors construction/vérification fiche voix éditoriale, limiter scan à 5 derniers numéros magazines (pas tout scanner).

**Motif** : Économiser temps/tokens sans sacrifier précision. Agents exploraient trop longtemps archives.

**Applicable** : Création/vérification fiches voix, audit éditorial contre archives réelles.

**Statut** : ✅ Codifié (VOIX/README.md)

---

## 08/09/2026 — Accès Permanent IONOS HiDrive

**Décision** : Standing permission pour accès lien public IONOS sans redemander à Nils.

**Lien** : `https://c01.storage.ionos.fr/s/n4wtRz7wkQFA5Ct` (FTP CPPRESSE, 433 Go, lecture seule)

**Usage** : Sourcer images articles, consulter archives pour voix éditoriales.

**Permissions** : Lecture seule (pas suppression/upload, bloqués par lien).

**Statut** : ✅ Autorisé (Nils 08/09)

---

## 🔮 FUTURE — Planning Éditorial (Module Proposé)

**Décision** : À prendre ultérieurement

**Objectif** : Créer module planning éditorial (calendrier édito, répartition sujets, éviter doublons).

**Scope proposé** :
- Calendrier hebdomadaire / mensuel par site
- Sujets planifiés vs réels
- Blocage sur doublons (prévention avant rédaction)
- Tendances anticipées (véille longue durée)
- Répartition charges (6-9 articles/site/semaine)

**Exemple workflow** :
1. `/planning [site] [period]` → Afficher planning
2. `/planning [site] [sujet] [date]` → Bloquer sujet date
3. Éviter doublon avant `/redaction`

**Impact** :
- Meilleur contrôle éditorial
- Cohérence ligne édito
- Scaling à 10+ sites possible

**Dépendances** :
- [x] Phase 3 : /redaction fonctionnel
- [ ] Phase 4+ : Planning implémentation
- [ ] Stockage : DB ou fichier JSON ?
- [ ] Priorité : MOYENNE (après validation Phase 3)

**Statut** : 🔮 Proposition en attente décision Nils

---

## Résumé

| Date | Domaine | Décision | Statut |
|------|---------|----------|--------|
| [FUTURE] | Système | Planning éditorial (module proposé) | 🔮 |
| 12/09 | Architecture | Séparation .claude/ vs CP-PRESSE-AI | ✅ |
| 10/09 | Skill | /redaction v2 (Zeen + WordPress auto) | 🟡 |
| 11/09 | Style | Tiret long interdit | ✅ |
| 09/09 | Règles | Fiches techniques obligatoires | ✅ |
| 09/09 | Processus | 5 derniers numéros (archives) | ✅ |
| 08/09 | Accès | IONOS HiDrive standing permission | ✅ |

---

---

## 12/09/2026 — Phase 4 Audit Escapade + MAV : Résolution nommage credentials MAV

**Contexte** : Audit Phase 4 révèle blocage critique — fichier credentials MAV mal nommé.

**Problème** :
- Fichier réel : `~/.claude/wp-credentials-mavc.local.json`
- Config attendue : `~/.claude/wp-credentials-mav.local.json`
- Contenu fichier : ✅ Correct (site=maisonsavivre-mag.fr)

**Diagnostic** :
- Pas de collision (aucun `mav.local.json` existant)
- Probablement typo historique (créé 2026-09-09)
- Pas de risque régression

**Décision prise** : Créer alias symlink
```bash
ln -s ~/.claude/wp-credentials-mavc.local.json ~/.claude/wp-credentials-mav.local.json
```

**Rationale** :
- Préserve `mavc.local.json` (audit trail)
- Crée alias `mav.local.json` (config attend)
- Transition sans suppression de fichier
- Docummente intention historique

**Implémentation** : À faire après approbation Nils (avant test MAV, après test Escapade).

**Statut** : 🔄 Décision documentée, attente implémentation

---

## 12/09/2026 — Phase 4 Étape 2+ : Ordre test multi-sites (séquentiel)

**Contexte** : Phase 3 GEH validée. Phase 4 audit identifié Escapade OK, MAV blocage credentials.

**Décision** : Plan test séquentiel (pas parallèle)

1. **Étape 2 — Escapade** (PROCHAINE)
   - Aucun blocage
   - Test réplication GEH → nouveau site
   - Cible : `/redaction escapade "Test système validation workflow"`
   - Critères succès : Draft créé, auteur=13, cat+tags valides, Zeen design=21 validé, Yoast visible

2. **Étape 3 — MAV** (APRÈS Escapade ✅)
   - Résoudre credentials alias d'abord
   - Puis test identique Escapade
   - Cible : `/redaction mav "Test système DIY"`
   - Critères succès : Draft créé, voix MAV respectée (DIY chiffré), design=42 validé

3. **Étape 4 — Module 09_EDITORIAL** (QUAND GEH+Escapade+MAV ✅)
   - Pré-validations (author_id, categories, tags)
   - Planning éditorial (6-9 articles/site/semaine)
   - Workflow complet (création → validation → publication)

**Rationale** :
- Escalade progressive (risque contrôlé)
- Chaque site doit être validé avant suivant
- Escapade = test réplication critique
- MAV = test contrainte éditoriale (DIY chiffré)
- 09_EDITORIAL = orchestration 3 moteurs

**Blocage si** :
- Escapade brouillon non créé → debug avant MAV
- MAV brouillon non créé → escalader à Nils
- Zeen design ID réel ≠ config → documenter écart

**Statut** : 🔄 Étape 2 (Escapade) prêt lancer

---

## 12/09/2026 — Phase 4 Validation Zeen : Design IDs par site

**Contexte** : Audit identifié configuration design ID, impossible vérifier via API REST.

**Décision** : Validation visuelle manuelle en interface WordPress.

**Design IDs par site** :
- GEH : Design=1 (déjà validé Phase 3 ✅)
- Escapade : Design=21 (à valider Étape 2)
- MAV : Design=42 (à valider Étape 3)

**Validation checklist par site** :
- [ ] WordPress admin active : Customizer → Zeen Settings
- [ ] Brouillon créé : Vérifier hero image affichée
- [ ] Mobile responsive : Tester affichage mobile + desktop
- [ ] Capture screenshot : Archiver design réel validé
- [ ] Documenter écart : Si design ID réel ≠ config supposée

**Si design ID réel ≠ config** :
1. Noter ID réel trouvé
2. Mettre à jour config JSON
3. Escalader à Nils pour décision (maj centrale?)

**Statut** : 🔄 À faire lors tests Escapade + MAV

---

## 13/09/2026 — Source unique credentials : racine projet, pas home

**Contexte** : Audit Escapade révèle que le fichier home `~/.claude/wp-credentials-escapade.local.json` (créé 09/09) avait divergé du fichier projet `.claude/wp-credentials-escapade.local.json` (mis à jour 09/11). La config pointait vers le home → HTTP 401.

**Décision** : Les credentials WordPress sont toujours référencés depuis la **racine projet** (`.claude/wp-credentials-{site}.local.json`), jamais depuis `~/.claude/`.

**Règle permanente** :
- `credentials_path` dans les configs sites = `.claude/wp-credentials-{shortname}.local.json`
- Si `~` est présent dans le chemin → remplacer par `.claude/`
- Document complet : `CP-PRESSE-AI/01_CONFIG/CREDENTIALS_RULES.md`

**Application** :
- Escapade ✅ : corrigé 13/09
- MAV : à corriger prochaine session
- GEH : à corriger prochaine session (pas urgent, fichiers synchrones)

**Annule** : L'ancienne convention `~/.claude/wp-credentials-{shortname}.local.json` ci-dessous.

**Statut** : ✅ Décision prise, Escapade appliqué

---

## Standard : Nommage credentials multi-sites (⚠️ REMPLACÉ par décision 13/09/2026)

**Convention établie** :
```
~/.claude/wp-credentials-{shortname}.local.json   ← OBSOLÈTE
.claude/wp-credentials-{shortname}.local.json      ← CORRECT
```
Où `{shortname}` = config JSON `shortname` (geh, escapade, mav, etc.)

**Déviation actuelle** :
- GEH ✅ : `wp-credentials-geh.local.json`
- Escapade ✅ : `wp-credentials-escapade.local.json`
- MAV ⚠️ : `wp-credentials-mavc.local.json` → alias créé → `wp-credentials-mav.local.json`

**Normalisation Phase 4+** :
- Tous nouveaux sites doivent respecter convention
- Audit pré-déploiement = vérifier correspondance
- Documenter écarts découverts

**Automatisation future** (Phase 5) :
Créer script validation credentials :
```bash
for site in $(ls CP-PRESSE-AI/01_CONFIG/sites/*.json | jq -r '.shortname')
  do
    expected="~/.claude/wp-credentials-${site}.local.json"
    if [ ! -f "$expected" ]; then
      echo "WARNING: Credentials manquants pour $site"
    fi
  done
```

**Statut** : ✅ Documenté, 🔄 Automatisation Phase 5

---

**Source** : Transcriptions sessions Claude, mémoire projet, validation Nils.
