# STATE_AUDITv0.8.2 — Audit après refactorisations internes

Date d'audit : 2026-06-19

Version de référence : `v0.8.2 — Refactorisations internes et stabilisation technique`

Branche cible : `main`

Objectif : établir une photographie fiable de l'état attendu du dépôt après la série de refactorisations internes validées localement.

## 1. Résumé exécutif

`v0.8.2` est une version de maintenance technique. Elle ne change pas volontairement le gameplay et ne modifie pas volontairement le format de sauvegarde.

La version part de la base stable `v0.8.1`, qui avait stabilisé :

- renderer `Compatibility / OpenGL` ;
- scaling fenêtre `canvas_items + keep` ;
- playtest 01 documenté ;
- crashs Windows classés comme contrainte de renderer/export ;
- builds et logs hors repo.

La série `v0.8.2` allège plusieurs grands contrôleurs par extraction de helpers spécialisés :

- menu en jeu ;
- combat ;
- donjon ;
- session globale ;
- création d'équipe.

Chaque refactorisation a été appliquée puis testée localement avant de continuer.

## 2. État de version attendu

Dernière release à créer :

```text
v0.8.2 — Refactorisations internes et stabilisation technique
```

Statut attendu : release technique / maintenance.

Effet attendu : aucun changement visible majeur pour le joueur, mais une base de code plus lisible et plus sûre pour les prochains ajouts.

## 3. Base technique héritée de v0.8.1

Les réglages structurants de `project.godot` doivent rester :

```ini
config/features=PackedStringArray("4.6", "GL Compatibility")
window/size/viewport_width=1152
window/size/viewport_height=648
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"
window/stretch/scale=1.0
window/stretch/scale_mode="fractional"
renderer/rendering_method="gl_compatibility"
```

Interprétation : `v0.8.2` ne doit pas modifier ces réglages.

## 4. Refactorisations validées

### 4.1 Menu en jeu

Fichier principal :

```text
scripts/ui/InGameMenuPanelUI.gd
```

Nouveaux fichiers :

```text
scripts/ui/menu/MenuUIFactory.gd
scripts/ui/menu/DevTeleportMenuView.gd
scripts/ui/menu/InventoryMenuView.gd
scripts/ui/menu/ShopMenuView.gd
scripts/ui/menu/StatusEquipmentMenuView.gd
```

Résultat : le menu en jeu reste accessible depuis la scène existante, mais les écrans internes sont séparés.

Tests utilisateur : OK.

### 4.2 Combat

Fichier principal :

```text
scripts/combat/CombatManager.gd
```

Nouveaux fichiers :

```text
scripts/combat/CombatActorAccess.gd
scripts/combat/CombatAccuracyResolver.gd
scripts/combat/CombatDamageResolver.gd
scripts/combat/CombatAbilityResolver.gd
scripts/combat/CombatTargetSelector.gd
scripts/combat/CombatLogHelper.gd
```

Résultat : les règles pures et helpers sont extraits, mais le flow principal du combat reste dans `CombatManager.gd`.

Tests utilisateur : OK.

### 4.3 Donjon

Fichier principal :

```text
scripts/dungeon/Dungeon.gd
```

Nouveaux fichiers :

```text
scripts/dungeon/DungeonMapHelper.gd
scripts/dungeon/DungeonFloorStateHelper.gd
scripts/dungeon/DungeonAutoMapHelper.gd
```

Résultat : lecture/modification du layout, état d'étage et découverte automap sont isolés.

Tests utilisateur : OK.

### 4.4 Session globale

Fichier principal :

```text
scripts/core/GameSession.gd
```

Nouveaux fichiers :

```text
scripts/core/session/GameSessionFloorStateHelper.gd
scripts/core/session/GameSessionShopHelper.gd
scripts/core/session/GameSessionEquipmentHelper.gd
```

Résultat : `GameSession.gd` reste le singleton public, mais délègue des responsabilités internes.

Tests utilisateur : OK.

### 4.5 Création d'équipe

Fichier principal :

```text
scripts/ui/PartyCreationUI.gd
```

Nouveaux fichiers :

```text
scripts/ui/party_creation/PartyCreationUIFactory.gd
scripts/ui/party_creation/PartyCreationHeroBuilder.gd
scripts/ui/party_creation/PartyCreationSummaryHelper.gd
```

Résultat : l'écran de création d'équipe sépare construction UI, création des héros et résumé.

Tests utilisateur : OK.

## 5. Vérifications fonctionnelles rapportées

Les tests locaux ont confirmé que les systèmes suivants tiennent encore :

