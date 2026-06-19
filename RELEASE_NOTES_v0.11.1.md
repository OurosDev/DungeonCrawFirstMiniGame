# v0.11.1 — Carte agrandie et automap améliorée

Version qualité de vie issue du playtest.

Cette release ajoute une carte agrandie d'exploration affichée dans le viewport, afin de mieux planifier les déplacements dans l'étage déjà découvert.

La carte ne révèle aucune zone non découverte et ne remplace pas l'absence volontaire de journal de quête.

## Ajouts principaux

- Ajout d'un bouton `Carte` pendant l'exploration.
- Affichage d'une carte agrandie dans l'espace du viewport.
- Carte agrandie synchronisée avec l'état de l'automap.
- Aucune révélation de zones non découvertes.
- Fermeture de la carte par `Retour`, `E` ou `Échap`.
- Déplacements bloqués tant que la carte est ouverte.
- Carte indisponible en combat.
- Cadre de carte texturé avec le style UI `v0.11`.
- Bouton `Retour` texturé, réduit et placé dans le coin bas gauche du cadre.
- Retrait du titre `AUTOMAP` dans l'automap compacte.
- Zoom léger de l'automap compacte.
- Conservation d'une zone minimale affichée de 15 cases en largeur et 11 cases en hauteur.
- Coordonnées affichées au survol souris des cases découvertes non-mur.
- Coordonnées au survol disponibles sur la carte agrandie et sur l'automap compacte.
- Pas de coordonnées sur les murs.
- Pas de coordonnées sur les cases non découvertes.

## Fichiers principaux concernés

Scripts mis à jour :

```text
scripts/ui/AutoMapUI.gd
scripts/ui/CommandOverlayUI.gd
scripts/ui/DungeonViewportUI.gd
scripts/ui/GameUI.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonInputController.gd
```

Documentation :

```text
CHANGELOG/v0.11.1.md
CHANGELOG/README.md
README.md
ASSISTANT_WORKFLOW.md
IA_RELAIS.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
audits/STATE_AUDITv0.11.1.md
```

## Notes de design

La carte agrandie est une aide de navigation, pas un journal de quête.

Elle affiche uniquement les informations déjà découvertes par le joueur et ne donne pas d'objectif, de marqueur de quête ou d'indice supplémentaire.

Les coordonnées sont affichées uniquement au survol souris pour éviter de surcharger l'interface. Les murs et les cases non découvertes ne montrent pas de coordonnées.

## Sauvegarde

Pas de changement du format de sauvegarde.

La carte agrandie réutilise les données existantes du donjon et de l'automap :

```text
layout
discovered_map_cells
player.grid_cell
player.get_facing_name()
```

Aucun nouvel état persistant n'est ajouté.
