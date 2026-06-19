# IA_RELAIS — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Base de reprise : `v0.11.1 — Carte agrandie et automap améliorée`

## Prompt court de reprise

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame.

Lis d'abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md.
Ensuite vérifie l'état actuel du repo GitHub sur main, les changelogs, les audits, la roadmap, les documents dungeon et les playtests.

Travaille en français, signale les incohérences, et fournis des packs complets de fichiers à remplacer quand tu modifies le projet.

La base récente est v0.11.1 : UI NineSlice de v0.11, correction Prêtre, carte agrandie d'exploration dans le viewport, automap compacte améliorée, et coordonnées au survol souris des cases découvertes non-mur.
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
carte agrandie d'exploration
automap compacte améliorée
```

## Versions récentes

```text
v0.8.1 — Stabilisation playtest et scaling fenêtre
v0.8.2 — Refactorisations internes et stabilisation technique
v0.9 — Grimoire hors combat et sélection de cible
v0.10 — Grimoire de combat et ciblage des soins
v0.11-Polish — Cadres UI NineSlice et correction Prêtre
v0.11.1 — Carte agrandie et automap améliorée
```

## Points v0.11.1 validés

```text
- bouton Carte en exploration ;
- carte agrandie affichée dans le viewport ;
- fermeture par Retour, E ou Échap ;
- déplacements bloqués pendant l'affichage de la carte ;
- carte non disponible en combat ;
- carte agrandie synchronisée avec l'état de l'automap ;
- aucune révélation de zones non découvertes ;
- cadre de carte texturé selon les règles UI v0.11 ;
- bouton Retour texturé et placé dans le coin bas gauche du cadre de carte ;
- tooltip de coordonnées au survol souris des cases découvertes non-mur ;
- tooltip également disponible sur l'automap compacte ;
- pas de coordonnées affichées sur les murs ni sur les cases non découvertes ;
- titre AUTOMAP retiré pour gagner de la place ;
- automap compacte légèrement zoomée tout en conservant 15 cases par 11.
```

## Points v0.11 conservés

```text
- asset assets/ui/frames/texture_cadre_ui.png ;
- helper scripts/ui/theme/UIFrameStyle.gd ;
- cadres principaux texturés ;
- boutons principaux texturés ;
- menus harmonisés ;
- long cadre derrière les commandes supprimé ;
- correction de la classe d'Eldric : Prêtre ;
- compatibilité anciennes sauvegardes via normalisation du nom de classe.
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
- journal Combat : dégâts ennemis en rouge, soins verts, dégâts joueur conservés.
```

## Règles de design importantes

```text
- Pas d'objets consommables pour le moment.
- Pas de potions.
- Pas de journal de quête ni moniteur d'objectif.
- L'absence de suivi explicite fait partie de la difficulté voulue.
- Les cartes ne doivent pas révéler d'informations non découvertes.
- Les informations importantes passent plutôt par le canal de messages, avec variations de couleur si utile.
- Ne pas viser l'étage 3 comme priorité immédiate.
- Enrichir d'abord la boucle complète existante avec des fonctionnalités.
- Éviter les contours blancs et halos clairs sur les assets.
```

## Sorts et grimoires

État actuel :

```text
grimoire hors combat : action magique hors combat, notamment soins ;
grimoire de combat : propre au héros actif, sert à vérifier/changer le sort actif temporaire ;
Magie : lance directement le sort offensif actif ;
Soin : lance directement le sort de soin actif avec ciblage par cadres.
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
CHANGELOG/v0.11.1.md
audits/STATE_AUDITv0.11.1.md
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
