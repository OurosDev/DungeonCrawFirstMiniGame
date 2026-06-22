# DungeonCrawFirstMiniGame

Prototype public Godot de dungeon crawler rétro en vue subjective, inspiré par l'esprit old-school de jeux comme *Swords and Serpents* sur NES.

Le projet sert aussi de terrain d'apprentissage pour la gestion d'un petit projet de jeu : organisation du dépôt, versions, documentation, playtests, sauvegardes, refactorisations progressives et travail assisté par IA.

## État actuel

Version stable récente : `v0.13.1 — Correctifs UI, stèles de sort et flags de build`.

Cette version stabilise la base `v0.13 — Magicka` avec des correctifs d'interface et de workflow de build :

- flag central pour masquer/bloquer la téléportation de développement avant export ;
- symbole `S` pour les stèles de sort ;
- modèle 3D de stèle magique orienté vers le chemin ;
- correction de la fermeture du menu d'aventure ;
- bouton `X` de fermeture sur le menu d'aventure ;
- polish du menu inventaire ;
- bouton `X` de fermeture sur la carte agrandie.

## Base jouable actuelle

La base jouable contient notamment :

- création d'un groupe de quatre héros ;
- exploration case par case sur deux étages ;
- combats au tour par tour ;
- inventaire commun ;
- équipement de base ;
- boutique ;
- temple de guérison ;
- coffres, messages, stèles de sort, clé de progression et boss fixe ;
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

## Symboles de donjon

Symboles importants actuellement utilisés :

```text
# = mur
. = chemin praticable
D = porte
L = porte verrouillée spéciale
< = escalier vers l'étage précédent
> = escalier vers l'étage suivant
O = temple
B = boutique
C = coffre
M = message / indice
S = stèle de sort
X = boss / marqueur spécial
```

Les stèles de sort `S` servent aux découvertes magiques, par exemple `Éclat de givre` et `Soin de groupe`.

## Magie

La progression magique récente comprend :

```text
Étincelle
- Mage niveau 1
- 6 PM
- dégâts 8-16

Éclat de givre
- Mage niveau 2
- 10 PM
- dégâts 12-24
- découverte via stèle de sort

Poison
- Mage niveau 5
- 10 PM
- applique Poison à un monstre normal

Soin léger
- Prêtre niveau 1
- 4 PM
- soin 8-14 PV

Soin renforcé
- Prêtre niveau 5
- 9 PM
- soin 16-28 PV

Soin de groupe
- 9 PM
- soin 7-13 PV sur toute l'équipe
- découverte via stèle de sort à l'étage 2, x21 y8
```

Le boss gardien est immunisé au poison.

## Flags de build

La téléportation de développement est contrôlée depuis :

```text
scripts/core/BuildFlags.gd
```

Flag principal :

```gdscript
const DEV_TELEPORT_ENABLED: bool = false
```

Utilisation :

```text
true  = outil de téléportation disponible pour test local
false = outil de téléportation masqué et bloqué pour build playtest/exécutable
```

Avant tout export public ou playtest, vérifier que le flag est à `false`.

## Renderer et affichage

Le projet est actuellement configuré pour Godot 4.6 en `GL Compatibility`.

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

Les menus récents utilisent un bouton `X` en haut à droite quand une fermeture souris directe est nécessaire.

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
