# TECHNICAL_DEBT — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version de référence : `v0.9 — Grimoire hors combat et sélection de cible`

## 1. État général

La base `v0.9` est une base jouable avec une fonctionnalité de grimoire hors combat.

La dette la plus lourde des contrôleurs principaux a été réduite en `v0.8.2` :

```text
- menu en jeu refactorisé ;
- combat refactorisé ;
- donjon refactorisé ;
- GameSession refactorisé ;
- création d'équipe refactorisée.
```

`v0.9` ajoute une couche UI plus avancée : sélection de cible par cadres héros, prévisualisation PV/PM, grimoire hors combat et messages colorés.

## 2. Dette réglée ou fortement réduite

### Refactorisations v0.8.2

Les grands scripts suivants ont été allégés par extraction de helpers :

```text
scripts/ui/InGameMenuPanelUI.gd
scripts/combat/CombatManager.gd
scripts/dungeon/Dungeon.gd
scripts/core/GameSession.gd
scripts/ui/PartyCreationUI.gd
```

Statut : validé localement avant release `v0.8.2`.

### Renderer / crash playtest

Le problème de crash Windows du playtest `v0.8` a été traité par l'utilisation de `Compatibility / OpenGL` pour les builds de test.

Statut : résolu pour la procédure de build/playtest.

### Scaling fenêtre

Le scaling `canvas_items + keep` est la base validée.

Statut : résolu pour la base actuelle.

## 3. Dette nouvelle ou à surveiller après v0.9

### `PartyStatusUI.gd`

`PartyStatusUI.gd` gère maintenant plus de responsabilités visuelles :

```text
- affichage des héros ;
- flash rouge des dégâts ;
- bordure verte de sélection ;
- prévisualisation PV de soin ;
- prévisualisation PM de coût de sort ;
- signaux de cadres cliquables.
```

Ce n'est pas bloquant, mais il faudra surveiller ce fichier si d'autres mécaniques ciblant les héros s'ajoutent.

Piste future : isoler progressivement les éléments visuels de barre PV/PM ou les styles de cadres si le fichier grossit trop.

### `HeroFrameSelectionController.gd`

Ce contrôleur doit rester générique.

À éviter :

```text
- y coder des règles spécifiques au grimoire ;
- y dupliquer des tables d'input ;
- y appliquer directement des effets gameplay ;
- y dépendre d'une seule vue de menu.
```

À préserver :

```text
- sélection d'index ;
- survol souris ;
- validation ;
- annulation ;
- mise à jour visuelle via `PartyStatusUI` ;
- compatibilité souris / flèches / ZQSD / A / E.
```

### `GrimoireMenuView.gd`

La vue du grimoire doit rester spécialisée sur l'affichage et les choix du menu.

À éviter :

```text
- en faire un journal de quête ;
- y stocker une progression persistante ;
- y ajouter directement des systèmes de découverte complexes ;
- y mélanger trop de types de sorts avant d'avoir une abstraction stable.
```

Si un second sort hors combat est ajouté, vérifier si une extraction `OutOfCombatSpellResolver.gd` devient utile.

### `LogPanelUI.gd`

Le canal de messages coloré est utile mais doit rester maintenable.

À surveiller :

```text
- accumulation de détections textuelles fragiles ;
- couleurs trop nombreuses ;
- dépendance au texte exact des messages ;
- besoin futur d'un type de message explicite.
```

Piste future : remplacer progressivement les détections de texte par un système de catégories de messages, si le besoin devient réel.

## 4. Sauvegarde

`v0.9` ne change pas volontairement le format de sauvegarde.

Le grimoire modifie seulement des données déjà sauvegardées :

```text
- PV des héros ;
- PM des héros.
```

Les sorts disponibles restent déduits des classes et niveaux existants dans cette première version.

Dette future probable : si des sorts découverts, runes ou apprentissages sont ajoutés, il faudra créer une donnée persistante dédiée.

Exemples possibles :

```text
hero.known_ability_ids
hero.discovered_ability_ids
GameSession.magic_discoveries
floor_states.magic_unlocks
```

Ne pas ajouter cette persistance avant d'avoir un besoin clair.

## 5. UI / style

### Cadres et bordures

Le projet utilise actuellement des styles créés par script.

Pour de futures bordures plus propres :

```text
- envisager StyleBoxTexture ;
- utiliser des textures 9-slice ;
- centraliser les styles de cadres ;
- éviter les variations visuelles trop dispersées.
```

Ne pas lancer une refonte visuelle complète en même temps qu'un ajout gameplay important.

### Grimoire

Le grimoire est actuellement minimaliste, volontairement sans en-tête inutile et sans écran intermédiaire de cible.

À conserver :

```text
- menu compact ;
- sélection directe des cadres héros ;
- prévisualisation par barres ;
- peu de texte explicatif ;
- cohérence avec le reste de l'UI.
```

## 6. Donjon et visualiseur

Règles à respecter impérativement :

```text
- lire ASSISTANT_WORKFLOW.md avant modification ;
- lire docs/dungeon/FLOOR_DESIGN.md avant de modifier FLOOR_VISUALIZER.md ;
- reconstruire FLOOR_VISUALIZER.md depuis scripts/dungeon/FloorDatabase.gd ;
- conserver le format tableau/grille avec coordonnées ;
- ne pas remplacer par un bloc ASCII brut ;
- ne pas utiliser de format CSS expérimental sans demande explicite.
```

Les anciennes sauvegardes peuvent conserver des états de layout. Pour tester un changement de carte, utiliser une nouvelle partie ou nettoyer la sauvegarde de test.

## 7. Points non prioritaires

Ne pas prioriser pour le moment :

```text
- objets consommables ;
- potions ;
- étage 3 ;
- journal de quête ;
- suivi explicite d'objectifs ;
- bestiaire complet ;
- refonte visuelle globale.
```

Ces sujets peuvent revenir plus tard, mais ils ne correspondent pas à la priorité immédiate après `v0.9`.

## 8. Tests recommandés après v0.9

Pour sécuriser la version, effectuer au moins un test court :

```text
- démarrer une nouvelle partie ;
- créer un groupe avec Prêtresse ;
- subir des dégâts ;
- utiliser Soin léger hors combat ;
- vérifier prévisualisation PV/PM ;
- sauvegarder ;
- charger ;
- vérifier PV/PM ;
- acheter/vendre en boutique ;
- équiper/déséquiper ;
- ouvrir coffre ;
- lire message M ;
- combattre ;
- tester K.O. ;
- tester boss si possible.
```

## 9. Évaluation actuelle

La base est saine pour continuer.

La prochaine dette à traiter dépendra des retours :

```text
- si l'UI grimoire gêne : polish ciblé ;
- si les messages colorés deviennent fragiles : catégories de messages ;
- si un second sort hors combat est ajouté : resolver de sorts hors combat ;
- si des sorts découverts apparaissent : persistance dédiée.
```
