# IA_RELAIS — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Base de reprise : `v0.13 — Magicka : progression magique, sorts actifs et poison`

## Prompt court de reprise

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame.

Lis d'abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md. Ensuite vérifie l'état actuel du repo GitHub sur main, les changelogs, les audits, la roadmap, les documents dungeon et les playtests.

Travaille en français, signale les incohérences, et fournis des packs complets de fichiers à remplacer quand tu modifies le projet.

La base récente est v0.13-Magicka : progression magique, sorts actifs préparés hors combat, Soin renforcé, Soin de groupe, Poison, premier système de statut temporaire, sauvegarde active_ability_ids_by_party_slot, et en-tête de version dans les scripts modifiés.
```

## État actuel confirmé

Version stable récente : `v0.13 — Magicka : progression magique, sorts actifs et poison`.

Cette version conserve la base `v0.12 — Équilibrage combat, sort découvert et corrections UI`.

Elle ajoute :

- `Éclat de givre` à 10 PM et 12-24 dégâts ;
- `Soin renforcé`, Prêtre niveau 5, 9 PM, 16-28 PV ;
- `Soin de groupe`, 9 PM, 7-13 PV sur toute l'équipe ;
- découverte `spell_group_heal` à l'étage 2 en x21 y8 ;
- `Poison`, Mage niveau 5, 10 PM ;
- statut poison sur monstre ;
- boss gardien immunisé au poison ;
- préparation hors combat des sorts actifs ;
- sauvegarde des sorts actifs préparés ;
- format de sauvegarde version 7 ;
- règle d'en-tête de version sur les scripts modifiés.

## Versions récentes

```text
v0.10 — Grimoire de combat et ciblage des soins
v0.11-Polish — Cadres UI NineSlice et correction Prêtre
v0.11.1 — Carte agrandie et automap améliorée
v0.11.2 — Polish menus et orientation des modèles 3D
v0.11.3 — Fond de menu, polices et lisibilité UI
v0.12 — Équilibrage combat, sort découvert et corrections UI
v0.13 — Magicka : progression magique, sorts actifs et poison
```

## Points v0.13 à retenir

```text
- Les scripts modifiés dans ce bloc ont l'en-tête VERSION SCRIPT / v0.13-Magicka.
- Ne pas ajouter cet en-tête à tous les scripts d'un coup.
- L'ajouter progressivement aux scripts réellement modifiés.
- SaveManager est en version 7.
- active_ability_ids_by_party_slot sauvegarde les sorts actifs préparés.
- discovered_ability_ids continue de sauvegarder les découvertes de sorts.
- Le grimoire hors combat prépare les sorts actifs.
- Le grimoire de combat reste temporaire et n'écrase pas la préparation hors combat.
- Le poison est un premier statut réutilisable pour les futures évolutions.
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
CHANGELOG/v0.13.md
audits/STATE_AUDITv0.13.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
```
