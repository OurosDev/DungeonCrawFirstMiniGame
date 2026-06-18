# Feuille de route du projet — DungeonCrawFirstMiniGame

## 1. Objectif général du projet

Créer un dungeon crawler rétro en vue subjective, inspiré de l’esprit old-school et de jeux comme *Swords and Serpents* sur NES.

Le projet vise une progression simple, lisible et modulaire :

- exploration case par case ;
- groupe de quatre héros ;
- combats au tour par tour ;
- progression par étage ;
- danger parfois injuste ;
- récupération, préparation et gestion pour compenser cette difficulté ;
- documentation claire des layouts et des symboles avant chaque ajout de contenu.

Le projet doit continuer à avancer par petites releases stables. Les grosses fonctionnalités doivent rester découpées en étapes, avec des tags servant de points de retour fiables.

---

## 2. Version actuelle et logique de versioning

### 2.1 Version de continuation actuelle

Version actuelle à utiliser comme base de travail :

```text
v0.7
```

Nom de release :

```text
v0.7 — Coffres, indices et clé du gardien
```

Cette version ajoute les premiers vrais éléments de contenu de donjon persistants :

- coffres `C` ;
- messages / indices `M` ;
- porte verrouillée `L` ;
- Clé du gardien ;
- coffre spécial de l’étage 2 contenant la clé ;
- consommation automatique de la clé à l’ouverture de la porte du boss ;
- objet de quête non vendable ;
- mise à jour de l’automap et du rendu 3D pour ces nouveaux symboles.

### 2.2 Releases importantes

```text
v0.1 = base stable initiale
v0.2 = temple + audio amélioré + sprites monstres + correction portraits
v0.3 = inventaire commun du groupe
v0.4 = équipement de base stable
v0.5-unstable-shop = première boutique de vente + or + FLOOR_DESIGN + outil dev téléportation
v0.5.1 = hotfix stats héros
v0.5.2 = achat en boutique
v0.6 = transition vers l’étage 2
v0.6.1 = stabilisation multi-étages
v0.7 = coffres, messages / indices, porte verrouillée et clé du gardien
```

### 2.3 Règle de versioning

Ne pas considérer que `v1.0` arrive automatiquement après `v0.9`.

Le projet peut continuer en versions pré-1.0 :

```text
v0.7.1
v0.7.2
v0.8
v0.9
v0.10
v0.11
...
```

`v1.0` doit rester réservé à une version réellement complète, avec :

- boucle de jeu solide ;
- plusieurs étages jouables ;
- progression claire ;
- système économique stabilisé ;
- gestion de la défaite ;
- contenu de boss / progression ;
- niveau de polish minimum.

Pour les extensions mineures d’un système déjà posé, préférer une sous-version :

```text
v0.7.1 = boss du gardien
v0.7.2 = ajustements boss / coffre / porte / équilibrage si nécessaire
```

---

## 3. Structure générale du projet

Le projet possède actuellement trois scènes principales :

```text
MainMenu.tscn
PartyCreation.tscn
Dungeon.tscn
```

La scène `Dungeon.tscn` est le cœur du jeu en exploration et combat. Elle orchestre les systèmes principaux sans tout gérer directement.

Structure générale attendue de la scène Donjon :

```text
Dungeon
Player
Camera3D
GameUI
CombatManager
DungeonRenderer
```

Documents de conception importants :

```text
ROADMAP.md
FLOOR_DESIGN.md
FLOOR_VISUALIZER.md
```

Rôle des documents :

- `ROADMAP.md` : état global du projet, historique et prochaines priorités ;
- `FLOOR_DESIGN.md` : règles de construction des étages et nomenclature des symboles ;
- `FLOOR_VISUALIZER.md` : visualisation lisible des étages et préparation des variantes.

---

## 4. Systèmes fonctionnels actuellement

### 4.1 Menu principal

Le menu principal est fonctionnel.

Fonctions présentes :

- Nouvelle partie ;
- Charger ;
- Options ;
- Quitter ;
- musique de titre ;
- réglages audio.

Le menu peut lancer une nouvelle partie, charger une sauvegarde existante et modifier les volumes.

---

### 4.2 Création du groupe

La création de groupe est fonctionnelle.

Fonctions présentes :

- création de 4 héros ;
- choix de classe ;
- reroll des statistiques ;
- validation progressive du groupe ;
- retour au menu principal.

Classes actuelles :

- Guerrier ;
- Voleuse ;
- Mage ;
- Prêtresse.

Statistiques actuelles :

- Force ;
- Agilité ;
- Endurance ;
- Magie.

Rôle actuel des statistiques :

- Force → dégâts physiques ;
- Agilité → ordre des tours ;
- Endurance → points de vie ;
- Magie → points de magie et puissance des sorts.

Depuis `v0.5.1`, les statistiques issues du roll de création sont correctement conservées comme statistiques de base, même avec le système d’équipement.

---

### 4.3 Session de jeu

`GameSession.gd` fonctionne comme passerelle entre les scènes et les systèmes persistants.

Fonctions présentes :

- stocker le groupe ;
- stocker l’étage courant ;
- stocker l’inventaire courant ;
- stocker l’or du groupe ;
- stocker les états par étage ;
- préparer une nouvelle partie ;
- transporter les données de sauvegarde chargée.

Les états d’étage permettent maintenant de conserver :

- layout modifié ;
- portes ouvertes ;
- coffres ouverts ;
- porte verrouillée ouverte ;
- cellules découvertes par l’automap.

---

### 4.4 Sauvegarde et chargement

Le système de sauvegarde est fonctionnel.

Données sauvegardées actuellement :

- groupe ;
- noms des héros ;
- classes ;
- niveaux ;
- EXP ;
- statistiques de base ;
- statistiques finales recalculées ;
- équipement porté ;
- HP / MP ;
- étage courant ;
- position du joueur ;
- layout de l’étage ;
- états par étage ;
- portes ouvertes ;
- coffres ouverts via layout modifié ;
- porte verrouillée ouverte via layout modifié ;
- cellules découvertes de l’automap ;
- inventaire ;
- or du groupe.

Restrictions déjà en place :

- sauvegarde impossible pendant un combat.

Note importante :

