# Feuille de route du projet — Dungeon Crawler rétro Godot

## 1. Objectif général du projet

Créer un dungeon crawler rétro en vue subjective, inspiré de l’esprit old-school :

* exploration case par case ;
* groupe de quatre héros ;
* combats au tour par tour ;
* progression par étage ;
* danger parfois injuste ;
* outils de récupération, de préparation et de gestion pour compenser la difficulté.

Le projet doit rester simple, lisible et modulaire.
Les systèmes doivent être ajoutés progressivement, sans rendre les scripts principaux trop lourds.

---

## 2. État actuel du projet

### 2.1 Version stable actuelle

Version stable actuelle :

* `v0.2`

La version `v0.1` reste le point de retour stable avant l’ajout du temple de guérison.

La version `v0.2` ajoute notamment :

* temple de guérison ;
* amélioration du comportement audio combat / exploration ;
* correction du bug d’affichage avec plusieurs héros identiques ;
* sprites dédiés pour les monstres de l’étage 1.

---

### 2.2 Structure générale en place

Le projet possède actuellement trois grandes scènes principales :

* `MainMenu.tscn`
* `PartyCreation.tscn`
* `Dungeon.tscn`

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

---

## 3. Systèmes fonctionnels actuellement

### 3.1 Menu principal

Le menu principal est fonctionnel.

Fonctions présentes :

* Nouvelle partie ;
* Charger ;
* Options ;
* Quitter ;
* musique de titre ;
* réglages audio.

Le menu peut lancer une nouvelle partie, charger une sauvegarde existante et modifier les volumes.

---

### 3.2 Création du groupe

La création de groupe est fonctionnelle.

Fonctions présentes :

* création de 4 héros ;
* choix de classe ;
* reroll des statistiques ;
* validation progressive du groupe ;
* retour au menu principal.

Classes actuelles :

* Guerrier ;
* Voleuse ;
* Mage ;
* Prêtresse.

Statistiques actuelles :

* Force ;
* Agilité ;
* Endurance ;
* Magie.

Rôle actuel des statistiques :

* Force → dégâts physiques ;
* Agilité → ordre des tours ;
* Endurance → points de vie ;
* Magie → points de magie et puissance des sorts.

---

### 3.3 Session de jeu

`GameSession.gd` fonctionne comme passerelle entre les scènes.

Fonctions présentes :

* stocker le groupe ;
* stocker l’étage courant ;
* préparer une nouvelle partie ;
* transporter les données de sauvegarde chargée.

---

### 3.4 Sauvegarde et chargement

Le système de sauvegarde est fonctionnel.

Données sauvegardées actuellement :

* groupe ;
* noms des héros ;
* classes ;
* niveaux ;
* EXP ;
* statistiques ;
* HP / MP ;
* étage courant ;
* position du joueur ;
* layout de l’étage ;
* portes ouvertes ;
* cellules découvertes de l’automap.

Restrictions déjà en place :

* sauvegarde impossible pendant un combat.

La logique a été clarifiée :

* `SaveManager.gd` → lit et écrit le fichier JSON ;
* `DungeonSaveController.gd` → demande une sauvegarde et applique les données chargées au donjon ;
* `Dungeon.gd` → appelle simplement le contrôleur.

À prévoir plus tard :

* sauvegarde de l’inventaire ;
* sauvegarde de l’équipement ;
* sauvegarde de certains états d’étage si nécessaire.

---

### 3.5 Donjon et exploration

L’exploration est fonctionnelle.

Fonctions présentes :

* déplacement case par case ;
* rotation gauche / droite ;
* portes fermées ;
* ouverture automatique des portes ;
* portes ouvertes conservées dans la sauvegarde ;
* escaliers détectés ;
* rencontres aléatoires ;
* temple de guérison.

Le rendu du donjon est déjà en place :

* murs en briques ;
* sol / plafond ;
* portes fermées ;
* portes ouvertes ;
* brouillard de profondeur ;
* thème visuel d’étage ;
* rendu spécifique du temple de guérison.

Le rendu est géré par :

* `DungeonRenderer.gd`
* `DungeonThemeData.gd`
* `FloorData.gd`
* `FloorDatabase.gd`

---

### 3.6 Temple de guérison

Le temple de guérison est fonctionnel depuis `v0.2`.

Symbole utilisé dans le layout :

```text
O
```

Comportement actuel :

