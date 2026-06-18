# FLOOR_DESIGN

Normes de conception des étages du donjon.

Ce document sert de référence pour les layouts ASCII utilisés par `FloorDatabase.gd`, pour la nomenclature des symboles et pour les règles de placement des lieux spéciaux.

---

## 1. Objectif

Chaque étage du donjon est défini par une grille ASCII.

Règle fondamentale :

```text
1 caractère = 1 case
```

Les layouts doivent rester faciles à relire, à comparer et à modifier.

Ils ne doivent pas devenir un script caché : les comportements complexes doivent être définis dans des tables de données par étage + coordonnée quand c’est nécessaire.

---

## 2. Règles générales de layout

### 2.1 Dimensions rectangulaires

Toutes les lignes d’un même layout doivent avoir exactement la même longueur.

Exemple correct :

```text
#####
#...#
#.#.#
#...#
#####
```

Exemple incorrect :

```text
#####
#...#
#.#.##
#...#
#####
```

Un layout non rectangulaire rend les coordonnées difficiles à maintenir et peut provoquer des erreurs de lecture.

### 2.2 Bordures extérieures

Sauf cas particulier volontaire, l’extérieur d’un étage doit être fermé par des murs `#`.

```text
################
#..............#
#..............#
################
```

### 2.3 Coordonnées

Les coordonnées sont exprimées en `Vector2i(x, y)`.

- `x` augmente vers la droite.
- `y` augmente vers le bas.
- La première colonne est `x = 0`.
- La première ligne est `y = 0`.

Exemple :

```text
#####
#...#
#####
```

La case centrale de sol est :

```gdscript
Vector2i(2, 1)
```

### 2.4 Aucun espace dans les layouts source

Ne pas utiliser d’espaces dans les layouts de `FloorDatabase.gd`.

Utiliser `.` pour représenter explicitement le sol.

Les espaces sont réservés uniquement aux documents de visualisation, comme `FLOOR_VISUALIZER.md`, où ils peuvent améliorer la lisibilité.

### 2.5 Caractères ASCII simples

Éviter les lettres accentuées, les symboles multi-caractères et les caractères invisibles dans les layouts.

À éviter :

```text
É
SHOP
DOOR
  
```

---

## 3. Nomenclature officielle des symboles

| Symbole | Nom | Statut | Marchable | Rencontre aléatoire | État sauvegardé |
|---|---|---:|---:|---:|---:|
| `#` | Mur | Utilisé | Non | Non | Non |
| `.` | Sol / couloir | Utilisé | Oui | Oui | Non |
| `D` | Porte fermée | Utilisé | Oui | Non après ouverture | Oui, devient `d` |
| `d` | Porte ouverte | Runtime | Oui | Selon logique actuelle | Oui |
| `>` | Escalier descendant | Utilisé / prévu | Oui | Non | Selon activation |
| `<` | Escalier montant | Utilisé | Oui | Non | Selon transition |
| `O` | Temple de guérison | Utilisé | Oui | Non | Non actuellement |
| `B` | Boutique | Utilisé | Oui | Non | Or/inventaire via systèmes dédiés |
| `C` | Coffre | À venir v0.7 | À définir | Non recommandé | Oui |
| `M` | Message / PNJ neutre / indication | À venir v0.7 | Oui | Non | Selon design |
| `F` | Combat fixe non-boss | À venir | Oui | Non | Oui si unique |
| `X` | Boss / rencontre majeure | Marqueur actuel / futur gameplay | Oui | Non | Oui une fois implémenté |
| `P` | Piège | Réservé | Oui | Non recommandé | Selon design |
| `E` | Événement | Réservé | Oui | Non recommandé | Selon design |
| `R` | Rune / sort visible | Réservé | Oui | Non | Oui si unique |
| `L` | Porte verrouillée | À venir | Non puis Oui | Non | Oui |
| `S` | Passage secret | À venir | À définir | À définir | Oui |

---

## 4. Symboles utilisés actuellement

### `#` — Mur

Rôle :

- bloque le déplacement ;
- bloque la découverte visuelle au-delà ;
- rendu comme mur dans la vue 3D ;
- affiché comme mur sur l’automap.