- Les sauvegardes qui ont déjà mémorisé un étage peuvent conserver un ancien layout.
- Pour tester un changement de layout, utiliser une nouvelle partie ou réinitialiser la sauvegarde de test.

À prévoir plus tard :

- sauvegarde des rencontres fixes vaincues ;
- sauvegarde des boss vaincus ;
- sauvegarde des événements uniques déclenchés ;
- sauvegarde des passages secrets découverts.

---

### 4.5 Donjon et exploration

L’exploration est fonctionnelle.

Fonctions présentes :

- déplacement case par case ;
- rotation gauche / droite ;
- murs bloquants ;
- portes fermées `D` ;
- ouverture automatique des portes simples ;
- portes ouvertes converties en `d` ;
- portes verrouillées `L` ;
- ouverture conditionnelle de porte verrouillée par objet requis ;
- escaliers descendants `>` ;
- escaliers montants `<` ;
- transitions entre étage 1 et étage 2 ;
- rencontres aléatoires ;
- temple de guérison ;
- boutique ;
- coffres ;
- messages / indices ;
- outil temporaire de téléportation pour le développement.

Le rendu du donjon est en place :

- murs en briques ;
- sol / plafond ;
- portes fermées ;
- portes ouvertes ;
- brouillard de profondeur ;
- thème visuel d’étage ;
- rendu spécifique du temple ;
- rendu spécifique de la boutique ;
- rendu simple pour les escaliers ;
- rendu simple pour coffres, messages et portes verrouillées.

Fichiers principaux concernés :

```text
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonRenderer.gd
scripts/dungeon/FloorData.gd
scripts/dungeon/FloorDatabase.gd
scripts/dungeon/DungeonThemeData.gd
```

---

### 4.6 Multi-étages

Le système multi-étages est fonctionnel depuis `v0.6` / `v0.6.1`.

Fonctions présentes :

- étage 1 vers étage 2 via `>` ;
- étage 2 vers étage 1 via `<` ;
- retour sur le `>` de l’étage précédent ;
- conservation du groupe ;
- conservation de l’inventaire ;
- conservation de l’or ;
- conservation de l’équipement ;
- table de rencontre différente selon l’étage ;
- sauvegarde fiable depuis l’étage 2 ;
- restauration du bon étage au chargement ;
- mémorisation des états par étage.

Étage 2 actuel :

- même taille que l’étage 1 : 31 × 21 ;
- escalier montant `<` à `Vector2i(23, 17)` ;
- boss temporaire `X` en haut à gauche ;
- escalier descendant futur `>` derrière le boss ;
- temple `O` derrière porte ;
- boutique `B` derrière porte ;
- porte verrouillée `L` devant le boss depuis `v0.7`.

Limites actuelles :

- l’escalier descendant derrière le boss est encore visuel / inactif ;
- pas encore d’étage 3 ;
- le boss `X` n’est pas encore un vrai combat.

---

### 4.7 Normes de conception des étages

Le projet possède maintenant :

```text
FLOOR_DESIGN.md
```

Ce document sert de référence avant d’ajouter ou de modifier un symbole dans les layouts ASCII.

Nomenclature actuelle :

```text
# = mur
. = sol / couloir
D = porte fermée
d = porte ouverte runtime
> = escalier descendant
< = escalier montant
O = temple
B = boutique
C = coffre
M = message / PNJ neutre / indication
F = combat fixe non-boss
X = boss / rencontre majeure
L = porte verrouillée
S = passage secret
P = piège
E = événement
R = rune / sort visible
```

Règle importante :

- `M` ne doit plus signifier combat fixe.
- `M` signifie message, PNJ neutre, inscription ou indice.
- `F` doit être utilisé pour les combats fixes non-boss.
- `X` doit être utilisé pour les boss ou rencontres majeures.

Tout nouveau symbole doit être intégré dans les systèmes concernés :

- `FloorDatabase.gd` ;
- `FloorData.gd` si le symbole nécessite une définition par coordonnée ;
- `Dungeon.gd` ;
- `DungeonRenderer.gd` ;
- `AutoMapUI.gd` ;
- `SaveManager.gd` / état d’étage si l’état doit persister.

---

### 4.8 Visualiseur des étages

Le projet possède maintenant :

```text
FLOOR_VISUALIZER.md
```

Rôle :

- afficher les layouts sous forme de grille lisible ;
- conserver une section d’état actuel en jeu ;
- préparer des variantes de planification avant modification des scripts ;
- faciliter le placement précis de `C`, `M`, `F`, `X`, `L` et autres symboles.

Choix de lisibilité actuel :

- murs affichés en carrés `■` ;
- chemins / sols affichés comme cases vides ;
- symboles spéciaux affichés tels quels ;
- coordonnées X/Y autour des grilles ;
- tableaux HTML simples pour conserver le format grille dans le Markdown.

Règle de travail :

- la première section doit refléter strictement l’état actuel en jeu ;
- les variantes doivent être séparées dans une seconde section ;
- ne pas utiliser le visualiseur comme source gameplay : `FloorDatabase.gd` reste la source réelle.

---

### 4.9 Temple de guérison

Le temple de guérison est fonctionnel depuis `v0.2`.

Symbole utilisé :

```text
O
```

Comportement actuel :

- restaure tous les PV et PM du groupe ;
- gratuit ;
- réutilisable ;
- restaure aussi les héros tombés à 0 PV ;
- ne déclenche pas de rencontre aléatoire ;
- visible dans la vue donjon ;
- visible sur l’automap.

Règles de placement :

- derrière une porte `D` ;
- en bout de couloir ou alcôve ;
- pas directement dans un couloir principal ;
- orienté visuellement vers la porte d’accès.

Évolution possible :

- temple à usage limité ;
- coût en offrande ;
- restauration partielle ;
- temples différents selon les étages.

Priorité actuelle : faible.

---

### 4.10 Boutique

La boutique est fonctionnelle.

Symbole utilisé :

```text
B
```

Comportement actuel :

- case marchable ;
- accessible uniquement depuis une case `B` ;
- ne déclenche pas de rencontre aléatoire ;
- visible sur l’automap ;
- rendue en 3D ;
- propose achat et vente.

Fonctions actuelles :

