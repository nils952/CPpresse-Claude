# Skill : /status

## Objectif
Afficher en un coup d'œil l'état du projet : derniers travaux, blocages, prochaines actions, santé des sites.

## Syntaxe
```
/status
/status [site]
/status --full
```

Exemples :
```
/status
/status Escapade
/status --full
```

## Processus

### 1. Lire les sources d'info

#### JOURNAL.md
- 5 dernières entrées
- Blocages mentionnés
- Décisions en attente

#### Articles/_sujets-traites.md
- Nombre d'articles traités
- Derniers sujets
- Tendances (vélocité publication)

#### Brouillons actuels
- Via API WordPress (si accès)
- Compter par site
- Âge moyen

#### Memory
- Objectifs en cours
- Décisions pas encore réalisées

### 2. Synthétiser pour chaque site

#### État WordPress
- Brouillons : N
- Âge du plus ancien
- Blocages connus

#### Production
- Derniers articles publiés (5)
- Cadence (art/jour, art/semaine)
- Cibles : on track ?

#### Blocages
- Credentials manquantes/expirées
- Features débloquées/à faire
- Décisions en attente

### 3. Afficher le status global

Format compact (par défaut) :

```
# Status — CP Presse

## 🟢 Opérationnel

### GEH (electriquemag.fr)
- ✅ Credentials OK
- 📝 1 brouillon (Cupra Born, ID 25734)
- 📊 4 articles publiés cette semaine
- 🔲 Aucun blocage

### Escapade (escapade-mag.fr)
- ❓ Credentials à vérifier (tests 401)
- 📝 7 brouillons (planning 12-18 sept)
- 📊 0 articles publiés cette semaine (mode brouillons)
- 🔴 Blocages :
  - Images manquantes (4/7)
  - Yoast SEO à valider
  - 1 photo ITCV critique manquante

### MAV (maisonsavivre-mag.fr)
- ❓ Credentials à vérifier (tests 401)
- 📝 0 brouillon WordPress (3 en local)
- 📊 0 articles publiés cette semaine
- 🔴 Blocages :
  - Credentials suspects (401)
  - Brouillons pas encore postés

## ⏳ Decisions en attente

1. Escapade ID 12053 (Cap-Vert) — sourcer photos ITCV
2. GEH ID 25734 (Cupra) — ajouter image kit presse
3. MAV — confirmer credentials et poster les 3 brouillons
4. Trial Mag — page Publicité en attente credential

## 📅 Prochaines actions

- [ ] Valider Yoast SEO sur 7 brouillons Escapade
- [ ] Ajouter images hero (4/7 Escapade)
- [ ] Tester credentials MAV et Escapade
- [ ] Publier Escapade IFTM Top Résa (15/09 avant 9h)

## 📈 Métriques

- Articles produits (ce mois) : 12
- Brouillons prêts à publier : 1
- Brouillons en correction : 6
- Brouillons incomplets : 1
- Sujets traités (année) : 450+
```

### 4. Mode --full

Détail complet :

```markdown
# Status complet — CP Presse — {date}

[Idem format compact, mais]

## Par site (détail)

### GEH
- Credentials : `.claude/wp-credentials-geh.local.json` ✅
- Account : claude-editorial (ID 19) ✅
- Articles publiés (semaine) : 4
  - 2026-09-09 : Voiture électrique d'occasion : la prime CEE
  - 2026-09-09 : Leasing social 2026
  - 2026-09-10 : [autre]
  - 2026-09-11 : [autre]
- Brouillons (current)
  - ID 25734 : Cupra Born 2026 (créé 09/09, 2j)
    - Image : ❌ Manquante
    - Yoast : À checker
    - Tags : OK
- Audit santé : Aucun problème signalé

### Escapade
[idem]

## Calendrier

### Semaine 12-18 sept
- 15/09 9h : publication IFTM Top Résa
- 16/09 : Vilnius city trip
- 17/09 : Porto lifestyle
- 18/09 : City trips dossier

### Semaine 19-25 sept
- Aucun article planifié actuellement

## Tâches de maintenance

- [ ] Vérifier credentials Escapade (401)
- [ ] Vérifier credentials MAV (401)
- [ ] Fusionner tags "électrique" (GEH)
- [ ] Mettre à jour bios auteurs
```

## Règles

- Format compact par défaut (rapide)
- Mode --full si diagnostic détaillé demandé
- Toujours vérifier JOURNAL.md en premier (source unique de vérité)
- Ne jamais inventer l'état d'un site
- Si une info manque, la signaler au lieu de la deviner

## Remarques

Cette skill est à lancer régulièrement (lundi matin recommandé) pour rester synchronisé.

Pas de modification — lecture seule.
