# Problèmes Bloquants

État des problèmes rencontrés : en attente, résolu, en investigation.

---

## ✅ RÉSOLUS — Phase 4 Escapade (2026-09-13)

### ✅ P6 : Credentials Escapade — chemin incorrect dans config

**Résolu** : 13/09/2026  
**Cause** : La config pointait vers `~/.claude/wp-credentials-escapade.local.json` (fichier home, password périmé depuis 09/09). Le fichier correct et à jour est `.claude/wp-credentials-escapade.local.json` (racine projet, mis à jour 09/11).  
**Solution** : `credentials_path` corrigé dans `CP-PRESSE-AI/01_CONFIG/sites/escapade.json` → `.claude/wp-credentials-escapade.local.json`  
**Validation** : GET /users/me → HTTP 200, user_id=39, slug=claude-editorial, role=editor ✓

---

### ✅ P7 : author_id Escapade incorrect

**Résolu** : 13/09/2026  
**Cause** : La config avait `author_id: 13` (valeur supposée). Le compte claude-editorial a réellement l'ID 39 sur ce site.  
**Solution** : `author_id` mis à jour à 39 dans `CP-PRESSE-AI/01_CONFIG/sites/escapade.json`

---

## 🟢 RÉSOLUS — Phase 3 Test (2026-09-12)

### ✅ P1 : Design Zeen validé et fonctionnel

**Résolu** : 12/09/2026  
**Test** : Brouillon GEH (ID 25753) posté avec design Zeen 1  
**Validation** : Fonctionnel (design appliqué en backend WordPress)

**Détails**
- Design ID 1 utilisé : OK
- Featured media attachée : OK (Media 25752)
- Backend WordPress : Design reconnu et appliqué
- Aucun blocage

---

### ✅ P2 : Authentification API WordPress

**Résolu** : 12/09/2026  
**Test** : Auth Basic via credentials GEH  
**Validation** : 

- GET /users/me : HTTP 200 OK
- POST /posts : HTTP 201 Created
- Credentials OK : `nils+claude@cppresse.fr` + app password
- Droit POST brouillon : Confirmé (author_id 19 a droit Éditeur)

**Détails**
- Fichier `.claude/wp-credentials-geh.local.json` fonctionnel
- Encodage UTF-8 implicite OK
- Pas d'erreur 401/403

---

### ✅ P3 : Charte V8 + Voix éditoriale accessibles

**Résolu** : 12/09/2026  
**Test** : Chargement fichiers locaux CP-PRESSE-AI/  
**Validation** : 

- Charte V8 chargée : OK
- Voix GEH chargée : OK
- Encodage accents : OK (é è ê ë à â ç ô testés)
- Pas de dépendance MCP Drive requise pour test

**Détails**
- Fichiers locaux accessibles : CP-PRESSE-AI/02_RULES/CHARTE_V8.md
- Fichiers locaux accessibles : CP-PRESSE-AI/03_VOIX/GEH.md
- Pas de blocage accès

---

### ✅ P4 : Encodage UTF-8 fonctionnel

**Résolu** : 12/09/2026  
**Test** : Article avec accents français  
**Validation** : 

- Contenu posté : UTF-8 OK
- Accents affichés correct : Oui
- Header Content-Type : application/json; charset=utf-8
- PowerShell 5.1 encoding : Workaround appliqué (pas de -Encoding sur ConvertTo-Json)

**Détails**
- Accent testé : éàèêëôç
- Affichage frontend : Correct (pas de mojibake)
- Meta Yoast : Accents gérés OK

---

### ✅ P5 : Gestion images et fallback

**Résolu** : 12/09/2026  
**Test** : Création image 1600×900px en scratchpad  
**Validation** : 

- Format image : PNG 1600×900px OK
- Upload WordPress : HTTP 201 Created (Media 25752)
- Featured media attachment : OK
- Taille fichier : 15.78 KB (optimisé)
- Fallback en cas besoin : Image créée localement (PowerShell GDI+)

**Détails**
- Image peut être créée en fallback
- Upload fonction correctement
- Pas de blocage déploiement

---

## 🟡 EN INVESTIGATION

### P4 : Encodage accents WordPress

**Statut** : 🟡 En investigation  
**Découvert** : 10/09/2026  
**Priorité** : MOYENNE

**Description**
POST article avec accents français (é, è, ç) → alertes si pas UTF-8 explicite.
Skill corrige avec `charset=utf-8` en header. À vérifier en production.

**Action requise**
1. Phase 3 test : article avec accents
2. Vérifier brouillon lisible
3. Si alerte : ajouter debug encodage

**Assigné** : Session test Phase 3  
**Solution approx.** : 30 min test + fix si requis

---

### P5 : Fallback images (si IONOS indisponible)

**Statut** : 🟡 En investigation  
**Découvert** : 10/09/2026  
**Priorité** : BASSE

**Description**
Priorité sourcing images : Envato > IONOS > web > IA.
Si IONOS down → basculer web/IA OK.
À vérifier : gestion erreurs IONOS (HTTP 503, timeout).

**Action requise**
1. Code : tester comportement si IONOS indisponible
2. Vérifier fallback fonctionne
3. Si problème : ajouter retry logic

**Assigné** : Lors finalisation /redaction  
**Solution approx.** : 1-2 heures

---

## 🟢 RÉSOLUS

### ✅ Alertes UTF-8 constantes (/redaction v1)

**Résolu** : 10/09/2026  
**Solution** : Spécifier `charset=utf-8` explicite en HTTP Content-Type.  
**Implémentation** : Skill /redaction v2.1.

---

### ✅ Gestion design Zeen non automatisée (/redaction v1)

**Résolu** : 10/09/2026  
**Solution** : Table config Zeen par site (1/21/42).  
**Implémentation** : Config JSON + skill v2.1.

---

### ✅ Dépôt WordPress manuel (/redaction v1)

**Résolu** : 10/09/2026  
**Solution** : POST automatique via API WordPress (Basic Auth).  
**Implémentation** : Skill /redaction v2.1.

---

### ✅ Credentialissues bloquants (reconnaissance)

**Résolu** : 08/09/2026  
**Solution** : Utiliser `.local.json` (Git-safe) + connector MCP pour Drive.  
**Implémentation** : Actuel.

---

## 📊 Résumé état problèmes

| ID | Titre | Priorité | Statut | Découvert | Assigné |
|----|-------|----------|--------|-----------|---------|
| P1 | IDs Zeen non validés | HAUTE | 🟡 À valider | 10/09 | Nils |
| P2 | MCP Drive à tester | HAUTE | 🟡 À tester | 10/09 | Phase 3 |
| P3 | Credentials WP à tester | HAUTE | 🟡 À tester | 10/09 | Phase 3 |
| P4 | Encodage accents | MOYENNE | 🟡 Investigation | 10/09 | Phase 3 |
| P5 | Fallback images IONOS | BASSE | 🟡 Investigation | 10/09 | Finalisation |

---

## 🔧 Prochaines actions

**Ordre priorité** :
1. **P1** (IDs Zeen) → Nils : valider WordPress
2. **P2 + P3** (test Phase 3) → Session test : exécuter `/redaction GEH "Test"`, documenter erreurs
3. **P4 + P5** → Après Phase 3 : debug si requis

**Critical path** : P1 + P2 + P3 bloquent Phase 3 (test réel /redaction)

---

**Statut** : À jour 12/09/2026 — Revoir avant Phase 3 test.