* restaure tous les PV et PM du groupe ;
* gratuit ;
* réutilisable ;
* ne déclenche pas de rencontre aléatoire sur sa case ;
* visible dans la vue donjon ;
* visible sur l’automap.

Fichiers concernés :

* `FloorDatabase.gd`
* `Dungeon.gd`
* `DungeonRenderer.gd`
* `AutoMapUI.gd`

Évolution possible plus tard :

* temple à usage limité ;
* coût en offrande ;
* restauration partielle ;
* temple différent selon l’étage ;
* sauvegarde d’un état “déjà utilisé” si le design change.

Priorité actuelle : faible, système fonctionnel.

---

### 3.7 Automap

L’automap est fonctionnelle en version locale.

Fonctions présentes :

* découverte progressive ;
* affichage centré sur le joueur ;
* murs ;
* portes fermées ;
* portes ouvertes ;
* escaliers ;
* temple de guérison ;
* orientation du joueur.

La carte découverte est sauvegardée et restaurée.

---

### 3.8 Interface de jeu

L’interface principale est fonctionnelle.

Éléments présents :

* vue donjon centrale ;
* panneaux des héros ;
* portraits des classes ;
* barres HP / MP ;
* journal ;
* commandes de combat ;
* automap ;
* menu d’aventure.

Choix d’interface déjà actés :

* HP / MP affichés sous forme de barres dans l’interface principale ;
* pas de chiffres HP / MP pendant le combat ;
* la classe n’est pas affichée en permanence dans les panneaux ;
* les portraits communiquent la classe.

Correction importante depuis `v0.2` :

* les héros sont identifiés visuellement par emplacement de groupe ;
* cela évite les bugs quand plusieurs héros identiques ou de même classe sont présents dans l’équipe.

---

### 3.9 Menu d’aventure

Le menu d’aventure est fonctionnel.

Commandes actuelles :

* Inventaire ;
* Grimoire ;
* Statut ;
* Menu.

Sous-menu système :

* Sauvegarder ;
* Options ;
* Quitter ;
* Retour.

État actuel :

* Sauvegarde fonctionnelle ;
* Options audio fonctionnelles ;
* Quitter fonctionnel ;
* Inventaire placeholder ;
* Grimoire placeholder ;
* Statut fonctionnel.

Le menu est désactivé pendant les combats.

---

### 3.10 Audio

Le système audio est fonctionnel.

Fonctions présentes :

* musique de titre ;
* musique d’exploration ;
* musique de combat ;
* crossfade ;
* volume musique sauvegardé ;
* volume SFX sauvegardé ;
* sons d’attaque ;
* sons de sort ;
* sons de soin ;
* sons de pas ;
* son de sauvegarde ;
* son de fuite.

Amélioration depuis `v0.2` :

* les musiques d’exploration et de combat peuvent démarrer à une mesure aléatoire ;
* cela évite que les thèmes recommencent toujours au début après une transition combat / exploration ;
* la musique de titre conserve son démarrage au début.

Priorité actuelle : faible, système satisfaisant pour le prototype.

---

### 3.11 Combat

Le combat est fonctionnel.

Fonctions présentes :

* rencontres aléatoires ;
* combat au tour par tour ;
* ordre des tours selon l’Agilité ;
* attaque physique ;
* magie offensive ;
* soin ;
* fuite ;
* riposte ennemie ;
* victoire ;
* défaite ;
* EXP ;
* drops affichés dans le journal.

Commandes actuelles :

* Attaquer ;
* Magie ;
* Soin ;
* Fuir.

Il n’y a pas de commande Défendre, par choix de design.

---

### 3.12 Rythme visuel des dégâts

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

* l’état visuel des héros est maintenant suivi par slot de groupe ;
* cela corrige le bug des groupes composés de plusieurs héros identiques.

---

### 3.13 Refactor combat déjà effectué

Le combat est maintenant mieux séparé.

Structure actuelle :

* `CombatManager.gd` → orchestre le combat ;
* `CombatTurnOrder.gd` → gère l’ordre des tours ;
* `CombatRewards.gd` → gère EXP et drops ;
* `MonsterDatabase.gd` → gère les monstres et la table de rencontre ;
* `MonsterData.gd` → représente les données d’un monstre.

---

### 3.14 Monstres actuels

Liste actuelle des monstres de l’étage 1 :

