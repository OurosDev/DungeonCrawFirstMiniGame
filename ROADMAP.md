# Feuille de route du projet — DungeonCrawFirstMiniGame

## 1. Objectif général du projet

Créer un dungeon crawler rétro en vue subjective, inspiré de l’esprit old-school :

- exploration case par case ;
- groupe de quatre héros ;
- combats au tour par tour ;
- progression par étage ;
- danger parfois injuste ;
- outils de récupération, de préparation et de gestion pour compenser cette difficulté.

Le projet doit rester simple, lisible et modulaire.

Les systèmes doivent être ajoutés progressivement, sans rendre les scripts principaux trop lourds.  
Les grosses fonctionnalités doivent être validées par étapes, avec des releases servant de points de retour stables.

---

## 2. Version actuelle et logique de versioning

### 2.1 Version de continuation actuelle

Version actuelle à utiliser comme base de travail :

```text
v0.5.1
```

Cette version corrige le bug critique où les statistiques des héros pouvaient retomber à `1 / 1 / 1 / 1` après la création d’équipe ou le chargement, à cause de l’interaction entre `base_stats`, `stats` et le système d’équipement.

### 2.2 Releases importantes

```text
v0.1 = base stable initiale
v0.2 = temple + audio amélioré + sprites monstres + correction portraits
v0.3 = inventaire minimal fonctionnel
v0.4 = équipement de base stable
v0.5-unstable-shop = première boutique de vente + or + FLOOR_DESIGN + outil dev téléportation
v0.5.1 = hotfix stats héros, base actuelle corrigée
```

### 2.3 Règle de versioning

Ne pas considérer que `v1.0` arrive automatiquement après `v0.9`.

Le projet peut continuer en versions pré-1.0 :

```text
v0.6
v0.7
v0.8
v0.9
v0.10
v0.11
...
```

`v1.0` doit rester réservé à une version vraiment complète, avec une boucle de jeu solide, plusieurs étages, une progression claire, un système économique stabilisé, une gestion de la défaite, et un niveau de polish minimum.

Pour les corrections ou extensions mineures d’un système déjà posé :

```text
v0.5.1
v0.5.2
v0.6.1
...
```

---

## 3. Structure générale du projet

Le projet possède actuellement trois grandes scènes principales :

- `MainMenu.tscn`
- `PartyCreation.tscn`
- `Dungeon.tscn`

La scène `Dungeon.tscn` est le cœur du jeu en exploration et combat.  
Elle orchestre les systèmes principaux sans tout gérer directement.

Structure attendue de la scène Donjon :

```text
Dungeon
Player
Camera3D
GameUI
CombatManager
DungeonRenderer
```

Le dépôt contient aussi maintenant un document de conception d’étage :

```text
FLOOR_DESIGN.md
```

Ce document définit les normes de layout ASCII, les symboles utilisés, les symboles réservés, et les règles à suivre avant d’ajouter un nouveau type de case.

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

Depuis `v0.5.1`, les stats issues du roll de création sont correctement conservées comme statistiques de base, même avec le système d’équipement.

---

### 4.3 Session de jeu

`GameSession.gd` fonctionne comme passerelle entre les scènes.

Fonctions présentes :

- stocker le groupe ;
- stocker l’étage courant ;
- stocker l’inventaire courant ;
- stocker l’or du groupe ;
- préparer une nouvelle partie ;
- transporter les données de sauvegarde chargée.

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
- portes ouvertes ;
- cellules découvertes de l’automap ;
- inventaire ;
- or du groupe.

Restrictions déjà en place :

- sauvegarde impossible pendant un combat.

La logique générale :

- `SaveManager.gd` → lit et écrit le fichier JSON ;
- `DungeonSaveController.gd` → demande une sauvegarde et applique les données chargées au donjon ;
- `Dungeon.gd` → appelle simplement le contrôleur.

À prévoir plus tard :

- sauvegarde des coffres ouverts ;
- sauvegarde des rencontres fixes vaincues ;
- sauvegarde des événements uniques déclenchés ;
- sauvegarde des portes verrouillées ouvertes ;
- sauvegarde des passages secrets découverts.

---

### 4.5 Donjon et exploration

L’exploration est fonctionnelle.

Fonctions présentes :

