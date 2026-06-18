# Normes de conception des étages

Document de référence pour la création des layouts ASCII du donjon.

Ce fichier sert à garder une nomenclature claire pour les symboles de carte, à éviter les conflits entre systèmes, et à préparer les futurs étages avant leur implémentation.

---

## 1. Objectif

Chaque étage du donjon est défini par un layout ASCII, généralement dans `FloorDatabase.gd`.

Chaque caractère du layout représente une case du donjon :

- un mur ;
- un sol ;
- une porte ;
- un escalier ;
- un lieu spécial ;
- un événement futur.

La règle principale est simple :

```text
1 caractère = 1 case
```

Aucun symbole de layout ne doit utiliser plusieurs caractères.

---

## 2. Normes générales de layout

### 2.1 Taille des lignes

Toutes les lignes d’un layout doivent avoir exactement la même longueur.

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

---

### 2.2 Bordures extérieures

Sauf cas très particulier, l’extérieur d’un étage doit être fermé par des murs.

```text
################
#..............#
#..............#
################
```

Cela évite les sorties involontaires hors carte.

---

### 2.3 Coordonnées

Les coordonnées sont exprimées en `Vector2i(x, y)`.

- `x` augmente vers la droite ;
- `y` augmente vers le bas ;
- la première colonne est `x = 0` ;
- la première ligne est `y = 0`.

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

---

### 2.4 Cases de départ

La position de départ du joueur doit être une case marchable.

Recommandé :

```text
.
```

À éviter pour le départ :

```text
#
D
d
O
B
>
<
```

Le départ sur une case spéciale doit rester exceptionnel et documenté.

---

### 2.5 Espaces et caractères invisibles

Ne pas utiliser d’espaces dans les layouts.

À éviter :

```text
" #...# "
```

Les espaces sont difficiles à voir, à compter et à maintenir.

Utiliser `.` pour représenter explicitement le sol.

---

## 3. Symboles actuellement utilisés

### `#` — Mur

Statut : utilisé.

Rôle :

- bloque le déplacement ;
- bloque la découverte visuelle au-delà ;
- rendu comme mur dans le donjon ;
- affiché comme mur sur l’automap.

Utilisation :

```text
################
#..............#
################
```

---

### `.` — Sol / couloir

Statut : utilisé.

Rôle :

- case marchable standard ;
- peut déclencher une rencontre aléatoire ;
- rendu comme sol normal ;
- affiché comme case explorée vide sur l’automap.

Utilisation :

```text
#....#
```

---

### `D` — Porte fermée

Statut : utilisé.

Rôle :

- case marchable ;
- s’ouvre quand le joueur entre dessus ;
- transformée en `d` à l’exécution ;
- bloque la découverte visuelle tant qu’elle est fermée ;
- affichée comme porte fermée sur l’automap.

Utilisation :

```text
#..D..#
```

Règle :

Une porte fermée doit généralement relier deux zones marchables.

---

### `d` — Porte ouverte

Statut : utilisé à l’exécution.

Rôle :

- représente une porte déjà ouverte ;
- case marchable ;
- affichée différemment sur l’automap ;
- sauvegardée si la porte a été ouverte.

Important :

Ne pas placer `d` directement dans les layouts de base, sauf cas volontaire.  
Utiliser `D` dans `FloorDatabase.gd`, puis laisser le jeu convertir la porte en `d`.

---

### `>` — Escalier descendant

Statut : utilisé.

Rôle :

- indique une sortie vers l’étage inférieur ;
- case marchable ;
- bloque les rencontres aléatoires sur cette case ;
- affiché sur l’automap.

Utilisation :

```text
#..>..#
```

Règle actuelle :

La position de l’escalier est aussi stockée dans `FloorData`.

Quand un escalier est placé dans le layout, vérifier que la coordonnée déclarée correspond bien à la case contenant `>`.

---

### `<` — Escalier montant

Statut : prévu / partiellement pris en charge par l’automap.

Rôle futur :

- retour vers l’étage supérieur ;
- case marchable ;
- affiché sur l’automap.

Utilisation future :

```text
#..<..#
```

À implémenter complètement quand les transitions d’étage seront ajoutées.

---

### `O` — Temple de guérison

Statut : utilisé.

Rôle :

- case marchable ;
- restaure les PV et PM du groupe ;
- gratuit ;
- réutilisable ;
- bloque les rencontres aléatoires sur cette case ;
- rendu comme temple / autel dans le donjon ;
- affiché sur l’automap.

Utilisation :

```text
#..O..#
```

Règle :

Le temple doit être placé dans une zone accessible, mais idéalement derrière une petite progression ou une porte.

---

## 4. Symboles à ajouter à moyen terme

Ces symboles ne sont pas tous implémentés.  
Ils sont réservés pour éviter les conflits futurs.

### `B` — Boutique / marchand