- vendre des objets de l’inventaire ;
- gagner de l’or selon `sell_value` ;
- acheter des objets basiques ;
- stock marchand infini ;
- prix d’achat basé sur `sell_value × 4` ;
- refus d’achat si or insuffisant ;
- refus d’achat si inventaire plein ;
- affichage de l’or dans les écrans boutique ;
- objets de quête non vendables.

Stock marchand actuel :

```text
rusty_sword
fragile_dagger
worn_tunic
cracked_shield
tarnished_ring
```

Règles de placement :

- derrière une porte `D` ;
- en bout de couloir ou alcôve ;
- pas directement dans un couloir principal ;
- lieu sûr ;
- pas trop proche du temple si cela rend la zone trop sûre.

Évolutions possibles :

- stock limité ;
- services de boutique ;
- achats différents selon l’étage ;
- objets consommables si ce système est ajouté.

Priorité actuelle : moyenne.

---

### 4.11 Coffres

Les coffres sont fonctionnels depuis `v0.7`.

Symbole utilisé :

```text
C
```

Comportement actuel :

- case marchable ;
- déclenche une récompense quand le joueur entre dessus ;
- peut donner de l’or ;
- peut donner un objet ;
- peut donner un objet de quête ;
- devient une case de sol `.` après ouverture ;
- son état ouvert est conservé via le layout mémorisé par étage ;
- ne déclenche pas de rencontre aléatoire lors de l’ouverture.

Coffres actuels de l’étage 1 :

```text
Vector2i(5, 1)  = +25 or
Vector2i(15, 19) = tarnished_ring
Vector2i(27, 9) = small_shield
```

Coffres actuels de l’étage 2 :

```text
Vector2i(1, 13) = boss_door_key_floor_2 / Clé du gardien
Vector2i(15, 15) = reinforced_leather
Vector2i(25, 7) = +50 or
```

Règles de design :

- les coffres doivent généralement récompenser l’exploration ;
- les coffres importants doivent être placés dans des impasses ou zones volontairement explorées ;
- un coffre ouvert ne doit jamais redonner sa récompense après chargement ;
- éviter de placer un coffre sur une case déjà utilisée par une découverte de sort.

---

### 4.12 Messages / indices

Les messages sont fonctionnels depuis `v0.7`.

Symbole utilisé :

```text
M
```

Comportement actuel :

- case marchable ;
- affiche un message dans le journal / log ;
- peut représenter une inscription, un PNJ neutre, un avertissement ou un indice ;
- ne déclenche pas de combat ;
- ne déclenche pas de rencontre aléatoire.

Messages actuels de l’étage 1 :

```text
Vector2i(3, 1)
"Une inscription gravée indique : les vieux coffres gardent parfois plus que de l'or."

Vector2i(25, 18)
"L'air venu d'en bas est plus froid. Préparez-vous avant de descendre."
```

Messages actuels de l’étage 2 :

```text
Vector2i(21, 17)
"Des traces anciennes mènent vers l'ouest. Quelque chose semble garder les profondeurs."

Vector2i(3, 11)
"Une voix lointaine murmure : la voie du gardien ne s'ouvre qu'à ceux qui fouillent les impasses."

Vector2i(1, 1)
"Une présence puissante se tient derrière cette porte. Ce passage n'est pas encore prêt."
```

Règle importante :

- `M` ne doit pas déclencher de combat.
- Pour un combat fixe, utiliser `F`.
- Pour un boss ou une rencontre majeure, utiliser `X`.

---

### 4.13 Porte verrouillée et Clé du gardien

La première porte verrouillée est fonctionnelle depuis `v0.7`.

Symbole utilisé :

```text
L
```

Comportement actuel :

- la porte verrouillée bloque l’accès tant que le joueur ne possède pas l’objet requis ;
- la porte devant le boss temporaire de l’étage 2 utilise `L` ;
- la clé requise est `boss_door_key_floor_2` ;
- la clé est obtenue dans le coffre `C` de l’étage 2 à `Vector2i(1, 13)` ;
- la clé est consommée automatiquement quand le joueur tente d’ouvrir la porte ;
- la porte devient une porte ouverte `d` ;
- l’état ouvert reste conservé via le layout d’étage mémorisé.

Objet de quête actuel :

```text
boss_door_key_floor_2 = Clé du gardien
```

Règles :

- la clé est un objet de quête ;
- la clé est non vendable ;
- la clé ne doit pas pouvoir être jetée si une action “jeter” est ajoutée plus tard ;
- les objets de quête doivent rester protégés explicitement dans les règles d’inventaire / boutique.

---

### 4.14 Automap

L’automap est fonctionnelle.

Fonctions présentes :

- découverte progressive ;
- affichage centré sur le joueur ;
- murs ;
- portes fermées ;
- portes ouvertes ;
- escaliers ;
- temple ;
- boutique ;
- coffres ;
- messages ;
- portes verrouillées ;
- boss / marqueur majeur ;
- orientation du joueur.

La carte découverte est sauvegardée et restaurée par étage.

---

### 4.15 Interface de jeu

L’interface principale est fonctionnelle.

Éléments présents :

- vue donjon centrale ;
- panneaux des héros ;
- portraits des classes ;
- barres HP / MP ;
- journal ;
- commandes de combat ;
- automap ;
- menu d’aventure.

Choix d’interface déjà actés :

- HP / MP affichés sous forme de barres dans l’interface principale ;
- pas de chiffres HP / MP pendant le combat ;
- chiffres détaillés dans les menus ;
- portraits utilisés pour communiquer la classe ;
- pas d’en-têtes redondants dans les menus quand le contexte est clair ;
- interface compacte pour l’inventaire, l’équipement et la boutique.

Correction importante depuis `v0.2` :

- les héros sont identifiés visuellement par emplacement de groupe ;
- cela évite les bugs avec plusieurs héros identiques ou de même classe.

---

### 4.16 Menu d’aventure

Le menu d’aventure est fonctionnel.

Commandes actuelles :

- Inventaire ;
- Grimoire ;
- Statut ;
- Boutique si le joueur est sur une case `B` ;
- Menu.

Sous-menu système :

- Sauvegarder ;
- Options ;
- Quitter ;
- Retour.

État actuel :

- sauvegarde fonctionnelle ;
- options audio fonctionnelles ;
- quitter fonctionnel ;
- inventaire fonctionnel ;
- statut fonctionnel ;
- équipement fonctionnel depuis statut ;
- boutique achat / vente fonctionnelle ;
- grimoire encore placeholder.