- déplacement case par case ;
- rotation gauche / droite ;
- portes fermées ;
- ouverture automatique des portes ;
- portes ouvertes conservées dans la sauvegarde ;
- escaliers détectés ;
- rencontres aléatoires ;
- temple de guérison ;
- boutique de vente ;
- outil temporaire de téléportation pour le développement.

Le rendu du donjon est en place :

- murs en briques ;
- sol / plafond ;
- portes fermées ;
- portes ouvertes ;
- brouillard de profondeur ;
- thème visuel d’étage ;
- rendu spécifique du temple de guérison ;
- rendu spécifique de la boutique.

Le rendu est géré par :

- `DungeonRenderer.gd`
- `DungeonThemeData.gd`
- `FloorData.gd`
- `FloorDatabase.gd`

---

### 4.6 Normes de conception des étages

Le projet possède maintenant :

```text
FLOOR_DESIGN.md
```

Ce document sert de référence avant d’ajouter de nouveaux symboles dans les layouts ASCII.

Symboles actuellement utilisés :

```text
#  mur
.  sol
D  porte fermée
d  porte ouverte runtime
>  escalier descendant
<  escalier montant prévu / partiellement pris en charge
O  temple de guérison
B  boutique
```

Symboles réservés ou prévus :

```text
C  coffre
P  piège
E  événement
M  rencontre fixe
R  rune / découverte magique visible
L  porte verrouillée
S  passage secret
```

Règle importante :

Tout nouveau symbole doit être ajouté à `FLOOR_DESIGN.md`, puis intégré dans les systèmes concernés :

- `FloorDatabase.gd`
- `Dungeon.gd`
- `DungeonRenderer.gd`
- `AutoMapUI.gd`
- `SaveManager.gd` si l’état doit persister.

---

### 4.7 Temple de guérison

Le temple de guérison est fonctionnel depuis `v0.2`.

Symbole utilisé dans le layout :

```text
O
```

Comportement actuel :

- restaure tous les PV et PM du groupe ;
- gratuit ;
- réutilisable ;
- ne déclenche pas de rencontre aléatoire sur sa case ;
- visible dans la vue donjon ;
- visible sur l’automap ;
- rendu orienté vers l’ouest sur l’étage actuel.

Fichiers concernés :

- `FloorDatabase.gd`
- `Dungeon.gd`
- `DungeonRenderer.gd`
- `AutoMapUI.gd`

Évolution possible plus tard :

- temple à usage limité ;
- coût en offrande ;
- restauration partielle ;
- temple différent selon l’étage ;
- sauvegarde d’un état “déjà utilisé” si le design change.

Priorité actuelle : faible.

---

### 4.8 Boutique de vente

La première boutique est fonctionnelle depuis `v0.5-unstable-shop`.

Symbole utilisé dans le layout :

```text
B
```

Comportement actuel :

- case marchable ;
- ne déclenche pas de rencontre aléatoire ;
- visible sur l’automap ;
- rendue en 3D comme un petit comptoir de marchand ;
- orientée vers l’ouest sur l’étage actuel ;
- donne accès au menu Boutique uniquement quand le joueur est sur la case `B`.

Fonctions actuelles :

- vendre des objets de l’inventaire ;
- gagner de l’or selon la valeur de vente définie dans `ItemDatabase.gd` ;
- sauvegarder et charger l’or ;
- afficher l’or dans l’inventaire.

Limites actuelles :

- pas encore d’achat ;
- pas encore d’inventaire marchand ;
- pas encore de stock limité ;
- pas encore de services de boutique ;
- système encore considéré comme récent / à stabiliser.

Priorité actuelle : moyenne à élevée.

Prochaine évolution naturelle :

```text
v0.5.2 ou v0.6 selon l’ampleur :
- ajout de l’achat d’objets basiques ;
- inventaire marchand simple ;
- prix d’achat basé sur sell_value × multiplicateur ;
- refus d’achat si inventaire plein ;
- garder les objets rares hors boutique.
```

---

### 4.9 Automap

L’automap est fonctionnelle.

Fonctions présentes :

- découverte progressive ;
- affichage centré sur le joueur ;
- murs ;
- portes fermées ;
- portes ouvertes ;
- escaliers ;
- temple de guérison ;
- boutique ;
- orientation du joueur.

La carte découverte est sauvegardée et restaurée.

---

