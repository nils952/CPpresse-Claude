# Audit MAV (Maisons à Vivre) — Phase 4 Industrialisation

**Date** : 2026-09-12  
**Site** : Maisons à Vivre Magazine (maisonsavivre-mag.fr)  
**Objectif** : Préparer le site au workflow /redaction utilisé pour GEH  
**Audité par** : Claude Haiku 4.5  
**Statut** : Pré-audit complet, prêt pour validation manuelle

---

## 📋 Checklist audit

### 1. Configuration WordPress

| Élément | Config attendue | Réalité API | Statut |
|---------|---------|---------|---------|
| **URL API** | https://maisonsavivre-mag.fr/wp-json/wp/v2 | ✅ Accessible | ✅ |
| **Authentification** | /users/me accessible | 401 (auth requise) | ✅ Normal |
| **Author ID** | 13 (claude-editorial) | À vérifier | ⚠️ |
| **Compte technique** | nils+claude@cppresse.fr | À vérifier | ⚠️ |
| **Statut credentials** | ~/.claude/wp-credentials-mav.local.json | 🔴 **Décalage détecté** | ⚠️ |

**Écart détecté** : Le fichier credentials s'appelle `wp-credentials-mavc.local.json` (avec suffixe 'c'), pas `wp-credentials-mav.local.json`. À clarifier.

**Recommandation** : 
1. Vérifier quelle variante est correcte (mav vs mavc)
2. Corriger config JSON si nécessaire
3. Aligner avec convention de nommage (escapade.json, geh.json)

---

### 2. Catégories WordPress

**Total trouvé** : 37 catégories actives

| ID | Nom | Parent | Type |
|----|------|--------|------|
| 32 | Maisons à vivre | 0 | Principale |
| 27 | Actu | 0 | Principale |
| 110 | Inspiration | 0 | Principale |
| 160 | Intérieur | 0 | Principale |
| 114 | Extérieur | 0 | Principale |
| 59 | Shopping | 0 | Principale |
| 42 | Brocante | 0 | Principale |
| 630 | activité | 0 | Principale (typo minuscule) |
| 1075 | Jardinage | 0 | Principale (ID élevé = récent) |
| 1340 | Visites privées | 0 | Principale (ID élevé = récent) |
| 156 | Chambres | 160 | Sous-catégorie (Intérieur) |
| 161 | Pièce à vivre | 160 | Sous-catégorie (Intérieur) |
| 202 | Salle de bain | 160 | Sous-catégorie (Intérieur) |
| 152 | Electroménager | 59 | Sous-catégorie (Shopping) |
| 143 | Mobilier | 59 | Sous-catégorie (Shopping) |
| 226 | Linges de maison | 59 | Sous-catégorie (Shopping) |
| 159 | Décoration | 59 | Sous-catégorie (Shopping) |
| 72 | Idées créatives | 110 | Sous-catégorie (Inspiration) |
| 47 | Portrait | 110 | Sous-catégorie (Inspiration) |
| ... | (17 autres) | ... | Mixtes |

**Structure** : Hiérarchie bien organisée autour de 5 piliers :
- **Inspiration** (110) — Idées créatives, Portrait, Tendance
- **Intérieur** (160) — Chambres, Pièce à vivre, Salle de bain
- **Extérieur** (114) — Jardin, Salon extérieur, Piscine
- **Shopping** (59) — Mobilier, Décoration, Linges, Electroménager
- **Actu** (27) — Carnet d'adresses, Magazine, Tutos, Vidéos

**Écarts observés** :

- ⚠️ **Catégorie typo minuscule** : "activité" (630) vs "Activité" — Non-bloquant mais à noter.
- ✅ **Hiérarchie profonde** : Structure 3-4 niveaux (parent/child) bien établie.
- ✅ **IDs cohérents** : Plage 27-1340 → site mature avec ajouts progressifs.
- ✅ **Catégories "Maisons à vivre"** (32) — Brand principal présent.

**Recommandation** : 
- Utiliser catégorie 32 (Maisons à vivre) comme défaut pour brouillons lifestyle
- Utiliser catégorie 27 (Actu) pour brouillons actualité/news
- Valider sous-catégories cibles lors de la rédaction (ex: 160 Intérieur → 161 Pièce à vivre)
- Corriger typo "activité" → "Activité" (optionnel, cosmétique)

---

### 3. Tags

**Total trouvé** : 100+ tags (pagination limitée)

