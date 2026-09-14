# Fiches Techniques — Consigne d'Enrichissement

**Version** : 1.0  
**Validée** : 09/09/2026 (mail équipe)  
**Source** : Consigne systématique rédaction auto

---

## Objectif

Inclure dans tout article technique (essais, tests, comparatifs) une **fiche technique complète** et des **encadrés complémentaires**.

## Pourquoi

Les fiches techniques et encadrés sont la **valeur ajoutée** face au contenu digital pur. Leur absence dégrade la qualité perçue et l'accessibilité pour le lecteur impatient.

Mail équipe 27/04/2026 : articles progressivement "vidés" de contenu enrichi. **Solution** : enrichir systématiquement.

---

## Quand appliquer

- **Toujours** : essais auto, tests produit, guides techniques
- **Si pertinent** : articles pratiques, conseils spécialisés, tutoriels

---

## Structure Obligatoire

### Fiche Technique Complète

Présenter sous forme de **tableau** (lisible mobile) ou **listes structurées**.

#### MOTORISATION
- Type (essence, diesel, électrique, hybride)
- Cylindrée (cm³)
- Puissance max (ch à tr/mn)
- Couple maxi (Nm)
- Boîte de vitesses
- Transmission (traction, propulsion, 4x4)
- Carburant / Batterie (si électrique)

#### DIMENSIONS / CAPACITÉS
- Longueur / largeur / hauteur (mm)
- Empattement (mm)
- Garde au sol (mm)
- Poids à vide (kg)
- Poids tractable (kg)
- Capacité coffre (L)
- Réservoirs (L)
- Nombre portes / places

#### PERFORMANCES / CONSO
- Vitesse maximale (km/h)
- 0 à 100 km/h (s)
- Autonomie WLTP (km, si électrique)
- Consommation mixte (L/100 km)
- Émissions CO₂ (g/km)
- Malus écologique (€)

---

## Encadrés Complémentaires

Ajouter 1-2 encadrés quand pertinent (article technique) :

- **Comparatif concurrence** : auto similaire, points forts vs faibles
- **Avis expert** : témoignage pro (mécanicien, essayeur, influenceur)
- **Angle complémentaire** : fiscalité, assurance, entretien, crédits
- **Points clés** : résumé 3-5 tirets des avantages/défauts majeurs

---

## Formatage

Utiliser **tableau HTML** ou **listes structurées** — lisible sur mobile.

### Exemple : Tableau HTML

```html
<table>
  <tr>
    <th>Motorisation</th>
    <td>Électrique (100% batterie)</td>
  </tr>
  <tr>
    <th>Puissance</th>
    <td>250 ch</td>
  </tr>
  <tr>
    <th>Couple</th>
    <td>450 Nm</td>
  </tr>
  <tr>
    <th>Vitesse max</th>
    <td>200 km/h</td>
  </tr>
</table>
```

### Exemple : Encadré "Points Clés"

```html
<div class="encadre">
  <h4>Points clés</h4>
  <ul>
    <li>Accélération : impressionnante (0-100 en 6,2s)</li>
    <li>Autonomie : 450 km WLTP (bon en condition réelle)</li>
    <li>Recharge : 30 min (20%-80% sur Supercharger)</li>
    <li>Confort : excellent (suspension adaptative)</li>
    <li>Prix : 45 000€ (compétitif électrique)</li>
  </ul>
</div>
```

---

## Validation

Checklist avant dépôt brouillon WordPress :

- [ ] Toutes rubriques remplies (motorisation, dimensions, performances)
- [ ] Tableau lisible mobile
- [ ] Encadré au moins 1 (si article technique)
- [ ] Encadrés bien structurés (lisible, pas wall of text)
- [ ] Sources vérifiées (specs constructeur, sources éditeur)
- [ ] Pas de tiret long (—)

---

## Applicable

- `/redaction` (voir [[redaction-skill]]) : vérifier présence fiche technique si GEH (auto)
- Tous articles techniques CP Presse

---

**Référence** : Decision 09/09/2026 — [[DECISIONS.md]]