### 4.10 Interface de jeu

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
- la classe n’est pas affichée en permanence dans les panneaux ;
- les portraits communiquent la classe ;
- les menus internes doivent éviter les titres redondants quand le contexte est déjà clair.

Correction importante depuis `v0.2` :

- les héros sont identifiés visuellement par emplacement de groupe ;
- cela évite les bugs quand plusieurs héros identiques ou de même classe sont présents dans l’équipe.

---

### 4.11 Menu d’aventure

Le menu d’aventure est fonctionnel.

Commandes actuelles :

- Inventaire ;
- Grimoire ;
- Statut ;
- Boutique si le joueur est sur une case boutique ;
- Menu.

Sous-menu système :

- Sauvegarder ;
- Options ;
- Quitter ;
- Retour.

État actuel :

- Sauvegarde fonctionnelle ;
- Options audio fonctionnelles ;
- Quitter fonctionnel ;
- Inventaire fonctionnel ;
- Statut fonctionnel ;
- Équipement fonctionnel depuis Statut ;
- Boutique de vente fonctionnelle sur case `B` ;
- Grimoire placeholder.

Le menu est désactivé pendant les combats.

Le titre `MENU D’AVENTURE` a été retiré pour libérer de l’espace et alléger l’interface.

---

### 4.12 Outil temporaire de développement — Téléportation

Un outil temporaire de téléportation existe pour faciliter les tests.

Accès :