Le menu est désactivé pendant les combats.

---

### 4.17 Outil temporaire de développement — Téléportation

Un outil temporaire de téléportation existe pour faciliter les tests.

Accès :

```text
Menu d’aventure → bouton T
```

Fonction :

- ouvre un panneau de saisie X / Y ;
- préremplit la position actuelle ;
- téléporte le groupe sur une case valide ;
- refuse les coordonnées hors carte ;
- refuse les cases non marchables ;
- refuse l’utilisation pendant un combat ;
- ne déclenche pas de rencontre aléatoire lors de la téléportation.

Ce système est uniquement destiné au développement.

Pour le désactiver rapidement :

```gdscript
const DEV_TELEPORT_ENABLED: bool = false
```

dans `InGameMenuPanelUI.gd`.

Pour le supprimer complètement avant une version finale :

- retirer les blocs liés à la téléportation temporaire dans `InGameMenuPanelUI.gd` ;
- retirer les blocs liés à la téléportation temporaire dans `Dungeon.gd` ;
- retirer les connexions / signaux liés à cette commande ;
- vérifier que le bouton `T` n’apparaît plus dans le menu ;
- tester une nouvelle partie et un chargement après suppression.

Priorité :

- garder tant que les tests de layout sont fréquents ;
- supprimer avant une version considérée comme proche d’une version finale ou publique propre.

---

### 4.18 Audio

Le système audio est fonctionnel.

Fonctions présentes :

- musique de titre ;
- musique d’exploration ;
- musique de combat ;
- crossfade ;
- volume musique sauvegardé ;
- volume SFX sauvegardé ;
- sons d’attaque ;
- sons de sort ;
- sons de soin ;
- sons de pas ;
- son de sauvegarde ;
- son de fuite.

Amélioration depuis `v0.2` :

- les musiques d’exploration et de combat peuvent démarrer à une mesure aléatoire ;
- cela évite que les thèmes recommencent toujours au début après une transition combat / exploration ;
- la musique de titre conserve son démarrage au début.

Priorité actuelle : faible.

---

### 4.19 Combat

Le combat est fonctionnel.

Fonctions présentes :

- rencontres aléatoires ;
- combat au tour par tour ;
- ordre des tours selon l’Agilité ;
- attaque physique ;
- magie offensive ;
- soin ;
- fuite ;
- riposte ennemie ;
- victoire ;
- défaite ;
- EXP ;
- drops ;
- ajout des drops à l’inventaire ;
- interaction indirecte avec l’équipement via les stats finales des héros.

Commandes actuelles :

- Attaquer ;
- Magie ;
- Soin ;
- Fuir.

Il n’y a pas de commande Défendre, par choix de design.

Limites actuelles :

- pas encore de vrai boss ;
- pas encore de combat fixe `F` ;
- pas encore de rencontres uniques vaincues et sauvegardées.

---

### 4.20 Rythme visuel des dégâts

Le rythme des dégâts a été amélioré.

Comportement actuel :

1. Le héros agit.
2. L’ennemi attaque.
3. Le héros touché passe en portrait damage.
4. Son cadre devient rouge.
5. Le joueur valide avec la touche d’action.
6. Le portrait revient en idle.
7. Le cadre rouge disparaît.
8. Le tour passe au héros suivant.

Cela rend le combat plus lisible et évite que le prochain héros actif soit affiché trop tôt.

---

### 4.21 Refactor combat déjà effectué

Le combat est mieux séparé qu’au départ.

Structure actuelle :

- `CombatManager.gd` → orchestre le combat ;
- `CombatTurnOrder.gd` → gère l’ordre des tours ;
- `CombatRewards.gd` → gère EXP et drops ;
- `MonsterDatabase.gd` → gère les monstres et les tables de rencontre ;
- `MonsterData.gd` → représente les données d’un monstre.

À extraire plus tard si nécessaire :

- `CombatActions.gd` ;
- `CombatTargeting.gd` ;
- `CombatAbilityResolver.gd` ;
- `FixedEncounterController.gd` ou équivalent si les rencontres fixes deviennent nombreuses.

Priorité actuelle : moyenne, mais pas urgente.

---

### 4.22 Monstres actuels

Monstres actuellement disponibles :

- Zombie ;
- Chauve-souris ;
- Gobelin ;
- Troll ;
- Gardien.

Sprites dédiés intégrés :

```text
assets/monsters/zombie/zombie_idle_01.png
assets/monsters/zombie/zombie_idle_02.png
assets/monsters/gobelin/gobelin_idle_01.png
assets/monsters/gobelin/gobelin_idle_02.png
assets/monsters/chauve_souris/chauve_souris_idle_01.png
assets/monsters/chauve_souris/chauve_souris_idle_02.png
assets/monsters/troll/troll_idle_01.png
assets/monsters/troll/troll_idle_02.png
assets/monsters/gardien/gardien_idle_01.png
assets/monsters/gardien/gardien_idle_02.png
```

Évolutions possibles :

- frame damage spécifique ;
- animation d’attaque ;
- taille / position par monstre ;
- effets visuels spécifiques ;
- variante boss du gardien.

---

### 4.23 Tables de rencontre

L’étage 1 possède sa table de rencontre initiale, avec une logique de danger parfois injuste.

L’étage 2 possède une table dédiée :

```text
Zombie : 20 %
Chauve-souris : 22 %
Gobelin : 28 %
Troll : 20 %
Gardien : 10 %
```

Philosophie :

- les ennemis dangereux peuvent apparaître tôt ;
- les taux d’apparition doivent rester maîtrisés ;
- les récompenses et lieux sûrs compensent partiellement la difficulté.

---

### 4.24 Loots

Les drops sont fonctionnels.

État actuel :

- les monstres possèdent une `loot_table` ;
- `CombatRewards` tire les drops ;
- les objets trouvés sont affichés dans le journal ;
- les objets sont ajoutés à l’inventaire ;
- les objets peuvent ensuite être équipés ou vendus, sauf objets de quête.

Intention de design :

- les ennemis donnent surtout de l’équipement ;
- les ennemis faibles donnent de l’équipement basique surtout utile à la revente ;
- les ennemis forts donnent de meilleurs objets avec des chances faibles ;
- les objets rares ne doivent pas être banalisés par la boutique.

