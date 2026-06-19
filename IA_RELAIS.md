# IA_RELAIS — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Base de reprise : `v0.11 — Cadres UI NineSlice et correction Prêtre`

## Prompt court de reprise

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame.

Lis d'abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md.
Ensuite vérifie l'état actuel du repo GitHub sur main, les changelogs, les audits, la roadmap, les documents dungeon et les playtests.

Travaille en français, signale les incohérences, et fournis des packs complets de fichiers à remplacer quand tu modifies le projet.

La base récente est v0.11 : amélioration visuelle de l'UI par texture NineSlice, cadres principaux et boutons texturés, menus harmonisés, long cadre de commandes supprimé derrière les boutons, et correction du libellé de classe Prêtre.
```

## État actuel confirmé

Le projet est un dungeon crawler rétro Godot en vue subjective.

La boucle jouable actuelle comprend :

```text
création de groupe
exploration étage 1 / étage 2
portes, temples, boutiques, coffres, messages
clé du gardien
porte verrouillée
boss fixe du gardien
passage derrière le boss
combats au tour par tour
inventaire commun
équipement
sauvegarde / chargement
contrôles souris et clavier AZERTY
grimoire hors combat
grimoire de combat
interface principale texturée par NineSlice
```

## Versions récentes

```text
v0.8.1 — Stabilisation playtest et scaling fenêtre
v0.8.2 — Refactorisations internes et stabilisation technique
v0.9 — Grimoire hors combat et sélection de cible
v0.10 — Grimoire de combat et ciblage des soins
v0.11 — Cadres UI NineSlice et correction Prêtre
```

## Points v0.11 validés

```text
- ajout de l'asset assets/ui/frames/texture_cadre_ui.png ;
- création du helper scripts/ui/theme/UIFrameStyle.gd ;
- application du cadre NineSlice aux panneaux principaux ;
- application de la texture aux cadres des héros ;
- application de la texture au viewport, au journal et à l'automap ;
- application de la texture aux boutons principaux ;
- application de la texture aux cadres et boutons des menus ;
- suppression du long cadre derrière les commandes d'exploration ;
- suppression du long cadre derrière les commandes de combat ;
- lisibilité générale conservée ;
- boutons encore utilisables, même si une texture dédiée aux boutons reste souhaitable plus tard ;
- correction de la classe d'Eldric : Prêtre au lieu de Prêtresse ;
- compatibilité des anciennes sauvegardes via normalisation du nom de classe.
```

## Points v0.10 conservés

```text
- bouton Grimoire pendant le combat ;
- grimoire de combat propre au héros actif ;
- sorts actifs temporaires, réinitialisés à chaque combat ;
- sélection du sort déjà actif sans perte de tour ;
- retour depuis le grimoire sans perte de tour ;
- changement réel de sort actif consommant l'action du tour ;
- bouton Magie lançant directement le sort offensif actif ;
- bouton Soin lançant directement le sort de soin actif ;
- soin en combat avec sélection de cible par cadres ;
- prévisualisation PV sur la cible ;
- prévisualisation PM sur le lanceur ;
- contrôles souris, flèches, ZQSD, A/E ;
- journal Combat : dégâts ennemis en rouge, soins en vert, dégâts joueur conservés.
```

## Points v0.9 conservés

```text
- grimoire hors combat accessible depuis le menu en jeu ;
- soins hors combat ;
- sélection par cadres de héros ;
- bordure verte ;
- prévisualisation PV/PM ;
- son de soin et flash vert ;
- pas de journal de quête ;
- pas de consommables.
```

## Règles de design importantes

```text
- Pas d'objets consommables pour le moment.
- Pas de potions.
- Pas de journal de quête ni moniteur d'objectif.
- L'absence de suivi explicite fait partie de la difficulté voulue.
- Les informations importantes passent plutôt par le canal de messages, avec variations de couleur si utile.
- Ne pas viser l'étage 3 comme priorité immédiate.
- Enrichir d'abord la boucle complète existante avec des fonctionnalités.
- Éviter les contours blancs et halos clairs sur les assets.
```

## UI NineSlice

État actuel :

```text
asset principal : assets/ui/frames/texture_cadre_ui.png
helper : scripts/ui/theme/UIFrameStyle.gd
panneaux : marge NineSlice 16 px
boutons : marge NineSlice réduite 8 px
```

Évolution future probable :

```text
texture dédiée aux boutons
éventuelle variante de cadre pour certains états actifs
éventuel atlas/ninesheet si plusieurs familles de cadres apparaissent
```

## Sorts et grimoires

État actuel :

```text
grimoire hors combat : action magique hors combat, notamment soins ;
grimoire de combat : propre au héros actif, sert à vérifier/changer le sort actif temporaire ;
Magie : lance directement le sort offensif actif ;
Soin : lance directement le sort de soin actif avec ciblage par cadres.
```

Règles de combat :

```text
sélectionner le sort déjà actif -> fermer le grimoire sans perdre le tour ;
revenir en arrière -> fermer le grimoire sans perdre le tour ;
changer de sort actif -> action du tour consommée.
```

Évolution future possible :

```text
grimoire hors combat individuel par héros ;
choix des sorts actifs avant combat ;
sorts utilisables seulement en combat visibles mais grisés ;
système sauvegardé de sorts connus/découverts si nécessaire.
```

## Refactorisations validées

```text
InGameMenuPanelUI.gd -> scripts/ui/menu/*
CombatManager.gd -> scripts/combat/Combat*Resolver/Helper/Access/Selector
Dungeon.gd -> DungeonMapHelper / DungeonFloorStateHelper / DungeonAutoMapHelper
GameSession.gd -> scripts/core/session/*
PartyCreationUI.gd -> scripts/ui/party_creation/*
```

## Fichiers de pilotage à consulter

```text
ASSISTANT_WORKFLOW.md
README.md
CHANGELOG/README.md
CHANGELOG/v0.11.md
audits/STATE_AUDITv0.11.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
```

## Règles de workflow à respecter

```text
- Toujours travailler en français.
- Vérifier main avant de modifier.
- Si plusieurs fichiers sont concernés, fournir un pack complet en priorité.
- Pour les refactorisations : scripts d'abord, tests locaux, zip local côté utilisateur, documentation seulement au moment de la release.
- Les fichiers locaux fournis explicitement par l'utilisateur sont prioritaires pour la tâche en cours.
- Cette priorité locale n'exclut pas la consultation, l'utilisation ou la modification des fichiers du repo GitHub lorsque c'est pertinent.
- Si un fichier GitHub semble obsolète, trop long ou incertain, demander le fichier local à l'utilisateur.
- Ne pas pousser les packs zip, builds, logs bruts ou sauvegardes locales.
```

## FLOOR_VISUALIZER

Avant toute modification de `docs/dungeon/FLOOR_VISUALIZER.md` :

```text
1. lire ASSISTANT_WORKFLOW.md ;
2. lire docs/dungeon/FLOOR_DESIGN.md ;
3. vérifier scripts/dungeon/FloorDatabase.gd ;
4. conserver strictement le format tableau/grille avec coordonnées.
```

Ne pas remplacer par bloc ASCII, format monospacé brut ou CSS expérimental sans demande explicite.