```text
Menu d’aventure → bouton T en haut à gauche
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

- retirer le bloc de téléportation temporaire dans `InGameMenuPanelUI.gd` ;
- retirer le bloc de téléportation temporaire dans `Dungeon.gd` ;
- retirer les connexions / signaux liés à cette commande ;
- vérifier que le bouton `T` n’apparaît plus dans le menu ;
- tester une nouvelle partie et un chargement après suppression.

Priorité :

- garder tant que les tests de donjon sont fréquents ;
- supprimer avant toute release considérée comme proche d’une version finale ou publique propre.

---

### 4.13 Audio

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

### 4.14 Combat

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

---

### 4.15 Rythme visuel des dégâts

Le rythme des dégâts a été amélioré.

Comportement actuel :

1. Le héros agit.
2. L’ennemi attaque.
3. Le héros touché passe en portrait damage.
4. Son cadre devient rouge.
5. Le joueur doit valider avec la touche d’action.
6. Le portrait revient en idle.
7. Le cadre rouge disparaît.
8. Le tour passe au héros suivant.

Cela rend le combat plus lisible et évite que le prochain héros actif soit affiché trop tôt.

Correction importante :

- l’état visuel des héros est suivi par slot de groupe ;
- cela corrige le bug des groupes composés de plusieurs héros identiques.

---

### 4.16 Refactor combat déjà effectué

Le combat est mieux séparé qu’au départ.

Structure actuelle :

- `CombatManager.gd` → orchestre le combat ;
- `CombatTurnOrder.gd` → gère l’ordre des tours ;
- `CombatRewards.gd` → gère EXP et drops ;
- `MonsterDatabase.gd` → gère les monstres et la table de rencontre ;
- `MonsterData.gd` → représente les données d’un monstre.

À extraire plus tard si nécessaire :

- `CombatActions.gd`
- `CombatTargeting.gd`
- `CombatAbilityResolver.gd`

Priorité actuelle : moyenne, mais pas urgente.

---

### 4.17 Monstres actuels

Liste actuelle des monstres de l’étage 1 :

- Zombie ;
- Chauve-souris ;
- Gobelin ;
- Troll ;
- Gardien.

Table de rencontre actuelle :

- Zombie : 42 %
- Chauve-souris : 30 %
- Gobelin : 18 %
- Troll : 8 %
- Gardien : 2 %

Philosophie :

- danger parfois injuste ;
- monstre fort possible dès le début ;
- taux d’apparition faible pour les ennemis très dangereux.

---

### 4.18 Loots actuels

Les drops sont fonctionnels.

État actuel :

- les monstres possèdent une `loot_table` ;
- `CombatRewards` tire les drops ;
- les objets trouvés sont affichés dans le journal ;
- les objets sont ajoutés à l’inventaire ;
- les objets peuvent ensuite être équipés ou vendus.

Intention de design :

- les ennemis donnent surtout de l’équipement ;
- les ennemis faibles donnent de l’équipement basique surtout utile à la revente ;
- les ennemis forts donnent de meilleurs objets avec des chances faibles.

---

### 4.19 Visuels de monstres

Les vrais sprites des monstres de l’étage 1 sont intégrés depuis `v0.2`.

Monstres avec sprites dédiés :

- Zombie ;
- Gobelin ;
- Chauve-souris ;
- Troll ;
- Gardien.

Structure utilisée :

```text
assets/monsters/zombie/
assets/monsters/gobelin/
assets/monsters/chauve_souris/
assets/monsters/troll/
assets/monsters/gardien/
```

Chaque monstre utilise actuellement deux frames idle :

- `*_idle_01.png`
- `*_idle_02.png`

`CombatMonsterDisplayUI.gd` charge les sprites dédiés de chaque monstre.

Évolutions possibles plus tard :

- frame damage spécifique ;
- animation d’attaque par type de monstre ;
- position ou taille plus fine par monstre ;
- effets visuels spécifiques pour certains ennemis.

Priorité actuelle : faible à moyenne.

---

### 4.20 Inventaire

L’inventaire minimal est fonctionnel depuis `v0.3`.

Règles actuelles :

- inventaire commun au groupe ;
- 24 emplacements ;
- objets empilés par `item_id` ;
- 9 objets maximum par pile ;
- objets vides masqués ;
- message affiché si l’inventaire est vide ;
- drops ajoutés automatiquement après victoire ;
- sauvegarde et chargement de l’inventaire.

Affichage :

```text
Épée rouillée              | 2
Bouclier fendu             | 1
Cape déchirée              | 3
```

Depuis la boutique :

- l’or du groupe est affiché dans un petit cadre compact ;
- le bouton `Retour menu` est présent.

Évolutions possibles :

- tri ;
- filtres ;
- description détaillée ;
- objets utilisables ;
- objets clés ;
- inventaire plein mieux signalé ;
- interface plus graphique.

Priorité actuelle : moyenne.

---

### 4.21 Base de données d’objets

`ItemDatabase.gd` est maintenant la source centrale des objets.

Données prévues / utilisées :

- `item_id`
- `display_name`
- `item_type`
- `description`
- `sell_value`
- `max_stack`
- `equipment_slot`
- `allowed_classes`
- `stat_bonuses`

Rôle actuel :

- définir les objets dropés ;
- définir les valeurs de vente ;
- définir les restrictions d’équipement ;
- centraliser les bonus de stats ;
- préparer l’achat en boutique.

Priorité actuelle :

- maintenir l’équilibrage ici autant que possible ;
- éviter de disperser les valeurs d’objets dans les autres scripts.

---

### 4.22 Équipement

L’équipement de base est fonctionnel depuis `v0.4`.

Accès :

```text
Menu d’aventure → Statut → bouton EQUIPEMENT d’un héros
```

Slots actuels par héros :

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

- aucun objet de type casque n’existe encore dans les drops actuels ;
- pas d’effets spéciaux d’équipement ;
- pas de résistances ;
- pas de bonus conditionnels ;
- pas d’affichage graphique avancé.

Priorité actuelle : moyenne.

---

## 5. Ce qui manque encore de fondamental

### 5.1 Achat en boutique

La boutique permet de vendre, mais pas encore d’acheter.

Objectif futur :

- inventaire marchand simple ;
- objets basiques disponibles ;
- prix d’achat basé sur `sell_value × multiplicateur` ;
- refus d’achat si l’inventaire est plein ;
- message clair dans le journal ou le panneau boutique.

Recommandation :

Ne pas vendre les objets rares ou très puissants en boutique.  
Les drops rares doivent garder leur valeur.

Priorité actuelle : élevée si l’on continue le système économique.

---

### 5.2 Transitions d’étage

Les escaliers sont détectés, mais la transition vers un nouvel étage n’est pas encore un vrai système complet.

À créer :

- passer à l’étage suivant ;
- créer un `FloorData` pour l’étage 2 ;
- charger un nouveau layout ;
- conserver le groupe ;
- conserver inventaire, or et équipement ;
- réinitialiser ou conserver certaines découvertes ;
- changer la table de rencontre selon l’étage ;
- sauvegarder l’étage courant correctement.

Priorité actuelle : élevée.

---

### 5.3 Progression du contenu

Il manque encore :

- plusieurs étages ;
- événements de donjon ;
- coffres ;
- pièges ;
- portes spéciales ;
- rencontres fixes ;
- boss ou mini-boss.

Priorité actuelle : moyenne à élevée après transition d’étage.

---

### 5.4 Mort / défaite

La défaite existe dans le combat, mais il manque une vraie conséquence claire.

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

### 5.6 Coffres, événements et lieux spéciaux

Les symboles sont réservés dans `FLOOR_DESIGN.md`, mais pas encore implémentés.

À prévoir :

- `C` coffre ;
- `P` piège ;
- `E` événement ;
- `M` rencontre fixe ;
- `L` porte verrouillée ;
- `S` passage secret ;
- `R` rune / découverte magique visible.

Priorité actuelle : moyenne, après transition d’étage ou achat boutique.

---

### 5.7 Polish UI — cadres texturés `NinePatchRect`

Objectif :

Remplacer progressivement les bordures générées en code par des cadres graphiques propres, compatibles avec plusieurs résolutions.

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
- utiliser des marges de patch pour éviter la déformation des coins ;
- importer les textures UI en Nearest, sans filtre, sans mipmaps.

États visuels à prévoir :

- cadre normal ;
- cadre actif ;
- cadre dégâts ;
- cadre mort ;
- flash esquive ;
- éventuellement cadre animé plus tard.

Priorité actuelle : moyenne / polish visuel.

Note :

Ne pas remplacer les containers par de simples images étirées.  
Les images doivent habiller l’UI, pas remplacer sa structure logique.

---

## 6. Pistes d’amélioration des systèmes existants

### 6.1 `Dungeon.gd`

État actuel : fonctionnel, mais il orchestre beaucoup de systèmes.

Il gère encore :

- chargement d’étage ;
- exploration ;
- automap ;
- découvertes de sorts ;
- UI ;
- déplacement ;
- temple ;
- boutique ;
- téléportation temporaire de développement.

À ne pas extraire immédiatement tant que les systèmes changent vite.

Extraction possible plus tard :

- `DungeonDiscoveryController.gd` → runes, coffres, pièges, événements ;
- `DungeonFloorController.gd` → changements d’étages ;
- `DungeonExplorationController.gd` → déplacement, portes, escaliers, rencontres ;
- `DungeonSpecialTileController.gd` → temple, boutique, lieux spéciaux.

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

- `CombatActions.gd` → attaque, magie, soin, fuite ;
- `CombatTargeting.gd` → choix des cibles ;
- `CombatAbilityResolver.gd` → sorts disponibles, coûts, effets.

Priorité actuelle : moyenne, mais pas urgente.

---

### 6.3 `MonsterDatabase.gd`

État actuel : bon pour le prototype.

Améliorations futures :

- tables de rencontres par étage ;
- variantes de monstres ;
- rencontres fixes ;
- ennemis rares ;
- monstres uniques ;
- équilibrage après achat boutique et étage 2.

Priorité actuelle : moyenne.

---

### 6.4 `CombatMonsterDisplayUI.gd`

État actuel : fonctionnel avec vrais sprites pour les monstres de l’étage 1.

Améliorations futures :

- animation damage spécifique ;
- animation d’attaque par type de monstre ;
- taille différente plus précise par monstre ;
- position différente selon taille ;
- effets particuliers pour certains ennemis.

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

Extraction possible plus tard :

- `InventoryMenuUI.gd`
- `StatusMenuUI.gd`
- `EquipmentMenuUI.gd`
- `ShopMenuUI.gd`
- `DevTeleportMenuUI.gd` si l’outil reste longtemps pendant le développement.

Priorité actuelle : moyenne, surtout si on ajoute l’achat boutique ou le grimoire.

---

## 7. Ordre d’action recommandé

### Phase recommandée A — Stabilisation post-boutique

Objectif :

S’assurer que `v0.5.1` est bien une base fiable.

À vérifier :

- nouvelle partie ;
- création d’équipe ;
- stats après entrée en donjon ;
- prise de niveau ;
- sauvegarde / chargement ;
- inventaire ;
- équipement ;
- vente boutique ;
- or après sauvegarde / chargement ;
- téléportation de test ;
- aucune rencontre sur temple ou boutique.

Résultat attendu :

Le projet reste stable après l’ajout de la boutique et le hotfix stats.

Priorité : très élevée.

---

### Phase recommandée B — Achat en boutique

Objectif :

Rendre la boutique plus complète.

À faire :

- définir l’inventaire marchand ;
- vendre uniquement du basique ;
- ajouter un prix d’achat ;
- refuser l’achat si l’inventaire est plein ;
- afficher l’or dans l’écran boutique ;
- ajouter un retour clair entre Achat / Vente.

Résultat attendu :

Le joueur peut acheter quelques objets de base sans rendre les drops rares inutiles.

Priorité : élevée.

---

### Phase recommandée C — Transition d’étage

Objectif :

Transformer l’escalier en vraie progression.

À faire :

- permettre de descendre à l’étage suivant ;
- créer `FloorData` pour l’étage 2 ;
- charger une nouvelle table de rencontre ;
- sauvegarder l’étage courant ;
- définir ce qui est conservé ou réinitialisé entre deux étages.

Résultat attendu :

Le joueur peut quitter l’étage 1 et arriver dans un nouvel étage.

Priorité : élevée.

---

### Phase recommandée D — Contenu de donjon

Objectif :

Enrichir l’exploration.

À faire :

- coffres ;
- pièges ;
- portes spéciales ;
- rencontres fixes ;
- runes supplémentaires ;
- événements simples ;
- mini-boss ou boss.

Résultat attendu :

Le donjon ne repose plus seulement sur les combats aléatoires.

Priorité : moyenne.

---

### Phase recommandée E — Grimoire

Objectif :

Remplacer le placeholder du grimoire.

À faire :

- afficher les sorts connus ;
- afficher les coûts ;
- afficher les descriptions ;
- indiquer la classe concernée ;
- afficher les sorts découverts mais pas encore utilisables si souhaité.

Résultat attendu :

Le menu Grimoire devient utile.

Priorité : moyenne.

---

### Phase recommandée F — Polish UI

Objectif :

Améliorer la présentation générale sans casser la structure UI.

À faire :

- créer des cadres graphiques propres ;
- intégrer progressivement des `NinePatchRect` ;
- améliorer les panneaux existants ;
- préparer les fenêtres d’inventaire, grimoire, statut, équipement et boutique.

Résultat attendu :

L’interface garde sa logique actuelle, mais gagne en finition visuelle.

Priorité : moyenne.

---

## 8. Priorités immédiates

### Très haute priorité

- stabiliser `v0.5.1` après le hotfix stats ;
- vérifier sauvegarde / chargement avec stats, équipement, inventaire et or ;
- documenter clairement l’outil temporaire de téléportation ;
- garder `FLOOR_DESIGN.md` à jour.

### Haute priorité

- achat en boutique ;
- transition d’étage ;
- étage 2 ;
- tables de rencontre par étage.

### Priorité moyenne

- écran de défaite / Game Over ;
- Grimoire ;
- coffres ;
- événements simples ;
- Statut enrichi ;
- polish UI ;
- animations damage des monstres.

### Priorité basse pour l’instant

- boutique avancée avec stock limité ;
- effets spéciaux d’équipement ;
- système économique complexe ;
- refactor important du combat ;
- boss avancés ;
- suppression complète de l’outil téléportation tant que les tests de layout restent fréquents.

---

## 9. Décision recommandée pour la prochaine session

Deux directions sont cohérentes.

### Option 1 — Stabilisation courte puis achat boutique

```text
v0.5.2 ou v0.6
```

But :

```text
Boutique complète minimale :
→ vendre
→ acheter du basique
→ prix d’achat clair
→ refus si inventaire plein
```

Avantage :

- complète le système économique commencé avec `v0.5`.

### Option 2 — Transition d’étage

```text
v0.6
```

But :

```text
Escalier réellement fonctionnel :
→ quitter étage 1
→ charger étage 2
→ changer table de rencontre
→ conserver groupe / inventaire / or / équipement
```

Avantage :

- commence la vraie progression du jeu.

Recommandation actuelle :

```text
Faire d’abord une petite passe de stabilisation sur v0.5.1,
puis choisir entre achat boutique et transition d’étage.
```

Si la boutique actuelle reste stable, l’achat est la suite la plus naturelle.  
Si l’objectif est de faire avancer la boucle de progression, l’étage 2 devient prioritaire.

---

## 10. Architecture cible à court terme

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
```

