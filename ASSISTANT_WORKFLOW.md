# ASSISTANT_WORKFLOW — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Version de référence : `v0.13.1 — Correctifs UI, stèles de sort et flags de build`

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
CHANGELOG/v0.13.1.md
audits/STATE_AUDITv0.13.1.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
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
- Ne pas fournir de patch partiel de script pour ce projet.
- Si un script local est nécessaire pour produire un pack complet fiable, demander ce script à l'utilisateur au lieu d'improviser.

## 4. Règle d'en-tête de version des scripts

Chaque script modifié dans un bloc de travail doit recevoir un commentaire d'en-tête indiquant la version du bloc.

Format recommandé :

```gdscript
# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13.1-NomDuBloc
# ------------------------------------------------------------
```

Règles :

```text
- Ajouter l'en-tête aux scripts modifiés, pas à tout le projet d'un coup.
- Ne pas réécrire uniquement un fichier pour ajouter l'en-tête, sauf demande explicite.
- Mettre à jour l'en-tête quand un script est réellement modifié dans un nouveau bloc.
- Utiliser cet en-tête pour vérifier rapidement si un fichier local/GitHub est celui attendu.
```

## 5. Base actuelle v0.13.1

Version stable récente : `v0.13.1 — Correctifs UI, stèles de sort et flags de build`.

Cette version regroupe :

- `BuildFlags.gd` pour masquer/bloquer la téléportation de développement ;
- symbole `S` pour les stèles de sort ;
- modèle 3D de stèle magique orienté vers un chemin ;
- correction de la fermeture du menu d'aventure avec Échap ;
- bouton `X` du menu d'aventure ;
- polish du menu inventaire ;
- bouton `X` de la carte agrandie.

Scripts concernés par les correctifs v0.13.1 :

```text
scripts/core/BuildFlags.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonRenderer.gd
scripts/dungeon/FloorDatabase.gd
scripts/ui/AutoMapUI.gd
scripts/ui/DungeonViewportUI.gd
scripts/ui/InGameMenuPanelUI.gd
scripts/ui/menu/DevTeleportMenuView.gd
scripts/ui/menu/InventoryMenuView.gd
```

## 6. Systèmes sensibles

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
flags de build
```

## 7. Workflow général de modification

1. vérifier l'état actuel du repo ou la base locale fournie ;
2. identifier les fichiers concernés ;
3. vérifier les dépendances et l'organisation réelle des scripts ;
4. expliquer le périmètre ;
5. fournir un pack complet de remplacement ;
6. séparer clairement nouveaux fichiers / fichiers mis à jour / fichiers à ne pas pousser ;
7. attendre les tests locaux avant de préparer une release.

Pour les packs de scripts importants :

```text
- éviter les reconstructions complètes depuis des sources incertaines ;
- partir des fichiers locaux fournis quand ils existent ;
- limiter les changements par bloc ;
- tester la compilation autant que possible ;
- si une erreur massive apparaît, revenir à la base validée et corriger par étapes ;
- ne pas proposer de patch partiel.
```

## 8. Tests recommandés v0.13.1

```text
DEV_TELEPORT_ENABLED false : bouton T absent et TP bloqué
DEV_TELEPORT_ENABLED true : bouton T visible et TP fonctionnel
stèle Éclat de givre étage 1 visible et orientée correctement
stèle Soin de groupe étage 2 x21 y8 visible et orientée correctement
symbole S affiché sur automap / carte agrandie
découverte des sorts toujours fonctionnelle
menu d'aventure fermé avec Échap : commandes exploration restaurées
menu d'aventure fermé avec X : commandes exploration restaurées
inventaire sans cadre parasite
inventaire sans texte d'aide superflu
bouton Retour menu inventaire correctement placé
carte agrandie fermée avec X
boutons exploration actifs après fermeture de carte
```

## 9. Renderer et builds de test

Exporter les builds Windows de playtest en `Compatibility / OpenGL` par défaut.

Ne pas pousser builds, logs bruts ou sauvegardes locales.

Avant export playtest/exécutable, vérifier :

```gdscript
const DEV_TELEPORT_ENABLED: bool = false
```

dans :

```text
scripts/core/BuildFlags.gd
```

## 10. Règles de design

```text
ne pas ajouter d'objets consommables pour le moment
ne pas ajouter de potions pour le moment
ne pas ajouter de journal de quête ou moniteur d'objectif
ne pas révéler d'informations non découvertes sur la carte
ne pas placer volontairement des modèles lisibles face à un mur
utiliser S pour les stèles de sort
utiliser M pour les messages / indices
ne pas viser l'étage 3 comme priorité immédiate
éviter les contours blancs et halos clairs sur les assets
vérifier la lisibilité après toute modification de police globale
sauvegarder toute nouvelle progression durable
```
