# Gabarits Zeen par type d'article — mapping proposé

> Statut : **proposition à valider par Nils**, basée sur les 4 tests réels faits sur Escapade (09/09/2026). Rien n'est publié — les 4 brouillons testés restent en brouillon.

## Principe
Chaque article a son propre sélecteur "Conception de héros" (boîte méta Zeen), indépendant des autres. Pas de développement nécessaire : juste choisir le bon design ID au cas par cas selon le type d'article.

## Mapping testé (Escapade)

| Type d'article | Design ID | Nom / rendu | Brouillon testé |
|---|---|---|---|
| Destination (reportage) | **21** | Plein cadre (100% hauteur écran, titre blanc surimprimé en bas) — immersif, punchy | [Charlevoix et Saguenay](https://escapade-mag.fr/wp-admin/post.php?post=12019&action=edit) |
| Hôtel / adresse | **42** | Duo bandeau noir (titre serif + méta) + photo à droite — effet "premium éditorial" | [The Biltmore hotel](https://escapade-mag.fr/wp-admin/post.php?post=867&action=edit) |
| Pratique / idée week-end | **1** | Image contenue + sidebar "derniers articles" — plus calme/blog | [Slow travel en Ardèche](https://escapade-mag.fr/wp-admin/post.php?post=11841&action=edit) |
| Listicle (Top 10, etc.) | **21** (même que destination) | Plein cadre | [Top 10 plages Lisbonne](https://escapade-mag.fr/wp-admin/post.php?post=1865&action=edit) — module Listicle lui-même pas encore activé, à refaire |

## Design non retenu (testé mais pas assigné)
- **Plein cadre + légende photo** : quasi identique au design 21, ajoute juste un crédit photo visible en bas à droite. Utile si crédit photographe obligatoire (ex. reportage avec photographe pro nommé).

## À faire pour finaliser
1. Nils valide (ou ajuste) les 4 assignations ci-dessus sur les brouillons réels.
2. Réessayer le module **Listicle** (bloqué par le classificateur de permissions lors du 1er test) sur l'article Top 10 Lisbonne.
3. Étendre l'exercice à GEH et MAV (thème Zeen aussi installé sur ces 2 sites) — probablement un mapping différent par site vu la différence de ton (ex. GEH n'a pas d'articles "hôtel/adresse").
4. Une fois validé : documenter la règle dans la Charte ou dans une note dédiée "gabarits par site", pour que `/redaction` (ou une future extension) puisse suggérer le bon design directement.

## Non traité ici
- Module **Let's Review** (encart note/verdict pour essais produits) : repéré, pas testé.
- Module **Let's Live Blog** (direct événementiel) : repéré, pas testé.
