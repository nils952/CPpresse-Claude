# Commande /redaction

Créer un article complet en un seul appel : rédaction + images + Yoast SEO + dépôt WordPress (brouillon).

**Statut** : 🟡 En finalisation (Phase 3 test)  
**Priorité** : HAUTE  
**Lien skill** : `.claude/skills/redaction/SKILL.md`

---

## Syntaxe

```bash
/redaction [site] [sujet]
```

### Paramètres

| Param | Type | Exemple | Notes |
|-------|------|---------|-------|
| `[site]` | String | GEH, Escapade, MAV | Doit être configuré (`CP-PRESSE-AI/01_CONFIG/sites/{site}.json`) |
| `[sujet]` | String | "Cupra Born 2026", "Road trip Provence" | Sujet article (tendance, actu, angle) |

### Exemples

```bash
/redaction geh "Tesla Cybertruck prix France 2026"
/redaction escapade "5 jours en Norvège : fjords et aurores"
/redaction mav "Aménager petit studio 30m² : 7 astuces"
```

---

## Entrées Requises

Avant lancer `/redaction`, vérifier :

- [ ] **Site actif** : Configuration existe (`CP-PRESSE-AI/01_CONFIG/sites/{site}.json`)
- [ ] **Credentials** : `.claude/wp-credentials-{site}.local.json` présent et valide
- [ ] **Accès Drive** : Charte V8 + Voix [{site}] accessibles (MCP)
- [ ] **Accès IONOS** : Lien public archives (voir [[IONOS_ARCHIVES.md]])
- [ ] **Accès WordPress API** : Endpoint de publication accessible

---

## Sorties Garanties

Exécution complète produit :

1. **Brouillon WordPress** : Article créé en statut `draft`
2. **Champs complétés** :
   - Titre (30-60 char, focuskw inclus)
   - Slug (URL-friendly)
   - Contenu HTML (500-1200 mots)
   - Chapô (2-3 lignes, excerpt)
   - Catégorie (via config site)
   - Tags (minimum 2)
   - Image à la une (si trouvée)
3. **Yoast SEO** :
   - Focus keyword (focuskw)
   - Page title
   - Meta description
   - Readability (viser Green)
4. **Design Zeen** : Design ID correct par site (1/21/42)
5. **Journal** : Inscrit dans Charte V8 §18 (traçabilité)

---

## Workflow Complet

Voir **[workflow.md](./workflow.md)** pour détail étape par étape.

### Résumé phases

1. **Préparation** : Charger Charte V8, voix, config, credentials
2. **Rédaction** : Respecter Charte, appliquer voix, longueur 500-1200 mots
3. **Images** : Sourcer priorité Envato > IONOS > web > IA
4. **SEO** : Yoast : focuskw, title, metadesc
5. **WordPress** : POST brouillon (UTF-8 explicite)
6. **Journal** : Inscrire exécution

---

## Configuration Requise

### CP-PRESSE-AI/01_CONFIG/sites/{site}.json

**Source unique** — ne jamais utiliser `.claude/site-contexts/` (chemin obsolète, abandonné). Voir `_template.json` pour le format complet réel (shortname, credentials_path, local_docs, categories, etc.).

### .claude/wp-credentials-{site}.local.json

Format (voir `CP-PRESSE-AI/01_CONFIG/CREDENTIALS_RULES.md`) :
```json
{
  "site": "example-mag.fr",
  "username": "nils+claude@cppresse.fr",
  "application_password": "xxxx xxxx xxxx xxxx xxxx xxxx",
  "account_role": "compte dédié \"claude editorial\"",
  "created": "YYYY-MM-DD",
  "note": "..."
}
```

---

## Consignes Applicables

Respecter lors rédaction :

- **[[CHARTE_V8.md]]** — Règles rédactionnelles complètes
- **[[STYLE_GUIDE.md]]** — Pas de tiret long (—)
- **[[FICHES_TECHNIQUES.md]]** — Inclure fiche technique (si applicable)
- **[[VOIX/{site}.md]]** — Applique ton site
- **[[IONOS_ARCHIVES.md]]** — Source images priorité

---

## Validation Checklist

Avant dépôt, cocher :

**Rédaction**
- [ ] Titre (30-60 char)
- [ ] Focuskw (1-2 mots)
- [ ] Slug (URL-friendly)
- [ ] Chapô (2-3 lignes)
- [ ] H1 + 2-3 H2
- [ ] 500-1200 mots
- [ ] Minimum 2 liens internes
- [ ] Pas de — (tiret long)
- [ ] Voix éditoriale appliquée

**Images**
- [ ] 1 image trouvée
- [ ] Source documentée
- [ ] Droit d'utilisation confirmé

**SEO**
- [ ] Focus keyword défini
- [ ] Page title (< 60 char)
- [ ] Meta description (< 160 char)

**WordPress**
- [ ] Catégorie valide
- [ ] Tags (minimum 2)
- [ ] Image attachée
- [ ] Statut : BROUILLON
- [ ] UTF-8 OK

Voir **[checklist.md](./checklist.md)** pour versio complète.

---

## Après Exécution

### ✅ Si succès

1. Ouvrir brouillon WordPress
2. Vérifier images
3. Compléter si nécessaire
4. Publier (manuel, quand prêt)

### ⚠️ Si erreur

Consulter **[[../../../08_MEMORY/PROBLEMS.md]]** :
- P1 : IDs Zeen invalides
- P2 : MCP Drive indisponible
- P3 : Credentials WP 401/403
- P4 : Encodage accents

---

## Tests

**Phase 3 du projet** (session suivante) :
```bash
/redaction geh "Sujet test"
```

**Attendu** :
- Brouillon créé
- Yoast complet
- Images OK
- 0 alerte

---

## Lié à

- [[workflow.md]] — Détail étapes
- [[checklist.md]] — Validation complète
- `.claude/skills/redaction/SKILL.md` — Implémentation
- [[CHARTE_V8.md]] — Référence rédactionn elle
- [[IONOS_ARCHIVES.md]] — Sources images
- [[../../../08_MEMORY/DECISIONS.md#-102026--skill-redaction-corrigée-v2]] — Historique

---

**Version** : 2.1 (10/09/2026)  
**Statut** : 🟡 Finalisation Phase 3