```text
- menu en jeu ;
- inventaire ;
- boutique achat/vente ;
- statut ;
- équipement ;
- téléportation dev ;
- combat standard ;
- magie offensive ;
- soin ;
- fuite ;
- victoire ;
- K.O. ;
- exploration donjon ;
- portes ;
- automap ;
- transitions d'étage ;
- sauvegarde / chargement ;
- création d'équipe.
```

## 6. Documentation alignée pour la release

Fichiers documentaires à ajouter / mettre à jour pour `v0.8.2` :

```text
README.md
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
CHANGELOG/README.md
CHANGELOG/v0.8.2.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
audits/STATE_AUDITv0.8.2.md
```

Fichiers non modifiés par cette release sauf besoin explicite :

```text
project.godot
playtests/README.md
playtests/PLAYTEST_01_v0.8.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
CHANGELOG/v0.8.1.md
```

## 7. État de sauvegarde

Aucun changement volontaire du format de sauvegarde.

Points à vérifier avant ou après tag :

- charger une sauvegarde créée en `v0.8.1` ;
- ouvrir le menu ;
- équiper / déséquiper un objet ;
- acheter / vendre ;
- sauvegarder hors combat ;
- recharger ;
- confirmer l'état d'étage, l'inventaire, l'or et l'équipement.

Rappel : les anciennes sauvegardes peuvent conserver d'anciens layouts mémorisés.

## 8. État Git attendu

### Nouveaux fichiers scripts

```text
scripts/ui/menu/MenuUIFactory.gd
scripts/ui/menu/DevTeleportMenuView.gd
scripts/ui/menu/InventoryMenuView.gd
scripts/ui/menu/ShopMenuView.gd
scripts/ui/menu/StatusEquipmentMenuView.gd
scripts/combat/CombatActorAccess.gd
scripts/combat/CombatAccuracyResolver.gd
scripts/combat/CombatDamageResolver.gd
scripts/combat/CombatAbilityResolver.gd
scripts/combat/CombatTargetSelector.gd
scripts/combat/CombatLogHelper.gd
scripts/dungeon/DungeonMapHelper.gd
scripts/dungeon/DungeonFloorStateHelper.gd
scripts/dungeon/DungeonAutoMapHelper.gd
scripts/core/session/GameSessionFloorStateHelper.gd
scripts/core/session/GameSessionShopHelper.gd
scripts/core/session/GameSessionEquipmentHelper.gd
scripts/ui/party_creation/PartyCreationUIFactory.gd
scripts/ui/party_creation/PartyCreationHeroBuilder.gd
scripts/ui/party_creation/PartyCreationSummaryHelper.gd
```

### Fichiers scripts mis à jour

```text
scripts/ui/InGameMenuPanelUI.gd
scripts/combat/CombatManager.gd
scripts/dungeon/Dungeon.gd
scripts/core/GameSession.gd
scripts/ui/PartyCreationUI.gd
```

### Nouveaux fichiers docs

```text
CHANGELOG/v0.8.2.md
audits/STATE_AUDITv0.8.2.md
```

### Fichiers docs mis à jour

```text
README.md
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
CHANGELOG/README.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
```

### Fichiers à ne pas pousser

```text
packs .zip générés
builds exportées
*.exe
*.pck
*.zip
logs bruts
sauvegardes locales
backups zip locaux
README_PACK.md éventuel
```

## 9. Risques restants

Risque faible :

- oubli d'un nouveau helper dans Git ;
- fichier `.gd.uid` généré localement par Godot à vérifier selon l'état réel du projet ;
- doc en retard si la release est créée avant push des scripts.

Risque moyen :

- modification future de symboles de donjon sans source de vérité centralisée ;
- ajout de l'étage 3 sans vérifier sauvegarde multi-étages et automap ;
- extraction trop agressive du flow de combat.

Risque élevé :

- modifier le format de sauvegarde sans valeurs par défaut ;
- confondre crash renderer/export avec bug gameplay ;
- pousser des builds ou logs bruts.

## 10. Recommandation après v0.8.2

Ne pas enchaîner immédiatement sur une grosse réécriture.

Options recommandées :

```text
v0.8.3 : polish / confort / retours playtest / feedbacks joueur
v0.9   : nouveau contenu visible, probablement début d'étage 3 ou systèmes préparatoires
```

Avant l'étage 3, considérer une petite passe sur :

- symboles de donjon ;
- règles de marchabilité ;
- règles de rencontres aléatoires ;
- feedbacks boss / clé / sauvegarde.
