# TECHNICAL_DEBT — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Base actuelle : `v0.12 — Équilibrage combat, sort découvert et corrections UI`

## Résumé

La base récente ajoute une progression magique sauvegardée et plusieurs corrections d'interface post-police globale.

`v0.12` modifie le format de sauvegarde pour mémoriser les sorts découverts, tout en conservant la compatibilité avec les sauvegardes plus anciennes.

## Dette réduite ou stabilisée

### Sort découvert utilisable en combat

Le sort `Éclat de givre` n'est plus seulement découvert dans le donjon : il est relié au grimoire de combat via la progression du groupe.

Chaîne actuelle :

```text
Dungeon.gd
-> GameSession.gd
-> SaveManager.gd
-> CombatAbilityResolver.gd
```

### Sauvegarde des sorts découverts

Nouveau champ :

```text
discovered_ability_ids
```

Compatibilité :

```text
sauvegardes anciennes : champ absent = liste vide
```

### Boss gardien exclu de la hausse de PV

Le boss utilise une base séparée pour éviter toute augmentation indirecte quand le gardien normal est rééquilibré.

### Création d'équipe

Les valeurs de roll sont plus lisibles grâce à la couleur :

```text
10 vert
5 jaune
4 ou moins rouge
```

### Équipement

L'écran `Statut > Équipement` a été compacté pour mieux supporter la police globale et éviter les chevauchements.

### Journal / Combat

Le canal affiché revient automatiquement sur `Journal` en sortie de combat.

## Points de vigilance actuels

### 1. Progression magique

Le système commence à stocker des découvertes de sorts au niveau groupe.

À surveiller :

```text
cohérence entre sorts de classe et sorts découverts
compatibilité anciennes sauvegardes
sorts visibles mais non utilisables
niveau requis
coût PM
grimoire hors combat individuel futur
```

Dette future probable :

```text
système de sorts connus / découverts plus formel
choix persistant des sorts actifs
UI pour afficher les sorts découverts mais verrouillés
```

### 2. Équilibrage combat

La hausse de PV des monstres normaux et le coût augmenté du sort de base du Mage doivent être validés par playtest.

À surveiller :

```text
durée moyenne des combats
consommation de PM du Mage
intérêt réel d'Éclat de givre
difficulté étage 1
difficulté étage 2
boss gardien
récompenses après combat
```

### 3. Police globale

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

### 4. Texture dédiée aux boutons

Les boutons utilisent actuellement la même texture que les panneaux, avec des marges NineSlice réduites.

Cela fonctionne et reste lisible, mais une texture dédiée serait plus propre.

Piste future :

```text
assets/ui/frames/texture_bouton_ui.png
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

Après `v0.12`, privilégier :

```text
1. playtest 02 post-v0.12 ;
2. vérifier la durée des combats ;
3. vérifier l'intérêt d'Éclat de givre ;
4. vérifier la sauvegarde / recharge des sorts découverts ;
5. vérifier la lisibilité de tous les écrans avec la police globale ;
6. corriger les derniers débordements UI si nécessaire ;
7. ensuite seulement, concevoir les prochains sorts.
```
