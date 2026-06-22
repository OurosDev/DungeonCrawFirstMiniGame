# IA_RELAIS — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Base de reprise : `v0.13.1 — Correctifs UI, stèles de sort et flags de build`

## Prompt court de reprise

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame.

Lis d'abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md. Ensuite vérifie l'état actuel du repo GitHub sur main, les changelogs, les audits, la roadmap, les documents dungeon et les playtests.

Travaille en français, signale les incohérences, vérifie les dépendances réelles avant de proposer une modification, et fournis des packs complets de scripts à remplacer. Ne fournis pas de patch partiel.

La base récente est v0.13.1 : correctifs UI, stèles de sort et flags de build.
```

## État actuel confirmé

Version stable récente : `v0.13.1 — Correctifs UI, stèles de sort et flags de build`.

Cette version stabilise `v0.13 — Magicka`.

Elle ajoute ou corrige :

- `BuildFlags.gd` avec `DEV_TELEPORT_ENABLED` ;
- désactivation simple de la téléportation dev pour les builds playtest/exécutable ;
- symbole `S` pour les stèles de sort ;
- stèle 3D magique orientée vers le chemin ;
- stèles pour `spell_ice_shard` et `spell_group_heal` ;
- correction de fermeture du menu d'aventure avec Échap ;
- bouton `X` du menu d'aventure ;
- menu inventaire nettoyé et mieux ajusté ;
- bouton `X` dans la carte agrandie à la place de `Retour`.

## Versions récentes

```text
v0.11.3 — Fond de menu, polices et lisibilité UI
v0.12 — Équilibrage combat, sort découvert et corrections UI
v0.13 — Magicka : progression magique, sorts actifs et poison
v0.13.1 — Correctifs UI, stèles de sort et flags de build
```

## Points v0.13.1 à retenir

```text
- Ne pas proposer de patch partiel de script.
- Si un script complet est nécessaire, demander le fichier local à l'utilisateur.
- Les fichiers locaux fournis sont prioritaires sur GitHub.
- GitHub reste à vérifier pour les dépendances et l'organisation globale.
- Le flag DEV_TELEPORT_ENABLED doit être false avant export playtest/exécutable.
- S = stèle de sort.
- M reste réservé aux messages / indices.
- Les stèles de sort restent visibles après découverte.
- Les objets lisibles doivent être orientés vers un chemin quand c'est possible.
```

## Fichiers à connaître pour v0.13.1

```text
scripts/core/BuildFlags.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonRenderer.gd
scripts/dungeon/FloorDatabase.gd
scripts/ui/AutoMapUI.gd
scripts/ui/DungeonViewportUI.gd
scripts/ui/InGameMenuPanelUI.gd
scripts/ui/menu/DevTeleportMenuView.gd
scripts/ui/menu/InventoryMenuView.gd
```

## Règles de design importantes

```text
- Pas d'objets consommables pour le moment.
- Pas de potions.
- Pas de journal de quête ni moniteur d'objectif.
- L'absence de suivi explicite fait partie de la difficulté voulue.
- Les cartes ne doivent pas révéler d'informations non découvertes.
- Les modèles lisibles ou interactifs ne doivent pas faire face à un mur si un chemin adjacent existe.
- Ne pas viser l'étage 3 comme priorité immédiate.
- Enrichir d'abord la boucle complète existante avec des fonctionnalités.
- Éviter les contours blancs et halos clairs sur les assets.
- Toute progression durable doit être sauvegardée proprement.
```

## Fichiers de pilotage à consulter

```text
ASSISTANT_WORKFLOW.md
README.md
CHANGELOG/README.md
CHANGELOG/v0.13.1.md
audits/STATE_AUDITv0.13.1.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
```