---

### 4.25 Inventaire

L’inventaire commun est fonctionnel depuis `v0.3`.

Règles actuelles :

- inventaire commun au groupe ;
- 24 emplacements ;
- objets empilés par `item_id` ;
- 9 objets maximum par pile, sauf exception ;
- objets vides masqués ;
- message affiché si l’inventaire est vide ;
- drops ajoutés automatiquement après victoire ;
- récompenses de coffres ajoutées à l’inventaire ;
- sauvegarde et chargement de l’inventaire.

État particulier depuis `v0.7` :

- la Clé du gardien est un objet de quête ;
- elle a une pile maximale de 1 ;
- elle est consommée automatiquement à l’ouverture de la porte verrouillée correspondante ;
- elle est non vendable.

Évolutions possibles :

- tri ;
- filtres ;
- descriptions détaillées ;
- objets utilisables ;
- action “jeter” avec protection explicite des objets de quête ;
- signalement plus clair quand l’inventaire est plein.

Priorité actuelle : moyenne.

---

### 4.26 Base de données d’objets

`ItemDatabase.gd` est la source centrale des objets.

Données utilisées :

- `item_id` ;
- `display_name` ;
- `item_type` ;
- `description` ;
- `sell_value` ;
- `max_stack` ;
- `equipment_slot` ;
- `allowed_classes` ;
- `stat_bonuses`.

Rôle actuel :

- définir les objets dropés ;
- définir les objets de coffre ;
- définir les objets de quête ;
- définir les valeurs de vente ;
- définir les restrictions d’équipement ;
- centraliser les bonus de stats ;
- préparer l’achat en boutique.

Types importants :

```text
weapon
armor
shield
accessory
misc
quest
```

Règle :

- les objets de quête doivent rester non vendables et non jetables.

---

### 4.27 Équipement

L’équipement de base est fonctionnel depuis `v0.4`.

Accès :

```text
Menu d’aventure → Statut → bouton EQUIPEMENT d’un héros
```

Slots actuels :

- Arme ;
- Casque ;
- Armure ;
- Bouclier ;
- Bijou.

Règles actuelles :

- équiper un objet le retire de l’inventaire ;
- déséquiper un objet le remet dans l’inventaire ;
- remplacer un objet remet l’ancien dans l’inventaire si possible ;
- les objets incompatibles avec la classe ne sont pas proposés ;
- l’équipement est sauvegardé et restauré ;
- les bonus de stats sont plats et centralisés dans `ItemDatabase.gd`.

Stats concernées :

- Force ;
- Agilité ;
- Endurance ;
- Magie.

Limites actuelles :

- peu ou pas d’objets de type casque ;
- pas d’effets spéciaux ;
- pas de résistances ;
- pas de bonus conditionnels.

Priorité actuelle : moyenne.

---

## 5. Ce qui manque encore de fondamental

### 5.1 Boss du gardien

Le boss `X` de l’étage 2 est placé et protégé par une porte verrouillée, mais il n’est pas encore un vrai combat.

Objectif naturel :

```text
v0.7.1 — Boss du gardien
```

À faire :

- transformer le marqueur `X` en vrai déclencheur de boss ;
- créer ou adapter les données du boss ;
- empêcher les rencontres aléatoires sur la case boss ;
- sauvegarder l’état boss vaincu ;
- retirer ou transformer le `X` après victoire ;
- définir ce que donne la victoire : or, objet, ouverture de progression, message ou futur escalier actif ;
- conserver l’escalier `>` derrière le boss comme progression future si l’étage 3 n’existe pas encore.

Raison du versioning :

- le système de clé / porte / accès est déjà posé en `v0.7` ;
- ajouter le boss est une extension ciblée de ce système ;
- `v0.7.1` est donc plus cohérent que `v0.8`.

Priorité actuelle : très élevée.

---

### 5.2 Combats fixes non-boss

Le symbole `F` est réservé pour les combats fixes non-boss, mais il n’est pas encore implémenté.

À prévoir :

- définition par étage + coordonnée ;
- monstre ou groupe de monstres défini ;
- état vaincu sauvegardé ;
- remplacement du symbole après victoire ;
- aucun respawn si le design l’exige.

Priorité actuelle : moyenne, après le boss du gardien.

---

### 5.3 Étage 3 et progression après boss

L’escalier descendant derrière le boss de l’étage 2 existe visuellement, mais il ne mène pas encore à un étage 3.

À prévoir :

- création d’un étage 3 ;
- thème visuel éventuel ;
- table de rencontre dédiée ;
- logique d’activation de l’escalier après boss ;
- retour vers l’étage 2 ;
- contenu de transition.

Priorité actuelle : moyenne à élevée après `v0.7.1`.

---

### 5.4 Mort / défaite

La défaite existe dans le combat, mais il manque encore une conséquence claire.

À définir :

- retour menu principal ;
- chargement automatique ;
- écran Game Over ;
- perte partielle ;
- résurrection possible plus tard.

À court terme, un écran simple de défaite serait suffisant.

Priorité actuelle : moyenne.

---

### 5.5 Grimoire

Le menu Grimoire existe encore comme placeholder.

À terme, il devrait afficher :

- sorts connus ;
- sorts découverts mais niveau insuffisant ;
- coût en MP ;
- description ;
- classe concernée.

Priorité actuelle : moyenne.

---

### 5.6 Pièges, événements et passages secrets

Plusieurs symboles sont réservés mais non implémentés :

```text
P = piège
E = événement
S = passage secret
R = rune / sort visible
```

À prévoir plus tard :

- définition par coordonnées ;
- état persistant si nécessaire ;
- rendu 3D ;
- automap ;
- règles de non-blocage injuste.

Priorité actuelle : moyenne à basse, après boss / progression.

---

### 5.7 Polish UI — cadres texturés `NinePatchRect`

Objectif : remplacer progressivement les bordures générées en code par des cadres graphiques propres, compatibles avec plusieurs résolutions.

Éléments concernés :

- panneaux latéraux des héros ;
- cadres de portraits ;
- panneau central du donjon ;
- panneau du journal ;
- cadre de l’automap ;
- fenêtres du menu d’aventure ;
- sous-menus ;
- fenêtres d’inventaire ;
- fenêtres de statut ;
- fenêtres d’équipement ;
- boutique.

