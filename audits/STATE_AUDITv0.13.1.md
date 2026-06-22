# STATE_AUDIT v0.13.1 — DungeonCrawFirstMiniGame

Date d'audit : 2026-06-22

Version auditée : `v0.13.1 — Correctifs UI, stèles de sort et flags de build`

## Statut général

Prototype Godot public de dungeon crawler rétro en vue subjective.

`v0.13.1` est une release de stabilisation après `v0.13 — Magicka`.

Elle regroupe plusieurs correctifs locaux validés avant push.

## Base conservée

La base jouable reste celle de `v0.13` :

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
préparation des sorts actifs
Soin renforcé
Soin de groupe
Poison
statut poison sur monstre
```

## Changements v0.13.1

### Build flags

```text
scripts/core/BuildFlags.gd
DEV_TELEPORT_ENABLED
```

Utilité :

```text
- masquer le bouton de téléportation ;
- bloquer debug_teleport_to_cell() ;
- préparer des builds playtest/exécutables sans retirer les scripts.
```

### Stèles de sort

```text
S = Stèle de sort
```

Cases concernées :

```text
Étage 1 : spell_ice_shard
Étage 2 : spell_group_heal en x21 y8
```

Rendu :

```text
- symbole S sur automap/carte ;
- modèle 3D de stèle magique ;
- orientation vers chemin quand possible ;
- stèle visible après découverte.
```

### Menu d'aventure

Correction :

```text
fermer avec Échap restaure immédiatement les boutons d'exploration.
```

Ajout :

```text
bouton X en haut à droite du menu.
```

### Inventaire

Correction :

```text
- cadre parasite retiré ;
- texte d'aide superflu retiré ;
- cadre principal et bouton Retour menu réajustés.
```

### Carte agrandie

Correction de cohérence :

```text
bouton Retour remplacé par X en haut à droite.
```

## Fichiers principaux concernés

Nouveaux fichiers :

```text
scripts/core/BuildFlags.gd
CHANGELOG/v0.13.1.md
audits/STATE_AUDITv0.13.1.md
```

Scripts mis à jour :

```text
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonRenderer.gd
scripts/dungeon/FloorDatabase.gd
scripts/ui/AutoMapUI.gd
scripts/ui/DungeonViewportUI.gd
scripts/ui/InGameMenuPanelUI.gd
scripts/ui/menu/DevTeleportMenuView.gd
scripts/ui/menu/InventoryMenuView.gd
```

Documentation mise à jour :

```text
README.md
CHANGELOG/README.md
ASSISTANT_WORKFLOW.md
IA_RELAIS.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
    docs/dungeon/FLOOR_DESIGN.md
    docs/dungeon/FLOOR_VISUALIZER.md
```

## Tests locaux rapportés

```text
- BuildFlags / TP fonctionne localement.
- Stèles de sort fonctionnent.
- Menu d'aventure : fermeture avec Échap et X corrigée.
- Inventaire : layout presque corrigé, puis réajusté en v3.
- Carte agrandie : bouton X préparé pour cohérence.
```

## Tests à refaire avant tag

```text
compilation Godot
DEV_TELEPORT_ENABLED false
DEV_TELEPORT_ENABLED true
stèle Éclat de givre étage 1
stèle Soin de groupe étage 2 x21 y8
découverte des sorts sur S
orientation des stèles
automap/carte avec S
    FLOOR_DESIGN.md et FLOOR_VISUALIZER.md synchronisés avec S
menu aventure fermé avec Échap
menu aventure fermé avec X
inventaire vide
inventaire rempli
carte agrandie fermée avec X
sauvegarde / chargement rapide
boucle exploration -> menu -> carte -> inventaire -> retour exploration
```

## Points de vigilance

```text
- ne pas pousser les packs temporaires ;
- ne pas pousser les builds ;
- ne pas pousser les logs bruts ;
- vérifier DEV_TELEPORT_ENABLED = false avant export ;
- conserver Compatibility / OpenGL pour les builds de playtest ;
- mettre à jour FLOOR_VISUALIZER.md seulement lors d'un bloc dungeon dédié, depuis FloorDatabase.gd.
```
