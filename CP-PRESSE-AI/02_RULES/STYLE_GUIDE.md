# Guide de Style CP Presse

**Version** : 1.0  
**Validée** : 11/09/2026 (Nils)

---

## Tirets Longs Interdits

### Règle

Ne jamais utiliser le **tiret long** (`—`) dans les articles web CP Presse.

Jugé "non naturel à l'écrit web" et non conforme à la ligne éditoriale.

### ❌ Interdit

```
C'est une bonne voiture — vraiment performante — et elle consomme peu.
```

### ✅ Remplaçants selon contexte

| Contexte | Solution | Exemple |
|----------|----------|---------|
| Énumération courte | Virgule | `voiture, moto, vélo` |
| Pause forte / séparation | Point | `C'est bon. Vraiment bon.` |
| Relation logique / cause-effet | Deux-points | `Raison : qualité premium` |
| Incise / parenthèse | Entre parenthèses | `C'est bon (vraiment)` |
| Alternative | "ou" explicite | `Marche à pied ou vélo` |
| Liste complexe | Retour ligne + tiret court | `- Point 1\n- Point 2` |

### Exemples

**Avant (incorrect)**
```
Cette auto offre un confort exceptionnel — et une performance remarquable — tout en restant accessible — question d'alimentation électrique.
```

**Après (correct — 4 options)**
```
Option 1 (virgule) :
Cette auto offre un confort exceptionnel, une performance remarquable, tout en restant accessible grâce à l'alimentation électrique.

Option 2 (point) :
Cette auto offre un confort exceptionnel. La performance est remarquable. Et elle reste accessible : alimentation électrique.

Option 3 (deux-points) :
Confort exceptionnel : cette auto le propose. Performance remarquable : aussi. Prix accessible : grâce à l'électrique.

Option 4 (parenthèses) :
Cette auto offre un confort exceptionnel (vraiment) et une performance remarquable (oui, vraiment) en restant accessible.
```

---

## Validation Avant Dépôt

**Checklist** : Avant tout article en brouillon WordPress

- [ ] Recherche " — " (tiret long) dans HTML brut = 0 résultats
- [ ] Remplacé par alternative appropriée (voir tableau)
- [ ] Lisibilité OK

### Commande de vérification

Terminal / Search and Replace :
```bash
# Find: —
# Replace with: (adaptez selon contexte)
```

Ou directement dans WordPress Gutenberg :
1. Ouvrir article
2. HTML View
3. Ctrl+H (Find & Replace)
4. Find: `—` Replace: (adaptez)

---

## Note Importante

**Correction à la rédaction, pas après coup.**

Intégrer cette règle dès la phase d'écriture pour fluidité texte, pas faire correction post-publication (plus visible / modification confuse).

---

## Applicable

- `/redaction` (voir [[redaction-skill]]) : vérifier avant dépôt
- Tous articles web CP Presse
- Posts Drive/Slack/communications (si style identique)

---

**Référence** : Decision 11/09/2026 — [[DECISIONS.md]]
