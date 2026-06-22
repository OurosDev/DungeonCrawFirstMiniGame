# DungeonCrawFirstMiniGame

Prototype public Godot de dungeon crawler rétro en vue subjective, inspiré par l'esprit old-school de jeux comme *Swords and Serpents* sur NES.

Le projet sert aussi de terrain d'apprentissage pour la gestion d'un petit projet de jeu : organisation du dépôt, versions, documentation, playtests, sauvegardes, refactorisations progressives et travail assisté par IA.

## État actuel

Version stable récente : `v0.13 — Magicka : progression magique, sorts actifs et poison`.

Cette version poursuit la base `v0.12 — Équilibrage combat, sort découvert et corrections UI` avec une étape importante autour de la magie :

- rééquilibrage d'`Éclat de givre` ;
- ajout du `Soin renforcé` pour le Prêtre niveau 5 ;
- ajout du `Soin de groupe`, découvert à l'étage 2 ;
- ajout du sort `Poison` pour le Mage niveau 5 ;
- ajout d'un premier système de statut temporaire réutilisable ;
- préparation des sorts actifs hors combat depuis le grimoire ;
- sauvegarde des sorts actifs préparés ;
- initialisation des sorts actifs de combat depuis les choix hors combat ;
- conservation du grimoire de combat comme outil de changement temporaire pendant un combat.

Le format de sauvegarde passe en version 7 pour mémoriser les sorts actifs préparés.

## Base jouable actuelle

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
- grimoire hors combat ;
- grimoire de combat ;
- préparation hors combat des sorts actifs ;
- sort de poison et statut poison sur monstre ;
- soin en combat avec ciblage direct par cadres ;
- soin de groupe sans sélection de cible ;
- journal Combat coloré ;
- UI NineSlice ;
- carte agrandie et automap améliorée ;
- image de fond du menu principal ;
- police OpenType dédiée au titre et police globale d'interface.

## Magie en v0.13

### Mage

```text
Étincelle
- niveau : 1
- coût : 6 PM
- effet : dégâts 8-16 sur un ennemi

Éclat de givre
- niveau : 2
- coût : 10 PM
- effet : dégâts 12-24 sur un ennemi
- prérequis : découverte spell_ice_shard

Poison
- niveau : 5
- coût : 10 PM
- effet : applique le statut Poison à un monstre normal
- dégâts : 5 à 10 % des PV max du monstre à chaque tick
```

Le boss gardien est immunisé au poison pour préserver l'équilibrage actuel.

### Prêtre

```text
Soin léger
- niveau : 1
- coût : 4 PM
- effet : soin 8-14 PV sur un allié

Soin renforcé
- niveau : 5
- coût : 9 PM
- effet : soin 16-28 PV sur un allié

Soin de groupe
- coût : 9 PM
- effet : soin 7-13 PV sur toute l'équipe
- prérequis : découverte spell_group_heal
- emplacement : étage 2, x 21, y 8
```

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

Les boutons souris d'exploration affichent des libellés simples :

```text
Avancer
Reculer
Gauche
Droite
Carte
Menu
```

## Interface

L'interface principale utilise :

```text
assets/ui/frames/texture_cadre_ui.png
```

L'identité visuelle récente du menu principal et des textes repose sur :

```text
assets/ui/backgrounds/main_menu_background.png
assets/ui/themes/game_theme.tres
assets/fonts/title_medieval.otf
assets/fonts/game_ui.otf
```

Les fichiers de police doivent être conservés uniquement si leur licence autorise leur utilisation et leur distribution dans le dépôt public.

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
