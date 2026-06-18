# REPO_STATEv0.8

État du dépôt `DungeonCrawFirstMiniGame` observé pour la période `v0.8`.

Ce document sert de photographie technique et organisationnelle du projet avant la compilation complète des retours de playtest.  
Il ne remplace pas `ROADMAP.md`, `TECHNICAL_DEBT.md` ou `CHANGELOG/` : il résume l’état actuel du repo et propose une hiérarchie de priorités.

---

## 1. Résumé exécutif

Le projet est dans un état globalement sain pour un prototype Godot pré-1.0 :

- la première boucle de jeu est fonctionnelle ;
- les systèmes majeurs sont présents : exploration, combat, inventaire, équipement, boutique, multi-étages, coffres, messages, clé, boss, sauvegarde ;
- la documentation a été séparée en documents spécialisés ;
- les contrôles `v0.8` sont présents sur `main` : souris, clavier directionnel, clavier AZERTY ;
- le projet est assez avancé pour une première vague de retours externes.

Les points à traiter en priorité ne sont pas des ajouts de contenu, mais des points de stabilité et de lisibilité :

1. corriger la mise à l’échelle de la fenêtre ;
2. nettoyer les fichiers temporaires déjà versionnés dans `scenes/` ;
3. remettre la documentation de pilotage exactement au niveau `v0.8` ;
4. éviter les gros refactors tant que les retours de playtest ne sont pas compilés.

---

## 2. État de version constaté

### 2.1 Code et documentation sur `main`

Le `main` contient déjà des éléments correspondant à `v0.8` :

- actions d’input dédiées dans `project.godot` :
  - `move_forward` ;
  - `move_back` ;
  - `turn_left` ;
  - `turn_right` ;
  - `confirm_action` ;
  - `back_action`.
- `CHANGELOG/README.md` référence déjà `v0.8`.
- `CHANGELOG/v0.8.md` existe.
- les scripts de contrôle souris / clavier AZERTY sont présents.

### 2.2 Releases GitHub

La dernière release GitHub visible lors de la vérification est encore `v0.7.1-Boss&death`.  
Aucune release GitHub `v0.8` n’était visible au moment de l’audit.

Conséquence :

```text
main semble être en état post-v0.8,
mais les releases publiques semblent encore arrêtées à v0.7.1.
```

À vérifier avant toute annonce publique ou tag final.

---

## 3. Organisation générale du dépôt

### 3.1 Racine

Fichiers principaux observés :

```text
.gitignore
README.md
ROADMAP.md
TECHNICAL_DEBT.md
ASSISTANT_WORKFLOW.md
FLOOR_DESIGN.md
FLOOR_VISUALIZER.md
project.godot
CHANGELOG/
assets/
scenes/
scripts/
```

Rôle actuel :

- `project.godot` : configuration moteur, autoloads, inputs, rendu.
- `README.md` : présentation publique du projet, encore très minimale dans le repo.
- `ROADMAP.md` : direction actuelle du projet.
- `CHANGELOG/` : historique de versions.
- `TECHNICAL_DEBT.md` : refactorisations et dette technique.
- `ASSISTANT_WORKFLOW.md` : règles de collaboration avec l’assistant.
- `FLOOR_DESIGN.md` : nomenclature et règles de conception des layouts.
- `FLOOR_VISUALIZER.md` : lecture visuelle des étages.

### 3.2 Assets

Organisation constatée :

```text
assets/audio/
assets/cleric/
assets/mage/
assets/thief/
assets/warrior/
assets/monsters/
```

Les assets de monstres utilisés par le code sont présents via chemins directs :

```text
assets/monsters/zombie/
assets/monsters/gobelin/
assets/monsters/chauve_souris/
assets/monsters/troll/
assets/monsters/gardien/
```

Note : la vue de répertoire GitHub peut parfois ne pas présenter clairement tous les sous-dossiers de monstres, mais les chemins raw directs des assets testés répondent correctement.

### 3.3 Scènes

Organisation observée :

```text
scenes/Dungeon.tscn
scenes/MainMenu.tscn
scenes/PartyCreation.tscn
```

Problème observé :

```text
scenes/Dungeon.tscn*.tmp
scenes/PartyCreation.tscn*.tmp
```