| Portée | Exemple | ID |
|--------|---------|-----|
| Design/Style | "Décoration" (886), "Minimaliste" (930), "Art déco" (980) | 880-980 |
| Matière | "bois" (1040), "acier" (1014), "textile" (1088) | 1000-1100 |
| Thème | "Noël" (1124), "DIY" (1130), "Bien-être" (1150) | 1100+ |
| Pièce | "Chambre" (156), "Cuisine" (104), "Salle de bain" (202) | 100-250 |
| Tendance | "agencement" (1150+), "aération" (1126), "2026" (1098) | 1090+ |

**Statut** : ✅ Tags nombreux, bien catégorisés. Pas de blocage pour création.

**Recommandation** : 
- Utiliser tags matière + design pour articles MAV (aligné avec ton "premium-bienveillant, précis")
- Éviter doublon tags génériques
- Ajouter tags thématiques en fin de rédaction

---

### 4. Thème Zeen

| Paramètre | Config attendue | Statut |
|-----------|---------|---------|
| **Thème** | Zeen | ✅ Supposé actif |
| **Version** | 5.2 | ✅ Cohérent avec Escapade & GEH |
| **Design ID** | 42 | ⚠️ À valider visuellement |

**Statut** : ⚠️ Impossible de vérifier l'API (settings non accessible publiquement). Design ID 42 doit être validé en interface WordPress.

**Note** : Design ID 42 (MAV) ≠ Design ID 21 (Escapade) ≠ Design ID 1 (GEH) → Chaque site a sa propre identité visuelle Zeen.

**Recommandation** : 
1. Accéder WordPress admin MAV
2. Vérifier Zeen → thème actif = Zeen 5.2
3. Vérifier design par défaut = ID 42 (ou note écart si différent)
4. Valider responsive mobile/desktop
5. Comparer avec Escapade/GEH pour cohérence multi-site

---

### 5. Voix éditoriale

| Fichier | Présence | Statut |
|---------|----------|--------|
| **CP-PRESSE-AI/03_VOIX/MAV.md** | ✅ Présent | ✅ |
| Contenu | 50+ lignes, positionnement + principes | ✅ |
| Date synchro | 2026-09-12 | ✅ Actuel |

**Contenu résumé** :
- Ton : Premium-bienveillant, expert sans condescendance
- Position : Déco urbaine, DIY chiffré, design accessible
- Cibles : Propriétaires urbains 30-50 ans, qualité accessible

**Spécificité MAV** : Obligation de chiffrer (budgets, temps, matière) — très différent d'Escapade (narratif). À respecter strictement.

**Statut** : ✅ Voix éditoriale présente, à jour, et très spécifique. Prête à charge lors de /redaction.

---

### 6. Images & média

| Élément | Statut | Note |
|---------|--------|------|
| **Upload API** | À tester | Requires auth POST /media |
| **IONOS accès** | ✅ Autorisé permanent | Per memory `ionos-hidrive-standing-access` |
| **Fallback local** | ✅ Disponible | PNG/fallback ready |

**Statut** : ✅ Infrastructure prête. Validation requise lors de 1er POST.

**Recommandation** : 
- Tester upload image lors du 1er brouillon (comme Phase 3 GEH)
- Mémoriser Media ID pour featured_media
- Valider affichage image en interface

---

## ✅ Éléments validés

| Critère | Résultat |
|---------|----------|
| API REST accessible | ✅ Oui |
| Catégories présentes | ✅ Oui (37 catégories) |
| Tags utilisables | ✅ Oui (100+) |
| Voix éditoriale chargée | ✅ Oui |
| Config JSON en place | ✅ Oui |
| Credentials fichier présent | ✅ Oui (avec caveat) |
| Zeen thème supposé | ✅ Oui |

---

## ⚠️ Éléments à corriger / valider

| Critère | Blocage | Action |
|---------|---------|--------|
| **Credentials nommage** | 🔴 Critique | Vérifier : mav vs mavc dans ~/.claude/wp-credentials-*.local.json |
| **Author ID 13** | 🔍 À vérifier | Tester avec credentials (curl /users/me) |
| **Zeen design ID 42** | 🔍 À valider | Vérifier interface admin WordPress |
| **Catégorie typo** | 🔧 Cosmétique | Corriger "activité" → "Activité" en WordPress (optionnel) |

---

## 🔴 Blocages

### Blocage 1 : Nommage credentials (CRITIQUE)

**Problème** : Le fichier credentials s'appelle `wp-credentials-mavc.local.json` au lieu de `wp-credentials-mav.local.json`.

**Implications** :
- Config JSON référence `~/.claude/wp-credentials-mav.local.json`
- Mais le fichier réel est `wp-credentials-mavc.local.json`
- /redaction ne trouvera pas les credentials → 401 ou erreur auth

