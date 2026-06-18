# v0.8.2 — Refactorisations internes et stabilisation technique

Version technique de maintenance.

Cette release ne change pas volontairement le gameplay ni le format de sauvegarde. Elle consolide la base `v0.8.1` en refactorisant progressivement plusieurs scripts lourds, validés localement un par un.

## Principaux changements

- Refactorisation du menu en jeu : extraction des vues inventaire, boutique, statut/équipement, téléportation dev et fabrique UI commune.
- Refactorisation du combat : extraction des règles d'accès acteurs, précision/esquive, dégâts/soins, sorts, ciblage et journal.
- Refactorisation du donjon : extraction des helpers de carte, état d'étage et automap.
- Refactorisation de `GameSession.gd` : extraction des helpers d'état d'étage, boutique et équipement.
- Refactorisation de la création d'équipe : extraction de la fabrique UI, création des héros et résumé d'équipe.
- Mise à jour documentaire : changelog, roadmap, technical debt, audit et relais assistant.

## Compatibilité

- Pas de changement volontaire du format de sauvegarde.
- Les scènes Godot restent inchangées.
- La base renderer reste `Compatibility / OpenGL` avec scaling `canvas_items + keep`.
- Les builds, logs bruts et zips locaux restent hors repo.

## Tests locaux validés

- Menu en jeu
- Inventaire
- Boutique achat/vente
- Statut / équipement
- Téléportation dev
- Combat standard
- Magie offensive / soin
- Fuite / victoire / K.O.
- Exploration, portes, automap, transitions
- Sauvegarde / chargement
- Création d'équipe