Approche technique :

- conserver la structure actuelle en `Control` / `Container` ;
- ajouter un `NinePatchRect` comme couche visuelle de fond ;
- garder les `Label`, `ProgressBar`, portraits et contenus au-dessus ;
- importer les textures UI en Nearest, sans filtre, sans mipmaps.

Priorité actuelle : moyenne / polish visuel.

---

## 6. Pistes d’amélioration des systèmes existants

### 6.1 `Dungeon.gd`

État actuel : fonctionnel, mais il orchestre beaucoup de systèmes.

Il gère encore :

- chargement d’étage ;
- états d’étage ;
- exploration ;
- automap ;
- découvertes de sorts ;
- coffres ;
- messages ;
- portes verrouillées ;
- UI ;
- déplacement ;
- temple ;
- boutique ;
- transitions d’étage ;
- téléportation temporaire de développement.

À ne pas extraire immédiatement tant que les systèmes changent vite.

Extractions possibles plus tard :

- `DungeonDiscoveryController.gd` → runes, coffres, messages, événements ;
- `DungeonFloorController.gd` → changements d’étages et états par étage ;
- `DungeonExplorationController.gd` → déplacement, portes, escaliers, rencontres ;
- `DungeonSpecialTileController.gd` → temple, boutique, lieux sûrs ;
- `DungeonLockedDoorController.gd` si les portes verrouillées deviennent nombreuses.

Priorité actuelle : faible à moyenne.

---

### 6.2 `CombatManager.gd`

État actuel : beaucoup plus propre qu’au départ.

Il reste encore plusieurs responsabilités :

- actions héros ;
- attaque ennemie ;
- calculs de dégâts ;
- choix de cible ;
- sorts disponibles ;
- coût en MP ;
- transmission des drops à l’inventaire.

Extractions futures possibles :

- `CombatActions.gd` ;
- `CombatTargeting.gd` ;
- `CombatAbilityResolver.gd` ;
- `BossEncounterController.gd` si les boss demandent une logique spécifique.

Priorité actuelle : moyenne, mais pas urgente.

---

### 6.3 `MonsterDatabase.gd`

État actuel : bon pour le prototype.

Améliorations futures :

- boss unique ;
- rencontres fixes ;
- variantes de monstres ;
- ennemis rares ;
- tables de rencontre par zone d’un même étage ;
- équilibrage après boss et étage 3.

Priorité actuelle : moyenne.

---

### 6.4 `CombatMonsterDisplayUI.gd`

État actuel : fonctionnel avec vrais sprites pour les monstres actuels.

Améliorations futures :

- animation damage spécifique ;
- animation d’attaque ;
- taille différente plus précise par monstre ;
- position différente selon taille ;
- effets particuliers pour certains ennemis ;
- sprite ou animation spécifique pour le boss du gardien si nécessaire.

Priorité actuelle : faible à moyenne.

---

### 6.5 `InGameMenuPanelUI.gd`

État actuel : centralise beaucoup d’écrans de menu.

Il gère actuellement :

- menu principal d’aventure ;
- inventaire ;
- statut ;
- équipement ;
- boutique ;
- sous-menu système ;
- outil temporaire de téléportation.

Ce fichier risque de devenir lourd.

Extractions possibles plus tard :

- `InventoryMenuUI.gd` ;
- `StatusMenuUI.gd` ;
- `EquipmentMenuUI.gd` ;
- `ShopMenuUI.gd` ;
- `DevTeleportMenuUI.gd`.

Priorité actuelle : moyenne, surtout avant d’ajouter des menus plus riches comme le Grimoire.

---

## 7. Ordre d’action recommandé

### Phase A — Finalisation post-v0.7

Objectif : vérifier que `v0.7` reste une base fiable.

À vérifier :

- nouvelle partie ;
- création d’équipe ;
- passage étage 1 → étage 2 ;
- retour étage 2 → étage 1 ;
- ouverture de coffres ;
- coffres ouverts persistants après sauvegarde / chargement ;
- lecture des messages `M` ;
- absence de rencontre aléatoire sur `M` ;
- récupération de la Clé du gardien ;
- clé non vendable ;
- ouverture de la porte verrouillée `L` ;
- disparition de la clé après ouverture ;
- porte ouverte persistante après sauvegarde / chargement ;
- automap cohérente.

Résultat attendu :

- `v0.7` est une base stable de contenu de donjon.

Priorité : très élevée jusqu’à validation complète.

---

### Phase B — `v0.7.1` Boss du gardien

Objectif : transformer le marqueur `X` de l’étage 2 en vrai boss.

À faire :

- définir les stats du boss ;
- déclencher le combat sur `X` ;
- bloquer les rencontres aléatoires sur `X` ;
- sauvegarder boss vaincu ;
- décider si `X` devient `.` ou autre symbole après victoire ;
- décider la récompense ;
- garder l’escalier `>` derrière le boss inactif si l’étage 3 n’est pas prêt.

Résultat attendu :

- la boucle clé → porte verrouillée → boss devient jouable.

Priorité : très élevée.

---

### Phase C — Stabilisation `v0.7.1` / ajustements mineurs

Objectif : corriger ou équilibrer le boss sans lancer immédiatement un gros chantier.

Possibles versions :

```text
v0.7.2 = équilibrage boss / récompense / sauvegarde
v0.7.3 = polish mineur lié à la zone boss
```

Priorité : selon les tests.

---

### Phase D — Progression vers étage 3 ou contenu fixe

Deux directions cohérentes :

#### Option 1 — Étage 3

But :

```text
Créer une nouvelle progression après le boss.
```

Avantage :

- renforce la boucle de progression verticale.

#### Option 2 — Combats fixes `F`

But :

```text
Ajouter des rencontres non aléatoires et persistantes.
```

Avantage :

- enrichit les étages existants sans créer tout de suite un nouvel étage.

Priorité : moyenne après `v0.7.1`.

---

### Phase E — Grimoire

Objectif : remplacer le placeholder du grimoire.

À faire :

- afficher les sorts connus ;
- afficher les coûts ;
- afficher les descriptions ;
- indiquer la classe concernée ;
- afficher les sorts découverts mais pas encore utilisables si souhaité.