* Zombie ;
* Chauve-souris ;
* Gobelin ;
* Troll ;
* Gardien.

Table de rencontre actuelle :

* Zombie : 42 %
* Chauve-souris : 30 %
* Gobelin : 18 %
* Troll : 8 %
* Gardien : 2 %

Philosophie :

* danger parfois injuste ;
* monstre fort possible dès le début ;
* taux d’apparition faible pour les ennemis très dangereux.

---

### 3.15 Loots actuels

Les drops existent en version simple.

État actuel :

* les monstres possèdent une `loot_table` ;
* `CombatRewards` tire les drops ;
* les objets trouvés sont affichés dans le journal ;
* les objets ne sont pas encore stockés dans un inventaire.

Intention de design :

* les ennemis donnent surtout de l’équipement ;
* les ennemis faibles donnent de l’équipement basique surtout utile à la revente ;
* les ennemis forts donnent de meilleurs objets avec des chances faibles.

---

### 3.16 Visuels de monstres

Les vrais sprites des monstres de l’étage 1 sont intégrés depuis `v0.2`.

Monstres avec sprites dédiés :

* Zombie ;
* Gobelin ;
* Chauve-souris ;
* Troll ;
* Gardien.

Structure utilisée :

```text
assets/monsters/zombie/
assets/monsters/gobelin/
assets/monsters/chauve_souris/
assets/monsters/troll/
assets/monsters/gardien/
```

Chaque monstre utilise actuellement deux frames idle :

* `*_idle_01.png`
* `*_idle_02.png`

`CombatMonsterDisplayUI.gd` charge maintenant les sprites dédiés de chaque monstre.

Évolutions possibles plus tard :

* frame damage spécifique ;
* animation d’attaque par type de monstre ;
* position ou taille plus fine par monstre ;
* effets visuels spécifiques pour certains ennemis.

Priorité actuelle : faible à moyenne, les visuels principaux sont en place.

---

## 4. Ce qui manque encore de fondamental

### 4.1 Inventaire réel

C’est le prochain système fondamental le plus important.

Actuellement :

* les drops apparaissent dans le journal ;
* aucun objet n’est stocké.

À créer :

* `InventoryData.gd`
* `ItemData.gd`
* `ItemDatabase.gd`

Objectif minimal :

* stocker `item_id` + quantité ;
* afficher les objets dans le menu Inventaire ;
* sauvegarder l’inventaire ;
* charger l’inventaire ;
* ajouter automatiquement les drops obtenus en combat.

À ne pas faire immédiatement :

* équipement actif complet ;
* boutique ;
* revente ;
* effets complexes d’objets.

Priorité actuelle : très élevée.

---

### 4.2 Base de données d’objets

Les drops utilisent actuellement des `item_id` et des `display_name` directement dans les loot tables.

À terme, il faudra déplacer les vraies informations d’objet dans `ItemDatabase.gd`.

Données minimales d’un objet :

* `item_id`
* `display_name`
* `item_type`
* `sell_value`
* `description`

Types possibles au départ :

* `weapon`
* `armor`
* `shield`
* `accessory`
* `misc`

Priorité actuelle : très élevée, à faire avec l’inventaire minimal.

---

### 4.3 Système d’équipement

Le jeu parle déjà d’équipement, mais les héros ne peuvent pas encore équiper d’objets.

À créer plus tard :

* emplacements d’équipement ;
* restrictions par classe ;
* bonus d’attaque / défense / stats ;
* affichage de l’équipement dans le statut.

Ce système ne doit pas être commencé avant que l’inventaire et `ItemDatabase` soient solides.

Priorité actuelle : moyenne, mais pas immédiate.

---

### 4.4 Boutique / revente

Le loot d’équipement faible a besoin d’un usage économique.

Usage prévu :

* objets faibles servent à la revente ;
* objets meilleurs peuvent être gardés.

À créer plus tard :

* boutique ;
* prix de vente ;
* prix d’achat ;
* interface de revente ;
* monnaie.

Ce n’est pas prioritaire tant que l’inventaire n’existe pas.

Priorité actuelle : basse à moyenne.

---

### 4.5 Transitions d’étage

Les escaliers sont détectés, mais la transition vers un nouvel étage n’est pas encore un vrai système.

À créer :

* passer à l’étage suivant ;
* créer un `FloorData` pour l’étage 2 ;
* charger un nouveau layout ;
* conserver le groupe ;
* réinitialiser ou conserver certaines découvertes ;
* changer la table de rencontre selon l’étage ;
* sauvegarder l’étage courant correctement.

