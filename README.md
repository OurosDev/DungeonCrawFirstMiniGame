# DungeonCrawFirstMiniGame

Prototype public Godot de dungeon crawler rétro en vue subjective, inspiré par l'esprit old-school de jeux comme *Swords and Serpents* sur NES.

Le projet sert aussi de terrain d'apprentissage pour la gestion d'un petit projet de jeu : organisation du dépôt, versions, documentation, playtests, sauvegardes, refactorisations progressives et travail assisté par IA.

## État actuel

Version stable récente : `v0.11.1 — Carte agrandie et automap améliorée`.

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
- refactorisations internes validées des grands contrôleurs de menu, combat, donjon, session et création d'équipe ;
- grimoire hors combat permettant d'utiliser des sorts de soin ;
- sélection de cible par cadres de héros avec prévisualisation PV/PM ;
- grimoire de combat lié au héros actif ;
- sorts actifs temporaires réinitialisés à chaque combat ;
- soin en combat avec ciblage direct par cadres ;
- journal Combat coloré pour distinguer dégâts ennemis et soins ;
- cadres et boutons principaux de l'interface habillés avec une texture NineSlice sombre ;
- classe `Prêtre` corrigée pour Eldric ;
- carte agrandie d'exploration dans le viewport ;
- automap compacte améliorée avec survol souris des coordonnées.

`v0.11.1` ajoute une amélioration de qualité de vie issue du playtest : le joueur peut ouvrir une carte agrandie de l'étage découvert pour planifier ses déplacements. Cette carte ne révèle rien de plus que l'automap compacte. Le jeu ne propose pas de journal de quête ni d'objets consommables à ce stade.

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

Pour les builds Windows destinées aux testeurs, utiliser `Compatibility / OpenGL` par défaut.

Cette règle vient du premier playtest externe : les builds modernes `Forward+ / D3D12` ou Vulkan pouvaient provoquer des crashs natifs sur une machine Intel UHD Graphics, alors que la build `Compatibility / OpenGL` a fonctionné.

## Contrôles

### Exploration

- `Z` : avancer
- `S` : reculer
- `Q` : tourner à gauche
- `D` : tourner à droite
- `A` : valider / équivalent `Entrée` ou `Espace`
- `E` : retour / équivalent `Échap`
- Souris : boutons d'action affichés à l'écran

La commande `Carte` ouvre une carte agrandie de l'étage découvert dans le viewport. `Retour`, `E` ou `Échap` ferment la carte et reviennent à l'exploration.

### Carte et automap

La carte agrandie et l'automap compacte utilisent le même état :

- étage courant ;
- cellules découvertes ;
- position du joueur ;
- orientation du joueur ;
- symboles déjà connus par l'automap.

Elles ne révèlent pas les zones non découvertes. Les coordonnées s'affichent au survol souris sur les cases découvertes non-mur. Les cases non découvertes et les murs ne montrent pas de coordonnées.

### Combat

Les commandes de combat sont utilisables à la souris.

Selon le héros actif, les commandes peuvent inclure :

- `Attaquer`
- `Magie`
- `Soin`
- `Grimoire`
- `Fuir`

Le bouton `Grimoire` permet au héros actif de vérifier ou changer son sort actif temporaire.

Changer réellement de sort actif consomme l'action du tour ; valider le sort déjà actif ou revenir en arrière ne consomme pas le tour. Le bouton `Magie` lance directement le sort offensif actif. Le bouton `Soin` lance directement le sort de soin actif et passe en sélection de cible par cadres. Un clic peut aussi valider certains messages d'attente, notamment après l'affichage de dégâts.

### Grimoire et sélection de cible

Depuis le menu en jeu, le grimoire hors combat permet d'utiliser certains sorts hors combat. En combat, le grimoire est distinct : il est propre au héros actif et sert à gérer son sort actif temporaire pour le combat en cours.

Pour la sélection de cible :

- souris : survol puis clic sur un cadre de héros ;
- clavier : flèches ou `ZQSD` pour changer de cible ;
- `A` / `Entrée` : valider ;
- `E` / `Échap` : annuler.

La cible reçoit une bordure verte et une prévisualisation du soin prévu sur sa barre de PV. Le lanceur affiche une prévisualisation du coût en PM sur sa barre de mana.

## Interface

L'interface principale utilise une texture de cadre NineSlice :

```text
assets/ui/frames/texture_cadre_ui.png
```

Cette texture est appliquée aux cadres principaux de jeu, aux cadres de héros, au viewport, au journal, à l'automap, aux menus et aux boutons principaux. Les boutons restent lisibles avec la texture actuelle, mais une variante dédiée aux boutons pourra être créée plus tard pour un rendu plus propre.

## Organisation du dépôt

```text
CHANGELOG/                 Historique des versions
audits/                    Audits d'état du dépôt
docs/dungeon/              Documents de conception et visualisation des étages
docs/informations/         Roadmap, idées et dette technique
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
- `docs/informations/IDEAS.md` : réserve d'idées non priorisées ou reportées ;
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

Les contours blancs ou halos autour des portraits, personnages, monstres, cadres ou assets UI ne font pas partie du style souhaité : ils doivent être évités dans les futurs assets.
