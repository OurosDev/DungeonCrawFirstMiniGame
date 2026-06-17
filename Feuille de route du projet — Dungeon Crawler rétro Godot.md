# **Feuille de route du projet — Dungeon Crawler rétro Godot**

## **1\. Objectif général du projet**

Créer un dungeon crawler rétro en vue subjective, inspiré de l’esprit old-school : exploration case par case, groupe de quatre héros, combats au tour par tour, progression par étage, danger parfois injuste mais compensé par des outils de récupération, de préparation et de gestion.

Le projet doit rester simple, lisible et modulaire. Les systèmes doivent être ajoutés progressivement, sans rendre les scripts principaux trop lourds.

---

## **2\. État actuel du projet**

### **2.1 Structure générale en place**

Le projet possède actuellement trois grandes scènes principales :

MainMenu.tscn  
PartyCreation.tscn  
Dungeon.tscn

La scène `Dungeon.tscn` est devenue le cœur du jeu en exploration et combat. Elle orchestre les systèmes principaux sans tout gérer directement.

Structure attendue de la scène Donjon :

Dungeon  
  Player  
    Camera3D  
  GameUI  
  CombatManager  
  DungeonRenderer

---

## **3\. Systèmes fonctionnels actuellement**

### **3.1 Menu principal**

Le menu principal est fonctionnel.

Fonctions présentes :

\- Nouvelle partie  
\- Charger  
\- Options  
\- Quitter  
\- Musique de titre  
\- Réglages audio

Le menu peut lancer une nouvelle partie, charger une sauvegarde existante et modifier les volumes.

---

### **3.2 Création du groupe**

La création de groupe est fonctionnelle.

Fonctions présentes :

\- création de 4 héros  
\- choix de classe  
\- reroll des statistiques  
\- validation progressive du groupe  
\- retour au menu principal

Classes actuelles :

\- Guerrier  
\- Voleuse  
\- Mage  
\- Prêtresse

Statistiques actuelles :

\- Force  
\- Agilité  
\- Endurance  
\- Magie

Rôle actuel des statistiques :

Force  
→ dégâts physiques

Agilité  
→ ordre des tours

Endurance  
→ points de vie

Magie  
→ points de magie et puissance des sorts

---

### **3.3 Session de jeu**

`GameSession.gd` fonctionne comme passerelle entre les scènes.

Fonctions présentes :

\- stocker le groupe  
\- stocker l’étage courant  
\- préparer une nouvelle partie  
\- transporter les données de sauvegarde chargée

---

### **3.4 Sauvegarde et chargement**

Le système de sauvegarde est fonctionnel.

Données sauvegardées actuellement :

\- groupe  
\- noms des héros  
\- classes  
\- niveaux  
\- EXP  
\- statistiques  
\- HP / MP  
\- étage courant  
\- position du joueur  
\- layout de l’étage  
\- portes ouvertes  
\- cellules découvertes de l’automap

Restrictions déjà en place :

\- sauvegarde impossible pendant un combat

La logique a été clarifiée :

SaveManager.gd  
→ lit et écrit le fichier JSON

DungeonSaveController.gd  
→ demande une sauvegarde  
→ applique les données chargées au donjon

Dungeon.gd  
→ appelle simplement le contrôleur

---

### **3.5 Donjon et exploration**

L’exploration est fonctionnelle.

Fonctions présentes :

\- déplacement case par case  
\- rotation gauche / droite  
\- portes fermées  
\- ouverture automatique des portes  
\- portes ouvertes conservées dans la sauvegarde  
\- escaliers détectés  
\- rencontres aléatoires

Le rendu du donjon est déjà en place :

\- murs en briques  
\- sol / plafond  
\- portes fermées  
\- portes ouvertes  
\- brouillard de profondeur  
\- thème visuel d’étage

Le rendu est géré par :

DungeonRenderer.gd  
DungeonThemeData.gd  
FloorData.gd  
FloorDatabase.gd

---

### **3.6 Automap**

L’automap est fonctionnelle en version locale.

Fonctions présentes :

\- découverte progressive  
\- affichage centré sur le joueur  
\- murs  
\- portes fermées  
\- portes ouvertes  
\- escaliers  
\- orientation du joueur