Priorité actuelle : élevée, après inventaire minimal.

---

### 4.6 Progression du contenu

Il manque encore :

* plusieurs étages ;
* événements de donjon ;
* coffres ;
* pièges ;
* portes spéciales ;
* rencontres fixes ;
* boss ou mini-boss.

Priorité actuelle : moyenne, après les fondations inventaire / étage 2.

---

### 4.7 Mort / défaite

La défaite existe dans le combat, mais il manque une vraie conséquence.

À définir :

* retour menu principal ;
* chargement automatique ;
* écran Game Over ;
* perte partielle ;
* résurrection possible plus tard.

À court terme, un écran simple de défaite serait suffisant.

Priorité actuelle : moyenne.

---

## 5. Pistes d’amélioration des systèmes existants

### 5.1 `Dungeon.gd`

État actuel : sain.

Il orchestre encore :

* chargement d’étage ;
* exploration ;
* automap ;
* découvertes de sorts ;
* UI ;
* déplacement ;
* temple de guérison.

À ne pas extraire immédiatement.

Extraction possible plus tard :

* `DungeonDiscoveryController.gd` → runes, coffres, pièges, événements ;
* `DungeonFloorController.gd` → changements d’étages ;
* `DungeonExplorationController.gd` → déplacement, portes, escaliers, rencontres.

Priorité actuelle : faible à moyenne.

---

### 5.2 `CombatManager.gd`

État actuel : beaucoup plus propre.

Il reste encore plusieurs responsabilités :

* actions héros ;
* attaque ennemie ;
* calculs de dégâts ;
* choix de cible ;
* sorts disponibles ;
* coût en MP ;
* transmission future des drops à l’inventaire.

Extractions futures possibles :

* `CombatActions.gd` → attaque, magie, soin, fuite ;
* `CombatTargeting.gd` → choix des cibles ;
* `CombatAbilityResolver.gd` → sorts disponibles, coûts, effets.

Priorité actuelle : moyenne, mais pas urgente.

---

### 5.3 `MonsterDatabase.gd`

État actuel : bon pour le prototype.

Améliorations futures :

* tables de rencontres par étage ;
* variantes de monstres ;
* rencontres fixes ;
* ennemis rares ;
* monstres uniques ;
* équilibrage après ajout de l’inventaire et de l’équipement.

Priorité actuelle : moyenne.

---

### 5.4 `CombatMonsterDisplayUI.gd`

État actuel : fonctionnel avec vrais sprites pour les monstres de l’étage 1.

Améliorations futures :

* animation damage spécifique ;
* animation d’attaque par type de monstre ;
* taille différente plus précise par monstre ;
* position différente selon taille ;
* effets particuliers pour certains ennemis.

Priorité actuelle : faible à moyenne.

---

### 5.5 Menu Inventaire

État actuel : placeholder.

C’est probablement l’un des plus gros manques visibles maintenant.

À faire :

* afficher les objets possédés ;
* afficher les quantités ;
* afficher une description simple ;
* relier le menu aux données réelles de l’inventaire.

Priorité actuelle : très élevée.

---

### 5.6 Menu Grimoire

État actuel : placeholder.

À terme, il devrait afficher :

* sorts connus ;
* sorts découverts mais niveau insuffisant ;
* coût en MP ;
* description ;
* classe concernée.

Priorité actuelle : moyenne.

---

### 5.7 Menu Statut

État actuel : fonctionnel.

Améliorations futures :

* afficher équipement équipé ;
* afficher valeurs exactes de stats dérivées ;
* afficher EXP / niveau suivant ;
* afficher effets actifs.

Priorité actuelle : moyenne.

---

### 5.8 Polish UI — cadres texturés `NinePatchRect`

Objectif :

Remplacer progressivement les bordures générées en code par des cadres graphiques propres, compatibles avec plusieurs résolutions.

Éléments concernés :

* panneaux latéraux des héros ;
* cadres de portraits ;
* panneau central du donjon ;
* panneau du journal ;
* cadre de l’automap ;
* fenêtres du menu d’aventure ;
* sous-menus ;
* futures fenêtres d’inventaire / grimoire / statut.

Approche technique :