Des fichiers temporaires `.tmp` sont présents dans le repo.  
Le `.gitignore` ignore déjà `*.tmp`, mais cela ne supprime pas les fichiers déjà suivis par Git.

Priorité : haute avant une diffusion plus large du repo.

### 3.4 Scripts

Organisation actuelle :

```text
scripts/abilities/
scripts/audio/
scripts/characters/
scripts/combat/
scripts/core/
scripts/dungeon/
scripts/equipment/
scripts/inventory/
scripts/items/
scripts/monsters/
scripts/shop/
scripts/ui/
```

Cette séparation est saine pour un projet qui a grandi vite.  
Le plus gros point de vigilance reste que certains scripts centraux orchestrent beaucoup de responsabilités, surtout `Dungeon.gd` et `InGameMenuPanelUI.gd`.

---

## 4. Relations entre les systèmes

## 4.1 Configuration projet

`project.godot` définit :

```text
Autoloads :
- GameSession
- SaveManager
- AudioManager

Main scene :
- scène principale du projet

Inputs :
- move_forward
- move_back
- turn_left
- turn_right
- confirm_action
- back_action
```

Le projet indique Godot `4.6`.

Point important : aucune configuration globale `display/window/stretch` n’est actuellement visible.  
Cela correspond au bug déjà identifié : redimensionnement de fenêtre non proportionnel.

---

## 4.2 Session, sauvegarde et persistance

### `GameSession.gd`

Rôle :

- conserve le groupe courant ;
- conserve l’étage courant ;
- conserve les états d’étage ;
- conserve l’inventaire commun ;
- conserve l’or ;
- conserve la disponibilité contextuelle de la boutique ;
- prépare nouvelle partie ou chargement.

Relations :

```text
Dungeon.gd -> GameSession
SaveManager.gd -> GameSession
InGameMenuPanelUI.gd -> GameSession
ShopRules.gd -> GameSession via achats/ventes
InventoryData.gd -> GameSession
EquipmentRules.gd -> GameSession
```

### `SaveManager.gd`

Rôle :

- sauvegarde en `user://savegame.json` ;
- sérialise le groupe ;
- sérialise l’étage courant ;
- sérialise les états d’étage ;
- sérialise l’inventaire ;
- sérialise l’or ;
- recharge les héros et prépare `GameSession`.

Point fort : la compatibilité avec les anciennes sauvegardes a été prise en compte.

Point à prévoir plus tard : une stratégie explicite de migration de sauvegarde par version.

---

## 4.3 Donjon et progression

### `FloorDatabase.gd` / `FloorData.gd`

Rôle :

- layouts ASCII des étages ;
- coordonnées importantes ;
- tables de rencontre ;
- coffres ;
- messages ;
- portes verrouillées ;
- découvertes de sorts.

### `Dungeon.gd`

Rôle actuel :

- charge les étages ;
- orchestre le déplacement ;
- gère les portes simples ;
- gère les portes verrouillées ;
- gère les coffres ;
- gère les messages ;
- gère les escaliers ;
- gère temple et boutique ;
- déclenche les rencontres aléatoires ;
- déclenche le boss `X` ;
- conserve l’état runtime du donjon ;
- connecte l’UI ;
- connecte le combat ;
- gère la sauvegarde via `DungeonSaveController.gd` ;
- expose l’outil temporaire de téléportation de développement.

Conclusion :

`Dungeon.gd` fonctionne, mais c’est le principal carrefour du projet.  
Il ne faut pas le réécrire brutalement maintenant. Les extractions doivent être ciblées.

### `DungeonInputController.gd`

Rôle :

- centralise les entrées clavier ;
- centralise une partie de la validation souris ;
- fait correspondre `ZQSD` au comportement directionnel ;
- fait correspondre `A` à `Espace` / `Entrée` ;
- fait correspondre `E` à `Échap`.

Point positif : ce script limite les doublons entre clavier et souris.

---

## 4.4 Combat

### `CombatManager.gd`

Rôle :

- démarre les combats ;
- maintient l’état de combat ;
- gère les commandes ;
- applique les dégâts ;
- applique fuite/victoire/défaite ;
- signale la fin de combat ;
- gère les validations de dégâts.