La carte découverte est sauvegardée et restaurée.

---

### **3.7 Interface de jeu**

L’interface principale est fonctionnelle.

Éléments présents :

\- vue donjon centrale  
\- panneaux des héros  
\- portraits des classes  
\- barres HP / MP  
\- journal  
\- commandes de combat  
\- automap  
\- menu d’aventure

Choix d’interface déjà actés :

\- HP / MP affichés sous forme de barres dans l’interface principale  
\- pas de chiffres HP / MP pendant le combat  
\- la classe n’est pas affichée en permanence dans les panneaux  
\- les portraits communiquent la classe

---

### **3.8 Menu d’aventure**

Le menu d’aventure est fonctionnel.

Commandes actuelles :

\- Inventaire  
\- Grimoire  
\- Statut  
\- Menu

Sous-menu système :

\- Sauvegarder  
\- Options  
\- Quitter  
\- Retour

État actuel :

\- Sauvegarde fonctionnelle  
\- Options audio fonctionnelles  
\- Quitter fonctionnel  
\- Inventaire placeholder  
\- Grimoire placeholder  
\- Statut fonctionnel

Le menu est désactivé pendant les combats.

---

### **3.9 Audio**

Le système audio est fonctionnel.

Fonctions présentes :

\- musique de titre  
\- musique d’exploration  
\- musique de combat  
\- crossfade  
\- volume musique sauvegardé  
\- volume SFX sauvegardé  
\- sons d’attaque  
\- sons de sort  
\- sons de soin  
\- sons de pas  
\- son de sauvegarde  
\- son de fuite

---

### **3.10 Combat**

Le combat est fonctionnel.

Fonctions présentes :

\- rencontres aléatoires  
\- combat au tour par tour  
\- ordre des tours selon l’Agilité  
\- attaque physique  
\- magie offensive  
\- soin  
\- fuite  
\- riposte ennemie  
\- victoire  
\- défaite  
\- EXP  
\- drops affichés dans le journal

Commandes actuelles :

\- Attaquer  
\- Magie  
\- Soin  
\- Fuir

Il n’y a pas de commande Défendre, par choix de design.

---

### **3.11 Rythme visuel des dégâts**

Le rythme des dégâts a été amélioré.

Comportement actuel :

1\. Le héros agit  
2\. L’ennemi attaque  
3\. Le héros touché passe en portrait damage  
4\. Son cadre devient rouge  
5\. Le joueur doit valider avec la touche d’action  
6\. Le portrait revient en idle  
7\. Le cadre rouge disparaît  
8\. Le tour passe au héros suivant

Cela rend le combat plus lisible et évite que le prochain héros actif soit affiché trop tôt.

---

### **3.12 Refactor combat déjà effectué**

Le combat est maintenant mieux séparé.

Structure actuelle :

CombatManager.gd  
→ orchestre le combat

CombatTurnOrder.gd  
→ gère l’ordre des tours

CombatRewards.gd  
→ gère EXP et drops

MonsterDatabase.gd  
→ gère les monstres et la table de rencontre

MonsterData.gd  
→ représente les données d’un monstre

---

### **3.13 Monstres actuels**

Liste actuelle des monstres de l’étage 1 :

Zombie  
Chauve-souris  
Gobelin  
Troll  
Gardien

Table de rencontre actuelle :

Zombie          42 %  
Chauve-souris  30 %  
Gobelin         18 %  
Troll            8 %  
Gardien          2 %

Philosophie :

\- danger parfois injuste  
\- monstre fort possible dès le début  
\- taux d’apparition faible pour les ennemis très dangereux

---

### **3.14 Loots actuels**

Les drops existent en version simple.

État actuel :

\- les monstres possèdent une loot\_table  
\- CombatRewards tire les drops  
\- les objets trouvés sont affichés dans le journal  
\- les objets ne sont pas encore stockés dans un inventaire

Intention de design :

\- les ennemis donnent surtout de l’équipement  
\- les ennemis faibles donnent de l’équipement basique surtout utile à la revente  
\- les ennemis forts donnent de meilleurs objets avec des chances faibles

---

### **3.15 Visuels de monstres**

