# ASSISTANT_WORKFLOW — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Version de référence : `v0.12 — Équilibrage combat, sort découvert et corrections UI`

## 1. Règle de démarrage d'une conversation

Au premier échange d'une nouvelle conversation de travail sur ce projet, l'assistant doit :

1. lire `IA_RELAIS.md` ;
2. lire `ASSISTANT_WORKFLOW.md` ;
3. vérifier l'état réel du dépôt GitHub public sur `main` ;
4. consulter les documents structurants ;
5. signaler toute incohérence avant de proposer une modification.

Documents à vérifier selon le besoin :

```text
README.md
CHANGELOG/README.md
CHANGELOG/v0.12.md
audits/STATE_AUDITv0.12.md
docs/informations/ROADMAP.md
docs/informations/IDEAS.md
docs/informations/TECHNICAL_DEBT.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
project.godot
```

## 2. Sources de vérité et base locale active

Le repo GitHub public sur `main` est la source vérifiable principale, mais il peut être en retard par rapport à l'état local de l'utilisateur.

Ordre de confiance recommandé :

```text
1. Fichiers locaux fournis explicitement par l'utilisateur pour la tâche en cours
2. Repo GitHub public vérifié sur main
3. Audit d'état le plus récent
4. Changelog de version
5. IA_RELAIS.md
6. ROADMAP.md / TECHNICAL_DEBT.md / IDEAS.md
7. Mémoire de conversation
```

Les fichiers locaux fournis explicitement sont prioritaires, sans exclure la consultation ou la modification du repo GitHub quand c'est pertinent.

## 3. Langue et format de réponse

- Travailler en français.
- Être direct et précis.
- Signaler les incohérences.
- Donner des fichiers complets quand c'est raisonnable.
- Quand plusieurs fichiers sont concernés, fournir un pack complet téléchargeable en priorité.

## 4. Systèmes sensibles

Avant de modifier un système sensible, résumer la conception prévue :

```text
sauvegarde / chargement
combat
GameSession
inventaire / équipement
sorts / grimoire
input global
UI partagée
thème global / police globale
FloorDatabase / layouts
symboles et règles de cases du donjon
orientation des modèles 3D spéciaux
```

## 5. Workflow général de modification

1. vérifier l'état actuel du repo ou la base locale fournie ;
2. identifier les fichiers concernés ;
3. expliquer le périmètre ;
4. fournir un pack complet de remplacement ;
5. séparer clairement nouveaux fichiers / fichiers mis à jour / fichiers à ne pas pousser ;
6. attendre les tests locaux avant de préparer une release.

## 6. Base actuelle v0.12

Version stable récente : `v0.12 — Équilibrage combat, sort découvert et corrections UI`.

Cette version conserve la base `v0.11.3 — Fond de menu, polices et lisibilité UI` et ajoute :

- coût de mana du sort de base du Mage doublé ;
- utilisation en combat du sort `Éclat de givre` découvert à l'étage 1 ;
- sauvegarde des sorts découverts via `discovered_ability_ids` ;
- PV des monstres normaux augmentés de 25 % ;
- boss gardien explicitement exclu de cette hausse ;
- coloration des valeurs de rolls dans la création d'équipe ;
- corrections de layout dans l'écran `Statut > Équipement` ;
- retour automatique du canal `Journal` après un combat.

Scripts concernés par `v0.12` :

```text
scripts/abilities/AbilityDatabase.gd
scripts/monsters/MonsterDatabase.gd
scripts/combat/CombatAbilityResolver.gd
scripts/dungeon/Dungeon.gd
scripts/core/GameSession.gd
scripts/core/SaveManager.gd
scripts/ui/PartyCreationUI.gd
scripts/ui/menu/StatusEquipmentMenuView.gd
scripts/ui/GameUI.gd
```

Point sensible :

```text
SaveManager passe en version 6 pour sauvegarder discovered_ability_ids.
Anciennes sauvegardes compatibles : champ absent = liste vide.
```

## 7. Tests recommandés v0.12

```text
Étincelle coûte 6 PM
Éclat de givre découvert à l'étage 1
Mage niveau 1 : Éclat de givre indisponible
Mage niveau 2 : Éclat de givre disponible en combat
sauvegarde / chargement après découverte
PV des monstres normaux augmentés
boss gardien conservé à 225 PV
création d'équipe : stats 10 vertes
création d'équipe : stats 5 jaunes
création d'équipe : stats 4 ou moins rouges
écran équipement : Accessoire visible
écran équipement : pas de cadres inutiles autour des slots
écran équipement : Retour statut dans le cadre
entrée combat : canal Combat
sortie combat : canal Journal
inventaire
boutique
temple
carte
automap
grimoire hors combat
grimoire de combat
boss gardien
```

## 8. Renderer et builds de test

Exporter les builds Windows de playtest en `Compatibility / OpenGL` par défaut.

Ne pas pousser builds, logs bruts ou sauvegardes locales.

## 9. Règles de design

```text
ne pas ajouter d'objets consommables pour le moment
ne pas ajouter de potions pour le moment
ne pas ajouter de journal de quête ou moniteur d'objectif
ne pas révéler d'informations non découvertes sur la carte
ne pas placer volontairement des modèles lisibles face à un mur
ne pas viser l'étage 3 comme priorité immédiate
éviter les contours blancs et halos clairs sur les assets
vérifier la lisibilité après toute modification de police globale
sauvegarder toute nouvelle progression durable
```
