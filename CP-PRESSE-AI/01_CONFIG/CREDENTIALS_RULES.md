# Règles Credentials WordPress — CP Presse

**Version** : 1.0  
**Date** : 2026-09-13  
**Statut** : Règle permanente, applicable à tous les sites

---

## Règle 1 : Source unique par site

Chaque site a **un seul** fichier credentials actif.

**Chemin canonique** : `.claude/wp-credentials-{site}.local.json`  
**Résolution** : relatif à la racine du projet (`C:\Users\nilsm\Desktop\Projet Nils\`)

```
Projet Nils/
└── .claude/
    ├── wp-credentials-escapade.local.json  ← SOURCE UNIQUE
    ├── wp-credentials-geh.local.json
    ├── wp-credentials-mav.local.json
    └── ...
```

---

## Règle 2 : Jamais dans ~/.claude/

Le dossier `~/.claude/` (home Windows) ne doit **pas** être la source de credentials actifs.

- Les fichiers `~/.claude/wp-credentials-*.local.json` peuvent exister comme archive mais ne sont jamais référencés dans les configs.
- Si un fichier home et un fichier projet divergent : **le fichier projet fait foi**.
- Cause documentée du problème Escapade (13/09) : config pointait vers `~/.claude/` (périmé 09/09) au lieu de `.claude/` (mis à jour 09/11).

---

## Règle 3 : Structure du fichier

```json
{
  "site": "nom-du-site.fr",
  "username": "nils+claude@cppresse.fr",
  "application_password": "xxxx xxxx xxxx xxxx xxxx xxxx",
  "account_role": "compte dédié claude-editorial",
  "created": "AAAA-MM-JJ",
  "note": "..."
}
```

**Champ mot de passe** : `application_password` (pas `password`, pas `app_password`).  
WordPress formate les app passwords en groupes de 4 caractères avec espaces. Lors de l'utilisation en Basic Auth, **supprimer les espaces** : `$pass -replace ' ', ''`.

---

## Règle 4 : Jamais commité

Tous les fichiers `.local.json` sont dans `.gitignore`. Vérifier avant tout commit.

```
# .gitignore — règle existante
*.local.json
.claude/*.local.json
```

---

## Règle 5 : Jamais affiché dans les logs

Le skill `/redaction` ne doit jamais afficher ni loguer les valeurs de `application_password`.  
Seuls sont logués : `username`, `user_id`, code HTTP de la réponse.

---

## État actuel par site

| Site | Fichier projet | credentials_path dans config | author_id | Statut auth |
|------|---------------|------------------------------|-----------|-------------|
| GEH | `.claude/wp-credentials-geh.local.json` | `.claude/...` | 19 | ✅ harmonisé + HTTP 200 confirmé (13/09) |
| Escapade | `.claude/wp-credentials-escapade.local.json` | `.claude/...` | 39 | ✅ HTTP 200 confirmé |
| MAV | `.claude/wp-credentials-mav.local.json` | `.claude/...` | 19 | ✅ HTTP 200 confirmé (13/09) |

**GEH** : les deux fichiers sont identiques (créés le même jour). Le chemin `~/.claude/` fonctionne par chance. À harmoniser vers `.claude/` lors du prochain cycle.

**MAV** : corrigé le 13/09. `credentials_path` pointe maintenant vers `.claude/` (fichier du 09/11). Auth testée : HTTP 200, user_id=19 (et non 13 comme documenté précédemment), rôle=editor. `author_id` mis à jour dans `mav.json`.

---

## Action recommandée (à valider par Nils)

Corriger le `credentials_path` de GEH dans sa config (même règle, risque faible car les deux fichiers GEH sont identiques) :
- `~/.claude/wp-credentials-geh.local.json` → `.claude/wp-credentials-geh.local.json`

MAV et GEH sont traités (voir ci-dessus). Les trois sites pilotes sont désormais alignés sur la Règle 1 (source unique `.claude/`).
