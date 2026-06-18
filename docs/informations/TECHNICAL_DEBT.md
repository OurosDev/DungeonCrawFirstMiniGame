# Dette technique et refactorisations — DungeonCrawFirstMiniGame

Ce document regroupe les pistes techniques qui alourdiraient trop `ROADMAP.md`. Objectif : garder la roadmap lisible, tout en conservant une trace des refactorisations utiles.

## 1. Principe général

Le projet possède maintenant une première boucle jouable stable jusqu'à `v0.8.2`.

Les refactorisations doivent rester :

- ciblées ;
- testables rapidement ;
- compatibles avec les sauvegardes autant que possible ;
- faites une par une ;
- séparées des gros ajouts de contenu ;
- préparées en packs complets quand plusieurs fichiers sont concernés.

La priorité n'est pas de rendre le code parfait. La priorité est de préserver la boucle jouable, de garder les playtests fiables et de réduire progressivement les zones difficiles à modifier.

## 2. Points résolus ou reclassés

### Scaling fenêtre

Statut : résolu en `v0.8.1`.

Le projet utilise maintenant :

```ini
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"
window/stretch/scale=1.0
window/stretch/scale_mode="fractional"
```

Ce point ne doit plus être traité comme une dette active, sauf si un nouveau retour de playtest montre un problème sur une résolution précise.

### Crashs playtest Windows avec renderer moderne

Statut : reclassé en contrainte d'export / compatibilité.

Le playtest 01 a montré des crashs natifs Windows non reproduits localement sur une machine Intel UHD Graphics avec renderer moderne. La build `Compatibility / OpenGL` a fonctionné.

Décision actuelle :

- ne pas modifier le gameplay des coffres ou de la sauvegarde pour cet incident ;
- exporter les builds Windows de playtest en `Compatibility / OpenGL` par défaut ;
- conserver les logs complets hors repo ;
- documenter seulement des résumés nettoyés dans `playtests/`.

### Fichiers temporaires versionnés

Statut : résolu d'après l'état actuel du dossier `scenes/`.

Les fichiers `.tmp` ne sont plus visibles dans `scenes/`. La règle reste : ne pas pousser `*.tmp`, `*.bak`, builds, exports ou zips temporaires.

### Grands contrôleurs allégés

Statut : première passe résolue en `v0.8.2`.

Scripts refactorisés et validés localement :

```text
scripts/ui/InGameMenuPanelUI.gd
scripts/combat/CombatManager.gd
scripts/dungeon/Dungeon.gd
scripts/core/GameSession.gd
scripts/ui/PartyCreationUI.gd
```

Les refactorisations ont conservé les façades principales pour limiter les risques : les scènes et autres systèmes continuent à appeler les scripts centraux connus, tandis que les détails internes sont délégués à des helpers.

## 3. Refactorisations réalisées en v0.8.2

### 3.1 Menu en jeu

Responsabilités extraites :

- fabrique UI commune ;
- inventaire ;
- boutique ;
- statut / équipement ;
- téléportation de développement.

Nouveau dossier :

```text
scripts/ui/menu/
```

Dette restante : améliorer l'habillage visuel plus tard, mais ne pas mélanger une refonte visuelle UI avec un ajout gameplay majeur.

### 3.2 Combat

Responsabilités extraites :

- accès aux données d'acteurs ;
- précision / esquive ;
- dégâts / soins ;
- sorts disponibles ;
- ciblage ;
- journal de combat.

Nouveaux helpers :

```text
scripts/combat/CombatActorAccess.gd
scripts/combat/CombatAccuracyResolver.gd
scripts/combat/CombatDamageResolver.gd
scripts/combat/CombatAbilityResolver.gd
scripts/combat/CombatTargetSelector.gd
scripts/combat/CombatLogHelper.gd
```

Dette restante : le flow de tour reste dans `CombatManager.gd`. C'est volontaire pour éviter de casser les signaux, la victoire, la fuite, la défaite et les attentes de validation.

### 3.3 Donjon

Responsabilités extraites :

- lecture et modification du layout ;
- état d'étage ;
- découverte automap.

Nouveaux helpers :