### `MonsterDatabase.gd`

Rôle :

- centralise les monstres ;
- fournit les rencontres par étage ;
- contient le boss `gardien_boss_etage_2`.

État actuel :

- le boss réutilise le gardien normal ;
- seule différence gameplay : PV multipliés ;
- la constante de multiplicateur est prévue pour l’équilibrage.

Point à garder :

- ne pas multiplier les cas spéciaux de boss directement dans `Dungeon.gd` ou `CombatManager.gd` ;
- prévoir plus tard une structure de données pour les boss si le nombre augmente.

---

## 4.5 Inventaire, objets, équipement et boutique

### `ItemDatabase.gd`

Rôle :

- base d’objets ;
- objets équipables ;
- objets de quête ;
- descriptions ;
- valeurs de vente ;
- limites de pile ;
- bonus d’équipement.

Contient notamment :

```text
boss_door_key_floor_2 = Clé du gardien
```

### `InventoryData.gd`

Rôle :

- inventaire commun ;
- piles ;
- ajout / retrait ;
- sérialisation.

### `EquipmentRules.gd`

Rôle :

- règles d’équipement ;
- slots ;
- restrictions par classe.

### `ShopRules.gd`

Rôle :

- achat ;
- vente ;
- prix ;
- refus des objets non vendables ou de quête.

État global : sain.  
Le système est encore simple, mais il a une séparation correcte pour un prototype.

---

## 4.6 Interface

Scripts UI principaux :

```text
GameUI.gd
DungeonViewportUI.gd
CommandOverlayUI.gd
PartyStatusUI.gd
HeroPortraitUI.gd
CombatMonsterDisplayUI.gd
InGameMenuPanelUI.gd
AutoMapUI.gd
LogPanelUI.gd
MainMenu.gd
PartyCreationUI.gd
```

Relations principales :

```text
Dungeon.gd
  -> GameUI.gd
      -> DungeonViewportUI.gd
          -> CommandOverlayUI.gd
          -> CombatMonsterDisplayUI.gd
      -> PartyStatusUI.gd
      -> InGameMenuPanelUI.gd
      -> AutoMapUI.gd
      -> LogPanelUI.gd
```

Points forts :

- UI de commandes désormais cliquable ;
- commandes de combat cliquables ;
- overlay distinct ;
- automap séparée ;
- portraits séparés.

Points faibles actuels :

- `InGameMenuPanelUI.gd` concentre plusieurs écrans ;
- la mise à l’échelle globale n’est pas maîtrisée ;
- certains panneaux risquent de s’étirer sans que les portraits ou sprites suivent proportionnellement.

---

## 5. État documentaire

### Documents déjà bien séparés

```text
ROADMAP.md
TECHNICAL_DEBT.md
ASSISTANT_WORKFLOW.md
FLOOR_DESIGN.md
FLOOR_VISUALIZER.md
CHANGELOG/
```

Cette séparation est bonne et doit être conservée.

### Points à mettre à jour après `v0.8`

`ROADMAP.md` indique encore `v0.7.1` comme version stable actuelle et parle encore d’une prochaine version probable `v0.7.2` ou `v0.8`.

`ASSISTANT_WORKFLOW.md` indique encore `v0.7.1` comme dernière base stable connue.

`README.md` reste très minimal et ne décrit pas encore clairement :

- la version jouable ;
- les contrôles ;
- le contenu actuel ;
- la façon de lancer ou tester le projet ;
- les documents utiles.

`CHANGELOG/README.md` et `CHANGELOG/v0.8.md` sont en avance sur les releases publiques si la release GitHub `v0.8` n’est pas encore créée.

---

## 6. Problèmes / optimisations par priorité

## P0 — À corriger avant ou pendant `v0.8.1`

### P0.1 — Scaling global de la fenêtre

Problème :

- redimensionner la fenêtre peut casser l’alignement des sprites de monstres ;
- l’UI ne se met pas à l’échelle proportionnellement ;
- certains cadres s’étirent pendant que portraits/sprites restent fixes.

Comportement souhaité :

```text
redimensionnement fenêtre = zoom proportionnel du jeu complet
```

Piste principale :

```text
project.godot
display/window/stretch/mode = "viewport"
display/window/stretch/aspect = "keep"
```