### `.` — Sol / couloir

Rôle :

- case marchable standard ;
- peut déclencher une rencontre aléatoire ;
- rendu comme sol normal ;
- affiché comme case explorée vide sur l’automap.

### `D` — Porte fermée

Rôle :

- case marchable ;
- s’ouvre quand le joueur entre dessus ;
- transformée en `d` à l’exécution ;
- bloque la découverte visuelle tant qu’elle est fermée ;
- affichée comme porte fermée sur l’automap ;
- son état ouvert doit être sauvegardé par étage.

Règle : placer `D` dans les layouts source. Ne pas placer `d` directement sauf cas volontaire et documenté.

### `d` — Porte ouverte runtime

Rôle :

- représente une porte déjà ouverte ;
- case marchable ;
- affichée différemment sur l’automap ;
- sauvegardée et restaurée par étage.

### `>` — Escalier descendant

Rôle :

- indique une sortie vers l’étage inférieur ;
- case marchable ;
- ne doit pas déclencher de rencontre aléatoire ;
- affiché sur l’automap.

Règles :

- la coordonnée du `>` actif doit correspondre à la coordonnée déclarée dans `FloorData` ;
- un `>` peut exister comme marqueur visuel futur, mais il ne doit être actif que si l’étage suivant existe et si `FloorData` le déclare correctement ;
- l’escalier descendant futur derrière un boss peut rester visuel/non actif tant que le boss ou l’étage suivant ne sont pas codés.

### `<` — Escalier montant

Rôle :

- indique un retour vers l’étage supérieur ;
- case marchable ;
- ne doit pas déclencher de rencontre aléatoire ;
- affiché sur l’automap.

Règles actuelles :

- l’étage 2 utilise `<` comme point de départ et comme retour vers l’étage 1 ;
- le retour doit replacer le joueur sur le `>` de l’étage précédent ;
- l’état propre à chaque étage doit être conservé pendant la transition.

### `O` — Temple de guérison

Rôle :

- restaure les PV et PM du groupe ;
- gratuit ;
- réutilisable ;
- ne déclenche pas de rencontre aléatoire ;
- affiché dans la vue 3D ;
- affiché sur l’automap.

Règles de placement :

- doit être placé derrière une porte `D` ;
- doit être en bout de couloir ou dans une alcôve ;
- ne doit pas être placé directement dans un couloir principal ;
- doit être accessible, mais idéalement après une petite progression ;
- doit être éloigné d’un boss ou d’une zone finale si cela rend la zone trop sûre.

Règle d’orientation 3D :

- le modèle 3D du temple doit être orienté vers la porte d’accès ;
- à terme, `DungeonRenderer.gd` devrait déduire cette orientation depuis la porte adjacente.

Exemples :

```text
#..DO#  porte à l’ouest, temple orienté vers l’ouest
#OD..#  porte à l’est, temple orienté vers l’est
```

### `B` — Boutique

Rôle :

- ouvre l’accès à la boutique ;
- case marchable ;
- ne déclenche pas de rencontre aléatoire ;
- affichée sur l’automap ;
- utilisée pour acheter et vendre des objets.

Règles de placement :

- doit être placée derrière une porte `D` ;
- doit être en bout de couloir ou dans une alcôve ;
- ne doit pas être placée directement dans un couloir principal ;
- doit rester un lieu sûr ;
- ne doit pas être trop proche du temple si cela rend la zone trop sûre ;
- sur les premiers étages, elle peut être relativement accessible pour limiter la frustration liée à l’inventaire.

Règle d’orientation 3D :

- le modèle 3D de boutique doit être orienté vers la porte d’accès ;
- à terme, `DungeonRenderer.gd` devrait déduire cette orientation depuis la porte adjacente.

Exemples :

```text
#..DB#  porte à l’ouest, boutique orientée vers l’ouest
#BD..#  porte à l’est, boutique orientée vers l’est
```

---

## 5. Symboles prévus ou réservés

### `C` — Coffre

Statut : prévu pour `v0.7 — Coffres et indices`.

Rôle prévu :

