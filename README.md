# DungeonCrawFirstMiniGame

Prototype public Godot de dungeon crawler rétro en vue subjective, inspiré par l'esprit old-school de jeux comme *Swords and Serpents* sur NES.

Le projet sert aussi de terrain d'apprentissage pour la gestion d'un petit projet de jeu : organisation du dépôt, versions, documentation, playtests, sauvegardes, refactorisations progressives et travail assisté par IA.

## État actuel

Version stable récente : `v0.11.3 — Fond de menu, polices et lisibilité UI`.

Cette version conserve la base `v0.11.2 — Polish menus et orientation des modèles 3D` et ajoute une passe d'identité visuelle et de lisibilité :

- image de fond dédiée pour le menu principal ;
- placement réglable des éléments du menu principal par constantes de layout ;
- police OpenType dédiée au titre du menu principal ;
- thème de police global pour l'interface du jeu ;
- libellés des boutons d'exploration simplifiés pour rester lisibles avec la nouvelle police ;
- tooltip de coordonnées de carte / automap corrigé pour éviter les retours à la ligne quand `X` ou `Y` dépassent 10.

Aucun gameplay, layout de donjon, règle de combat ou format de sauvegarde n'est modifié.

La base jouable contient notamment :

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
- grimoire hors combat ;
- grimoire de combat ;
- soin en combat avec ciblage direct par cadres ;
- journal Combat coloré ;
- UI NineSlice ;
- carte agrandie et automap améliorée.

## Renderer et affichage

Le projet est actuellement configuré pour Godot 4.6 en `GL Compatibility`.

```ini
config/features=PackedStringArray("4.6", "GL Compatibility")
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"
window/stretch/scale=1.0
window/stretch/scale_mode="fractional"
renderer/rendering_method="gl_compatibility"
```

Pour les builds Windows destinées aux testeurs, utiliser `Compatibility / OpenGL` par défaut.

## Contrôles

Exploration :

- `Z` : avancer
- `S` : reculer
- `Q` : tourner à gauche
- `D` : tourner à droite
- `A` : valider / équivalent `Entrée` ou `Espace`
- `E` : retour / équivalent `Échap`
- Souris : boutons d'action affichés à l'écran

Depuis `v0.11.3`, les boutons souris d'exploration affichent des libellés plus courts et plus lisibles :

```text
Avancer
Reculer
Gauche
Droite
Carte
Menu
```

Les raccourcis clavier restent inchangés.

La commande `Carte` ouvre une carte agrandie de l'étage découvert dans le viewport. `Retour`, `E` ou `Échap` ferment la carte et reviennent à l'exploration.

## Interface

L'interface principale utilise :

```text
assets/ui/frames/texture_cadre_ui.png
```

Depuis `v0.11.2`, le menu principal et l'écran de création d'équipe sont aussi alignés avec ce style.

Depuis `v0.11.3`, l'identité visuelle du menu principal et des textes est enrichie par :

```text
assets/ui/backgrounds/main_menu_background.png
assets/ui/themes/game_theme.tres
assets/fonts/title_medieval.otf
assets/fonts/game_ui.otf
```

Les fichiers de police doivent être conservés uniquement si leur licence autorise leur utilisation et leur distribution dans le dépôt public.

## Donjon et modèles 3D spéciaux

Règle d'orientation des modèles spéciaux :

1. conserver l'orientation naturelle si elle regarde déjà une case `.`;
2. sinon, chercher une case `.` adjacente ;
3. sinon, chercher une case praticable non-mur ;
4. sinon, conserver l'orientation naturelle.

Modèles concernés :

- `M` = message / stèle ;
- `C` = coffre ;
- `O` = temple ;
- `B` = boutique.

## Organisation du dépôt

```text
CHANGELOG/          Historique des versions
audits/             Audits d'état du dépôt
docs/dungeon/       Documents de conception et visualisation des étages
docs/informations/  Roadmap, idées et dette technique
playtests/          Synthèses propres des sessions de test
scenes/             Scènes Godot
scripts/            Scripts GDScript organisés par domaine
assets/             Images, sons, musiques, polices et sprites
```

Ne pas pousser :

- builds exportées ;
- cache Godot `.godot/` ;
- logs bruts complets ;
- sauvegardes locales de testeurs ;
- packs temporaires ;
- backups zip locaux.

Les contours blancs ou halos autour des assets ne font pas partie du style souhaité.
