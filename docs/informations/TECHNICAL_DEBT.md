# TECHNICAL_DEBT — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Base actuelle : `v0.10 — Grimoire de combat et ciblage des soins`

## Résumé

La dette technique principale du projet a été réduite par la série de refactorisations `v0.8.2`, puis la base a été enrichie par `v0.9` et `v0.10` avec les grimoires et la sélection de cible.

La priorité technique actuelle n'est pas de refactoriser massivement à nouveau, mais de surveiller les nouveaux systèmes de magie, d'input et de journal de combat pendant les prochains playtests.

## Dette résolue ou fortement réduite

### Refactorisations internes v0.8.2

```text
InGameMenuPanelUI.gd -> scripts/ui/menu/*
CombatManager.gd -> scripts/combat/Combat*Resolver/Helper/Access/Selector
Dungeon.gd -> DungeonMapHelper / DungeonFloorStateHelper / DungeonAutoMapHelper
GameSession.gd -> scripts/core/session/*
PartyCreationUI.gd -> scripts/ui/party_creation/*
```

Ces refactorisations ont été testées localement et stabilisées avant release.

### Scaling et renderer

La configuration `Compatibility / OpenGL` et le scaling `canvas_items + keep` restent la base recommandée pour les builds de test Windows.

### Grimoire hors combat v0.9

Le grimoire hors combat fonctionne sans nouveau format de sauvegarde. Les PV/PM modifiés sont déjà persistés avec les héros.

### Grimoire de combat v0.10

Le grimoire de combat utilise des sorts actifs temporaires réinitialisés à chaque combat. Il n'ajoute pas encore de persistance.

## Points de vigilance actuels

### 1. CombatManager.gd

Même refactorisé, `CombatManager.gd` reste sensible car il orchestre :

```text
tour des héros
actions ennemies
victoire / fuite / défaite
boss
récompenses
sorts actifs temporaires
grimoire de combat
ciblage des soins
```

Les prochaines évolutions de magie doivent rester progressives et testables.

### 2. Sorts actifs

Pour le moment :

```text
sorts actifs = temporaires
réinitialisation = début de combat
sauvegarde = aucune persistance volontaire
```

Dette future probable : quand plusieurs sorts seront réellement disponibles, il faudra probablement créer :

```text
système de sorts connus / découverts
grimoire hors combat individuel par héros
choix persistant des sorts actifs
compatibilité anciennes sauvegardes
```

Cette évolution ne doit pas être improvisée dans `CharacterData.gd` ou `SaveManager.gd` sans conception préalable.

### 3. Sélection par cadres héros

`HeroFrameSelectionController.gd` est une brique UI réutilisable. Elle sert déjà :

```text
soins hors combat
soins en combat
```

À surveiller si elle sert plus tard à :

```text
sorts de protection
inspection de héros
actions spéciales
objets clés ou événements ciblés
```

Elle doit continuer à respecter :

```text
souris
flèches
ZQSD
A / Entrée
E / Échap
```

### 4. Journal Combat

`LogPanelUI.gd` colore maintenant certaines lignes de combat selon leur texte.

Risque : si les messages de combat deviennent plus variés, l'analyse textuelle peut devenir fragile.

Solution future possible : passer à des messages typés, par exemple :

```text
combat_player_damage
combat_enemy_damage
combat_heal
system_warning
key_item
message_tile
```

Ce n'est pas nécessaire immédiatement, mais c'est une bonne direction si la coloration devient difficile à maintenir.

### 5. Documentation dungeon

Pour `FLOOR_VISUALIZER.md`, ne jamais remplacer la grille/tableau par un bloc ASCII ou un format CSS expérimental sans demande explicite.

Avant modification :

```text
1. lire ASSISTANT_WORKFLOW.md ;
2. lire docs/dungeon/FLOOR_DESIGN.md ;
3. vérifier scripts/dungeon/FloorDatabase.gd ;
4. conserver le format tableau/grille avec coordonnées.
```

## À ne pas faire pour le moment

```text
- ajouter des objets consommables ;
- ajouter des potions ;
- créer un journal de quête ;
- créer un moniteur d'objectif ;
- ajouter l'étage 3 avant d'enrichir davantage la boucle actuelle ;
- changer le format de sauvegarde sans nécessité claire ;
- préparer une grosse refactorisation générale non motivée.
```

## Dette technique future probable

```text
système de sorts connus / découverts
grimoire individuel par héros
sauvegarde des préférences de sorts actifs
messages typés au lieu de détection textuelle
meilleur découpage si CombatManager grossit à nouveau
playtest 02 post-v0.10
```

## Recommandation immédiate

Après `v0.10`, privilégier :

```text
1. test complet de la boucle avec Mage + Prêtresse ;
2. test boss et K.O. ;
3. sauvegarde / chargement après plusieurs combats ;
4. éventuellement playtest 02 ;
5. ensuite seulement, concevoir les prochains sorts.
```
