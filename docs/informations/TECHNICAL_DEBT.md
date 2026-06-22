# TECHNICAL_DEBT — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Base actuelle : `v0.13 — Magicka : progression magique, sorts actifs et poison`

## Résumé

`v0.13` ajoute une vraie progression magique et introduit un premier système de statut temporaire avec le poison.

Le format de sauvegarde passe en version 7 afin de mémoriser les sorts actifs préparés hors combat.

## Dette réduite ou stabilisée

### Sorts actifs hors combat

Le grimoire hors combat peut maintenant préparer les sorts actifs.

Chaîne actuelle :

```text
GrimoireMenuView.gd
-> GameSession.gd
-> SaveManager.gd
-> CombatManager.gd
```

Le grimoire de combat reste temporaire et n'écrase pas les choix sauvegardés hors combat.

### Soin de groupe

Le Soin de groupe ajoute un comportement distinct :

```text
cible : toute l'équipe
sélection de cible : non
```

Cette logique doit rester séparée des soins ciblés.

### Poison

Nouveau fichier :

```text
scripts/combat/CombatStatusEffectResolver.gd
```

Ce fichier pose la base d'un système de statuts temporaires réutilisable.

Pour le moment :

```text
- poison sur monstres uniquement ;
- dégâts à la fin du tour du monstre ;
- dissipation progressive ;
- boss gardien immunisé.
```

## Points de vigilance actuels

### 1. Sauvegarde version 7

Nouveau champ :

```text
active_ability_ids_by_party_slot
```

À surveiller :

```text
anciennes sauvegardes
nouveaux héros après création
ordre des héros
choix de sort préparé invalide après changement de règles
découverte de sort manquante
niveau insuffisant au chargement
```

### 2. Statuts temporaires

Le poison est volontairement limité.

À surveiller :

```text
timing des ticks
dégâts sur monstres à hauts PV
dissipation
message de journal
victoire causée par poison
interaction avec la défaite du groupe
immunité boss
```

Dette future probable :

```text
afficher visuellement les statuts
gérer les statuts sur héros
permettre certains monstres empoisonneurs
centraliser les immunités
sauvegarder des statuts si un jour les combats deviennent persistants
```

### 3. Grimoire hors combat

Le grimoire contient maintenant deux usages :

```text
- préparer un sort actif ;
- utiliser un soin hors combat.
```

À surveiller :

```text
lisibilité de l'écran
taille des boutons avec police globale
séparation claire entre préparation et usage immédiat
compréhension par le joueur
```

### 4. CombatManager.gd

`CombatManager.gd` reste sensible car il orchestre :

```text
tour des héros
actions ennemies
victoire / fuite / défaite
boss
récompenses
sorts actifs
grimoire de combat
soin de groupe
poison
ciblage des soins
```

Les prochaines évolutions doivent rester progressives et testées.

### 5. En-têtes de version des scripts

Nouvelle règle à maintenir :

```text
chaque script modifié reçoit un en-tête VERSION SCRIPT correspondant au bloc de travail
```

Ne pas ajouter ces en-têtes à tous les fichiers en une seule passe pour le moment.

## À ne pas faire pour le moment

```text
- ajouter des objets consommables ;
- ajouter des potions ;
- créer un journal de quête ;
- créer un moniteur d'objectif ;
- révéler des informations non découvertes sur la carte ;
- ajouter l'étage 3 avant d'enrichir davantage la boucle actuelle ;
- ajouter trop de statuts avant d'avoir testé le poison ;
- changer le format de sauvegarde sans nécessité claire ;
- préparer une grosse refactorisation générale non motivée.
```

## Recommandation immédiate

Après `v0.13`, privilégier :

```text
1. playtest 03 post-v0.13 ;
2. vérifier les sauvegardes anciennes et nouvelles ;
3. vérifier l'équilibrage du poison ;
4. vérifier la lisibilité du grimoire ;
5. vérifier la logique de soin de groupe ;
6. corriger les éventuels débordements UI ;
7. seulement ensuite, concevoir d'autres statuts ou sorts.
```