```text
scripts/dungeon/DungeonMapHelper.gd
scripts/dungeon/DungeonFloorStateHelper.gd
scripts/dungeon/DungeonAutoMapHelper.gd
```

Dette restante : les interactions de cases spéciales peuvent encore grossir avec le contenu futur. Les extraire trop tôt serait risqué ; mieux vaut le faire quand les nouveaux symboles seront décidés.

### 3.4 Session globale

Responsabilités extraites :

- états d'étages ;
- boutique ;
- équipement.

Nouveau dossier :

```text
scripts/core/session/
```

Dette restante : `GameSession.gd` reste un singleton central. C'est acceptable pour le prototype, tant que ses méthodes publiques restent stables.

### 3.5 Création d'équipe

Responsabilités extraites :

- fabrique UI ;
- construction des héros ;
- résumé de l'équipe.

Nouveau dossier :

```text
scripts/ui/party_creation/
```

Dette restante : faible. L'écran est isolé et peut rester ainsi tant que la création de groupe ne devient pas beaucoup plus complexe.

## 4. Refactorisations restantes utiles à court terme

### 4.1 Centraliser les symboles de donjon

Les symboles de cases (`#`, `.`, `D`, `O`, `B`, `C`, `M`, `L`, `X`, `<`, `>`, etc.) sont compris par plusieurs systèmes : données d'étage, rendu, automap, interactions, rencontres, sauvegarde.

Objectif : éviter que l'ajout d'un nouveau symbole demande des modifications dispersées et risquées.

Approche recommandée :

1. créer ou compléter une source de vérité légère pour les symboles ;
2. garder les chaînes existantes pour ne pas casser les layouts ;
3. migrer progressivement les tests directs vers des fonctions explicites.

Risque : moyen si fait trop vite, faible si fait progressivement.

### 4.2 Centraliser les règles de marchabilité

Plusieurs systèmes doivent savoir si une case bloque ou non le joueur.

Objectif : avoir une fonction claire du type :

```gdscript
is_walkable_tile(tile: String) -> bool
```

À couvrir :

- murs ;
- portes fermées / ouvertes ;
- temples ;
- boutiques ;
- coffres ;
- messages ;
- porte verrouillée ;
- boss vaincu ou non ;
- escaliers.

Risque : moyen, car une erreur peut bloquer la progression.

### 4.3 Centraliser les règles de rencontres aléatoires

Les temples, boutiques, messages, coffres, escaliers ou cases spéciales ne doivent pas nécessairement déclencher de rencontres.

Objectif : éviter les exceptions dispersées.

Fonction cible possible :

```gdscript
allows_random_encounter(tile: String) -> bool
```

Risque : faible à moyen.

### 4.4 Clarifier les événements de cases spéciales

Les événements `C`, `M`, `L`, `X`, `O`, `B`, `<`, `>` sont déjà fonctionnels, mais leur logique va grossir avec le contenu futur.

Approche recommandée :

- conserver le fonctionnement actuel ;
- identifier les blocs par catégories ;
- déplacer seulement les helpers vraiment stables ;
- éviter une architecture trop abstraite pour le prototype.

Risque : moyen.

## 5. Dette UI / ergonomie

### 5.1 Panneaux principaux

Les panneaux Inventaire, Statut, Équipement et Boutique sont mieux structurés depuis `v0.8.2`, mais leur habillage visuel reste simple.

Améliorations possibles :

- normaliser davantage les marges ;
- envisager progressivement `StyleBoxTexture` ou `NinePatchRect` ;
- garder les layouts faciles à modifier ;
- éviter une refonte UI complète dans le même pack qu'un gros ajout de contenu.

Risque : faible si les changements restent visuels.

### 5.2 Feedback joueur

Points à améliorer avant ou après la suite du playtest :

- message plus clair après victoire boss ;
- confirmation plus visible de consommation de la Clé du gardien ;
- feedback de sauvegarde / chargement ;
- feedback de coffre déjà ouvert ;
- feedback de mort / retour titre ;
- meilleure hiérarchie visuelle dans le journal.

Risque : faible.

## 6. Dette gameplay / contenu

### 6.1 Boss actuel

