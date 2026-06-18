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
- un message ;
- une rencontre ;
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
<
```

À éviter pour le départ :

```text
#
D
d
O
B
>
X
F
M
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

Statut : utilisé / prévu selon l’étage.

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

Règle pour les étages futurs :

Un `>` peut être placé visuellement dans le layout pour préparer une progression future, mais il ne doit devenir actif que si l’étage le déclare comme escalier fonctionnel.

---

### `<` — Escalier montant

Statut : prévu / partiellement pris en charge par l’automap.

Rôle futur :

- retour vers l’étage supérieur ;
- case marchable ;
- bloque les rencontres aléatoires sur cette case ;
- affiché sur l’automap.

Utilisation future :

```text
#..<..#
```

À implémenter complètement avec les transitions d’étage.

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
#..DO#
```

Règles de placement :

- le temple doit être placé derrière une porte ;
- le temple doit être en bout de couloir ou dans une alcôve ;
- il doit faire face à la case de porte qui permet d’y accéder ;
- il ne doit pas être placé directement dans un couloir principal ;
- il doit être accessible, mais idéalement après une petite progression.

Règle d’orientation 3D :

Le modèle 3D du temple doit être orienté vers son accès.

Exemples :

```text
#..DO#  accès par l’ouest, temple orienté vers l’ouest
#OD..#  accès par l’est, temple orienté vers l’est
```

---

### `B` — Boutique / marchand

Statut : utilisé.

Rôle :

- case marchable ;
- ouvre l’accès à la boutique ;
- bloque les rencontres aléatoires sur cette case ;
- affichée sur l’automap ;
- rendue comme comptoir, marchand ou alcôve.

Utilisation :

```text
#..DB#
```

Règles de placement :

- la boutique doit être placée derrière une porte ;
- la boutique doit être en bout de couloir ou dans une alcôve ;
- elle doit faire face à la case de porte qui permet d’y accéder ;
- elle doit être un lieu sûr ;
- elle ne doit pas être placée directement dans un couloir principal ;
- elle ne doit pas être trop proche du temple si cela rend la zone trop sûre.

Règle d’orientation 3D :

Le modèle 3D de la boutique doit être orienté vers son accès.

Exemples :

```text
#..DB#  accès par l’ouest, boutique orientée vers l’ouest
#BD..#  accès par l’est, boutique orientée vers l’est
```

Rôle économique actuel :

- vente des objets de l’inventaire ;
- achat d’objets basiques ;
- affichage et sauvegarde de l’or.

---

## 4. Symboles à ajouter ou à utiliser à moyen terme

Ces symboles ne sont pas tous implémentés.  
Ils sont réservés pour éviter les conflits futurs.

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
- déclenche un événement simple ;
- peut ouvrir une porte, modifier un état, donner un objet ou déclencher une conséquence ;
- peut être réutilisable ou unique selon son identifiant.

Utilisation prévue :

```text
#..E..#
```

Exemples :

- mécanisme ;
- levier ;
- autel secondaire ;
- choix narratif simple ;
- événement qui débloque une porte.

Règle :

Les événements complexes devraient être définis par coordonnées dans une table dédiée, plutôt que par le symbole seul.

---

### `M` — Message / PNJ neutre / indication

Statut : à venir.

Rôle prévu :

- case marchable ;
- affiche un message ou une information ;
- peut représenter un PNJ neutre, une inscription, un avertissement ou un indice ;
- ne déclenche pas de combat ;
- peut être réutilisable ou unique selon le design.

Utilisation prévue :

```text
#..M..#
```

Exemples :

- PNJ qui donne une information ;
- inscription donnant un indice ;
- avertissement avant une porte ;
- rumeur sur une clé ou un coffre ;
- message préparant un boss.

Règle :

`M` ne doit pas déclencher de combat.  
Pour un combat fixe, utiliser `F`.  
Pour un boss, utiliser `X`.

---

### `F` — Combat fixe

Statut : à venir.

Rôle prévu :

- case marchable ;
- déclenche un combat prédéfini ;
- peut être utilisé pour une garde, un monstre rare ou une rencontre obligatoire ;
- doit sauvegarder son état si le combat ne doit pas revenir.

Utilisation prévue :

```text
#..F..#
```

Règle :

À utiliser pour les rencontres importantes qui ne sont pas des boss.  
Pour une rencontre majeure de fin d’étage, utiliser `X`.

---

### `X` — Boss / rencontre majeure

Statut : à venir.

Rôle prévu :

- case marchable ;
- représente un boss ou une rencontre majeure d’étage ;
- peut être placé derrière une porte spéciale ou une porte verrouillée ;
- peut protéger un escalier descendant ou une récompense importante ;
- doit sauvegarder son état une fois vaincu.

Utilisation prévue :

```text
#.D.X>#
```

Règles de design :

- le boss doit être loin du départ ;
- le boss doit être loin du temple ;
- le boss peut être placé devant un escalier descendant futur ;
- l’accès au boss peut dépendre d’un coffre, d’une clé, d’un message ou d’un événement ;
- la zone du boss doit être lisible et reconnaissable.

Différence avec les autres symboles :

```text
M = message / PNJ neutre / indication
F = combat fixe
X = boss / rencontre majeure
```

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
| `>` | Escalier descendant | Utilisé / prévu | Oui | Non | Selon activation |
| `<` | Escalier montant | Prévu | Oui | Non | Selon transition |
| `O` | Temple de guérison | Utilisé | Oui | Non | Non actuellement |
| `B` | Boutique | Utilisé | Oui | Non | Or/inventaire via systèmes dédiés |
| `C` | Coffre | À venir | À définir | Non recommandé | Oui |
| `P` | Piège | À venir | Oui | Non recommandé | Selon design |
| `E` | Événement | À venir | Oui | Non recommandé | Selon design |
| `M` | Message / PNJ neutre | À venir | Oui | Non | Selon design |
| `F` | Combat fixe | À venir | Oui | Non | Oui |
| `X` | Boss / rencontre majeure | À venir | Oui | Non | Oui |
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
- `<` Escalier montant ;
- `M` Message / PNJ neutre, selon design.

Règle :

Quand un nouveau lieu sûr est ajouté, vérifier qu’il bloque bien les rencontres aléatoires dans la logique de déplacement.

---

## 8. Règles pour les objets persistants

Certains éléments doivent mémoriser leur état.

Exemples :

- porte ouverte ;
- coffre ouvert ;
- combat fixe vaincu ;
- boss vaincu ;
- passage secret découvert ;
- porte verrouillée ouverte ;
- événement unique déjà déclenché ;
- message unique déjà lu si le design le demande.

Règle :

Tout élément qui change définitivement doit être sauvegardé.

À vérifier lors de l’ajout :

- données dans le contrôleur du donjon ;
- sauvegarde dans `SaveManager.gd`;
- restauration au chargement ;
- rendu visuel après chargement ;
- affichage automap après chargement.

---

## 9. Règles de placement pour temple et boutique

Le temple `O` et la boutique `B` sont des lieux sûrs importants.

Règles communes :

```text
[ ] Être placés derrière une porte `D`.
[ ] Être en bout de couloir ou dans une alcôve.
[ ] Ne pas couper un couloir principal.
[ ] Ne pas déclencher de rencontre aléatoire.
[ ] Être affichés clairement sur l’automap.
[ ] Avoir un modèle 3D orienté vers leur accès.
```

Exemples recommandés :

```text
#..DO#  porte à l’ouest, lieu spécial orienté ouest
#OD..#  porte à l’est, lieu spécial orienté est
```

À éviter :

```text
#..O..#  temple directement dans un couloir
#..B..#  boutique directement dans un couloir
```

Règle technique recommandée :

À terme, `DungeonRenderer.gd` devrait pouvoir déduire l’orientation d’un lieu spécial à partir de la position de sa porte d’accès adjacente.

Exemple :

- porte à gauche du temple → modèle orienté ouest ;
- porte à droite du temple → modèle orienté est ;
- porte au-dessus du temple → modèle orienté nord ;
- porte en-dessous du temple → modèle orienté sud.

En attendant une détection automatique, l’orientation peut être gérée par convention ou par fonction dédiée.

---

## 10. Checklist avant d’ajouter un nouveau symbole

Avant d’ajouter un symbole de layout, vérifier :

```text
[ ] Le symbole est un seul caractère ASCII.
[ ] Le symbole n’est pas déjà utilisé.
[ ] Le comportement est défini.
[ ] La case est marchable ou bloquante de façon claire.
[ ] La rencontre aléatoire est autorisée ou bloquée explicitement.
[ ] Le rendu 3D est prévu dans DungeonRenderer.gd si nécessaire.
[ ] L’orientation 3D est définie si le modèle a une façade.
[ ] L’affichage automap est prévu dans AutoMapUI.gd.
[ ] La sauvegarde est prévue si l’état peut changer.
[ ] Le symbole est ajouté dans ce document.
```

---

## 11. Fichiers généralement concernés par un nouveau symbole

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

## 12. Convention de placement pour l’étage 1 et les futurs étages

### Temple

Le temple doit être accessible mais pas forcément immédiat.

Bon usage :

- derrière une porte ;
- en bout de couloir ;
- près d’un embranchement ;
- comme point de récupération dans une zone dangereuse.

À éviter :

- directement dans le couloir principal ;
- trop près de la boutique ;
- trop près d’un boss.

---

### Boutique

La boutique doit être un point sûr et utile.

Bon usage :

- derrière une porte ;
- en bout de couloir ;
- pas trop loin du départ sur les premiers étages ;
- ou près d’un raccourci ;
- ou après une portion dangereuse pour récompenser l’exploration.

À éviter :

- placer la boutique trop profondément si l’inventaire se remplit vite ;
- placer la boutique sur le chemin exact du temple si cela rend la zone trop sûre ;
- placer la boutique directement dans un couloir principal.

---

### Coffres

Les coffres doivent encourager l’exploration.

Bon usage :

- cul-de-sac ;
- derrière une porte ;
- après un petit risque ;
- proche d’un piège léger si le contenu vaut le détour ;
- comme récompense liée à une clé ou à un indice.

---

### Messages / PNJ neutres

Les messages `M` doivent donner une information utile ou une ambiance.

Bon usage :

- avertir d’un danger ;
- donner un indice pour une porte ;
- indiquer l’existence d’un coffre ;
- annoncer un boss ;
- donner un élément narratif court.

À éviter :

- utiliser `M` pour un combat ;
- multiplier les messages sans utilité ;
- bloquer la progression sur une information trop obscure.

---

### Combats fixes

Les combats fixes `F` doivent rythmer l’étage.

Bon usage :

- garde devant une récompense ;
- monstre rare visible ;
- premier contact avec un type d’ennemi ;
- combat de protection avant un coffre ou une porte.

À éviter :

- remplacer toutes les rencontres aléatoires par des `F` ;
- placer un combat fixe sans récompense, indice ou intérêt clair.

---

### Boss

Les boss `X` doivent structurer la fin d’une section ou d’un étage.

Bon usage :

- loin du départ ;
- loin du temple ;
- derrière une porte ou une condition ;
- avant un escalier descendant ;
- annoncé par un message, une rencontre ou un indice.

À éviter :

- placer un boss trop proche d’un lieu sûr ;
- placer un boss sans préparation ni signal ;
- rendre obligatoire un boss sans avoir prévu la sauvegarde de son état.

---

## 13. Notes de maintenance

Quand un étage devient difficile à lire, il vaut mieux :

- ajouter des commentaires autour du layout ;
- documenter les coordonnées importantes ;
- déplacer certains événements dans des dictionnaires de coordonnées ;
- éviter d’utiliser trop de symboles spéciaux dans une même zone.

Objectif :

Le layout doit rester lisible comme une carte, pas devenir un script caché.
