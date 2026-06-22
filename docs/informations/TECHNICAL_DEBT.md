# TECHNICAL_DEBT — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Base actuelle : `v0.11.3 — Fond de menu, polices et lisibilité UI`

## Résumé

La dette technique principale du projet a été réduite par la série de refactorisations `v0.8.2`, puis la base a été enrichie par les grimoires, le polish UI, la carte agrandie, l'automap améliorée et l'identité visuelle du menu principal.

`v0.11.3` ajoute une police globale et une image de fond de menu sans nouveau format de sauvegarde.

## Dette résolue ou fortement réduite

### Refactorisations internes v0.8.2

```text
InGameMenuPanelUI.gd -> scripts/ui/menu/*
CombatManager.gd -> scripts/combat/Combat*Resolver/Helper/Access/Selector
Dungeon.gd -> DungeonMapHelper / DungeonFloorStateHelper / DungeonAutoMapHelper
GameSession.gd -> scripts/core/session/*
PartyCreationUI.gd -> scripts/ui/party_creation/*
```

### UI NineSlice v0.11

Base de rendu texturé centralisée dans :

```text
scripts/ui/theme/UIFrameStyle.gd
```

Asset principal :

```text
assets/ui/frames/texture_cadre_ui.png
```

### Carte agrandie v0.11.1

La carte agrandie reste une extension de l'automap :

```text
layout
discovered_map_cells
player.grid_cell
player.get_facing_name()
```

Aucun nouvel état persistant n'est ajouté.

### Menu principal et police globale v0.11.3

Le menu principal est maintenant plus configurable :

```text
scripts/ui/MainMenu.gd
assets/ui/backgrounds/main_menu_background.png
assets/ui/themes/game_theme.tres
assets/fonts/title_medieval.otf
assets/fonts/game_ui.otf
```

Points stabilisés :

```text
titre avec police dédiée
placement du menu par constantes Rect2
libellés d'exploration simplifiés
tooltip coordonnées sans retour à la ligne
```

## Points de vigilance actuels

### 1. Police globale

À surveiller :

```text
textes longs dans les boutons
inventaire
équipement
boutique
grimoire
journal Combat
tooltips
basse résolution
textes avec accents
```

Solution recommandée si un écran déborde :

```text
corriger localement les libellés ou tailles minimales
éviter de réduire toute la police globale sans nécessité
ajouter des overrides par écran si besoin
```

### 2. Carte agrandie et automap

À surveiller :

```text
redimensionnement de fenêtre
position du tooltip
clarté des coordonnées
absence de tooltip sur murs
absence de tooltip sur cases non découvertes
alignement du bouton Retour
lisibilité sur étage 1 et étage 2
```

### 3. Texture dédiée aux boutons

Les boutons utilisent actuellement la même texture que les panneaux, avec des marges NineSlice réduites.

Cela fonctionne et reste lisible, mais une texture dédiée serait plus propre.

Piste future :

```text
assets/ui/frames/texture_bouton_ui.png
```

### 4. UI texturée et états visuels

L'application du NineSlice et de la police globale ne doit pas masquer les feedbacks importants :

```text
héros actif
sélection verte
prévisualisation PV/PM
dégâts reçus
soins
boutons désactivés
tooltips carte
```

### 5. CombatManager.gd

Même refactorisé, `CombatManager.gd` reste sensible car il orchestre :

```text
tour des héros
actions ennemies
victoire / fuite / défaite
boss
récompenses
sorts actifs temporaires
grimoire de combat
ciblage des soins
```

Les prochaines évolutions de magie doivent rester progressives et testables.

### 6. Sorts actifs

Pour le moment :

```text
sorts actifs = temporaires
réinitialisation = début de combat
sauvegarde = aucune persistance volontaire
```

Dette future probable : quand plusieurs sorts seront réellement disponibles, il faudra probablement créer :

```text
système de sorts connus / découverts
grimoire hors combat individuel par héros
choix persistant des sorts actifs
compatibilité anciennes sauvegardes
```

### 7. Journal Combat

`LogPanelUI.gd` colore certaines lignes de combat selon leur texte.

Risque : si les messages de combat deviennent plus variés, l'analyse textuelle peut devenir fragile.

Solution future possible : passer à des messages typés, par exemple :

```text
combat_player_damage
combat_enemy_damage
combat_heal
system_warning
key_item
message_tile
```

## À ne pas faire pour le moment

```text
- ajouter des objets consommables ;
- ajouter des potions ;
- créer un journal de quête ;
- créer un moniteur d'objectif ;
- révéler des informations non découvertes sur la carte ;
- ajouter l'étage 3 avant d'enrichir davantage la boucle actuelle ;
- changer le format de sauvegarde sans nécessité claire ;
- préparer une grosse refactorisation générale non motivée.
```

## Recommandation immédiate

Après `v0.11.3`, privilégier :

```text
1. playtest 02 post-v0.11.3 ;
2. vérifier la lisibilité de la police globale dans tous les écrans ;
3. tester étage 1 et étage 2 ;
4. vérifier l'automap compacte et la carte agrandie ;
5. vérifier les tooltips coordonnées ;
6. tester la boucle complète avec Mage + Prêtre ;
7. créer une texture dédiée aux boutons si le besoin visuel reste confirmé ;
8. ensuite seulement, concevoir les prochains sorts.
```