À vérifier dans Godot :

- rendu exploration ;
- rendu combat ;
- sprites monstres ;
- portraits ;
- menu ;
- inventaire ;
- statut ;
- équipement ;
- boutique ;
- export Windows.

Fichiers probables :

```text
project.godot
scripts/dungeon/Dungeon.gd si une taille minimale de fenêtre est ajoutée
```

---

### P0.2 — Fichiers temporaires suivis dans `scenes/`

Problème :

- plusieurs fichiers `*.tmp` sont visibles dans `scenes/`.
- `.gitignore` contient déjà `*.tmp`, mais les fichiers déjà suivis par Git restent dans le repo.

Action recommandée :

```bash
git rm scenes/*.tmp
git commit -m "Remove tracked temporary scene files"
```

Vérifier ensuite :

```bash
git status
git ls-files "*.tmp"
```

Résultat attendu :

```text
aucun fichier .tmp suivi par Git
```

---

## P1 — À faire autour de `v0.8.1`

### P1.1 — Aligner la documentation avec `v0.8`

À mettre à jour après confirmation de la release :

```text
ROADMAP.md
ASSISTANT_WORKFLOW.md
README.md
```

Objectif :

- `ROADMAP.md` doit indiquer `v0.8` comme base si la release est faite ;
- `ASSISTANT_WORKFLOW.md` doit indiquer `v0.8` comme dernière base stable connue ;
- `README.md` doit être utile à un visiteur ou testeur.

### P1.2 — Centraliser les symboles de donjon

Les symboles sont encore répétés entre :

```text
Dungeon.gd
FloorDatabase.gd
DungeonRenderer.gd
AutoMapUI.gd
FLOOR_DESIGN.md
FLOOR_VISUALIZER.md
```

Créer plus tard :

```text
scripts/dungeon/DungeonTileTypes.gd
```

Rôle :

- constantes des symboles ;
- noms lisibles ;
- groupes : lieux sûrs, portes, événements, boss, etc.

Bénéfice :

- moins de divergences ;
- ajout de symboles futurs plus sûr ;
- meilleure cohérence entre rendu, automap et gameplay.

### P1.3 — Centraliser les règles de marchabilité et de rencontre

Aujourd’hui, `Dungeon.gd` décide principalement :

- si une case est marchable ;
- si une case déclenche une rencontre ;
- si une case spéciale intercepte le déplacement.

Créer plus tard :

```text
scripts/dungeon/DungeonTileRules.gd
```

Rôle :

- `is_walkable(tile)` ;
- `can_trigger_random_encounter(tile)` ;
- `blocks_vision(tile)` ;
- `is_safe_tile(tile)`.

Bénéfice :

- essentiel avant d’ajouter `F`, `S`, `P`, `E`, `R` ;
- évite que chaque symbole ait sa logique dispersée.

---

## P2 — Refactors utiles mais à faire prudemment

### P2.1 — Extraire les événements de tuiles spéciales

Actuellement, `Dungeon.gd` gère directement :

```text
C = coffre
M = message
L = porte verrouillée
X = boss
O = temple
B = boutique
< / > = escaliers
```

Extraction possible :

```text
scripts/dungeon/DungeonTileEventController.gd
```

Ne pas faire avant d’avoir stabilisé les retours `v0.8.1`.

### P2.2 — Scinder `InGameMenuPanelUI.gd`

Ce fichier concentre :

```text
inventaire
statut
équipement
boutique
options système
téléportation dev
futur grimoire
```

Extractions possibles :

```text
InventoryMenuUI.gd
StatusMenuUI.gd
EquipmentMenuUI.gd
ShopMenuUI.gd
DevTeleportMenuUI.gd
GrimoireMenuUI.gd
```

À faire seulement si une nouvelle fonctionnalité UI importante est ajoutée.

### P2.3 — Migration de sauvegarde

Le projet conserve déjà des états d’étage.  
Les anciennes sauvegardes peuvent conserver d’anciens layouts.

À prévoir :

```text
save_version
migration v5 -> v6
reset optionnel d’étage pour test
note explicite dans changelog
```

Priorité moyenne avant une diffusion plus large.

---

## P3 — Améliorations confort / maintenance