À envisager si `InGameMenuPanelUI.gd` devient trop lourd :

```text
res://scripts/ui/menus/
    InventoryMenuUI.gd
    StatusMenuUI.gd
    EquipmentMenuUI.gd
    ShopMenuUI.gd
```

À envisager pour les étages futurs :

```text
res://scripts/dungeon/
    DungeonFloorController.gd
    DungeonDiscoveryController.gd
    DungeonSpecialTileController.gd
```

---

## 11. Notes de design à conserver

Décisions importantes :

- pas de commande Défendre ;
- combat dur et parfois injuste accepté ;
- les compensations doivent venir du donjon, pas d’un équilibrage trop doux ;
- les HP / MP restent en barres dans l’UI principale ;
- les chiffres détaillés restent dans les menus ;
- les monstres peuvent donner surtout de l’équipement ;
- les objets faibles servent surtout à la revente ;
- les objets rares ne doivent pas être rendus trop accessibles en boutique ;
- équipement retiré de l’inventaire quand équipé ;
- bonus d’équipement simples et centralisés dans `ItemDatabase.gd` ;
- éviter les gros systèmes avant que les bases soient stables ;
- conserver des scripts lisibles, commentés et découpés par responsabilité ;
- préférer une progression modulaire plutôt qu’un gros chantier unique ;
- garder `FLOOR_DESIGN.md` comme référence pour tout nouveau symbole de layout ;
- l’outil de téléportation est temporaire et ne doit pas rester dans une version finale.