Le boss `gardien_boss_etage_2` est volontairement simple : il réutilise le gardien normal avec un multiplicateur de PV.

Dette assumée :

- pas encore d'attaque spéciale ;
- pas encore de récompense unique ;
- pas encore d'écran ou séquence de victoire ;
- escalier derrière lui pas encore activé vers un étage 3.

Statut : acceptable pour prototype, à reprendre quand le contenu suivant démarre.

### 6.2 Étage 3

Avant d'ajouter l'étage 3, vérifier :

- règles de transition multi-étages ;
- sauvegarde / chargement depuis un étage supérieur ;
- automap par étage ;
- retour vers étage précédent ;
- table de rencontres dédiée ;
- nouveaux symboles nécessaires.

Risque : moyen.

### 6.3 Nouveaux symboles possibles

Idées déjà envisagées :

```text
F = combat fixe non-boss
S = passage secret
P = piège
E = événement simple
R = rune / découverte visible
```

Avant implémentation, mettre à jour :

- `docs/dungeon/FLOOR_DESIGN.md` ;
- `docs/dungeon/FLOOR_VISUALIZER.md` ;
- la source de vérité gameplay ;
- l'automap ;
- les règles de marchabilité / rencontre.

## 7. Sauvegarde et compatibilité

La sauvegarde couvre déjà beaucoup de systèmes : groupe, inventaire, équipement, or, position, étage, portes ouvertes, cellules découvertes, coffres, boss vaincu.

Règles de prudence :

- maintenir une compatibilité raisonnable avec les anciennes sauvegardes ;
- prévoir des valeurs par défaut pour les nouveaux champs ;
- tester une nouvelle partie et un chargement existant après chaque modification liée à la sauvegarde ;
- rappeler que les anciennes sauvegardes peuvent conserver d'anciens layouts mémorisés.

Risque : élevé si modifié sans test.

## 8. Outil de téléportation de développement

L'outil de téléportation est utile pour tester rapidement les étages.

Dette assumée :

- il ne fait pas partie de l'expérience finale ;
- il doit rester clairement identifié comme outil de développement ;
- il doit être désactivé ou supprimé avant une version finale propre.

À retirer plus tard :

- constante / garde `DEV_TELEPORT_ENABLED` ;
- sections temporaires de téléportation dans `InGameMenuPanelUI.gd` et les vues associées ;
- hooks associés dans `Dungeon.gd` ;
- documentation de test devenue inutile.

Risque : faible si retiré tard, après stabilisation des tests.

## 9. Renderer, builds et playtests

Le renderer `Compatibility / OpenGL` est la base recommandée pour les builds Windows de playtest.

À ne pas pousser :

```text
*.exe
*.pck
*.zip
build/
dist/
export/
logs bruts
sauvegardes locales de testeurs
captures système complètes
```

Si un crash testeur revient :

1. confirmer le renderer de la build ;
2. confirmer si le jeu est lancé depuis un dossier local simple ;
3. récupérer les logs Godot complets hors repo ;
4. documenter seulement un résumé nettoyé dans `playtests/` ;
5. éviter une correction gameplay tant que le crash n'est pas reproduit ou compris.

## 10. Priorités recommandées

### Court terme

1. Continuer / finaliser le playtest 01 si de nouveaux retours arrivent.
2. Corriger uniquement les problèmes confirmés.
3. Améliorer quelques feedbacks joueur visibles.
4. Centraliser progressivement les symboles et règles de cases.

### Moyen terme

1. Préparer proprement les futurs symboles `F`, `S`, `P`, `E`, `R`.
2. Améliorer le rendu des éléments spéciaux de donjon.
3. Préparer l'étage 3 seulement après validation de la stabilité post-playtest.
4. Garder une architecture simple et lisible plutôt qu'une abstraction excessive.

## 11. Ce qu'il faut éviter

- Réécrire entièrement `Dungeon.gd` sans besoin concret.
- Ajouter plusieurs nouveaux systèmes en même temps.
- Modifier sauvegarde, donjon et UI dans un même pack sans raison forte.
- Confondre problème de renderer/export avec bug gameplay.
- Pousser des builds, logs ou zips temporaires.
- Faire monter artificiellement la version vers `v1.0`.
