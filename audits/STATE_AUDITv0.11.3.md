# STATE_AUDIT v0.11.3 — DungeonCrawFirstMiniGame

Date d'audit : 2026-06-22

Version auditée : `v0.11.3 — Fond de menu, polices et lisibilité UI`

## Statut général

Prototype Godot public de dungeon crawler rétro en vue subjective.

`v0.11.3` est une release de polish visuel et de lisibilité, construite sur la base `v0.11.2`.

## Base conservée

La base jouable reste celle des versions précédentes :

```text
création d'équipe
exploration case par case
deux étages
combats au tour par tour
inventaire commun
équipement
boutique
temple
coffres
messages
clé de progression
boss fixe
sauvegarde / chargement
contrôles souris et clavier AZERTY
grimoire hors combat
grimoire de combat
soin ciblé par cadres
journal Combat coloré
UI NineSlice
carte agrandie
automap compacte
```

## Changements v0.11.3

```text
- fond illustré du menu principal ;
- placement du menu principal réglable par constantes ;
- police OpenType dédiée au titre du menu principal ;
- thème global de police OpenType ;
- libellés d'exploration simplifiés ;
- correction du tooltip de coordonnées de carte / automap.
```

## Fichiers principaux concernés

Scripts :

```text
scripts/ui/MainMenu.gd
scripts/ui/CommandOverlayUI.gd
scripts/ui/AutoMapUI.gd
```

Assets / configuration UI :

```text
assets/ui/backgrounds/main_menu_background.png
assets/ui/themes/game_theme.tres
assets/fonts/title_medieval.otf
assets/fonts/game_ui.otf
project.godot
```

Documentation :

```text
README.md
CHANGELOG/README.md
CHANGELOG/v0.11.3.md
ASSISTANT_WORKFLOW.md
IA_RELAIS.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
audits/STATE_AUDITv0.11.3.md
```

## Sauvegarde

Aucun changement du format de sauvegarde.

Aucun nouvel état persistant.

## Tests locaux à confirmer avant tag

```text
menu principal
titre avec police dédiée
boutons du menu principal
Options / Retour
création d'équipe
exploration boutons souris
exploration raccourcis clavier
carte agrandie
automap compacte
tooltip X/Y à deux chiffres
inventaire
équipement
boutique
temple
grimoire hors combat
grimoire de combat
combat
boss
sauvegarde / chargement
```

## Points de vigilance

```text
- vérifier licence des fichiers .otf ;
- ne pas pousser les packs temporaires ;
- ne pas pousser les builds ;
- ne pas pousser les logs bruts ;
- vérifier les écrans contenant beaucoup de texte avec la police globale ;
- conserver Compatibility / OpenGL pour les builds de playtest.
```
