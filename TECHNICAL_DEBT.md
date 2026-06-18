# Dette technique et refactorisations — DungeonCrawFirstMiniGame

Ce document regroupe les pistes techniques qui alourdissaient auparavant `ROADMAP.md`.

Objectif : garder la roadmap lisible, tout en conservant une trace des refactorisations utiles.

---

## 1. Principe général

Le projet possède maintenant une première boucle jouable stable jusqu’à `v0.7.1`.

À ce stade, il vaut mieux éviter les grosses réécritures. Les refactorisations doivent être :

- ciblées ;
- testables rapidement ;
- compatibles avec les sauvegardes autant que possible ;
- faites une par une ;
- séparées des gros ajouts de contenu.

---

## 2. Refactorisations sûres à court terme

### 2.1 Centraliser les symboles de donjon

Les symboles `#`, `.`, `D`, `d`, `>`, `<`, `O`, `B`, `C`, `M`, `F`, `X`, `L`, `S`, `P`, `E`, `R` sont utilisés par plusieurs systèmes.

Créer plus tard une source commune éviterait les oublis entre :

- `FloorDatabase.gd` ;
- `Dungeon.gd` ;
- `DungeonRenderer.gd` ;
- `AutoMapUI.gd` ;
- `FLOOR_DESIGN.md` ;
- `FLOOR_VISUALIZER.md`.

Nom possible :

```text
scripts/dungeon/DungeonTileTypes.gd
```

Priorité : haute, mais à faire simplement.

---

### 2.2 Centraliser les règles de marchabilité

Les règles “est-ce que le joueur peut marcher ici ?” deviennent plus importantes avec :

- portes verrouillées ;
- coffres ;
- messages ;
- boss ;
- lieux sûrs ;
- futurs pièges / passages secrets.

Nom possible :

```text
scripts/dungeon/DungeonTileRules.gd
```

Priorité : haute si de nouveaux symboles sont ajoutés.

---

### 2.3 Centraliser les règles de rencontre aléatoire

Certaines cases ne doivent pas déclencher de rencontre :

- temple `O` ;
- boutique `B` ;
- message `M` ;
- coffre `C` lors de l’ouverture ;
- boss `X` ;
- porte verrouillée `L` ;
- escaliers `<` / `>`.

Ces règles gagneraient à être vérifiées depuis un seul endroit.

Priorité : moyenne à haute.

---

### 2.4 Clarifier les événements de tuiles spéciales

Les tuiles `C`, `M`, `L`, `X` ont maintenant des comportements spécifiques.

Extraction possible :

```text
scripts/dungeon/DungeonTileEventController.gd
```

Responsabilités possibles :

- ouvrir coffre ;
- afficher message ;
- vérifier clé de porte verrouillée ;
- déclencher boss ;
- retourner un résultat clair à `Dungeon.gd`.

Priorité : moyenne.

---

## 3. Refactorisations utiles mais à faire prudemment

### 3.1 `Dungeon.gd`

`Dungeon.gd` reste fonctionnel, mais il orchestre beaucoup de choses :

- chargement d’étage ;
- état d’étage ;
- déplacement ;
- automap ;
- coffres ;
- messages ;
- portes verrouillées ;
- boss ;
- transitions ;
- temple ;
- boutique ;
- sauvegarde ;
- outil temporaire de téléportation.

Extractions possibles plus tard :

```text
DungeonFloorController.gd
DungeonExplorationController.gd
DungeonTileEventController.gd
DungeonEncounterController.gd
DungeonLockedDoorController.gd
```

Priorité : moyenne, pas urgente.

---

### 3.2 `CombatManager.gd`

Le combat est déjà mieux séparé qu’au départ, mais `CombatManager.gd` porte encore beaucoup de responsabilités.

Extractions futures possibles :

```text
CombatActions.gd
CombatTargeting.gd
CombatAbilityResolver.gd
BossEncounterRules.gd
FixedEncounterRules.gd
```

Priorité : moyenne, après stabilisation playtest.

---

### 3.3 `InGameMenuPanelUI.gd`

Ce fichier centralise beaucoup d’écrans :

- inventaire ;
- statut ;
- équipement ;
- boutique ;
- options système ;
- outil de téléportation ;
- futur grimoire.

Extractions possibles :

```text
InventoryMenuUI.gd
StatusMenuUI.gd
EquipmentMenuUI.gd
ShopMenuUI.gd
DevTeleportMenuUI.gd
GrimoireMenuUI.gd
```

Priorité : moyenne si le grimoire ou de nouvelles fenêtres sont ajoutés.

---

## 4. À éviter avant playtest externe

Ne pas faire avant une première vague de retours :

- réécrire entièrement `Dungeon.gd` ;
- réécrire entièrement le système de combat ;
- changer massivement la structure de sauvegarde ;
- refaire toute l’UI en même temps qu’un ajout de gameplay ;
- modifier plusieurs layouts pendant une grosse refactorisation ;
- supprimer l’outil de téléportation tant que les tests de layout sont fréquents, sauf s’il gêne le playtest.

---

## 5. Sauvegardes et migration

Le projet conserve déjà des états d’étage dans les sauvegardes.

Conséquence importante : une ancienne sauvegarde peut conserver un ancien layout même si `FloorDatabase.gd` a changé.

À prévoir plus tard :

- versionner les sauvegardes ;
- ajouter une stratégie de migration ;
- proposer un reset d’état d’étage pour les tests ;
- documenter clairement les incompatibilités de sauvegarde dans les releases.

Priorité : moyenne avant un playtest plus large.