* conserver la structure actuelle en `Control` / `Container` ;
* ajouter un `NinePatchRect` comme couche visuelle de fond ;
* garder les `Label`, `ProgressBar`, portraits et contenus au-dessus ;
* utiliser des marges de patch pour éviter la déformation des coins ;
* importer les textures UI en Nearest, sans filtre, sans mipmaps.

États visuels à prévoir :

* cadre normal ;
* cadre actif ;
* cadre dégâts ;
* cadre mort ;
* flash esquive ;
* éventuellement cadre animé plus tard.

Priorité actuelle : moyenne / polish visuel.

Note :

Ne pas remplacer les containers par de simples images étirées.
Les images doivent habiller l’UI, pas remplacer sa structure logique.

---

## 6. Ordre d’action recommandé

### Phase 1 — Stabilisation des systèmes fondamentaux

Objectif :

Rendre les drops réellement utiles.

À faire :

* créer `ItemData.gd` ;
* créer `ItemDatabase.gd` ;
* créer `InventoryData.gd` ;
* ajouter l’inventaire à `GameSession` ;
* sauvegarder / charger l’inventaire ;
* faire apparaître les drops dans l’inventaire ;
* afficher l’inventaire dans le menu.

Résultat attendu :

Un objet obtenu en combat est stocké, sauvegardé, chargé et visible dans le menu Inventaire.

Statut : à faire.
Priorité : très élevée.

---

### Phase 2 — Transition d’étage

Objectif :

Transformer l’escalier en vraie progression.

À faire :

* permettre de descendre à l’étage suivant ;
* créer `FloorData` pour l’étage 2 ;
* charger une nouvelle table de rencontre ;
* sauvegarder l’étage courant ;
* définir ce qui est conservé ou réinitialisé entre deux étages.

Résultat attendu :

Le joueur peut quitter l’étage 1 et arriver dans un nouvel étage.

Statut : à faire.
Priorité : élevée.

---

### Phase 3 — Équipement actif

Objectif :

Rendre certains drops réellement utilisables.

À faire :

* définir les slots d’équipement ;
* équiper / déséquiper ;
* appliquer restrictions par classe ;
* appliquer bonus ;
* sauvegarder équipement équipé ;
* afficher équipement dans le menu Statut.

Résultat attendu :

Un héros peut équiper une arme ou une armure et ses performances changent.

Statut : à faire plus tard.
Priorité : moyenne.

---

### Phase 4 — Boutique / revente

Objectif :

Donner une utilité aux drops faibles.

À faire :

* créer une interface de boutique ;
* vendre les objets inutiles ;
* acheter équipement ou services ;
* stocker une monnaie.

Résultat attendu :

Les objets basiques trouvés sur les ennemis deviennent utiles économiquement.

Statut : à faire plus tard.
Priorité : basse à moyenne.

---

### Phase 5 — Contenu de donjon

Objectif :

Enrichir l’exploration.

À faire :

* coffres ;
* pièges ;
* portes spéciales ;
* rencontres fixes ;
* runes supplémentaires ;
* événements simples ;
* mini-boss ou boss.

Résultat attendu :

Le donjon ne repose plus seulement sur les combats aléatoires.

Statut : à faire plus tard.
Priorité : moyenne.

---

### Phase 6 — Polish visuel UI

Objectif :

Améliorer la présentation générale sans casser la structure UI.

À faire :

* créer des cadres graphiques propres ;
* intégrer progressivement des `NinePatchRect` ;
* améliorer les panneaux existants ;
* préparer les fenêtres d’inventaire, grimoire et statut.

Résultat attendu :

L’interface garde sa logique actuelle, mais gagne en finition visuelle.

Statut : à faire plus tard.
Priorité : moyenne.

---

## 7. Phases terminées

### Phase terminée — Temple de guérison

Objectif :

Compenser le danger élevé et les rencontres injustes.

Fait :

* symbole de carte dédié ;
* ajout dans le layout ;
* détection de la case temple ;
* restauration complète PV / PM ;
* blocage des rencontres aléatoires sur la case ;
* rendu visuel dans le donjon ;
* affichage sur l’automap.

Statut : terminé en `v0.2`.

---

### Phase terminée — Vrais sprites de monstres étage 1

Objectif :

Remplacer les placeholders.

Fait :

* zombie déjà présent ;
* gobelin ajouté ;
* chauve-souris ajoutée ;
* troll ajouté ;
* gardien ajouté ;
* intégration dans `CombatMonsterDisplayUI.gd`.

