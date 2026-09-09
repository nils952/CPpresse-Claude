# /save
Sauvegarde et pousse tes changements vers GitHub automatiquement.

Usage: `/save [message]`

Si tu fournis un message, il sera utilisé pour le commit. Sinon, un message par défaut sera utilisé.

Exemples:
- `/save` → commit avec message "Update"
- `/save Ajout article GEH` → commit avec ce message spécifique

---

## Ce que ça fait:
1. Ajoute tous les fichiers modifiés (`git add .`)
2. Crée un commit avec ton message
3. Pousse vers GitHub (`git push`)

Après, tu verras la confirmation que tout est en ligne! 🚀
