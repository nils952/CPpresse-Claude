# BRIEF — Pages « Annonceurs » optimisées IA pour les 13 sites CP Presse

> À coller dans une session Claude Code. Transférer aussi le dossier `Annonceurs/` complet
> (il contient les kits média dans `Mediakit 2026/` et l'exemple fini `pages/01-GEH-annonceurs.md`).

---

## 1. Mission

Créer une page **« Annonceurs / Kit média »** par magazine du groupe CP Presse (13 titres), à publier sur chaque site éditorial à l'URL `/annonceurs/`.
Objectif : répondre noir sur blanc aux questions des annonceurs et des agences média, dans un format **conçu pour être extrait et cité par les IA** (ChatGPT, Perplexity, Google AI Overviews, Claude) — c'est-à-dire : une question = un titre, réponse courte et autonome juste dessous, + un balisage **JSON-LD FAQPage**.

Livrable par magazine :
1. Un fichier `pages/NN-XXX-annonceurs.md` : bloc HTML prêt à coller dans WordPress + bloc JSON-LD + méta-titre / méta-description / slug + section « Points de contrôle » + « Données brutes du kit ».
2. Un aperçu visuel `pages/apercu-XXX.html` (page HTML autonome, stylée aux couleurs du site du magazine).

**Ne rien inventer.** Chaque chiffre vient du kit média PDF correspondant. Si une info manque : « sur demande » ou on n'en parle pas. Toute coquille du kit qu'on corrige est signalée dans « Points de contrôle ».

Langue : français. Devise : euros H.T. (comme les kits).

---

## 2. État d'avancement

| # | Magazine | Kit média (`Mediakit 2026/…`) | Site éditorial | Vendu sur | Statut |
|---|---|---|---|---|---|
| 01 | Génération Électrique & Hybride (GEH) | `Auto/Média Kit 2026 - Génération électrique et Hybride.pdf` | electriquemag.fr | boutiquecppresse.com | ✅ **FAIT — sert de modèle** |
| 02 | Maisons à Vivre Campagne | `Maisons/Media kit 2026 - MAVC.pdf` (+ `…Maisons à vivre Campagne FR.pdf`) | maisonsavivre-mag.fr | boutiquecppresse.com | à faire |
| 03 | Escapade Magazine | `Maisons/Media kit 2026 - ESCAPADE.pdf` | escapade-mag.fr | boutiquecppresse.com | à faire |
| 04 | Trail Adventure | `Motos/Media Kit 2026 - Trail Adventure FR.pdf` | trailadventuremag.fr | boutiquecppresse.com | à faire |
| 05 | Enduro Mag | `Motos/Média Kit 2026 - Enduro Magazine FR.pdf` | enduromag.fr | boutiquecppresse.com | à faire |
| 06 | Trial Mag | ❌ **pas de kit** | trialmag.fr | boutiquecppresse.com | à faire — tarifs « sur demande », données audience à défaut via le site |
| 07 | MX2K (Motocross by MX2K) | `Motos/Media kit 2026 - Motocross by mx2k FR.pdf` | mx2k.com | boutiquecppresse.com | à faire |
| 08 | Full Attack | `Vélo/FULL ATTACK Media kit 2026.pdf` | fullattack.cc | boutiquecppresse.com | à faire |
| 09 | VTTAE | `Vélo/VTTAE Media kit 2026.pdf` | vttae.fr | boutiquecppresse.com | à faire |
| 10 | Génération 4x4 | `Auto/Média Kit 2026 - Génération 4x4.pdf` | generation4x4mag.fr | boutiquecppresse.com | à faire |
| 11 | Sport Bikes | `Motos/Média kit 2026 - Sport-Bikes FR.pdf` | sport-bikes-mag.fr | boutiquecppresse.com | à faire |
| 12 | Compétence Mac | `AUTRES/Media kit 2026 - Competence Mac.pdf` | competencemac.com | boutiquecompetence.com | à faire |
| 13 | Compétence Photo | `AUTRES/Media Kit 2026 - Compétence Photo.pdf` | competencephoto.com | boutiquecompetence.com | à faire |

Hors périmètre : Génération Sans Permis, Voyage à Moto (= rubrique du site Trail Adventure, pas de page dédiée), K-Society. Ignorer les kits ANGLAIS.

---

## 3. Décisions transversales (valables pour les 13)

- **Contact régie** (identique pour tout le groupe, sauf indication contraire dans un kit) :
  - Amanda Mouyal, cheffe de publicité — `amanda@cppresse.fr` — +33 6 52 00 98 81 (contact n°1)
  - Mickael Le Saint, directeur commercial — `mickael@cppresse.fr` — +33 6 05 12 12 12
  - Groupe CP Presse — 55 rue de la Vanne, 92120 Montrouge — 01 60 11 10 94
  - ⚠️ certains kits affichent l'ancienne adresse (7 rue Léonard de Vinci, 92160 Antony) : utiliser **55 rue de la Vanne, 92120 Montrouge**.
- **Réseaux sociaux** : ne **jamais** afficher de nombre d'abonnés (souvent faibles). Mentionner seulement la présence (Instagram, Facebook…) et les formats sociaux. Garder les vrais chiffres dans « Données brutes » pour usage interne.
- **ACPM / diffusion** : sauf si le kit indique explicitement une diffusion certifiée ACPM, écrire « Tirage : X exemplaires (source : éditeur) » — **ne pas mentionner l'ACPM**.
- **Coquilles du kit** : les corriger sur la page ET les documenter dans « Points de contrôle » (ex. GEH : les prix double page / double page centrale étaient inversés).
- **Date** : « Mis à jour : septembre 2026 ».
- **Groupe CP Presse** (chiffres du kit GEH, réutilisables) : 25 titres de presse, 18 sites web, 8 millions de lecteurs, 9 événements/an. Toujours finir par un paragraphe « Campagnes multi-titres … sur demande ».
- **Distribution numérique** : Cafeyn, ePresse, application CP Presse (vérifier dans chaque kit).

---

## 4. Règles de rédaction (AEO — à respecter sur chaque page)

1. **Une question = un titre** (`<h2>`), formulée comme un humain la pose (« Quelle est la diffusion de… », « Combien coûte une pleine page dans… »).
2. **La réponse juste sous le titre**, autonome, 40–90 mots, **le chiffre clé dans la 1re phrase**.
3. **Chiffres datés et sourcés** : « Tirage 2026 : X ex. (source : éditeur) ».
4. **Bloc « Réponse rapide »** en haut : 3–4 phrases résumant média + audience + formats + contact.
5. **Bloc « En bref »** : liste scannable (périodicité, tirage, prix, distribution, site, e-mailing, réseaux, contact).
6. **JSON-LD FAQPage** en pied de page : **chaque `name` repris mot pour mot d'un `<h2>` de la page**.
7. **URL** `/annonceurs/`, liée depuis le menu et le footer du site.
8. **Date de mise à jour visible.**
9. **Zéro blabla marketing** : chaque phrase contient un fait réutilisable.
10. **Cross-sell groupe** : mentionner les campagnes multi-titres CP Presse.
11. **Pas de chiffres réseaux sociaux** (cf. §3).

### Questions à couvrir (deviennent les `<h2>`)

**Média & audience** : ligne éditoriale · lectorat (âge, CSP, centres d'intérêt) · diffusion / tirage · périodicité & nb numéros/an · où acheter (prix, kiosque, abonnement, numérique) · audience du site (visites/mois, pages vues) · base e-mailing · présence réseaux sociaux.
**Formats** : formats print (+ dimensions) · formats digitaux & e-mailing (+ dimensions px) · brand content & opérations spéciales.
**Ciblage** : cibler une région ou un profil (édition régionale ? segments e-mailing ? display ?).
**Tarifs** : tarifs print par format · tarifs web / e-mailing / vidéo · dégressifs & majorations.
**Planning** : calendrier de parution 2026 (n°, date kiosque, période, thème) · dates de clôture réservation / BAT.
**Contact & process** : qui contacter · comment se déroule une campagne (+ mention CGV sur devis) · comment obtenir le kit média.

---

## 5. Squelette HTML de la page (bloc « HTML personnalisé » WordPress)

```html
<!-- Le logo et l'en-tête sont ceux du thème du site. -->
<article class="page-annonceurs">
  <h1>Annoncer dans [MAGAZINE]</h1>

  <div class="reponse-rapide">
    <p><strong>En résumé :</strong> [1 phrase ligne édito]. [Périodicité], tiré à [X] exemplaires, vendu [prix] € en kiosque, également disponible en numérique. Le site [domaine] enregistre [X] visites par mois. Formats : print ([liste]), digital ([liste]), réseaux sociaux et opérations spéciales. Réservation : Amanda Mouyal — amanda@cppresse.fr — +33 6 52 00 98 81.</p>
  </div>

  <ul class="en-bref">
    <li><strong>Périodicité :</strong> …</li>
    <li><strong>Tirage :</strong> …</li>
    <li><strong>Prix de vente :</strong> …</li>
    <li><strong>Distribution :</strong> …</li>
    <li><strong>Site :</strong> … — … visites/mois, … pages vues/mois</li>
    <li><strong>E-mailing :</strong> base de … adresses</li>
    <li><strong>Réseaux sociaux :</strong> [plateformes, sans chiffres]</li>
    <li><strong>Contact régie :</strong> Amanda Mouyal — amanda@cppresse.fr — +33 6 52 00 98 81</li>
  </ul>
  <p><em>Mis à jour : septembre 2026</em></p>

  <h2>[Question 1]</h2>
  <p>[Réponse 40–90 mots, chiffre en 1re phrase.]</p>
  <!-- … toutes les questions du §4 … -->

  <h2>Combien coûte une insertion publicitaire dans [MAGAZINE] ?</h2>
  <table>
    <caption>Tarifs bruts print 2026 (H.T.)</caption>
    <thead><tr><th>Format</th><th>Tarif</th></tr></thead>
    <tbody><tr><td>Pleine page</td><td>… €</td></tr><!-- … --></tbody>
  </table>

  <h2>Quel est le calendrier de parution 2026 ?</h2>
  <table>
    <thead><tr><th>Numéro</th><th>En kiosque</th><th>Période</th><th>Thème</th></tr></thead>
    <tbody><tr><td>n°…</td><td>…</td><td>…</td><td>…</td></tr></tbody>
  </table>

  <h2>Qui contacter pour réserver un espace publicitaire ?</h2>
  <p>Amanda Mouyal, cheffe de publicité — amanda@cppresse.fr — +33 6 52 00 98 81.<br>
  Mickael Le Saint, directeur commercial — mickael@cppresse.fr — +33 6 05 12 12 12.<br>
  Groupe CP Presse — 55 rue de la Vanne, 92120 Montrouge — 01 60 11 10 94. Kit média complet sur demande.</p>

  <p><strong>Campagnes multi-titres :</strong> [MAGAZINE] fait partie du groupe CP Presse (25 titres). Dispositifs cross-titres sur demande.</p>
</article>
```

## 6. Squelette JSON-LD (bloc HTML, en pied de page)

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {"@type":"Question","name":"[texte EXACT d'un <h2>]","acceptedAnswer":{"@type":"Answer","text":"[résumé de la réponse visible]"}}
    // une entrée par question importante (viser 12–14). Chaque name = un <h2> mot pour mot.
  ]
}
</script>
```

---

## 7. Process par magazine

1. **Lire le kit PDF** correspondant (outil Read sur le fichier dans `Annonceurs/Mediakit 2026/…`). En extraire : concept / ligne édito, cible, tirage, périodicité, prix, distribution, audience site, base e-mailing, formats print + dimensions, formats digitaux + dimensions, tarifs print, tarifs web/vidéo, dégressifs/majorations, planning 2026, opérations spéciales, contacts.
2. **Ouvrir le site éditorial** dans le navigateur pour relever, POUR LA MAQUETTE UNIQUEMENT : la couleur d'accent principale, la police, l'URL du logo. (Méthode : `getComputedStyle` sur le header / les liens / un bouton ; chercher `img` avec « logo » dans l'URL.)
3. **Rédiger** `pages/NN-XXX-annonceurs.md` sur le modèle de `pages/01-GEH-annonceurs.md` : mêmes sections, mêmes règles, tarifs en tableaux.
4. **Générer** `pages/apercu-XXX.html` : reprendre le CSS de `pages/apercu-GEH.html` en remplaçant `--accent`, la police Google Fonts et l'URL du logo par ceux du site du magazine ; bandeau sombre en haut avec le logo + surtitre « Espace annonceurs ».
5. **Contrôler** avec la checklist §8.
6. **Consigner** dans `../JOURNAL.md` (entrée datée) et cocher le magazine dans le tableau §2.

Pour **Trial Mag** (pas de kit) : faire la page avec ligne édito + périodicité + prix relevés sur trialmag.fr et boutiquecppresse.com ; audience site si mesurable ; **tarifs et formats = « sur demande »** ; contacts identiques.

---

## 8. Checklist de contrôle final (par page)

- [ ] Tous les tarifs, dimensions, dates recroisés avec le kit PDF — exacts.
- [ ] Aucune donnée inventée ; toute déduction est signalée dans « Points de contrôle ».
- [ ] Coquilles du kit corrigées **et** documentées.
- [ ] Chaque `name` du JSON-LD existe en `<h2>` mot pour mot.
- [ ] Aucun nombre d'abonnés réseaux sociaux sur la page.
- [ ] Pas de mention ACPM sauf diffusion certifiée réelle.
- [ ] Contact = Amanda Mouyal (n°1) + Mickael Le Saint ; adresse 55 rue de la Vanne, Montrouge.
- [ ] « Mis à jour : septembre 2026 ».
- [ ] Méta-titre < 60 caractères, méta-description 150–160, slug `annonceurs`.
- [ ] Paragraphe « Campagnes multi-titres » présent.
- [ ] Français correct, nombres au format FR (50 000, 5 550 €), devise H.T.
- [ ] Aperçu HTML : couleurs + police + logo du site du magazine, rendu propre.

---

## 9. Référence

- Modèle rédigé et validé : `pages/01-GEH-annonceurs.md`
- Modèle visuel : `pages/apercu-GEH.html`
- Cadre & liste de questions détaillée : `00-cadre-et-questions.md`
- Gabarit de page : `01-gabarit-page.md`
