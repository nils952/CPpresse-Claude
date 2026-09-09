# Gabarit de page "Annonceurs" (identique sur les 13 sites)

## Métadonnées
- **Titre SEO :** Annoncer dans [Magazine] — Kit média, audience et tarifs
- **Meta description :** Diffusion, lectorat, formats publicitaires, tarifs et calendrier [année] de [Magazine]. Toutes les infos pour les annonceurs et agences média. (150–160 car.)
- **Slug :** `/annonceurs/`
- **H1 :** Annoncer dans [Magazine]

## Structure de la page (dans l'ordre)

1. **H1** — Annoncer dans [Magazine]
2. **Réponse rapide** (encadré, 3–4 phrases) :
   > [Magazine] est [nature + ligne édito en une phrase]. Il touche [audience clé chiffrée] via [périodicité + diffusion]. Formats disponibles : print (pleine page, double page, couvertures), digital (native, newsletter dédiée), brand content et opérations spéciales. Contact régie : [nom] — [email] — [tél].
3. **En bref** (liste à puces) : Périodicité · Diffusion (année, source) · Audience/numéro · Site (visiteurs/mois) · Newsletter (abonnés) · Réseaux sociaux · Contact régie
4. **Mis à jour :** [mois année]
5. **Sections Q/R** — reprendre les 7 blocs de `00-cadre-et-questions.md`, chaque question en **H2**, réponse dessous (40–90 mots, chiffre en 1re phrase). Regrouper : "Le média & l'audience", "Formats publicitaires", "Tarifs & conditions", "Calendrier [année]", "Contact & déroulé", "Ciblage & data", "Références & résultats".
6. **Tableau calendrier [année]** : Numéro | En kiosque le | Clôture réservation | Remise BAT
7. **Bloc contact régie** (coordonnées structurées : nom, fonction, email, téléphone, lien formulaire)
8. **Mention groupe** : "Campagnes multi-titres possibles à l'échelle du groupe CP Presse (13 magazines) — voir [lien]."
9. **JSON-LD FAQPage** (voir ci-dessous)

## Squelette HTML (à coller dans WordPress — bloc "HTML personnalisé")

```html
<article class="page-annonceurs">
  <h1>Annoncer dans [Magazine]</h1>

  <div class="reponse-rapide">
    <p><strong>En résumé :</strong> [Magazine] est [ligne édito]. Audience : [X] lecteurs par numéro,
    diffusion [X] ex. ([année], [source]). Formats : print (pleine page, double page, 2e/3e/4e de couv.),
    digital (native, newsletter dédiée, habillage), brand content, opérations spéciales.
    Réservation : [Nom régie] — <a href="mailto:[email]">[email]</a> — [tél].</p>
  </div>

  <ul class="en-bref">
    <li><strong>Périodicité :</strong> [X] ([N] numéros/an)</li>
    <li><strong>Diffusion :</strong> [X] ex. ([année], source [ACPM/interne])</li>
    <li><strong>Audience :</strong> [X] lecteurs/numéro</li>
    <li><strong>Site :</strong> [X] visiteurs/mois</li>
    <li><strong>Newsletter :</strong> [X] abonnés — [fréquence] — taux d'ouverture [X] %</li>
    <li><strong>Réseaux sociaux :</strong> [plateforme X ex., plateforme Y ex.]</li>
    <li><strong>Contact régie :</strong> [Nom] — [email] — [tél]</li>
  </ul>

  <p><em>Mis à jour : [mois année]</em></p>

  <h2>Qu'est-ce que [Magazine] et quelle est sa ligne éditoriale ?</h2>
  <p>[Réponse 40–90 mots, fait clé en premier.]</p>

  <h2>Qui lit [Magazine] ?</h2>
  <p>[…]</p>

  <!-- … toutes les questions de 00-cadre-et-questions.md … -->

  <h2>Calendrier de parution [année]</h2>
  <table>
    <thead><tr><th>Numéro</th><th>En kiosque</th><th>Clôture réservation</th><th>Remise BAT</th></tr></thead>
    <tbody>
      <tr><td>n°[X]</td><td>[date]</td><td>[date]</td><td>[date]</td></tr>
    </tbody>
  </table>

  <h2>Qui contacter pour réserver un espace publicitaire ?</h2>
  <p>[Nom], [fonction] — <a href="mailto:[email]">[email]</a> — [tél]. Kit média complet sur demande.</p>

  <p>Campagnes multi-titres possibles à l'échelle du groupe CP Presse (13 magazines).</p>
</article>
```

## Gabarit JSON-LD FAQPage (à coller dans un bloc HTML, en pied de page)

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "Quelle est la diffusion de [Magazine] ?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Diffusion [année] : [X] exemplaires ([source]). Périodicité [X], [N] numéros par an."
      }
    },
    {
      "@type": "Question",
      "name": "Combien coûte une insertion publicitaire dans [Magazine] ?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Tarifs bruts [année] : pleine page [X] €, double page [X] €, 4e de couverture [X] €. Dégressifs multi-parutions et remise agence sur demande."
      }
    }
    // … une entrée par question de la page, texte = résumé de la réponse visible
  ]
}
</script>
```

> Règle : **toute** question du JSON-LD doit exister en H2 sur la page, avec une réponse cohérente. Sinon Google ignore (ou pénalise) le balisage.
