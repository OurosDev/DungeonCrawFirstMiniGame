# IA_RELAIS — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Base de reprise : `v0.11.3 — Fond de menu, polices et lisibilité UI`

## Prompt court de reprise

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame.

Lis d'abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md. Ensuite vérifie l'état actuel du repo GitHub sur main, les changelogs, les audits, la roadmap, les documents dungeon et les playtests.

Travaille en français, signale les incohérences, et fournis des packs complets de fichiers à remplacer quand tu modifies le projet.

La base récente est v0.11.3 : UI NineSlice, correction Prêtre, carte agrandie d'exploration, automap compacte améliorée, polish du menu principal et de la création d'équipe, orientation automatique des modèles 3D spéciaux, image de fond du menu principal, police dédiée au titre, police globale OpenType, libellés d'exploration simplifiés et tooltip de coordonnées corrigé pour les coordonnées à deux chiffres.
```

## État actuel confirmé

Version stable récente : `v0.11.3 — Fond de menu, polices et lisibilité UI`.

Cette version conserve la base `v0.11.2 — Polish menus et orientation des modèles 3D`.

Elle ajoute une passe de polish visuel et de lisibilité :

- image de fond dédiée au menu principal ;
- placement du menu principal réglable par constantes dans `MainMenu.gd` ;
- police OpenType dédiée au titre `DONJON DES SERPENTS` ;
- thème de police global pour l'interface du jeu ;
- simplification des libellés des boutons d'exploration ;
- correction du tooltip de coordonnées de carte / automap avec la police globale.

Aucun gameplay, layout de donjon ou format de sauvegarde n'est modifié.

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
```

## Points v0.11.3 validés

```text
- fond illustré du menu principal intégré ;
- cadres de placement du menu principal réglables ;
- police spéciale du titre du menu principal ;
- thème global de police OpenType ;
- libellés d'exploration simplifiés : Avancer / Reculer / Gauche / Droite / Carte / Menu ;
- raccourcis clavier conservés ;
- tooltip de coordonnées corrigé en X:12  Y:10 ;
- retour à la ligne désactivé dans le tooltip de coordonnées ;
- taille du tooltip augmentée pour la nouvelle police ;
- aucune sauvegarde modifiée ;
- aucun gameplay modifié ;
- aucun layout de donjon modifié.
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
- Vérifier la licence des polices avant de les pousser dans un dépôt public.
```

## Fichiers de pilotage à consulter

```text
ASSISTANT_WORKFLOW.md
README.md
CHANGELOG/README.md
CHANGELOG/v0.11.3.md
audits/STATE_AUDITv0.11.3.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
```