- donne de l’or, un objet, ou un contenu défini ;
- contenu défini par étage + coordonnée ;
- état ouvert / fermé sauvegardé par étage ;
- ne doit pas redonner son contenu après chargement ;
- affichage automap à prévoir.

Règles de placement :

- encourager l’exploration ;
- privilégier les cul-de-sac, alcôves, petites récompenses derrière porte ou chemins secondaires ;
- éviter de placer un coffre sur un lieu déjà utilisé par une découverte de sort ;
- éviter les coffres bloquant un couloir principal ;
- un coffre narratif important peut être placé tôt, mais son contenu peut rester réservé à une version future.

Règle v0.7 :

- ne pas placer de vraie clé tant que les portes verrouillées `L` ne sont pas codées.

### `M` — Message / PNJ neutre / indication

Statut : prévu pour `v0.7 — Coffres et indices`.

Rôle prévu :

- affiche un message court ;
- peut représenter un PNJ neutre, une inscription, un avertissement ou un indice ;
- ne déclenche aucun combat ;
- peut être réutilisable ou unique selon le design ;
- ne doit pas remplacer un système de quête complexe.

Règles :

- `M` ne signifie plus combat fixe ;
- pour un combat fixe non-boss, utiliser `F` ;
- pour un boss ou une rencontre majeure, utiliser `X` ;
- les messages doivent avoir une utilité : orientation, indice, ambiance courte, avertissement.

Bon usage :

- avertir d’un danger ;
- annoncer un boss ;
- indiquer un coffre ;
- donner un indice vers une future clé ;
- préparer une mécanique à venir.

À éviter :

- multiplier les messages sans utilité ;
- bloquer la progression sur un indice trop obscur ;
- utiliser `M` comme déclencheur de combat.

### `F` — Combat fixe non-boss

Statut : réservé pour une version future.

Rôle prévu :

- déclenche un combat prédéfini ;
- peut représenter une garde, un monstre rare visible ou une rencontre obligatoire ;
- doit sauvegarder son état si le combat ne doit pas revenir.

Règles :

- utiliser `F` pour les rencontres importantes qui ne sont pas des boss ;
- ne pas remplacer toutes les rencontres aléatoires par des `F` ;
- placer un combat fixe avec un intérêt clair : récompense, protection, apprentissage, tension.

### `X` — Boss / rencontre majeure

Statut : marqueur temporaire actuel, gameplay boss à venir.

Rôle prévu :

- représente un boss ou une rencontre majeure d’étage ;
- peut protéger un escalier descendant futur ;
- doit sauvegarder son état une fois vaincu ;
- doit être annoncé ou préparé par le level design.

Règles de placement :

- loin du départ ;
- loin du temple ;
- derrière une porte, une condition ou une zone identifiable ;
- potentiellement avant un escalier descendant ;
- accompagné d’un message, indice, combat fixe ou signal visuel.

Différence officielle :

```text
M = message / PNJ neutre / indication
F = combat fixe non-boss
X = boss / rencontre majeure
```

### `L` — Porte verrouillée

Statut : à venir.

Rôle prévu :

- porte spéciale nécessitant une clé, un événement ou une condition ;
- bloquante tant que la condition n’est pas remplie ;
- état ouvert / fermé sauvegardé.

Règles :

- ne pas confondre avec `D`, qui est une porte simple ouvrable automatiquement ;
- ne pas concevoir de vraie clé avant que `L` soit codé ;
- ne pas bloquer une progression essentielle avec `L` sans indice clair.

### `S` — Passage secret

Statut : à venir.

Rôle prévu :

- mur ou porte cachée ;
- peut devenir marchable après découverte ;
- état découvert / non découvert sauvegardé ;
- affichage automap à définir.

Règles :

- rare ;
- lisible ;
- ne doit pas bloquer une progression essentielle sans indice.

### `P` — Piège

Statut : réservé.

Rôle possible :

- infliger des dégâts ;
- réduire des MP ;
- déclencher un effet négatif ;
- déclencher éventuellement une rencontre.

Règle : utiliser avec parcimonie pour garder une difficulté lisible.

### `E` — Événement

Statut : réservé.

Rôle possible :

