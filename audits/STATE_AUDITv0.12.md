# STATE_AUDIT v0.12 — DungeonCrawFirstMiniGame

Date d'audit : 2026-06-22

Version auditée : `v0.12 — Équilibrage combat, sort découvert et corrections UI`

## Statut général

Prototype Godot public de dungeon crawler rétro en vue subjective.

`v0.12` est une release de progression, équilibrage et corrections UI, construite sur la base `v0.11.3`.

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

## Changements v0.12

Gameplay :

```text
- Étincelle / spark : 3 PM -> 6 PM ;
- Éclat de givre utilisable en combat après découverte et conditions remplies ;
- sorts découverts sauvegardés dans discovered_ability_ids ;
- monstres normaux +25 % PV ;
- boss gardien conservé à 225 PV.
```

Interface :

```text
- rolls de création d'équipe colorés ;
- écran équipement compacté et cadres inutiles retirés ;
- retour automatique au canal Journal après combat.
```

## Fichiers principaux concernés

Gameplay / sauvegarde :

```text
scripts/abilities/AbilityDatabase.gd
scripts/monsters/MonsterDatabase.gd
scripts/combat/CombatAbilityResolver.gd
scripts/dungeon/Dungeon.gd
scripts/core/GameSession.gd
scripts/core/SaveManager.gd
```

Interface :

```text
scripts/ui/PartyCreationUI.gd
scripts/ui/menu/StatusEquipmentMenuView.gd
scripts/ui/GameUI.gd
```

Documentation :

```text
README.md
CHANGELOG/README.md
CHANGELOG/v0.12.md
ASSISTANT_WORKFLOW.md
IA_RELAIS.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
audits/STATE_AUDITv0.12.md
```

## Sauvegarde

Format de sauvegarde : version 6.

Nouveau champ :

```text
discovered_ability_ids
```

Compatibilité :

```text
anciennes sauvegardes chargeables
champ absent = liste vide
```

## Tests locaux à confirmer avant tag

```text
Étincelle coûte 6 PM
découverte d'Éclat de givre à l'étage 1
Mage niveau 1 : sort non utilisable
Mage niveau 2 : sort utilisable
sauvegarde / chargement après découverte
PV des monstres normaux
boss gardien à 225 PV
couleurs des rolls
écran équipement
canal Journal après combat
boucle complète étage 1 -> étage 2 -> boss
```

## Points de vigilance

```text
- surveiller la durée des combats ;
- vérifier l'économie de PM du Mage ;
- vérifier que les anciennes sauvegardes se chargent ;
- vérifier que la découverte de sort n'est pas perdue au chargement ;
- vérifier les écrans denses avec la police globale ;
- ne pas pousser les packs temporaires ;
- ne pas pousser les builds ;
- ne pas pousser les logs bruts ;
- conserver Compatibility / OpenGL pour les builds de playtest.
```
