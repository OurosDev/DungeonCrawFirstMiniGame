# ASSISTANT_WORKFLOW — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version de référence : `v0.11.2 — Polish menus et orientation des modèles 3D`

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
CHANGELOG/v0.11.2.md
audits/STATE_AUDITv0.11.2.md
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

## 6. Base actuelle v0.11.2

Version stable récente : `v0.11.2 — Polish menus et orientation des modèles 3D`.

Cette version conserve la base `v0.11.1 — Carte agrandie et automap améliorée` et ajoute un polish ciblé :
- boutons du menu principal texturés ;
- grand cadre autour de `DONJON DES SERPENTS` retiré ;
- panneau Options texturé ;
- création d'équipe harmonisée avec cadres et boutons texturés ;
- tooltips d'aide au survol de `Relancer`, `Stocker` et `Reprendre` ;
- orientation automatique des modèles spéciaux `M/C/O/B` pour éviter qu'ils fassent face à un mur quand une case chemin ou praticable existe.

Aucun gameplay, layout ou format de sauvegarde n'est modifié.


Scripts concernés par `v0.11.2` :
```text
scripts/ui/MainMenu.gd
scripts/ui/PartyCreationUI.gd
scripts/dungeon/DungeonRenderer.gd
```

## 7. Tests recommandés v0.11.2

```text
menu principal
boutons texturés
Options / Retour
Nouvelle partie
Charger
création d'équipe
survol Relancer / Stocker / Reprendre
tooltips qui suivent le curseur
validation des 4 héros
premier M de l'étage 1
coffres réorientés
messages réorientés
temples conservés
boutiques conservées
interactions M/C/O/B
étage 1
étage 2
sauvegarde / chargement
```

## 8. Renderer et builds de test

Exporter les builds Windows de playtest en `Compatibility / OpenGL` par défaut. Ne pas pousser builds, logs bruts ou sauvegardes locales.

## 9. Règles de design

```text
ne pas ajouter d'objets consommables pour le moment
ne pas ajouter de potions pour le moment
ne pas ajouter de journal de quête ou moniteur d'objectif
ne pas révéler d'informations non découvertes sur la carte
ne pas placer volontairement des modèles lisibles face à un mur
ne pas viser l'étage 3 comme priorité immédiate
```
