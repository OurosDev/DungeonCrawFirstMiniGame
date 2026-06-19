# v0.9 — Grimoire hors combat et sélection de cible

Version de gameplay ciblée.

Cette release ajoute une première vraie fonction au grimoire : l'utilisation de sorts de soin hors combat. Elle enrichit la boucle actuelle sans ajouter d'étage, sans objets consommables, sans journal de quête et sans changement volontaire du format de sauvegarde.

## Ajouts principaux

- Grimoire utilisable depuis le menu en jeu.
- Sorts de soin hors combat.
- Boutons compacts : `Nom du lanceur — Nom du sort`.
- Sélection directe de la cible via les cadres de héros latéraux.
- Bordure verte sur le héros sélectionné.
- Prévisualisation du soin prévu sur la barre de PV de la cible.
- Prévisualisation du coût PM sur la barre de mana du lanceur.
- Validation avec son de soin et flash vert.
- Contrôles compatibles souris, flèches, `ZQSD`, `A` et `E`.
- Canal de messages coloré pour améliorer la lisibilité des informations importantes.

## Corrections intégrées pendant la phase de test

- Correction d'un appel incompatible à `String.escape_bbcode()`.
- Correction d'un crash au clic sur cadre héros pendant `gui_input`.
- Alignement de la sélection de cible avec les contrôles existants du projet.
- Suppression des en-têtes et textes redondants du grimoire.
- Prévisualisation PV limitée à la cible active.
- Prévisualisation PM limitée au lanceur.

## Fichiers principaux concernés

Nouveaux scripts :

```text
scripts/ui/menu/GrimoireMenuView.gd
scripts/ui/hero_selection/HeroFrameSelectionController.gd
```

Scripts mis à jour :

```text
scripts/ui/InGameMenuPanelUI.gd
scripts/ui/LogPanelUI.gd
scripts/ui/PartyStatusUI.gd
```

Documentation :

```text
CHANGELOG/v0.9.md
CHANGELOG/README.md
README.md
ASSISTANT_WORKFLOW.md
IA_RELAIS.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
audits/STATE_AUDITv0.9.md
```

## Notes de design

Le grimoire est conçu comme une interface d'action magique hors combat. Il ne devient pas un journal de quête ni un système de suivi d'objectifs. Les informations importantes restent portées par le canal de messages, avec une meilleure lisibilité visuelle.

## Sauvegarde

Pas de changement volontaire du format de sauvegarde. Les PV/PM modifiés par le grimoire sont déjà sauvegardés avec les héros.

Pour de futurs sorts découverts ou appris, un système persistant dédié pourra être ajouté plus tard.
