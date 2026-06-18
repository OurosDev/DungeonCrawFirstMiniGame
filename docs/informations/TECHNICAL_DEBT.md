# Dette technique et refactorisations — DungeonCrawFirstMiniGame

Ce document regroupe les pistes techniques qui alourdiraient trop `ROADMAP.md`.

Objectif : garder la roadmap lisible, tout en conservant une trace des refactorisations utiles.

---

## 1. Principe général

Le projet possède maintenant une première boucle jouable stable jusqu'à `v0.8.1`.

À ce stade, il vaut mieux éviter les grosses réécritures. Les refactorisations doivent être :

- ciblées ;
- testables rapidement ;
- compatibles avec les sauvegardes autant que possible ;
- faites une par une ;
- séparées des gros ajouts de contenu.

La priorité immédiate n'est pas de rendre le code parfait. La priorité est de préserver la boucle jouable, de garder les playtests fiables et de réduire progressivement les zones difficiles à modifier.

---

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

---

## 3. Refactorisations sûres à court terme

### 3.1 Centraliser les symboles de donjon

Aujourd'hui, les symboles de cases (`#`, `.`, `D`, `O`, `B`, `C`, `M`, `L`, `X`, `<`, `>`, etc.) sont compris par plusieurs systèmes : données d'étage, rendu, automap, interactions, rencontres, sauvegarde.

Objectif : éviter que l'ajout d'un nouveau symbole demande des modifications dispersées et risquées.

Approche recommandée :

1. créer ou compléter une source de vérité légère pour les symboles ;
2. garder les chaînes existantes pour ne pas casser les layouts ;
3. migrer progressivement les tests directs vers des fonctions explicites.

Risque : moyen si fait trop vite, faible si fait progressivement.

### 3.2 Centraliser les règles de marchabilité

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

### 3.3 Centraliser les règles de rencontres aléatoires

Les temples, boutiques, messages, coffres, escaliers ou cases spéciales ne doivent pas nécessairement déclencher de rencontres.

Objectif : éviter les exceptions dispersées.

Fonction cible possible :

```gdscript
allows_random_encounter(tile: String) -> bool
```

Risque : faible à moyen.

### 3.4 Clarifier les événements de cases spéciales

Les événements `C`, `M`, `L`, `X`, `O`, `B`, `<`, `>` sont déjà fonctionnels, mais leur logique va grossir avec le contenu futur.

Objectif : rendre l'ajout de nouveaux événements plus simple sans surcharger `Dungeon.gd`.

Approche recommandée :

- conserver le fonctionnement actuel ;
- identifier les blocs par catégories ;
- déplacer seulement les helpers vraiment stables ;
- éviter une architecture trop abstraite pour le prototype.

Risque : moyen.

---

## 4. Dette UI / ergonomie

### 4.1 Panneaux principaux

Les panneaux Inventaire, Statut, Équipement et Boutique sont fonctionnels, mais leur structure peut devenir lourde.

Améliorations possibles :

- créer des helpers de construction de boutons/panneaux ;
- normaliser les marges ;
- envisager progressivement `NinePatchRect` ;
- garder les layouts faciles à modifier.

Risque : faible si les changements restent visuels.

### 4.2 Feedback joueur

Points à améliorer avant ou après la suite du playtest :

- message plus clair après victoire boss ;
- confirmation plus visible de consommation de la Clé du gardien ;
- feedback de sauvegarde / chargement ;
- feedback de coffre déjà ouvert ;
- feedback de mort / retour titre ;
- meilleure hiérarchie visuelle dans le journal.

Risque : faible.

---

## 5. Dette gameplay / contenu

### 5.1 Boss actuel

Le boss `gardien_boss_etage_2` est volontairement simple : il réutilise le gardien normal avec un multiplicateur de PV.

Dette assumée :

- pas encore d'attaque spéciale ;
- pas encore de récompense unique ;
- pas encore d'écran ou séquence de victoire ;
- escalier derrière lui pas encore activé vers un étage 3.

Statut : acceptable pour prototype, à reprendre quand le contenu suivant démarre.

### 5.2 Étage 3

Avant d'ajouter l'étage 3, vérifier :

- règles de transition multi-étages ;
- sauvegarde / chargement depuis un étage supérieur ;
- automap par étage ;
- retour vers étage précédent ;
- table de rencontres dédiée ;
- nouveaux symboles nécessaires.

Risque : moyen.

### 5.3 Nouveaux symboles possibles

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

---

## 6. Sauvegarde et compatibilité

La sauvegarde couvre déjà beaucoup de systèmes : groupe, inventaire, équipement, or, position, étage, portes ouvertes, cellules découvertes, coffres, boss vaincu.

Règles de prudence :

- maintenir une compatibilité raisonnable avec les anciennes sauvegardes ;
- prévoir des valeurs par défaut pour les nouveaux champs ;
- tester une nouvelle partie et un chargement existant après chaque modification liée à la sauvegarde ;
- rappeler que les anciennes sauvegardes peuvent conserver d'anciens layouts mémorisés.

Risque : élevé si modifié sans test.

---

## 7. Outil de téléportation de développement

L'outil de téléportation est utile pour tester rapidement les étages.

Dette assumée :

- il ne fait pas partie de l'expérience finale ;
- il doit rester clairement identifié comme outil de développement ;
- il doit être désactivé ou supprimé avant une version finale propre.

À retirer plus tard :

- constante / garde `DEV_TELEPORT_ENABLED` ;
- sections temporaires de téléportation dans `InGameMenuPanelUI.gd` ;
- hooks associés dans `Dungeon.gd` ;
- documentation de test devenue inutile.

Risque : faible si retiré tard, après stabilisation des tests.

---

## 8. Renderer, builds et playtests

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

---

## 9. Priorités recommandées

### Court terme

1. Continuer / finaliser le playtest 01 si de nouveaux retours arrivent.
2. Corriger uniquement les problèmes confirmés.
3. Améliorer quelques feedbacks joueur visibles.
4. Éviter les grosses réécritures.

### Moyen terme

1. Centraliser progressivement les symboles et règles de cases.
2. Préparer proprement les futurs symboles `F`, `S`, `P`, `E`, `R`.
3. Améliorer le rendu des éléments spéciaux de donjon.
4. Préparer l'étage 3 seulement après validation de la stabilité post-playtest.

---

## 10. Ce qu'il faut éviter

- Réécrire entièrement `Dungeon.gd` sans besoin concret.
- Ajouter plusieurs nouveaux systèmes en même temps.
- Modifier sauvegarde, donjon et UI dans un même pack sans raison forte.
- Confondre problème de renderer/export avec bug gameplay.
- Pousser des builds, logs ou zips temporaires.
- Faire monter artificiellement la version vers `v1.0`.