---

## 12. Historique détaillé des versions

### v0.1

Base stable du prototype.

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

Point de retour stable initial.

---

### v0.2

Version de stabilisation visuelle et confort.

Contenu principal :

- temple de guérison ;
- amélioration audio combat / exploration ;
- correction du bug de portraits avec héros identiques ;
- sprites dédiés pour Gobelin, Chauve-souris, Troll et Gardien ;
- intégration complète des sprites monstres dans `CombatMonsterDisplayUI.gd`.

Rôle :

Améliorer l’exploration, le combat et la lisibilité visuelle.

---

### v0.3

Version inventaire minimal.

Contenu principal :

- inventaire commun au groupe ;
- 24 emplacements ;
- piles de 9 ;
- drops ajoutés à l’inventaire ;
- sauvegarde / chargement de l’inventaire ;
- affichage simplifié de l’inventaire ;
- base `ItemDatabase.gd`.

Rôle :

Rendre les drops réellement persistants et visibles.

---

### v0.4

Version équipement de base stable.

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

Rendre les objets utilisables par les héros.

---

### v0.5-unstable-shop

Version boutique de vente et outils de conception.

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

Poser les bases économiques et documenter la conception des étages.

Statut :

Version marquée comme instable côté boutique, car plusieurs systèmes ont été ajoutés rapidement.

