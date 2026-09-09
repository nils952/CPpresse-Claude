# /save
Enregistre et pousse tes changements vers GitHub.

## Usage
```
/save [message]
```

Si tu fournis un message, il sera utilisé pour le commit. Sinon, "Update" sera utilisé.

## Exemples
- `/save` → commit avec "Update" et push
- `/save Ajout article GEH` → commit avec ce message et push
- `/save WIP: brouillon escapade` → commit avec ce message et push

## Ce que ça fait
1. ✅ Ajoute tous les fichiers (`git add .`)
2. ✅ Crée un commit avec ton message
3. ✅ Pousse vers GitHub (`git push`)

Les changements sont alors sauvegardés dans le cloud ! 🚀