Statut : à venir.

Rôle prévu :

- case marchable ;
- ouvre l’accès à la boutique ;
- bloque les rencontres aléatoires sur cette case ;
- affichée sur l’automap ;
- probablement rendue comme comptoir, marchand ou alcôve.

Utilisation prévue :

```text
#..B..#
```

Règle de design :

La boutique doit être un lieu sûr, comparable au temple, mais dédiée à l’économie.

Version initiale recommandée :

- vente des objets de l’inventaire ;
- ajout de l’or au groupe ;
- achat d’objets basiques plus tard.

---

### `C` — Coffre

Statut : à venir.

Rôle prévu :

- case marchable ou activable depuis une case adjacente ;
- donne un objet, de l’or, ou un contenu défini ;
- doit avoir un état ouvert / fermé sauvegardé ;
- affiché sur l’automap après découverte.

Utilisation prévue :

```text
#..C..#
```

Règle :

Un coffre ne doit pas redonner son contenu après chargement.  
Son état devra être sauvegardé.

---

### `P` — Piège

Statut : à venir.

Rôle prévu :

- case marchable ;
- déclenche un effet négatif ;
- peut être visible ou caché selon le design ;
- peut infliger des dégâts, réduire les MP, ou déclencher une rencontre.

Utilisation prévue :

```text
#..P..#
```

Règle :

Un piège doit être utilisé avec parcimonie pour garder une difficulté lisible.

---

### `E` — Événement de donjon

Statut : à venir.

Rôle prévu :

- case marchable ;
- déclenche un message, une décision, une découverte ou un script simple ;
- peut être réutilisable ou unique selon son identifiant.

Utilisation prévue :

```text
#..E..#
```

Exemples :

- inscription ancienne ;
- statue ;
- bruit inquiétant ;
- autel secondaire ;
- choix narratif simple.

Règle :

Les événements complexes devraient être définis par coordonnées dans une table dédiée, plutôt que par le symbole seul.

---

### `M` — Rencontre fixe

Statut : à venir.

Rôle prévu :

- case marchable ;
- déclenche un combat défini ;
- peut être utilisé pour un mini-boss ou une garde ;
- doit sauvegarder son état si la rencontre ne doit pas revenir.

Utilisation prévue :

```text
#..M..#
```

Règle :

À utiliser pour les rencontres importantes, pas pour remplacer les rencontres aléatoires.

---

### `R` — Rune / découverte magique visible

Statut : réservé.

Rôle possible :

- découverte de sort visible directement dans le layout ;
- alternative future aux découvertes définies uniquement par coordonnées.

Utilisation prévue :

```text
#..R..#
```

Note :

Actuellement, les découvertes de sorts sont placées via une table de coordonnées, pas par symbole de layout.  
Garder `R` réservé au cas où l’on souhaite les rendre plus explicites dans les layouts futurs.

---

### `L` — Porte verrouillée

Statut : à venir.

Rôle prévu :

- porte spéciale ;
- nécessite une clé, un événement ou une condition ;
- peut rester bloquante tant que la condition n’est pas remplie ;
- doit avoir un état sauvegardé si elle peut être ouverte.

Utilisation prévue :

```text
#..L..#
```

Règle :

Ne pas confondre avec `D`, qui représente une porte simple ouvrable automatiquement.

---

### `S` — Passage secret

Statut : à venir.

Rôle prévu :

- mur ou porte cachée ;
- peut devenir marchable après découverte ;
- doit avoir un état découvert / non découvert ;
- affichage automap à définir.

Utilisation prévue :

```text
#..S..#
```

Règle :

Le passage secret doit rester rare et lisible.  
Il ne doit pas bloquer une progression essentielle sans indice.

---

## 5. Symboles à éviter

### Espace

Ne pas utiliser.

```text
" "
```

Raison :

- difficile à voir ;
- confusable avec une erreur de formatage ;
- peut provoquer des erreurs de largeur de ligne.

---

### Lettres accentuées

Ne pas utiliser dans les layouts.

Exemples à éviter :

```text
É
À
Ç
```

Raison :

Les layouts doivent rester en ASCII simple.

---

### Symboles multi-caractères

Ne pas utiliser.

Exemples à éviter :

```text
TT
SHOP
DOOR
```

Raison :

Une case doit toujours correspondre à un seul caractère.

---

## 6. Tableau récapitulatif des symboles

