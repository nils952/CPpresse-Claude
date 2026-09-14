# Accès Archives IONOS HiDrive

**Version** : 1.0  
**Autorisé** : 08/09/2026 (Nils — Standing permission)  
**Statut** : Lecture seule

---

## Lien Public

```
https://c01.storage.ionos.fr/s/n4wtRz7wkQFA5Ct
```

**Dossier** : `FTP CPPRESSE`  
**Taille** : ~433 Go  
**Permissions** : Lecture seule (pas suppression, pas upload)

---

## Contenu

- **Images** : Photos, illustrations par magazine
- **PDF** : Fiches techniques, kits médias, numéros archivés
- **Structure** : Un dossier par magazine + subdossiers par type

### Organisation type

```
FTP CPPRESSE/
├─ GEH (electriquemag.fr)
│  ├─ Images/
│  ├─ PDF/
│  ├─ Kits médias/
│  └─ Numéros archivés/
├─ Escapade (escapade-mag.fr)
│  ├─ Images/
│  ...
├─ MAV (maisonsavivre-mag.fr)
│  ...
[et autres sites CP Presse]
```

---

## Cas d'Usage

### 1. Sourcer images pour articles (/redaction)

**Flux** :
1. Naviguer lien public → `/FTP CPPRESSE/{magazine}/Images/`
2. Parcourir dossier (récents en top)
3. Télécharger image appropriée
4. Uploader vers WordPress (featured image)

**Priorité sourcing** (voir [[redaction-skill]]) :
1. Envato (si accès)
2. **Images officielles magazine (IONOS)** ← priorité 2
3. Web (licence libre, crédits attribués)
4. IA (Midjourney, DALL-E, fallback)

### 2. Consulter archives (vérification voix éditoriale)

**Flux** :
1. Naviguer lien public → `/FTP CPPRESSE/{magazine}/Numéros archivés/`
2. Ouvrir 5 derniers numéros (PDF)
3. Lire 1-2 articles par numéro (éditorial, reportage, service)
4. Noter ton, structure, vocabulaire

**Limite** : 5 derniers numéros par magazine (voir [[voix-editoriale-echantillon-archives]] + [[LESSONS_LEARNED.md]])

**Rationale** : Économise tokens, capture tone actuel sans sur-analyse historique.

### 3. Vérifier context éditorial (audit, brouillons)

**Flux** :
1. Naviguer archives
2. Consulter contexte publication
3. Valider cohérence articles en brouillon

---

## Méthode d'Accès

### Via Browser (Claude Code)

```
1. Utiliser Claude Browser pane
2. Naviguer : https://c01.storage.ionos.fr/s/n4wtRz7wkQFA5Ct
3. Parcourir dossiers
4. Télécharger fichiers (clic droit → Save As)
```

**Avantages** :
- Pas d'authentification requise
- Accès direct, rapide
- Compatible avec Claude workflows

### Via WebDAV (non fonctionnel actuellement)

⚠️ **Statut** : 401 Unauthorized  
**Endpoint** : `https://.../public.php/webdav/`  
**Note** : À reconsidérer. Utiliser Browser directe en attendant.

---

## Permissions & Sécurité

### ✅ Autorisé

- ✅ Lecture (consultation)
- ✅ Téléchargement
- ✅ Utilisation images dans articles CP Presse
- ✅ Partage lien public avec équipe

### ❌ Interdit

- ❌ Suppression (bloqué par permissions lien)
- ❌ Upload
- ❌ Modification fichiers
- ❌ Partage lien en dehors équipe (sans validation)

### Standing Permission

Nils a autorisé (08/09/2026) accès permanent sans redemander à chaque utilisation.

**Condition** : Usage reste lecture uniquement.

---

## Intégration dans Workflows

### Dans /redaction

1. Phase "Images" : chercher dans IONOS (priorité 2)
2. Télécharger directement
3. Uploader WordPress featured image

### Dans création fiche voix éditoriale

1. Consulter 5 derniers numéros (IONOS)
2. Noter ton éditorial
3. Documenter dans `CP-PRESSE-AI/03_VOIX/{site}.md`

### Dans audit contenu

1. Valider cohérence vs archives
2. Détecter doublons (même sujet vs ancien)
3. Proposer angles complémentaires

---

## Dépannage

| Symptôme | Cause | Solution |
|----------|-------|----------|
| 404 Not Found | Lien mort ou mal entré | Vérifier URL exacte ci-dessus |
| 403 Forbidden | Lien expiré | Contacter Nils (nouvelle autorisation) |
| Lenteur téléchargement | Réseau ou fichier lourd | Vérifier connexion, relancer |
| Impossible parcourir dossiers | Browser bloqué | Utiliser Claude Browser pane officielle |

---

## Crédits & Attribution

Images IONOS = archives CP Presse propres.  
Utilisation interne uniquement (pas redistribution externe).

Vérifier toujours droits d'auteur photos (photographe, droits contractuels).

---

**Référence** : Decision 08/09/2026 — [[DECISIONS.md]]  
**Lié à** : [[redaction-skill]], [[VOIX/README.md]]