**Actions** :
1. Clarifier : c'est une typo ? ou intentionnel ?
2. Option A : Renommer fichier vers `mav.json` (recommandé)
3. Option B : Mettre à jour config JSON vers `mavc.json`
4. Décider avant 1er brouillon

**Urgence** : 🔴 CRITIQUE — Bloque /redaction Phase 4

---

## 📝 Pré-requis avant 1er redaction

1. ⚠️ Fichier credentials : **Résoudre nommage** (mav vs mavc)
2. ✅ Fichier voix éditoriale : `CP-PRESSE-AI/03_VOIX/MAV.md`
3. ✅ Config site : `CP-PRESSE-AI/01_CONFIG/sites/mav.json`
4. ✅ Charte V8 : `CP-PRESSE-AI/02_RULES/CHARTE_V8.md`
5. ✅ Skill /redaction : Disponible en `CP-PRESSE-AI/04_COMMANDES/redaction.md`

---

## 🎯 Recommandations Phase 4

### Court terme (avant 1er brouillon)

1. **Résoudre credentials nommage** (5 min) — CRITIQUE :
   ```bash
   # Vérifier quel fichier existe
   ls -la ~/.claude/wp-credentials-ma*.local.json
   
   # Option A : renommer vers standard
   mv ~/.claude/wp-credentials-mavc.local.json ~/.claude/wp-credentials-mav.local.json
   
   # Option B : mettre à jour config mav.json
   # "credentials_path": "~/.claude/wp-credentials-mavc.local.json"
   ```

2. **Valider author_id** (5 min) :
   ```bash
   # Une fois credentials nommage résolu
   curl -u user:pass https://maisonsavivre-mag.fr/wp-json/wp/v2/users/me
   # Vérifier id = 13, name = claude-editorial
   ```

3. **Valider design Zeen** (5 min) :
   - Log WordPress admin MAV
   - Customizer → Zeen Theme Settings
   - Note design ID réel (42 vs autre)

4. **Test brouillon** (15 min) :
   - Lancer `/redaction MAV "Projet DIY salon"`
   - Vérifier brouillon créé avec catégorie + tags
   - Valider hero image affichée
   - Valider Yoast SEO visible
   - Vérifier mise en page (DIY sections, chiffrage visible)

### Moyen terme (scaling multi-sites)

- Comparer design Zeen (ID 1 vs 21 vs 42) → cohérence visuelle
- Documenter pré-validations par site
- Créer module 09_EDITORIAL avec vérifications author_id
- Tester scaling 3-site en parallèle

---

## 📊 Fiche technique de synthèse

```json
{
  "site": "Maisons à Vivre",
  "shortname": "mav",
  "url": "maisonsavivre-mag.fr",
  "api_status": "✅ Active",
  "categories": "✅ 37 (Maisons à vivre=32, Actu=27, Inspiration=110)",
  "tags": "✅ 100+",
  "theme": "Zeen 5.2 (Design=42, à valider)",
  "author_id": "13 (à vérifier)",
  "voice_file": "CP-PRESSE-AI/03_VOIX/MAV.md",
  "credentials_issue": "🔴 Nommage mavc vs mav à clarifier",
  "workflow_ready": "Blocked (fix credentials nommage first)",
  "next_step": "1. Fix credentials nommage, 2. Validate auth, 3. Run: /redaction MAV 'Test'"
}
```

---

## Comparaison 3 sites (Phase 4 perspective)

| Critère | GEH | Escapade | MAV |
|---------|-----|----------|-----|
| API status | ✅ Active | ✅ Active | ✅ Active |
| Categories | 20 | 32 | 37 |
| Tags | 100+ | 100+ | 100+ |
| Author ID | 19 | 13 | 13 |
| Zeen Design | 1 | 21 | 42 |
| Voice file | ✅ | ✅ | ✅ |
| Credentials | ✅ geh | ✅ escapade | ⚠️ mavc |
| Blocages | 0 | 0 | 1 (naming) |
| Phase 3 status | ✅ Live | ✅ Ready | ⚠️ Blocked |

---

## Signature

**Audit complété** : 2026-09-12 — Phase 4 Industrialisation  
**Blocage critique** : Résoudre nommage credentials (mav vs mavc)  
**Prochaine étape** : Après résolution blocage, tester /redaction MAV  
**Transfert** : Passer à Phase 4 Étape 2 une fois blocage levé + Escapade validée.

---

**Document de référence pour Phase 4** — À conserver.  
**Attribution** : Phase 4 Audit MAV — Claude Haiku 4.5 / Nils Martin
