# ASSISTANT_WORKFLOW — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Version de référence : `v0.13 — Magicka : progression magique, sorts actifs et poison`

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
CHANGELOG/v0.13.md
audits/STATE_AUDITv0.13.md
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

## 4. Règle d'en-tête de version des scripts

À partir de `v0.13-Magicka`, chaque script modifié dans un bloc de travail doit recevoir un commentaire d'en-tête indiquant la version du bloc.

Format recommandé :

```gdscript
# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13-Magicka
# ------------------------------------------------------------
```

Règles :

```text
- Ajouter l'en-tête aux scripts modifiés, pas à tout le projet d'un coup.
- Ne pas réécrire uniquement un fichier pour ajouter l'en-tête, sauf demande explicite.
- Mettre à jour l'en-tête quand un script est réellement modifié dans un nouveau bloc.
- Utiliser cet en-tête pour vérifier rapidement si un fichier local/GitHub est celui attendu.
- Plus tard, faire un audit des scripts qui n'ont pas encore d'en-tête si l'utilisateur le demande.
```

## 5. Systèmes sensibles

Avant de modifier un système sensible, résumer la conception prévue :

```text
sauvegarde / chargement
combat
statuts temporaires
poison
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

## 6. Workflow général de modification

1. vérifier l'état actuel du repo ou la base locale fournie ;
2. identifier les fichiers concernés ;
3. expliquer le périmètre ;
4. fournir un pack complet de remplacement ;
5. séparer clairement nouveaux fichiers / fichiers mis à jour / fichiers à ne pas pousser ;
6. attendre les tests locaux avant de préparer une release.

Pour les packs de scripts importants :

```text
- éviter les reconstructions complètes depuis des sources incertaines ;
- partir des fichiers locaux fournis quand ils existent ;
- limiter les changements par bloc ;
- tester la compilation avant d'enchaîner ;
- si une erreur massive apparaît, revenir à la base validée et corriger par étapes.
```

## 7. Base actuelle v0.13

Version stable récente : `v0.13 — Magicka : progression magique, sorts actifs et poison`.

Cette version ajoute :

- rééquilibrage d'`Éclat de givre` ;
- ajout du `Soin renforcé` niveau 5 ;
- ajout du `Soin de groupe` découvert à l'étage 2 ;
- ajout du sort `Poison` niveau 5 ;
- ajout d'un premier système de statut temporaire ;
- préparation hors combat des sorts actifs ;
- sauvegarde des sorts actifs préparés ;
- initialisation des sorts actifs de combat depuis la préparation hors combat ;
- conservation du grimoire de combat pour des changements temporaires pendant un combat.

Scripts concernés par `v0.13-Magicka` :

```text
scripts/abilities/AbilityDatabase.gd
scripts/characters/ClassDatabase.gd
scripts/combat/CombatManager.gd
scripts/combat/CombatStatusEffectResolver.gd
scripts/core/GameSession.gd
scripts/core/SaveManager.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/FloorDatabase.gd
scripts/ui/menu/CombatGrimoireMenuView.gd
scripts/ui/menu/GrimoireMenuView.gd
```

Point sensible :

```text
SaveManager passe en version 7 pour sauvegarder active_ability_ids_by_party_slot.
Les découvertes de sorts restent sauvegardées via discovered_ability_ids.
```

## 8. Tests recommandés v0.13

```text
Éclat de givre coûte 10 PM
Éclat de givre inflige plus de dégâts qu'Étincelle
Poison disponible Mage niveau 5
Poison fonctionne sur monstre normal
Poison se dissipe selon la règle prévue
Poison ne fonctionne pas sur le boss gardien
Soin renforcé disponible Prêtre niveau 5
Soin de groupe découvert étage 2 x21 y8
Soin de groupe soigne toute l'équipe
Soin de groupe ne demande pas de cible
préparation hors combat d'un sort offensif
préparation hors combat d'un sort de soin
entrée combat avec sort préparé
grimoire de combat toujours temporaire
sauvegarde / chargement des sorts préparés
inventaire
boutique
temple
carte
automap
équipement
boss gardien
```

## 9. Renderer et builds de test

Exporter les builds Windows de playtest en `Compatibility / OpenGL` par défaut.

Ne pas pousser builds, logs bruts ou sauvegardes locales.

## 10. Règles de design

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