- levier ;
- autel secondaire ;
- choix narratif simple ;
- mécanisme ;
- événement qui modifie un état.

Règle : les événements complexes doivent être définis par coordonnées dans une table dédiée plutôt que par le symbole seul.

### `R` — Rune / sort visible

Statut : réservé.

Rôle possible :

- découverte de sort visible directement dans le layout ;
- alternative future aux découvertes définies par coordonnées.

Règle actuelle : les découvertes de sorts restent définies par table de coordonnées. Ne pas placer de coffre ou de message sur une case déjà utilisée par une découverte de sort.

---

## 6. Lieux sûrs

Les lieux sûrs ne doivent pas déclencher de rencontre aléatoire.

Lieux sûrs actuels ou prévus :

- `O` temple ;
- `B` boutique ;
- `>` escalier descendant ;
- `<` escalier montant ;
- `M` message / PNJ neutre / indication ;
- probablement `C` coffre, selon implémentation.

Règle : quand un nouveau lieu sûr est ajouté, vérifier explicitement la logique de déplacement et de rencontres.

---

## 7. Objets persistants et état par étage

Certains éléments doivent mémoriser leur état.

Exemples :

- porte ouverte ;
- coffre ouvert ;
- combat fixe vaincu ;
- boss vaincu ;
- passage secret découvert ;
- porte verrouillée ouverte ;
- événement unique déclenché ;
- message unique déjà lu si le design le demande.

Règles :

- tout état définitif doit être sauvegardé ;
- les états doivent être conservés par étage ;
- le chargement doit restaurer le layout, les portes ouvertes, les découvertes automap et les états persistants ;
- les anciennes sauvegardes peuvent conserver d’anciens layouts mémorisés, donc les tests doivent tenir compte des sauvegardes existantes.

À vérifier lors de l’ajout :

```text
[ ] Données runtime dans Dungeon.gd ou contrôleur dédié.
[ ] Sauvegarde dans SaveManager.gd.
[ ] Restauration au chargement.
[ ] Rendu visuel après chargement.
[ ] Affichage automap après chargement.
[ ] Compatibilité avec les anciennes sauvegardes.
```

---

## 8. Règles multi-étages

Règles actuelles :

- l’étage 1 descend vers l’étage 2 via `>` ;
- l’étage 2 remonte vers l’étage 1 via `<` ;
- le retour vers l’étage précédent doit replacer le joueur sur le `>` correspondant ;
- chaque étage conserve son état propre : layout runtime, portes ouvertes, cellules découvertes, position de retour ;
- les tables de rencontre peuvent être propres à chaque étage.

Règles de design :

- le départ d’un étage doit être une case marchable ;
- un escalier ne doit pas déclencher de rencontre aléatoire ;
- un escalier futur peut être visible, mais il doit rester non actif tant que la destination ou la condition n’est pas prête ;
- un escalier derrière boss doit rester lisible comme objectif, même si le boss n’est pas encore codé.

---

## 9. Règles de placement par type

### Temple `O`

Bon usage :

- derrière une porte ;
- en bout de couloir ;
- dans une alcôve ;
- comme point de récupération après une portion dangereuse.

À éviter :

- directement dans un couloir principal ;
- trop près de la boutique ;
- trop près d’un boss.

### Boutique `B`

Bon usage :

- derrière une porte ;
- en bout de couloir ;
- près d’un raccourci ;
- après une portion dangereuse ;
- assez accessible sur les premiers étages pour rendre la vente utile.

À éviter :

- directement dans un couloir principal ;
- trop proche du temple ;
- trop profondément placée si l’inventaire se remplit vite.

### Coffres `C`

Bon usage :

- cul-de-sac ;
- alcôve ;
- derrière une porte ;
- après un petit risque ;
- récompense liée à un indice ;
- récompense après un combat fixe futur.

À éviter :

- coffre sur le chemin obligatoire sans intérêt ;
- coffre sur une case de sort ou autre découverte existante ;
- vraie clé avant l’implémentation de `L`.

### Messages `M`

Bon usage :

- avertissement ;
- indice clair ;
- indication de direction ;
- ambiance courte ;
- préparation d’un boss ou d’un futur coffre.

À éviter :

