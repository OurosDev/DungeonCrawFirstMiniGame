# STATE_AUDIT v0.13 — DungeonCrawFirstMiniGame

Date d'audit : 2026-06-22

Version auditée : `v0.13 — Magicka : progression magique, sorts actifs et poison`

## Statut général

Prototype Godot public de dungeon crawler rétro en vue subjective.

`v0.13` est une release de progression magique et de système de combat, construite sur la base `v0.12`.

## Base conservée

La base jouable reste celle des versions précédentes :

```text
création d'équipe
exploration case par case
deux étages
combats au tour par tour
inventaire commun
équipement
boutique
temple
coffres
messages
clé de progression
boss fixe
sauvegarde / chargement
contrôles souris et clavier AZERTY
grimoire hors combat
grimoire de combat
soin ciblé par cadres
journal Combat coloré
UI NineSlice
carte agrandie
automap compacte
fond du menu principal
police OpenType globale
```

## Changements v0.13

Magie :

```text
- Éclat de givre : 10 PM, 12-24 dégâts ;
- Soin renforcé : Prêtre niveau 5, 9 PM, 16-28 PV ;
- Soin de groupe : 9 PM, 7-13 PV, toute l'équipe ;
- Soin de groupe découvert étage 2 x21 y8 ;
- Poison : Mage niveau 5, 10 PM ;
- Poison : 5 à 10 % des PV max par tick ;
- boss gardien immunisé au poison.
```

Grimoire :

```text
- préparation hors combat des sorts actifs ;
- choix de sort offensif actif ;
- choix de sort de soin actif ;
- grimoire de combat toujours temporaire.
```

Sauvegarde :

```text
- format version 7 ;
- nouveau champ active_ability_ids_by_party_slot ;
- conservation du champ discovered_ability_ids.
```

Scripts :

```text
- ajout progressif de l'en-tête VERSION SCRIPT / v0.13-Magicka aux scripts modifiés.
```

## Fichiers principaux concernés

Gameplay / données :

```text
scripts/abilities/AbilityDatabase.gd
scripts/characters/ClassDatabase.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/FloorDatabase.gd
```

Combat :

```text
scripts/combat/CombatManager.gd
scripts/combat/CombatStatusEffectResolver.gd
```

Sauvegarde :

```text
scripts/core/GameSession.gd
scripts/core/SaveManager.gd
```

Interface :

```text
scripts/ui/menu/CombatGrimoireMenuView.gd
scripts/ui/menu/GrimoireMenuView.gd
```

Documentation :

```text
README.md
CHANGELOG/README.md
CHANGELOG/v0.13.md
ASSISTANT_WORKFLOW.md
IA_RELAIS.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
audits/STATE_AUDITv0.13.md
```

## Tests locaux confirmés avant préparation release

```text
- le pack de correction syntaxique v0.13-Magicka a corrigé les erreurs d'indentation ;
- le pack grimoire / sorts actifs fonctionne comme prévu côté utilisateur.
```

## Tests à refaire avant tag si possible

```text
projet compile
Éclat de givre disponible et rééquilibré
Poison disponible Mage niveau 5
Poison fonctionne sur monstre normal
Poison ne fonctionne pas sur boss gardien
Soin renforcé disponible Prêtre niveau 5
Soin de groupe découvert étage 2 x21 y8
Soin de groupe hors combat
Soin de groupe en combat
préparation hors combat des sorts actifs
grimoire de combat temporaire
sauvegarde / chargement des sorts préparés
boucle complète étage 1 -> étage 2 -> boss
```

## Points de vigilance

```text
- surveiller les anciennes sauvegardes ;
- surveiller l'équilibrage du poison ;
- surveiller la lisibilité du grimoire ;
- ne pas pousser les packs temporaires ;
- ne pas pousser les builds ;
- ne pas pousser les logs bruts ;
- conserver Compatibility / OpenGL pour les builds de playtest.
```
