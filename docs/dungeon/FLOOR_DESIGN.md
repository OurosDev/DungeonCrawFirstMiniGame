# FLOOR_DESIGN

Normes de conception des étages du donjon.

Ce document sert de référence pour les layouts ASCII utilisés par `scripts/dungeon/FloorDatabase.gd`, pour la nomenclature des symboles et pour les règles de placement des lieux spéciaux.

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

Un layout non rectangulaire rend les coordonnées difficiles à maintenir et peut provoquer des erreurs de lecture.

### 2.2 Bordures extérieures

Sauf cas particulier volontaire, l’extérieur d’un étage doit être fermé par des murs `#`.

### 2.3 Coordonnées

Les coordonnées sont exprimées en `Vector2i(x, y)`.

- `x` augmente vers la droite.
- `y` augmente vers le bas.
- La première colonne est `x = 0`.
- La première ligne est `y = 0`.

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

| Symbole | Nom | Statut v0.13.1 | Marchable | Rencontre aléatoire | État sauvegardé |
|---|---|---:|---:|---:|---:|
| `#` | Mur | Utilisé | Non | Non | Non |
| `.` | Sol / couloir | Utilisé | Oui | Oui | Non |
| `D` | Porte fermée | Utilisé | Oui | Non après ouverture | Oui, devient `d` |
| `d` | Porte ouverte | Runtime | Oui | Selon logique actuelle | Oui |
| `>` | Escalier descendant | Utilisé / futur selon étage | Oui | Non | Selon activation |
| `<` | Escalier montant | Utilisé | Oui | Non | Selon transition |
| `O` | Temple de guérison | Utilisé | Oui | Non | Non actuellement |
| `B` | Boutique | Utilisé | Oui | Non | Or/inventaire via systèmes dédiés |
| `C` | Coffre | Utilisé | Oui | Non | Oui, devient `.` après ouverture |
| `M` | Message / PNJ neutre / indication | Utilisé | Oui | Non | Non actuellement |
| `S` | Stèle de sort | Utilisé | Oui | Non | Découverte sauvegardée via `discovered_ability_ids` |
| `F` | Combat fixe non-boss | Réservé | Oui prévu | Non | Oui si unique |
| `X` | Boss / rencontre majeure | Utilisé | Oui | Non | Oui, devient `.` après victoire |
| `P` | Piège | Réservé | Oui prévu | Non recommandé | Selon design |
| `E` | Événement | Réservé | Oui prévu | Non recommandé | Selon design |
| `L` | Porte verrouillée | Utilisé | Non puis Oui | Non | Oui, devient `d` après ouverture |

Note historique :

```text
S a été réaffecté en v0.13.1 aux stèles de sort.
Le passage secret n'a plus de symbole officiel réservé pour le moment.
Un futur symbole de passage secret devra être choisi seulement quand ce système sera conçu.
```

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

Règle :

- placer `D` dans les layouts source ;
- ne pas placer `d` directement sauf cas volontaire et documenté.

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
- un `>` peut exister comme marqueur visuel futur ;
- il ne doit être actif que si l’étage suivant existe et si `FloorData` le déclare correctement ;
- l’escalier descendant futur derrière un boss peut rester visible comme objectif tant que l’étage suivant n’est pas codé.

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

- le modèle 3D du temple doit être orienté vers la porte d’accès ou le chemin adjacent praticable.

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
- ne doit pas être trop proche du temple si cela rend la zone trop sûre.

Règle d’orientation 3D :

- le modèle 3D de boutique doit être orienté vers la porte d’accès ou le chemin adjacent praticable.

### `C` — Coffre

Statut : utilisé depuis `v0.7`.

Rôle :

- donne de l’or, un objet ou un objet de quête ;
- contenu défini par étage + coordonnée ;
- état ouvert / fermé sauvegardé par étage ;
- ne redonne pas son contenu après chargement ;
- devient généralement `.` après ouverture ;
- affiché dans la vue 3D ;
- affiché sur l’automap.

Règles de placement :

