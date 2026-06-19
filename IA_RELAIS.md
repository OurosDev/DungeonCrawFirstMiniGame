# IA_RELAIS — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Base de reprise : `v0.11.2 — Polish menus et orientation des modèles 3D`

## Prompt court de reprise

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame.

Lis d'abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md.
Ensuite vérifie l'état actuel du repo GitHub sur main, les changelogs, les audits, la roadmap, les documents dungeon et les playtests.

Travaille en français, signale les incohérences, et fournis des packs complets de fichiers à remplacer quand tu modifies le projet.

La base récente est v0.11.2 : UI NineSlice, correction Prêtre, carte agrandie d'exploration, automap compacte améliorée, polish du menu principal et de la création d'équipe, tooltips d'aide sur les boutons de roll, et orientation automatique des modèles 3D spéciaux pour éviter qu'ils fassent face aux murs.
```

## État actuel confirmé

Version stable récente : `v0.11.2 — Polish menus et orientation des modèles 3D`.

Cette version conserve la base `v0.11.1 — Carte agrandie et automap améliorée` et ajoute un polish ciblé :
- boutons du menu principal texturés ;
- grand cadre autour de `DONJON DES SERPENTS` retiré ;
- panneau Options texturé ;
- création d'équipe harmonisée avec cadres et boutons texturés ;
- tooltips d'aide au survol de `Relancer`, `Stocker` et `Reprendre` ;
- orientation automatique des modèles spéciaux `M/C/O/B` pour éviter qu'ils fassent face à un mur quand une case chemin ou praticable existe.

Aucun gameplay, layout ou format de sauvegarde n'est modifié.


## Versions récentes

```text
v0.8.1 — Stabilisation playtest et scaling fenêtre
v0.8.2 — Refactorisations internes et stabilisation technique
v0.9 — Grimoire hors combat et sélection de cible
v0.10 — Grimoire de combat et ciblage des soins
v0.11-Polish — Cadres UI NineSlice et correction Prêtre
v0.11.1 — Carte agrandie et automap améliorée
v0.11.2 — Polish menus et orientation des modèles 3D
```

## Points v0.11.2 validés

```text
- boutons du menu principal texturés ;
- grand cadre autour du titre DONJON DES SERPENTS retiré ;
- panneau Options texturé ;
- cadre principal de création d'équipe texturé ;
- boutons de création d'équipe texturés ;
- boutons de classe texturés ;
- aide flottante au survol souris de Relancer ;
- aide flottante au survol souris de Stocker ;
- aide flottante au survol souris de Reprendre ;
- règle d'orientation des modèles spéciaux ajoutée dans DungeonRenderer.gd ;
- modèles M/C/O/B évitent de faire face à un mur si une case "." ou praticable existe ;
- aucun layout modifié ;
- aucune sauvegarde modifiée.
```

## Orientations modifiées par v0.11.2

Orientations modifiées :

Étage 1 :
- Message `M` (3, 1) : nord -> ouest
- Coffre `C` (5, 1) : nord -> sud
- Coffre `C` (27, 9) : nord -> ouest
- Coffre `C` (15, 19) : nord -> ouest

Étage 2 :
- Message `M` (1, 1) : nord -> sud
- Coffre `C` (25, 7) : nord -> est
- Coffre `C` (1, 13) : nord -> sud
- Coffre `C` (15, 15) : nord -> ouest
- Message `M` (21, 17) : nord -> ouest

Orientations conservées :

Étage 1 :
- Temple `O` (29, 1) : conservé ouest
- Boutique `B` (15, 15) : conservé ouest
- Message `M` (25, 18) : conservé nord

Étage 2 :
- Boutique `B` (13, 5) : conservé ouest
- Message `M` (3, 11) : conservé nord
- Temple `O` (5, 15) : conservé ouest


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
```

## Fichiers de pilotage à consulter

```text
ASSISTANT_WORKFLOW.md
README.md
CHANGELOG/README.md
CHANGELOG/v0.11.2.md
audits/STATE_AUDITv0.11.2.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
```