---

### v0.5.1

Hotfix stats héros.

Contenu principal :

- correction du bug où les stats des héros retombaient à `1 / 1 / 1 / 1` ;
- conservation correcte du roll de création comme stats de base ;
- compatibilité avec les bonus d’équipement ;
- prise de niveau confirmée fonctionnelle.

Rôle :

Base actuelle corrigée pour continuer le développement après `v0.5-unstable-shop`.

---

## 13. Checklist de test après changements importants

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
[ ] Or mis à jour
[ ] Sauvegarde
[ ] Chargement
[ ] Vérification inventaire / équipement / or / stats après chargement
[ ] Déplacement sur temple
[ ] Déplacement sur boutique
[ ] Absence de rencontre sur lieux sûrs
[ ] Automap cohérente
```

---

## 14. Notes de maintenance GitHub

À chaque push, séparer clairement :

```text
Nouveaux fichiers :
- ...

Fichiers mis à jour :
- ...

Assets ajoutés :
- ...

Assets mis à jour :
- ...

À ne pas pousser :
- *.zip
- .godot/
```

À chaque release :

- créer une sauvegarde zip locale du projet ;
- vérifier que la release correspond bien à un point de retour utile ;
- ne pas hésiter à nommer une release `unstable` si elle contient un système récent à stabiliser.