- encourager l’exploration ;
- privilégier les cul-de-sac, alcôves, petites récompenses derrière porte ou chemins secondaires ;
- éviter de placer un coffre sur un lieu déjà utilisé par une découverte de sort ;
- éviter les coffres bloquant un couloir principal ;
- un coffre narratif important peut contenir un objet de quête si le chemin est clairement indiqué.

Cas actuel important :

- le coffre en `Vector2i(1, 13)` à l’étage 2 contient `boss_door_key_floor_2`.

### `M` — Message / PNJ neutre / indication

Statut : utilisé depuis `v0.7`.

Rôle :

- affiche un message court ;
- peut représenter un PNJ neutre, une inscription, un avertissement ou un indice ;
- ne déclenche aucun combat ;
- peut guider vers un coffre, une clé, un boss ou une direction ;
- ne doit pas remplacer un système de quête complexe.

Règles :

- `M` ne signifie plus combat fixe ;
- pour un combat fixe non-boss, utiliser `F` ;
- pour un boss ou une rencontre majeure, utiliser `X` ;
- les messages doivent avoir une utilité : orientation, indice, ambiance courte, avertissement.

À éviter :

- multiplier les messages sans utilité ;
- bloquer la progression sur un indice trop obscur ;
- utiliser `M` comme déclencheur de combat.

### `S` — Stèle de sort

Statut : utilisé depuis `v0.13.1`.

Rôle :

- représente une découverte de sort visible dans le labyrinthe ;
- case marchable ;
- ne déclenche pas de rencontre aléatoire ;
- reste visible après découverte ;
- est affichée sur l’automap / carte agrandie ;
- est rendue en 3D par une stèle magique ;
- la découverte réelle reste définie dans `FloorDatabase.gd` par la table `discoveries`.

Cas actuels :

- `Vector2i(29, 13)` à l’étage 1 : `spell_ice_shard` ;
- `Vector2i(21, 8)` à l’étage 2 : `spell_group_heal`.

Règles de placement :

- placer la stèle dans une impasse, une alcôve ou une zone volontairement exploratoire ;
- éviter de la placer directement dans un couloir principal sans intention claire ;
- ne pas superposer une stèle avec un coffre, un message, une boutique, un temple ou un boss ;
- définir le sort dans `discoveries` avec la même coordonnée que la case `S`.

Règle d’orientation 3D :

- la stèle doit faire face à une case chemin `.` si possible ;
- sinon, elle doit faire face à une case praticable non-mur ;
- elle ne doit pas être orientée volontairement vers un mur `#` quand une case praticable adjacente existe.

### `L` — Porte verrouillée

Statut : utilisé depuis `v0.7`.

Rôle :

- porte spéciale nécessitant une clé, un événement ou une condition ;
- bloquante tant que la condition n’est pas remplie ;
- état ouvert / fermé sauvegardé ;
- peut consommer l’objet requis lors de l’ouverture.

Cas actuel :

- `Vector2i(2, 1)` à l’étage 2 ;
- nécessite `boss_door_key_floor_2` ;
- consomme la Clé du gardien ;
- devient une porte ouverte runtime.

Règles :

- ne pas confondre avec `D`, qui est une porte simple ouvrable automatiquement ;
- ne pas bloquer une progression essentielle avec `L` sans indice clair ;
- si la clé est un objet de quête, elle doit être non vendable et non jetable.

### `X` — Boss / rencontre majeure

Statut : utilisé depuis `v0.7.1`.

Rôle :

- représente un boss ou une rencontre majeure d’étage ;
- peut protéger un escalier descendant futur ;
- doit sauvegarder son état une fois vaincu ;
- doit être annoncé ou préparé par le level design ;
- devient généralement `.` après victoire.

Cas actuel :

- `Vector2i(4, 1)` à l’étage 2 ;
- déclenche `gardien_boss_etage_2` ;
- le boss réutilise le gardien normal ;
- seule différence gameplay actuelle : PV multipliés par une constante ;
- disparaît après victoire.

Règles de placement :

- loin du départ ;
- loin du temple ;
- derrière une porte, une condition ou une zone identifiable ;
- potentiellement avant un escalier descendant ;
- accompagné d’un message, indice, combat fixe ou signal visuel.

Différence officielle :

