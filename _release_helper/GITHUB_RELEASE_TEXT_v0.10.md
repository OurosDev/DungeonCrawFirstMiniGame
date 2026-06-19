# v0.10 — Grimoire de combat et ciblage des soins

Version de gameplay ciblée.

Cette release ajoute une version combat du grimoire et permet de cibler les soins en combat directement via les cadres de héros. Elle prépare une future base de sorts plus complexe sans changer volontairement le format de sauvegarde.

## Ajouts principaux

- Ajout d'un bouton `Grimoire` pendant le combat.
- Grimoire de combat propre au héros actif.
- Sorts actifs temporaires réinitialisés au début de chaque combat.
- Changer réellement de sort actif consomme l'action du tour.
- Sélectionner le sort déjà actif ou revenir en arrière ne consomme pas le tour.
- `Magie` lance directement le sort offensif actif.
- `Soin` lance directement le sort de soin actif.
- Le soin en combat passe directement en sélection de cible par cadres de héros.
- Prévisualisation du soin sur la barre de PV de la cible.
- Prévisualisation du coût PM sur la barre de mana du lanceur.
- Contrôles compatibles souris, flèches, `ZQSD`, `A` et `E`.
- Journal Combat plus lisible : dégâts ennemis en rouge, soins en vert, dégâts joueur conservés.

## Fichiers principaux concernés

Nouveau script :

```text
scripts/ui/menu/CombatGrimoireMenuView.gd
```

Scripts mis à jour :

```text
scripts/combat/CombatManager.gd
scripts/dungeon/DungeonInputController.gd
scripts/ui/InGameMenuPanelUI.gd
scripts/ui/LogPanelUI.gd
```

Documentation :

```text
CHANGELOG/v0.10.md
CHANGELOG/README.md
README.md
ASSISTANT_WORKFLOW.md
IA_RELAIS.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
audits/STATE_AUDITv0.10.md
```

## Notes de design

Le grimoire de combat est distinct du grimoire hors combat : il est lié au héros actif et sert à vérifier ou changer le sort actif temporaire du combat en cours.

Les boutons `Magie` et `Soin` restent des actions directes pour préserver le rythme du combat.

## Sauvegarde

Pas de changement volontaire du format de sauvegarde.

Les sorts actifs de combat sont temporaires et réinitialisés au début de chaque combat. Un futur système de sorts connus, découverts ou préparés hors combat devra être conçu séparément.