Le système d’identité visuelle est préparé.

État actuel :

\- Zombie utilise son vrai sprite  
\- les autres ennemis utilisent temporairement des portraits de héros comme placeholders  
\- visual\_id est prêt pour les futurs vrais sprites

Les vrais sprites de monstres seront générés plus tard, au cas par cas.

---

## **4\. Ce qui manque encore de fondamental**

### **4.1 Inventaire réel**

C’est l’un des prochains systèmes fondamentaux.

Actuellement :

\- les drops apparaissent dans le journal  
\- aucun objet n’est stocké

À créer :

InventoryData.gd  
ItemData.gd  
ItemDatabase.gd

Objectif minimal :

\- stocker item\_id \+ quantité  
\- afficher les objets dans le menu Inventaire  
\- sauvegarder l’inventaire

À ne pas faire immédiatement :

\- équipement actif complet  
\- boutique  
\- revente  
\- effets complexes d’objets

---

### **4.2 Base de données d’objets**

Les drops utilisent actuellement des `item_id` et des `display_name` directement dans les loot tables.

À terme, il faudra déplacer les vraies informations d’objet dans `ItemDatabase.gd`.

Données minimales d’un objet :

item\_id  
display\_name  
item\_type  
sell\_value  
description

Types possibles au départ :

weapon  
armor  
shield  
accessory  
misc

---

### **4.3 Système d’équipement**

Le jeu parle déjà d’équipement, mais les héros ne peuvent pas encore équiper d’objets.

À créer plus tard :

\- emplacements d’équipement  
\- restrictions par classe  
\- bonus d’attaque / défense / stats  
\- affichage de l’équipement dans le statut

Ce système ne doit pas être commencé avant que l’inventaire et ItemDatabase soient solides.

---

### **4.4 Boutique / revente**

Le loot d’équipement faible a besoin d’un usage.

Usage prévu :

\- objets faibles servent à la revente  
\- objets meilleurs peuvent être gardés

À créer plus tard :

\- boutique  
\- prix de vente  
\- prix d’achat  
\- interface de revente

Ce n’est pas prioritaire tant que l’inventaire n’existe pas.

---

### **4.5 Système de récupération dans le donjon**

Comme le jeu peut être injuste, il faudra une compensation.

Idée déjà retenue :

pièce temple  
→ restaure les PV dans l’étage

Variantes possibles :

\- restauration complète une fois par étage  
\- restauration partielle  
\- nécessite une offrande  
\- restaure seulement les héros vivants

À faire avant d’augmenter trop la difficulté.

---

### **4.6 Transitions d’étage**

Les escaliers sont détectés, mais la transition vers un nouvel étage n’est pas encore un vrai système.

À créer :

\- passer à l’étage suivant  
\- charger un nouveau FloorData  
\- conserver le groupe  
\- réinitialiser ou conserver certaines découvertes  
\- changer la table de rencontre selon l’étage

---

### **4.7 Progression du contenu**

Il manque encore :

\- plusieurs étages  
\- événements de donjon  
\- coffres  
\- pièges  
\- portes spéciales  
\- rencontres fixes  
\- boss ou mini-boss

---

### **4.8 Mort / défaite**

La défaite existe dans le combat, mais il manque une vraie conséquence.

À définir :

\- retour menu principal ?  
\- chargement automatique ?  
\- écran Game Over ?  
\- perte partielle ?  
\- résurrection possible plus tard ?

À court terme, un écran simple de défaite serait suffisant.

---

## **5\. Pistes d’amélioration des systèmes existants**

### **5.1 Dungeon.gd**

État actuel : sain.

Il orchestre encore :

\- chargement d’étage  
\- exploration  
\- automap  
\- découvertes de sorts  
\- UI  
\- déplacement

À ne pas extraire immédiatement.

Extraction possible plus tard :

DungeonDiscoveryController.gd  
→ runes, coffres, pièges, événements

DungeonFloorController.gd  
→ changements d’étages

DungeonExplorationController.gd  
→ déplacement, portes, escaliers, rencontres

Priorité actuelle : faible à moyenne.

---

### **5.2 CombatManager.gd**

État actuel : beaucoup plus propre.

Il reste encore plusieurs responsabilités :