```text
M = message / PNJ neutre / indication
S = stèle de sort
F = combat fixe non-boss
X = boss / rencontre majeure
```

---

## 5. Symboles prévus ou réservés

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

### Passage secret

Statut : prévu mais sans symbole officiel depuis `v0.13.1`.

Rôle prévu :

- mur ou porte cachée ;
- peut devenir marchable après découverte ;
- état découvert / non découvert sauvegardé ;
- affichage automap à définir.

Règles :

- choisir un nouveau symbole seulement quand le système sera réellement conçu ;
- ne plus utiliser `S`, désormais réservé aux stèles de sort.

### `P` — Piège

Statut : réservé.

Rôle possible :

- infliger des dégâts ;
- réduire des PM ;
- déclencher un effet négatif ;
- déclencher éventuellement une rencontre.

Règle :

- utiliser avec parcimonie pour garder une difficulté lisible.

### `E` — Événement

Statut : réservé.

Rôle possible :

- levier ;
- autel secondaire ;
- choix narratif simple ;
- mécanisme ;
- événement qui modifie un état.

Règle :

- les événements complexes doivent être définis par coordonnées dans une table dédiée plutôt que par le symbole seul.

---

## 6. Lieux sûrs et rencontres aléatoires

Les lieux sûrs ne doivent pas déclencher de rencontre aléatoire.

Lieux sûrs actuels ou prévus :

- `O` temple ;
- `B` boutique ;
- `>` escalier descendant ;
- `<` escalier montant ;
- `M` message / PNJ neutre / indication ;
- `S` stèle de sort ;
- `C` coffre ;
- `L` porte verrouillée ;
- `X` boss / rencontre majeure ;
- probablement `F` combat fixe non-boss.

Règle :

- quand un nouveau lieu sûr est ajouté, vérifier explicitement la logique de déplacement et de rencontres.

---

## 7. Objets persistants et état par étage

Certains éléments doivent mémoriser leur état.

Exemples :

- porte ouverte ;
- coffre ouvert ;
- combat fixe vaincu ;
- boss vaincu ;
- découverte de sort ;
- porte verrouillée ouverte ;
- événement unique déclenché.

Règles :

- tout état définitif doit être sauvegardé ;
- les états doivent être conservés par étage ;
- le chargement doit restaurer le layout, les portes ouvertes, les découvertes automap et les états persistants ;
- les anciennes sauvegardes peuvent conserver d’anciens layouts mémorisés, donc les tests doivent tenir compte des sauvegardes existantes.

Checklist lors de l’ajout :

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
- un escalier derrière boss doit rester lisible comme objectif.

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
- coffre de clé sans indice.

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

### Stèles de sort `S`

Bon usage :

- impasse ;
- alcôve ;
- zone secondaire ;
- découverte liée à l’exploration ;
- position avec face orientable vers un chemin.

À éviter :

- directement dans un couloir principal sans intention ;
- superposée à un coffre, message, boutique, temple ou boss ;
- orientée vers un mur alors qu’un chemin adjacent existe.

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

### Porte verrouillée `L`

Bon usage :

- barrière claire avant un boss ou une zone importante ;
- condition liée à un coffre, indice ou événement ;
- clé ou condition clairement annoncée par le level design.

À éviter :

- bloquer une progression sans indice ;
- consommer une clé sans message clair ;
- utiliser `L` comme simple porte décorative.

---

## 10. Checklist avant d’ajouter un symbole ou une case spéciale

```text
[ ] Le symbole est un seul caractère ASCII.
[ ] Le symbole n'entre pas en conflit avec un symbole existant.
[ ] FloorDatabase.gd est mis à jour.
[ ] Dungeon.gd ou les contrôleurs concernés savent lire le symbole.
[ ] DungeonRenderer.gd affiche ou ignore volontairement le symbole.
[ ] AutoMapUI.gd affiche correctement le symbole.
[ ] Les rencontres aléatoires sont autorisées ou bloquées explicitement.
[ ] Les états persistants sont sauvegardés si nécessaire.
[ ] FLOOR_VISUALIZER.md est régénéré depuis FloorDatabase.gd.
[ ] Les règles de placement sont documentées ici si le symbole devient durable.
```