- message trop long ;
- message sans utilité ;
- message utilisé comme combat fixe.

### Combats fixes `F`

Bon usage :

- garde devant une récompense ;
- monstre rare visible ;
- premier contact contrôlé avec un type d’ennemi ;
- protection d’un coffre ou d’une porte.

À éviter :

- trop nombreux ;
- sans récompense ni intérêt ;
- utilisés comme boss.

### Boss `X`

Bon usage :

- fin de section ;
- zone identifiable ;
- accès préparé par message ou indice ;
- protection d’un escalier descendant ou d’une récompense majeure.

À éviter :

- trop proche du départ ;
- trop proche d’un lieu sûr ;
- sans état sauvegardé ;
- sans préparation.

---

## 10. Checklist avant d’ajouter un symbole ou une case spéciale

```text
[ ] Le symbole est un seul caractère ASCII.
[ ] Le symbole n’est pas déjà utilisé pour autre chose.
[ ] Le comportement est défini.
[ ] La case est marchable ou bloquante de façon claire.
[ ] La rencontre aléatoire est autorisée ou bloquée explicitement.
[ ] Le rendu 3D est prévu dans DungeonRenderer.gd si nécessaire.
[ ] L’orientation 3D est définie si le modèle a une façade.
[ ] L’affichage automap est prévu dans AutoMapUI.gd.
[ ] La sauvegarde est prévue si l’état peut changer.
[ ] La compatibilité avec les sauvegardes existantes est prise en compte.
[ ] Le symbole est ajouté dans ce document.
[ ] Le visualiseur est mis à jour dans FLOOR_VISUALIZER.md.
```

---

## 11. Fichiers généralement concernés

Pour un symbole purement visuel ou fixe :

```text
scripts/dungeon/FloorDatabase.gd
scripts/dungeon/DungeonRenderer.gd
scripts/ui/AutoMapUI.gd
FLOOR_DESIGN.md
FLOOR_VISUALIZER.md
```

Pour un symbole avec effet gameplay :

```text
scripts/dungeon/FloorDatabase.gd
scripts/dungeon/FloorData.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonRenderer.gd
scripts/ui/AutoMapUI.gd
scripts/core/SaveManager.gd
FLOOR_DESIGN.md
FLOOR_VISUALIZER.md
```

Pour `v0.7 — Coffres et indices`, fichiers probables plus tard :

```text
scripts/dungeon/FloorDatabase.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonRenderer.gd
scripts/ui/AutoMapUI.gd
scripts/core/SaveManager.gd
FLOOR_DESIGN.md
FLOOR_VISUALIZER.md
```

---

## 12. Notes spécifiques v0.7 — Coffres et indices

Périmètre conseillé :

- `C` = coffre persistant ;
- contenu défini par étage + coordonnée ;
- récompense possible : or ou objet ;
- coffre ouvert sauvegardé par étage ;
- `M` = message / PNJ neutre / inscription / indice ;
- message défini par étage + coordonnée ;
- `M` ne déclenche aucun combat ;
- rendu 3D simple pour `C` et `M` ;
- affichage automap pour `C` et `M`.

À ne pas coder dans `v0.7` sauf décision contraire :

- vraie clé ;
- porte verrouillée `L` ;
- boss réel `X` ;
- combat fixe `F` ;
- pièges `P` ;
- passages secrets `S`.

Règles de prudence :

- ne pas placer de coffre sur `spell_ice_shard` ou une autre découverte existante ;
- ne pas introduire de vraie clé avant `L` ;
- garder les coffres et messages lisibles dans le visualiseur avant de modifier `FloorDatabase.gd` ;
- documenter toute correction de coordonnée si une proposition tombe sur un mur.

---

## 13. Maintenance

Quand un étage devient difficile à lire :

- vérifier le layout dans `FLOOR_VISUALIZER.md` ;
- séparer l’état actuel en jeu des variantes de planification ;
- documenter les coordonnées importantes ;
- déplacer les contenus complexes dans des dictionnaires par étage + coordonnée ;
- éviter d’utiliser trop de symboles spéciaux dans une même zone.

Objectif : le layout doit rester une carte lisible, pas un script caché.