| Symbole | Nom | Statut | Marchable | Rencontre aléatoire | Sauvegarde spéciale |
|---|---|---:|---:|---:|---:|
| `#` | Mur | Utilisé | Non | Non | Non |
| `.` | Sol | Utilisé | Oui | Oui | Non |
| `D` | Porte fermée | Utilisé | Oui | Non après ouverture immédiate | Oui, devient `d` |
| `d` | Porte ouverte | Runtime | Oui | Oui | Oui |
| `>` | Escalier descendant | Utilisé | Oui | Non | Non |
| `<` | Escalier montant | Prévu | Oui | Non | Non |
| `O` | Temple de guérison | Utilisé | Oui | Non | Non actuellement |
| `B` | Boutique | À venir | Oui | Non | Non au départ |
| `C` | Coffre | À venir | À définir | Non recommandé | Oui |
| `P` | Piège | À venir | Oui | Non recommandé | Selon design |
| `E` | Événement | À venir | Oui | Non recommandé | Selon design |
| `M` | Rencontre fixe | À venir | Oui | Non | Oui |
| `R` | Rune / sort visible | Réservé | Oui | Non | Oui |
| `L` | Porte verrouillée | À venir | Non puis Oui | Non | Oui |
| `S` | Passage secret | À venir | À définir | À définir | Oui |

---

## 7. Règles pour les lieux sûrs

Les lieux sûrs sont des cases spéciales qui ne doivent pas déclencher de rencontre aléatoire.

Lieux sûrs actuels ou prévus :

- `O` Temple de guérison ;
- `B` Boutique ;
- `>` Escalier descendant ;
- `<` Escalier montant.

Règle :

Quand un nouveau lieu sûr est ajouté, vérifier qu’il bloque bien les rencontres aléatoires dans la logique de déplacement.

---

## 8. Règles pour les objets persistants

Certains éléments doivent mémoriser leur état.

Exemples :

- porte ouverte ;
- coffre ouvert ;
- rencontre fixe vaincue ;
- passage secret découvert ;
- porte verrouillée ouverte ;
- événement unique déjà déclenché.

Règle :

Tout élément qui change définitivement doit être sauvegardé.

À vérifier lors de l’ajout :

- données dans le contrôleur du donjon ;
- sauvegarde dans `SaveManager.gd` ;
- restauration au chargement ;
- rendu visuel après chargement ;
- affichage automap après chargement.

---

## 9. Checklist avant d’ajouter un nouveau symbole

Avant d’ajouter un symbole de layout, vérifier :

```text
[ ] Le symbole est un seul caractère ASCII.
[ ] Le symbole n’est pas déjà utilisé.
[ ] Le comportement est défini.
[ ] La case est marchable ou bloquante de façon claire.
[ ] La rencontre aléatoire est autorisée ou bloquée explicitement.
[ ] Le rendu 3D est prévu dans DungeonRenderer.gd si nécessaire.
[ ] L’affichage automap est prévu dans AutoMapUI.gd.
[ ] La sauvegarde est prévue si l’état peut changer.
[ ] Le symbole est ajouté dans ce document.
```

---

## 10. Fichiers généralement concernés par un nouveau symbole

Selon le type de symbole, les fichiers suivants peuvent être concernés :

```text
scripts/dungeon/FloorDatabase.gd
scripts/dungeon/FloorData.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonRenderer.gd
scripts/ui/AutoMapUI.gd
scripts/core/SaveManager.gd
```

Pour un symbole purement visuel ou fixe :

```text
FloorDatabase.gd
DungeonRenderer.gd
AutoMapUI.gd
```

Pour un symbole avec effet gameplay :

```text
FloorDatabase.gd
Dungeon.gd
DungeonRenderer.gd
AutoMapUI.gd
SaveManager.gd si l’état doit persister
```

---

## 11. Convention de placement pour l’étage 1 et les futurs étages

### Temple

Le temple doit être accessible mais pas forcément immédiat.

Bon usage :

- après une porte ;
- près d’un embranchement ;
- comme point de récupération dans une zone dangereuse.

---

### Boutique

La boutique doit être un point sûr et utile.

Bon usage :

- pas trop loin du départ sur les premiers étages ;
- ou près d’un raccourci ;
- ou après une portion dangereuse pour récompenser l’exploration.

À éviter :

- placer la boutique trop profondément si l’inventaire se remplit vite ;
- placer la boutique sur le chemin exact du temple si cela rend la zone trop sûre.

---

### Coffres

Les coffres doivent encourager l’exploration.

Bon usage :

- cul-de-sac ;
- derrière une porte ;
- après un petit risque ;
- proche d’un piège léger si le contenu vaut le détour.

---

### Rencontres fixes

Les rencontres fixes doivent être utilisées pour rythmer l’étage.

Bon usage :

- garde devant une récompense ;
- mini-boss ;
- monstre rare visible ;
- premier contact avec un nouveau type d’ennemi.

---

## 12. Notes de maintenance

Quand un étage devient difficile à lire, il vaut mieux :

- ajouter des commentaires autour du layout ;
- documenter les coordonnées importantes ;
- déplacer certains événements dans des dictionnaires de coordonnées ;
- éviter d’utiliser trop de symboles spéciaux dans une même zone.

Objectif :

Le layout doit rester lisible comme une carte, pas devenir un script caché.