Résultat :

Chaque monstre de l’étage 1 a une silhouette claire et reconnaissable.

Statut : terminé en `v0.2`.

---

### Phase terminée — Correction affichage héros identiques

Objectif :

Éviter les conflits visuels quand plusieurs héros partagent le même nom ou la même classe.

Fait :

* suivi des portraits et états visuels par slot de groupe ;
* correction des cadres rouges persistants ;
* correction des portraits damage au démarrage.

Statut : terminé en `v0.2`.

---

### Phase terminée — Amélioration audio combat / exploration

Objectif :

Éviter que les musiques recommencent toujours au début.

Fait :

* départ aléatoire sur mesure pour musique d’exploration ;
* départ aléatoire sur mesure pour musique de combat ;
* conservation du démarrage au début pour le thème titre ;
* crossfade conservé.

Statut : terminé en `v0.2`.

---

## 8. Priorités immédiates

### Priorité très haute

* Inventaire minimal ;
* `ItemDatabase` minimal ;
* sauvegarde de l’inventaire ;
* affichage du menu Inventaire ;
* ajout réel des drops dans l’inventaire.

### Priorité haute

* Transition d’étage ;
* création de l’étage 2 ;
* tables de rencontre par étage.

### Priorité moyenne

* écran de défaite / Game Over ;
* Grimoire ;
* Statut enrichi ;
* polish UI ;
* animations damage des monstres.

### Priorité basse pour l’instant

* boutique ;
* équipement complet ;
* système économique ;
* refactor supplémentaire du combat ;
* coffres et pièges complexes ;
* boss avancés.

---

## 9. Décision recommandée pour la prochaine session

La prochaine étape la plus logique est :

```text
Créer le système d’inventaire minimal.
```

But exact :

Quand un monstre droppe un objet :

```text
→ l’objet est ajouté à l’inventaire
→ l’inventaire est sauvegardé
→ l’inventaire est chargé
→ le menu Inventaire affiche l’objet
```

Cette étape rendra les drops réellement fonctionnels sans encore ouvrir le chantier complexe de l’équipement.

---

## 10. Architecture cible à court terme

Structure recommandée :

```text
res://scripts/items/
    ItemData.gd
    ItemDatabase.gd

res://scripts/inventory/
    InventoryData.gd
```

Intégrations nécessaires :

* `GameSession.gd` → stocker l’inventaire courant ;
* `SaveManager.gd` → sauvegarder / charger l’inventaire ;
* `CombatRewards.gd` → renvoyer les `dropped_items` ;
* `CombatManager.gd` → transmettre les drops à l’inventaire ;
* `InGameMenuPanelUI.gd` → afficher le contenu de l’inventaire.

Objectif de première version :

* pas d’équipement actif ;
* pas d’utilisation d’objet ;
* pas de boutique ;
* uniquement stockage, sauvegarde, chargement et affichage.

---

## 11. Notes de design à conserver

Décisions importantes à ne pas oublier :

* pas de commande Défendre ;
* combat dur et parfois injuste accepté ;
* les compensations doivent venir du donjon, pas d’un équilibrage trop doux ;
* les HP / MP restent en barres dans l’UI principale ;
* les chiffres détaillés restent dans les menus ;
* les monstres peuvent donner uniquement de l’équipement ;
* les objets faibles servent surtout à la revente future ;
* éviter les gros systèmes avant que les bases soient stables ;
* conserver des scripts lisibles, commentés et découpés par responsabilité ;
* préférer une progression modulaire plutôt qu’un gros chantier unique.

---

## 12. Historique des versions

### v0.1

Base stable du prototype.

Contenu principal :

* menu principal ;
* création de groupe ;
* exploration ;
* combat ;
* sauvegarde / chargement ;
* automap ;
* audio de base ;
* premiers monstres et drops simples.

Rôle :

Point de retour stable avant l’ajout du temple de guérison.

---

### v0.2

Version stable actuelle.

Contenu principal :

* temple de guérison ;
* amélioration audio combat / exploration ;
* correction du bug de portraits avec héros identiques ;
* sprites dédiés pour Gobelin, Chauve-souris, Troll et Gardien ;
* intégration complète des sprites monstres dans `CombatMonsterDisplayUI.gd`.

Rôle :

Version de stabilisation visuelle et confort de jeu avant le chantier inventaire.