\- actions héros  
\- attaque ennemie  
\- calculs de dégâts  
\- choix de cible  
\- sorts disponibles  
\- coût en MP

Extractions futures possibles :

CombatActions.gd  
→ attaque, magie, soin, fuite

CombatTargeting.gd  
→ choix des cibles

CombatAbilityResolver.gd  
→ sorts disponibles, coûts, effets

Priorité actuelle : moyenne, mais pas urgente.

---

### **5.3 MonsterDatabase.gd**

État actuel : bon pour le prototype.

Améliorations futures :

\- tables de rencontres par étage  
\- variantes de monstres  
\- rencontres fixes  
\- ennemis rares  
\- monstres uniques

Priorité actuelle : moyenne.

---

### **5.4 CombatMonsterDisplayUI.gd**

État actuel : prêt pour plusieurs visuels.

Améliorations futures :

\- vrais sprites pour chaque monstre  
\- animation damage spécifique  
\- animation d’attaque par type de monstre  
\- taille différente par monstre  
\- position différente selon taille

Priorité actuelle : moyenne, après validation de la liste des monstres.

---

### **5.5 Menu Inventaire**

État actuel : placeholder.

C’est probablement l’un des plus gros manques visibles maintenant.

Priorité actuelle : élevée.

---

### **5.6 Menu Grimoire**

État actuel : placeholder.

À terme, il devrait afficher :

\- sorts connus  
\- sorts découverts mais niveau insuffisant  
\- coût en MP  
\- description  
\- classe concernée

Priorité actuelle : moyenne.

---

### **5.7 Menu Statut**

État actuel : fonctionnel.

Améliorations futures :

\- afficher équipement équipé  
\- afficher valeurs exactes de stats dérivées  
\- afficher EXP / niveau suivant  
\- afficher effets actifs

Priorité actuelle : moyenne.

---

## **6\. Ordre d’action recommandé**

### **Phase 1 — Stabilisation des systèmes fondamentaux**

Objectif : rendre les drops réellement utiles.

Priorité 1 :

Créer ItemData.gd  
Créer ItemDatabase.gd  
Créer InventoryData.gd  
Ajouter inventaire à GameSession  
Sauvegarder / charger l’inventaire  
Faire apparaître les drops dans l’inventaire  
Afficher l’inventaire dans le menu

Résultat attendu :

Un objet obtenu en combat est stocké, sauvegardé, chargé et visible dans le menu Inventaire.

---

### **Phase 2 — Temple / récupération**

Objectif : compenser le danger élevé et les rencontres injustes.

À faire :

\- définir un symbole de carte pour le temple  
\- ajouter une position de temple dans FloorData  
\- détecter l’entrée dans la case temple  
\- restaurer les PV  
\- empêcher l’abus si temple à usage unique  
\- sauvegarder l’usage du temple

Résultat attendu :

Le joueur peut trouver une pièce temple et récupérer une partie ou la totalité de ses PV.

---

### **Phase 3 — Transition d’étage**

Objectif : transformer l’escalier en vraie progression.

À faire :

\- permettre de descendre à l’étage suivant  
\- créer FloorData pour l’étage 2  
\- charger une nouvelle table de rencontre  
\- sauvegarder l’étage courant

Résultat attendu :

Le joueur peut quitter l’étage 1 et arriver dans un nouvel étage.

---

### **Phase 4 — Vrais sprites de monstres**

Objectif : remplacer les placeholders.

Ordre recommandé :

1\. Zombie déjà existant  
2\. Chauve-souris  
3\. Gobelin  
4\. Troll  
5\. Gardien

Pour chaque monstre :

\- idle\_01  
\- idle\_02  
\- damage ou hit si nécessaire plus tard

Résultat attendu :

Chaque monstre a une silhouette claire et reconnaissable.

---

### **Phase 5 — Équipement actif**

Objectif : rendre certains drops réellement utilisables.

À faire :

\- définir les slots d’équipement  
\- équiper / déséquiper  
\- restrictions par classe  
\- appliquer bonus  
\- sauvegarder équipement équipé

Résultat attendu :

Un héros peut équiper une arme ou une armure et ses performances changent.

---