Résultat attendu :

- le menu Grimoire devient utile.

Priorité : moyenne.

---

### Phase F — Polish UI

Objectif : améliorer la présentation générale sans casser la structure UI.

À faire :

- créer des cadres graphiques propres ;
- intégrer progressivement des `NinePatchRect` ;
- améliorer les panneaux existants ;
- préparer les fenêtres d’inventaire, grimoire, statut, équipement et boutique.

Résultat attendu :

- l’interface garde sa logique actuelle, mais gagne en finition visuelle.

Priorité : moyenne.

---

## 8. Priorités immédiates

### Très haute priorité

- stabiliser `v0.7` ;
- vérifier sauvegarde / chargement avec coffres, messages, clé et porte verrouillée ;
- préparer `v0.7.1 — Boss du gardien` ;
- garder `FLOOR_DESIGN.md` et `FLOOR_VISUALIZER.md` alignés avec les layouts réels.

### Haute priorité

- vrai combat de boss sur `X` ;
- état boss vaincu persistant ;
- récompense de boss ;
- comportement de l’escalier descendant derrière le boss ;
- équilibrage de l’étage 2 autour de la zone boss.

### Priorité moyenne

- combats fixes `F` ;
- écran de défaite / Game Over ;
- Grimoire ;
- événements simples ;
- passages secrets ;
- Statut enrichi ;
- polish UI ;
- animations damage / attaque des monstres.

### Priorité basse pour l’instant

- boutique avancée avec stock limité ;
- effets spéciaux d’équipement ;
- système économique complexe ;
- refactor important du combat ;
- suppression complète de l’outil téléportation tant que les tests de layout restent fréquents.

---

## 9. Architecture cible à court terme

Structure déjà présente ou recommandée :

```text
res://scripts/items/
  ItemData.gd
  ItemDatabase.gd

res://scripts/inventory/
  InventoryData.gd

res://scripts/equipment/
  EquipmentRules.gd

res://scripts/shop/
  ShopRules.gd

res://scripts/dungeon/
  FloorData.gd
  FloorDatabase.gd
  Dungeon.gd
  DungeonRenderer.gd
  DungeonThemeData.gd
```

À envisager si `Dungeon.gd` continue de grossir :

```text
res://scripts/dungeon/
  DungeonFloorController.gd
  DungeonDiscoveryController.gd
  DungeonSpecialTileController.gd
  DungeonLockedDoorController.gd
  DungeonEncounterController.gd
```

À envisager si `InGameMenuPanelUI.gd` continue de grossir :

```text
res://scripts/ui/menus/
  InventoryMenuUI.gd
  StatusMenuUI.gd
  EquipmentMenuUI.gd
  ShopMenuUI.gd
  DevTeleportMenuUI.gd
  GrimoireMenuUI.gd
```

À envisager pour les combats avancés :

```text
res://scripts/combat/
  CombatActions.gd
  CombatTargeting.gd
  CombatAbilityResolver.gd
  BossEncounterRules.gd
  FixedEncounterRules.gd
```

---

## 10. Notes de design à conserver

Décisions importantes :

- pas de commande Défendre ;
- combat dur et parfois injuste accepté ;
- les compensations doivent venir du donjon, pas d’un équilibrage trop doux ;
- les HP / MP restent en barres dans l’UI principale ;
- les chiffres détaillés restent dans les menus ;
- les monstres peuvent donner surtout de l’équipement ;
- les objets faibles servent surtout à la revente ;
- les objets rares ne doivent pas être rendus trop accessibles en boutique ;
- les objets de quête ne doivent pas être vendables ;
- les objets de quête ne doivent pas être jetables si une action “jeter” est ajoutée ;
- équipement retiré de l’inventaire quand équipé ;
- bonus d’équipement simples et centralisés dans `ItemDatabase.gd` ;
- éviter les gros systèmes avant que les bases soient stables ;
- conserver des scripts lisibles, commentés et découpés par responsabilité ;
- préférer une progression modulaire plutôt qu’un gros chantier unique ;
- garder `FLOOR_DESIGN.md` comme référence pour tout nouveau symbole de layout ;
- garder `FLOOR_VISUALIZER.md` comme outil de validation des placements ;
- l’outil de téléportation est temporaire et ne doit pas rester dans une version finale.

Décisions de nomenclature :

```text
M = message / PNJ neutre / indication
F = combat fixe non-boss
X = boss / rencontre majeure
C = coffre
L = porte verrouillée
S = passage secret
```

Décisions de placement :

- temple `O` derrière porte, en alcôve ou bout de couloir ;
- boutique `B` derrière porte, en alcôve ou bout de couloir ;
- temple et boutique orientés visuellement vers leur porte d’accès ;
- boss loin du départ et du temple ;
- coffre important placé dans une impasse ou zone exploratoire ;
- ne pas placer de coffre sur une case de découverte de sort.

---

## 11. Historique détaillé des versions

### v0.1 — Base stable initiale

Contenu principal :

- menu principal ;
- création de groupe ;
- exploration ;
- combat ;
- sauvegarde / chargement ;
- automap ;
- audio de base ;
- premiers monstres et drops simples.

Rôle :

- point de retour stable initial.

---

### v0.2 — Temple de guérison, audio amélioré et sprites monstres

Contenu principal :

- temple de guérison ;
- restauration gratuite et réutilisable des PV / PM ;
- absence de rencontre aléatoire sur le temple ;
- amélioration audio combat / exploration ;
- démarrage aléatoire par mesure pour musiques exploration / combat ;
- correction du bug de portraits avec héros identiques ;
- sprites dédiés pour Gobelin, Chauve-souris, Troll et Gardien ;
- intégration complète des sprites monstres dans `CombatMonsterDisplayUI.gd`.

Rôle :

- améliorer l’exploration, le combat et la lisibilité visuelle.

---

### v0.3 — Inventaire minimal

Contenu principal :

- inventaire commun au groupe ;
- 24 emplacements ;
- piles de 9 ;
- drops ajoutés à l’inventaire ;
- sauvegarde / chargement de l’inventaire ;
- affichage simplifié de l’inventaire ;
- base `ItemDatabase.gd`.

Rôle :

- rendre les drops réellement persistants et visibles.

---

### v0.4 — Équipement de base

Contenu principal :

