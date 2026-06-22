# IA_RELAIS — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Base de reprise : `v0.12 — Équilibrage combat, sort découvert et corrections UI`

## Prompt court de reprise

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame.

Lis d'abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md. Ensuite vérifie l'état actuel du repo GitHub sur main, les changelogs, les audits, la roadmap, les documents dungeon et les playtests.

Travaille en français, signale les incohérences, et fournis des packs complets de fichiers à remplacer quand tu modifies le projet.

La base récente est v0.12 : fond illustré du menu principal, police dédiée au titre, police globale OpenType, grimoire hors combat, grimoire de combat, soin ciblé par cadres, carte agrandie, automap améliorée, sort Éclat de givre découvert à l'étage 1 utilisable en combat, PV des monstres normaux augmentés, boss gardien exclu de la hausse, stats de création d'équipe colorées, écran équipement corrigé et retour automatique au canal Journal après combat.
```

## État actuel confirmé

Version stable récente : `v0.12 — Équilibrage combat, sort découvert et corrections UI`.

Cette version conserve la base `v0.11.3 — Fond de menu, polices et lisibilité UI`.

Elle ajoute :

- coût du sort `Étincelle / spark` augmenté de 3 PM à 6 PM ;
- sort `Éclat de givre / ice_shard` utilisable en combat après découverte et conditions remplies ;
- sauvegarde des sorts découverts avec `discovered_ability_ids` ;
- passage du format de sauvegarde en version 6 ;
- PV des monstres normaux augmentés d'environ 25 % ;
- boss gardien conservé à 225 PV ;
- rolls de création d'équipe colorés selon les valeurs ;
- layout équipement corrigé ;
- canal Journal restauré automatiquement en sortie de combat.

## Versions récentes

```text
v0.8.1 — Stabilisation playtest et scaling fenêtre
v0.8.2 — Refactorisations internes et stabilisation technique
v0.9 — Grimoire hors combat et sélection de cible
v0.10 — Grimoire de combat et ciblage des soins
v0.11-Polish — Cadres UI NineSlice et correction Prêtre
v0.11.1 — Carte agrandie et automap améliorée
v0.11.2 — Polish menus et orientation des modèles 3D
v0.11.3 — Fond de menu, polices et lisibilité UI
v0.12 — Équilibrage combat, sort découvert et corrections UI
```

## Points v0.12 validés à retenir

```text
- Étincelle coûte 6 PM.
- Éclat de givre est lié à la découverte spell_ice_shard.
- Éclat de givre reste soumis au niveau requis.
- Les découvertes de sorts sont sauvegardées.
- Les anciennes sauvegardes restent compatibles.
- Les monstres normaux ont plus de PV.
- Le boss gardien n'est pas augmenté.
- Les rolls affichent 10 en vert, 5 en jaune, 4 ou moins en rouge.
- L'écran équipement ne doit plus cacher Accessoire derrière Retour statut.
- Le canal affiché revient sur Journal après combat.
```

## Règles de design importantes

```text
- Pas d'objets consommables pour le moment.
- Pas de potions.
- Pas de journal de quête ni moniteur d'objectif.
- L'absence de suivi explicite fait partie de la difficulté voulue.
- Les cartes ne doivent pas révéler d'informations non découvertes.
- Les modèles lisibles ou interactifs ne doivent pas être orientés face à un mur si un chemin adjacent existe.
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
CHANGELOG/v0.12.md
audits/STATE_AUDITv0.12.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
```