### P3.1 — README public

Le `README.md` actuel reste trop court pour un dépôt public jouable.

Suggestion :

- description du jeu ;
- statut `v0.8` ;
- contrôles ;
- contenu jouable ;
- capture éventuelle ;
- comment lancer dans Godot ;
- comment exporter ;
- liens vers `ROADMAP.md`, `CHANGELOG/`, `FLOOR_DESIGN.md`.

### P3.2 — Export playtest

Pas besoin de pousser les exécutables.  
Mais le dépôt pourrait contenir plus tard :

```text
EXPORT_PLAYTEST.md
```

ou une section README décrivant :

- Godot 4.6 ;
- export Windows ;
- fichiers à zipper ;
- fichiers à ne pas pousser.

À décider après les retours testeurs.

### P3.3 — Assets

Points à surveiller :

- tailles et poids des sprites ;
- cohérence des noms de dossiers ;
- halos blancs à éviter ;
- éventuelle normalisation des dimensions d’affichage côté UI plutôt que par asset.

Ne pas refaire les assets maintenant, sauf bug visuel bloquant.

---

## P4 — À reporter après les retours

Ne pas traiter avant d’avoir compilé les retours testeurs :

- gros polish visuel global ;
- étage 3 ;
- attaques spéciales de boss ;
- grimoire complet ;
- refonte lourde de l’UI ;
- système de quêtes plus complexe ;
- passages secrets ;
- pièges ;
- combats fixes non-boss `F`.

---

## 7. Plan recommandé pour `v0.8.1`

### Étape 1 — Correctifs bloquants / visibles

```text
project.godot
- ajouter le stretch global proportionnel
- vérifier taille minimale éventuelle

scenes/
- retirer les .tmp suivis par Git
```

### Étape 2 — Documentation minimale

```text
ROADMAP.md
- base actuelle v0.8
- prochaine étape v0.8.1 : correctifs playtest

ASSISTANT_WORKFLOW.md
- dernière base stable connue v0.8

README.md
- seulement si tu veux rendre le repo plus lisible publiquement avant davantage de testeurs
```

### Étape 3 — Retours testeurs

Regrouper les retours en :

```text
Bloquant
Important
Confort / polish
```

Puis décider si `v0.8.1` reste un hotfix ou devient un patch plus large.

---

## 8. Fichiers à envisager pour le prochain patch

### Nouveaux fichiers

```text
Aucun obligatoire pour v0.8.1.
```

### Fichiers probablement mis à jour

```text
project.godot
ROADMAP.md
ASSISTANT_WORKFLOW.md
README.md optionnel
```

### Fichiers à nettoyer du suivi Git

```text
scenes/*.tmp
```

### À ne pas pousser

```text
build/
dist/
export/
*.exe
*.pck
*.zip
README_TESTEURS.txt sauf décision explicite
sauvegardes locales
dossier .godot/
```

---

## 9. Verdict

Le repo est assez bien organisé pour un prototype qui a grandi vite.

Les systèmes de données sont déjà mieux séparés que nécessaire pour une version aussi précoce :

- objets ;
- monstres ;
- inventaire ;
- équipement ;
- boutique ;
- donjon ;
- sauvegarde ;
- UI ;
- documentation.

Le principal risque n’est pas l’absence de structure, mais l’accumulation progressive dans certains scripts centraux.

Recommandation :

```text
Ne pas lancer de gros refactor avant les retours testeurs.
Corriger d’abord le scaling fenêtre et le nettoyage des fichiers temporaires.
Ensuite seulement décider des refactors utiles selon les retours.
```

---

## 10. Sources consultées

- `project.godot`
- `.gitignore`
- `README.md`
- `ROADMAP.md`
- `TECHNICAL_DEBT.md`
- `ASSISTANT_WORKFLOW.md`
- `CHANGELOG/README.md`
- `CHANGELOG/v0.8.md`
- `FLOOR_DESIGN.md`
- `FLOOR_VISUALIZER.md`
- `scripts/dungeon/`
- `scripts/combat/`
- `scripts/core/`
- `scripts/items/`
- `scripts/monsters/`
- `scripts/ui/`
- `scenes/`
- `assets/monsters/`
- page des releases GitHub
