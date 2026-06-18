# DungeonCrawFirstMiniGame

Prototype public Godot de dungeon crawler rétro en vue subjective, inspiré par l'esprit old-school de jeux comme *Swords and Serpents* sur NES.

Le projet sert aussi de terrain d'apprentissage pour la gestion d'un petit projet de jeu : organisation du dépôt, versions, documentation, playtests, sauvegardes, refactorisations progressives et travail assisté par IA.

## État actuel

Version stable récente : `v0.8.2 — Refactorisations internes et stabilisation technique`.

Cette base contient une première boucle jouable :

- création d'un groupe de quatre héros ;
- exploration case par case sur deux étages ;
- combats au tour par tour ;
- inventaire commun ;
- équipement de base ;
- boutique ;
- temple de guérison ;
- coffres, messages, clé de progression et boss fixe ;
- sauvegarde / chargement ;
- commandes souris et clavier AZERTY ;
- configuration de playtest stabilisée en `Compatibility / OpenGL` ;
- refactorisations internes validées des grands contrôleurs de menu, combat, donjon, session et création d'équipe.

`v0.8.2` ne change pas volontairement le gameplay. Cette version rend surtout le code plus maintenable en séparant plusieurs responsabilités jusque-là concentrées dans de gros scripts.

## Renderer et affichage

Le projet est actuellement configuré pour Godot 4.6 en `GL Compatibility`.

Réglages importants dans `project.godot` :

```ini
config/features=PackedStringArray("4.6", "GL Compatibility")
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"
window/stretch/scale=1.0
window/stretch/scale_mode="fractional"
renderer/rendering_method="gl_compatibility"
```

Pour les builds Windows destinées aux testeurs, utiliser `Compatibility / OpenGL` par défaut. Cette règle vient du premier playtest externe : les builds modernes `Forward+ / D3D12` ou Vulkan pouvaient provoquer des crashs natifs sur une machine Intel UHD Graphics, alors que la build `Compatibility / OpenGL` a fonctionné.

## Contrôles

### Exploration

- `Z` : avancer
- `S` : reculer
- `Q` : tourner à gauche
- `D` : tourner à droite
- `A` : valider / équivalent `Entrée` ou `Espace`
- `E` : retour / équivalent `Échap`
- Souris : boutons d'action affichés à l'écran

### Combat

Les commandes de combat sont utilisables à la souris. Un clic peut aussi valider certains messages d'attente, notamment après l'affichage de dégâts.

## Organisation du dépôt

```text
CHANGELOG/                 Historique des versions
audits/                    Audits d'état du dépôt
docs/dungeon/              Documents de conception et visualisation des étages
docs/informations/         Roadmap et dette technique
playtests/                 Synthèses propres des sessions de test
scenes/                    Scènes Godot
scripts/                   Scripts GDScript organisés par domaine
assets/                    Images, sons, musiques et sprites
```

Fichiers de pilotage importants :

- `IA_RELAIS.md` : passage de main entre conversations avec l'assistant ;
- `ASSISTANT_WORKFLOW.md` : règles de collaboration et de préparation des packs ;
- `docs/informations/ROADMAP.md` : direction actuelle du projet ;
- `docs/informations/TECHNICAL_DEBT.md` : refactorisations et dette technique ;
- `CHANGELOG/README.md` : index des versions ;
- `playtests/README.md` : règles de documentation des playtests.

## Règles de contribution / maintenance

Ce dépôt est un prototype public. Les éléments suivants ne doivent pas être poussés :

- builds exportées : `.exe`, `.pck`, `.zip` ;
- dossiers `build/`, `dist/`, `export/` ;
- cache Godot `.godot/` ;
- logs bruts complets ;
- sauvegardes locales de testeurs ;
- packs temporaires générés pour remplacement de fichiers ;
- backups zip locaux.

Les changements sont préparés par petits lots testables. Pour les refactorisations importantes, le workflow privilégié est : pack scripts d'abord, tests locaux, zip local de sécurité, refactorisation suivante, puis documentation et release seulement quand la série est terminée.

## Notes sur les assets

Une grande partie du projet est produite ou organisée avec assistance IA. Les SFX utilisés proviennent de sources CC0 indiquées localement par le développeur.

Les contours blancs ou halos autour des portraits, personnages ou monstres ne font pas partie du style souhaité : ils doivent être évités dans les futurs assets.
