# Fiches Voix Éditoriales

Chaque site CP Presse a une **voix distinctive** — ton, structure, vocabulaire — définis par ses archives réelles.

---

## Fiches Disponibles

- **[GEH.md](./GEH.md)** — Auto / Électrique (electriquemag.fr)
- **[ESCAPADE.md](./ESCAPADE.md)** — Voyages (escapade-mag.fr)
- **[MAV.md](./MAV.md)** — Déco urbaine (maisonsavivre-mag.fr)

---

## Comment Utiliser

### Dans /redaction

1. Lancer commande : `/redaction [site] [sujet]`
2. Skill charge fiche voix correspondante
3. Applique ton + structure + vocabulaire à la rédaction

**Exemple** :
```bash
/redaction geh "Peugeot E-3008 2026"
# → charge GEH.md
# → ton tech/service + structure vs reportage + focus électrique
```

---

## Construire une Nouvelle Fiche Voix

### Source : Archives IONOS

Consulter archives réelles sur IONOS HiDrive (voir [[IONOS_ARCHIVES.md]]).

### Limite : 5 Derniers Numéros

⚠️ **Consigne importante** (09/09/2026)

Limiter scan archives à **5 derniers numéros** du magazine (pas scanner tout le dossier).

#### Pourquoi

- Capture le **tone actuel** (pas drift historique)
- Économise **tokens** (évite exploration exhaustive)
- **Suffisant** pour établir patterns éditoriaux

#### Antipattern

❌ **Dont** : Explore 50 numéros, tous sous-dossiers, documentations anciennes  
✅ **Do** : Ouvrir dossier magazine → sélectionner 5 plus récents → lire 1-2 articles par numéro

### Méthodologie

1. **Accéder IONOS** (lien public, voir [[IONOS_ARCHIVES.md]])
2. **Ouvrir** : `/FTP CPPRESSE/{magazine}/Numéros archivés/`
3. **Sélectionner** : 5 derniers numéros (date / couverture)
4. **Lire** : 1-2 articles par numéro minimum
   - Éditorial (voix directeur)
   - Reportage principal (ton narratif)
   - Service/pratique (ton conseillant)
5. **Documenter**

### Éléments à Noter

| Dimension | À Observer | Exemple |
|-----------|-----------|---------|
| **Ton général** | Formel, ludique, expert, complice | GEH = expert + service |
| **Structure type** | Intro → sections → conclusion | Chapô court + 2-3 H2 |
| **Vocabulaire récurrent** | Mots/expressions clés | "électrique", "autonomie", "recharge" |
| **Longueur moyenne** | Mots par article | 800-1200 mots |
| **Sujets dominants** | Themes prioritaires | Voitures électriques, recharge |
| **Angle éditorial** | Service? Reportage? Critique? | Mix service/reportage/test |

### Template Fiche Voix

```markdown
# [Site] — Voix Éditoriale

**Magazine** : [Titre]  
**URL** : [www.site.fr]  
**Domaine** : [Sujet principal]

## Ton général
[Formel/ludique/expert/etc.]

## Structure article type
[H1 + chapô + 2-3 sections + conclusion]

## Vocabulaire clé
- mot1
- mot2
- expr3

## Longueur
[moyenne mots par article]

## Sujets dominants
- sujet1
- sujet2

## Angle éditorial
[Service/reportage/critique/mix]

## Exemples
- Article 1 : [lien], résumé
- Article 2 : [lien], résumé

**Sources** : 5 derniers numéros IONOS (dates XX-YY/2026)
```

---

## Utilisation dans /redaction

### Chargement automatique

Skill /redaction :
1. Récupère fiche voix [{site}.md]
2. Applique ton à la rédaction
3. Valide contre structure attendue

### Validations

- [ ] Ton respecté (formel/ludique/expert)
- [ ] Structure type appliquée (H1/H2, chapô)
- [ ] Vocabulaire cohérent avec fiche
- [ ] Longueur dans plage (mots)
- [ ] Angle éditorial respecté

---

## Maintenance

### Quand mettre à jour

- Tous les 3-6 mois (évolution tone)
- Après changement éditorial (nouveau rédac chef, repositionnement)
- Sur signalement Nils (feedback rédaction)

### Comment mettre à jour

1. Relire 5 derniers numéros actuels
2. Comparer vs fiche existante
3. Mettre à jour [{site}.md]
4. Dater la modif (header "Last updated")

---

## Lié à

- [[IONOS_ARCHIVES.md]] — Accès archives
- [[redaction-skill]] — Implémentation /redaction
- [[DECISIONS.md#-092026--limite-archives-ionos-5-derniers-numéros]] — Décision 09/09

---

**Référence** : Decision 09/09/2026 — [[DECISIONS.md]]