### **Phase 6 — Boutique / revente**

Objectif : donner une utilité aux drops faibles.

À faire :

\- créer une interface de boutique  
\- vendre les objets inutiles  
\- acheter équipement ou services  
\- stocker une monnaie

Résultat attendu :

Les objets basiques trouvés sur les ennemis deviennent utiles économiquement.

---

### **Phase 7 — Contenu de donjon**

Objectif : enrichir l’exploration.

À faire :

\- coffres  
\- pièges  
\- portes spéciales  
\- rencontres fixes  
\- runes supplémentaires  
\- événements simples

Résultat attendu :

Le donjon ne repose plus seulement sur les combats aléatoires.

## 6.1 Polish UI — cadres texturés NinePatchRect

Objectif :  
Remplacer progressivement les bordures générées en code par des cadres graphiques propres, compatibles avec plusieurs résolutions.

Éléments concernés :  
\- panneaux latéraux des héros  
\- cadres de portraits  
\- panneau central du donjon  
\- panneau du journal  
\- cadre de l’automap  
\- fenêtres du menu d’aventure  
\- sous-menus  
\- futures fenêtres d’inventaire / grimoire / statut

Approche technique :  
\- conserver la structure actuelle en Control / Container  
\- ajouter un NinePatchRect comme couche visuelle de fond  
\- garder les Labels, ProgressBar, portraits et contenus au-dessus  
\- utiliser des marges de patch pour éviter la déformation des coins  
\- importer les textures UI en Nearest, sans filtre, sans mipmaps

États visuels à prévoir :  
\- cadre normal  
\- cadre actif  
\- cadre dégâts  
\- cadre mort  
\- flash esquive  
\- éventuellement cadre animé plus tard

Priorité :  
Moyenne / polish visuel.

À faire après :  
\- inventaire minimal  
\- temple de soin  
\- transition d’étage  
\- stabilisation des systèmes fondamentaux

Note :  
Ne pas remplacer les containers par de simples images étirées. Les images doivent habiller l’UI, pas remplacer sa structure logique.

---

## **7\. Priorités immédiates**

Priorité très haute :

Inventaire minimal  
ItemDatabase minimal  
Sauvegarde de l’inventaire  
Affichage inventaire

Priorité haute :

Temple de soin  
Transition d’étage

Priorité moyenne :

Vrais sprites de monstres  
Grimoire  
Statut enrichi

Priorité basse pour l’instant :

Boutique  
Équipement complet  
Système économique  
Refactor supplémentaire du combat  
Coffres et pièges complexes

---

## **8\. Décision recommandée pour la prochaine session**

La prochaine étape la plus logique est :

Créer le système d’inventaire minimal.

But exact :

Quand un monstre droppe un objet :  
→ l’objet est ajouté à l’inventaire  
→ l’inventaire est sauvegardé  
→ l’inventaire est chargé  
→ le menu Inventaire affiche l’objet

Cette étape rendra les drops réellement fonctionnels sans encore ouvrir le chantier complexe de l’équipement.

---

## **9\. Architecture cible à court terme**

Structure recommandée :

res://scripts/items/  
  ItemData.gd  
  ItemDatabase.gd

res://scripts/inventory/  
  InventoryData.gd

Intégrations nécessaires :

GameSession.gd  
→ stocker l’inventaire courant

SaveManager.gd  
→ sauvegarder / charger l’inventaire

CombatRewards.gd  
→ renvoyer les dropped\_items

CombatManager.gd  
→ transmettre les drops à l’inventaire

InGameMenuPanelUI.gd  
→ afficher le contenu de l’inventaire

---

## **10\. Notes de design à conserver**

Décisions importantes à ne pas oublier :

\- pas de commande Défendre  
\- combat dur et parfois injuste accepté  
\- les compensations doivent venir du donjon, pas d’un équilibrage trop doux  
\- les HP/MP restent en barres dans l’UI principale  
\- les chiffres détaillés restent dans les menus  
\- les monstres peuvent donner uniquement de l’équipement  
\- les objets faibles servent surtout à la revente future  
\- les vrais visuels de monstres seront créés au cas par cas  
\- il faut éviter les gros systèmes avant que les bases soient stables

