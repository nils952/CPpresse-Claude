# 00_CORE — Cœur de l'agent

Contient la constitution permanente de l'agent éditorial CP PRESSE.

## Fichiers

- **AGENT_CORE_CP_PRESSE.md** — La mission, les principes, les commandes, les règles
- **CHANGELOG.md** — Versions et évolutions du système
- **README.md** — Ce fichier

## Fonctionnement

L'AGENT_CORE définit :

1. **Rôle** : producteur de contenus éditoriaux
2. **Principes** : ne jamais inventer, respecter l'identité de chaque publication
3. **Sources de vérité** : hiérarchie (demande > Charte > Voix > sources > SEO)
4. **Commandes** : /redaction, /veille, /brouillons, /seo, /audit, /status, /install-site
5. **Règles** : WordPress, images, style, journalisation, gestion d'erreurs

## Chargement

Chaque session doit charger ce dossier en premier.

C'est le **point d'entrée unique** pour comprendre le système.

Un nouvel agent lit AGENT_CORE et peut immédiatement contribuer.

## Indépendance

Ce dossier doit rester lisible par n'importe quel agent IA, pas seulement Claude.

Format : Markdown pur, pas de dépendances.