- panneau d’équipement par héros ;
- accès depuis le Statut via bouton `EQUIPEMENT` ;
- slots Arme, Casque, Armure, Bouclier, Bijou ;
- restrictions par classe ;
- bonus plats de stats ;
- équipement retiré de l’inventaire ;
- sauvegarde / chargement de l’équipement ;
- ajustements UI Statut / Équipement / Inventaire.

Rôle :

- rendre les objets utilisables par les héros.

---

### v0.5-unstable-shop — Boutique de vente, documentation d’étage et outil de test

Contenu principal :

- case boutique `B` ;
- première boutique de vente ;
- ajout de l’or ;
- sauvegarde / chargement de l’or ;
- affichage de l’or dans l’inventaire ;
- rendu 3D boutique ;
- boutique affichée sur l’automap ;
- `FLOOR_DESIGN.md` ;
- outil temporaire de téléportation ;
- ajustements UI du menu d’aventure.

Rôle :

- poser les bases économiques et documenter la conception des étages.

Statut :

- version marquée comme instable côté boutique, car plusieurs systèmes ont été ajoutés rapidement.

---

### v0.5.1 — Correctif stats héros

Contenu principal :

- correction du bug où les stats des héros retombaient à `1 / 1 / 1 / 1` ;
- conservation correcte du roll de création comme stats de base ;
- compatibilité avec les bonus d’équipement ;
- prise de niveau confirmée fonctionnelle.

Rôle :

- stabiliser l’interaction entre statistiques de base et équipement.

---

### v0.5.2 — Achat en boutique

Contenu principal :

- achat d’objets en boutique ;
- stock infini d’objets basiques ;
- prix d’achat basé sur `sell_value × 4` ;
- refus si or insuffisant ;
- refus si inventaire plein ;
- écrans Acheter / Vendre / Retour menu ;
- or affiché dans un cadre compact en boutique ;
- message d’accès à la boutique restauré sur case `B`.

Rôle :

- compléter la première boucle économique simple.

---

### v0.6 — Transition vers l’étage 2

Contenu principal :

- ajout de l’étage 2 ;
- transition étage 1 → étage 2 via `>` ;
- arrivée sur `<` à la même coordonnée que le `>` de l’étage 1 ;
- table de rencontre dédiée à l’étage 2 ;
- symbole `X` pour préparer le futur boss ;
- escalier descendant futur derrière le boss ;
- temple et boutique sur l’étage 2 derrière portes ;
- automap compatible avec les nouveaux symboles.

Rôle :

- poser la première vraie progression d’étage.

---

### v0.6.1 — Stabilisation multi-étages

Contenu principal :

- retour étage 2 → étage 1 via `<` ;
- retour sur le `>` de l’étage précédent ;
- stabilisation sauvegarde / chargement depuis l’étage 2 ;
- mémoire d’état par étage ;
- portes ouvertes mémorisées séparément par étage ;
- cellules découvertes mémorisées séparément par étage ;
- compatibilité conservée avec les anciennes sauvegardes.

Rôle :

- transformer la transition d’étage en base stable.

---

### v0.7 — Coffres, indices et clé du gardien

Contenu principal :

- symbole `C` pour les coffres ;
- coffres persistants par étage ;
- récompenses de coffre en or, objets et objet de quête ;
- symbole `M` pour messages, inscriptions, PNJ neutres et indices ;
- messages sans déclenchement de combat ;
- symbole `L` pour porte verrouillée ;
- Clé du gardien ;
- coffre spécial à l’étage 2 en `Vector2i(1, 13)` contenant la Clé du gardien ;
- porte boss de l’étage 2 verrouillée par cette clé ;
- consommation automatique de la clé à l’ouverture ;
- objet de quête non vendable ;
- automap mise à jour ;
- rendu 3D simple pour coffres, messages et portes verrouillées ;
- documentation `FLOOR_DESIGN.md` et `FLOOR_VISUALIZER.md` mise à jour.

Rôle :

- enrichir l’exploration avec du contenu persistant et préparer le boss du gardien.

---

## 12. Checklist de test après changements importants

Après chaque ajout système, tester au minimum :

```text
[ ] Nouvelle partie
[ ] Création de 4 héros
[ ] Vérification des stats après entrée dans le donjon
[ ] Combat simple
[ ] Gain d’EXP
[ ] Prise de niveau si possible
[ ] Drop ajouté à l’inventaire
[ ] Inventaire visible
[ ] Équipement / déséquipement
[ ] Statut mis à jour
[ ] Vente boutique si concerné
[ ] Achat boutique si concerné
[ ] Or mis à jour
[ ] Sauvegarde
[ ] Chargement
[ ] Vérification inventaire / équipement / or / stats après chargement
[ ] Déplacement étage 1 → étage 2
[ ] Déplacement étage 2 → étage 1
[ ] Vérification état des portes par étage
[ ] Vérification automap par étage
[ ] Déplacement sur temple
[ ] Déplacement sur boutique
[ ] Absence de rencontre sur lieux sûrs
[ ] Ouverture coffre si concerné
[ ] Coffre ouvert persistant après sauvegarde / chargement
[ ] Message M lisible si concerné
[ ] Message M sans combat ni rencontre aléatoire
[ ] Porte verrouillée si concerné
[ ] Clé consommée si concerné
[ ] Objet de quête non vendable si concerné
[ ] Boss / combat fixe si concerné
```

---

## 13. Checklist spécifique avant `v0.7.1`

Avant de coder le boss du gardien :

```text
[ ] Confirmer que v0.7 est bien taggé et publié.
[ ] Confirmer que la porte L du boss reste ouverte après sauvegarde / chargement.
[ ] Confirmer que la Clé du gardien disparaît après ouverture.
[ ] Confirmer que le coffre de clé ne peut pas redonner la clé.
[ ] Confirmer que X ne déclenche pas encore de combat dans v0.7.
[ ] Définir les stats du boss.
[ ] Définir la récompense du boss.
[ ] Décider ce que devient X après victoire.
[ ] Décider si l’escalier derrière le boss reste inactif ou affiche un nouveau message.
[ ] Mettre à jour FLOOR_DESIGN.md si le boss ajoute une nouvelle règle.
[ ] Mettre à jour FLOOR_VISUALIZER.md si le layout change.
```
