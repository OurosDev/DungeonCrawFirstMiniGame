# ASSISTANT_WORKFLOW — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version de référence : `v0.10 — Grimoire de combat et ciblage des soins`

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
CHANGELOG/v0.10.md
audits/STATE_AUDITv0.10.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
playtests/PLAYTEST_01_v0.8.md
project.godot
```

La source de vérité principale reste l'état réel du repo sur `main`. Si un document est en retard, le signaler clairement.

Si l'assistant a un doute sur la version d'un fichier GitHub, si un fichier est trop long/difficile à consulter, ou si des modifications locales non poussées peuvent rendre GitHub obsolète, il doit demander à l'utilisateur de fournir le fichier local concerné plutôt que d'improviser.

## 2. Langue et format de réponse

- Travailler en français.
- Être direct et précis.
- Signaler les incohérences entre repo, mémoire, documents et demandes utilisateur.
- Donner des fichiers complets quand c'est raisonnable.
- Quand plusieurs fichiers sont concernés, fournir un pack complet téléchargeable en priorité.
- Les fichiers individuels peuvent être donnés en complément, mais le pack reste le livrable principal.

## 3. Workflow général de modification

Avant toute modification importante :

1. vérifier l'état actuel du repo ;
2. identifier les fichiers concernés ;
3. expliquer le périmètre ;
4. fournir un pack complet de remplacement ;
5. séparer clairement : nouveaux fichiers, fichiers mis à jour, fichiers à ne pas pousser ;
6. attendre les tests locaux de l'utilisateur avant de préparer une release.

Pour les scripts, conserver ou ajouter des commentaires de sections quand c'est utile :

```gdscript
# CONSTANTES
# VARIABLES
# INITIALISATION
# API PUBLIQUE
# SIGNALS
# HELPERS
```

## 4. Workflow spécial refactorisation

Pour les refactorisations ou modifications techniques importantes, utiliser cette séquence :

```text
1. L'utilisateur crée un zip local de sécurité de l'état actuel.
2. L'assistant prépare uniquement un pack complet de scripts.
3. L'utilisateur applique et teste localement.
4. Si les tests sont OK, l'utilisateur crée un nouveau zip local de sécurité.
5. On passe à la refactorisation suivante.
6. La documentation du repo est mise à jour seulement au moment de préparer la release.
```

Ne pas préparer une release après chaque refactorisation validée si une série de refactorisations est en cours.

Ne pas mélanger dans un premier pack de refactorisation :

- scripts ;
- changelog ;
- roadmap ;
- dette technique ;
- audit.

La documentation arrive à la fin, quand l'ensemble des refactorisations utiles est terminé ou quand l'utilisateur le demande explicitement.

## 5. Base actuelle v0.10

`v0.10` ajoute le grimoire de combat et le ciblage des soins en combat.

Fonctionnalités validées :

```text
- bouton Grimoire pendant le combat ;
- grimoire de combat propre au héros actif ;
- sorts actifs temporaires réinitialisés à chaque combat ;
- sélection du sort déjà actif sans perte de tour ;
- retour depuis le grimoire sans perte de tour ;
- changement réel de sort actif consommant l'action du tour ;
- bouton Magie lançant directement le sort offensif actif ;
- bouton Soin lançant directement le sort de soin actif ;
- soin en combat avec sélection directe par cadres de héros ;
- prévisualisation PV sur la cible ;
- prévisualisation PM sur le lanceur ;
- contrôles souris ;
- contrôles flèches / Entrée / Échap ;
- contrôles AZERTY ZQSD / A / E ;
- canal Combat coloré ligne par ligne : dégâts ennemis rouges, soins verts, dégâts joueur conservés.
```

Règles de design associées :

```text
- le grimoire hors combat reste dédié aux sorts hors combat ;
- le grimoire de combat est distinct et propre au héros actif ;
- les boutons Magie et Soin doivent rester rapides et directs ;
- la sélection par cadres est une brique UI réutilisable ;
- pas de sauvegarde des sorts actifs pour le moment ;
- pas d'objets consommables pour le moment ;
- pas de journal de quête ;
- pas de moniteur de quête explicite.
```

Scripts concernés par `v0.10` :

```text
scripts/ui/menu/CombatGrimoireMenuView.gd
scripts/combat/CombatManager.gd
scripts/dungeon/DungeonInputController.gd
scripts/ui/InGameMenuPanelUI.gd
scripts/ui/LogPanelUI.gd
```

## 6. Base héritée de v0.9

`v0.9` ajoute le grimoire hors combat et une sélection de cible par cadres de héros.

Fonctionnalités conservées :

```text
- grimoire accessible depuis le menu en jeu ;
- sorts de soin hors combat ;
- sélection de cible via cadres héros latéraux ;
- bordure verte sur la cible ;
- prévisualisation PV sur la cible ;
- prévisualisation PM sur le lanceur ;
- son de soin et flash vert à la validation ;
- canal de messages coloré pour les messages importants.
```

Le grimoire ne doit pas devenir un journal de quête. Les informations importantes peuvent être mieux colorées dans le canal de messages existant, mais sans checklist ni suivi d'objectifs explicite.

## 7. Base technique héritée de v0.8.2

`v0.8.2` reste la base de refactorisation interne.

Refactorisations validées localement :

```text
scripts/ui/InGameMenuPanelUI.gd -> scripts/ui/menu/*
scripts/combat/CombatManager.gd -> scripts/combat/Combat*Resolver/Helper/Access/Selector
scripts/dungeon/Dungeon.gd -> DungeonMapHelper / DungeonFloorStateHelper / DungeonAutoMapHelper
scripts/core/GameSession.gd -> scripts/core/session/*
scripts/ui/PartyCreationUI.gd -> scripts/ui/party_creation/*
```

Règles conservées :

```text
- scènes Godot conservées ;
- grandes façades publiques conservées ;
- éviter les changements de format de sauvegarde sans décision explicite ;
- tests locaux validés par l'utilisateur avant release.
```

## 8. Renderer et builds de test

La base `v0.8.1` reste valide pour le renderer :

```ini
config/features=PackedStringArray("4.6", "GL Compatibility")
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"
window/stretch/scale=1.0
window/stretch/scale_mode="fractional"
renderer/rendering_method="gl_compatibility"
```

Règles :

- exporter les builds Windows de playtest en `Compatibility / OpenGL` par défaut ;
- ne pas pousser les builds ;
- ne pas pousser les logs bruts ;
- documenter seulement des synthèses nettoyées dans `playtests/`.

## 9. Documentation et chemins actuels

Chemins actuels importants :

```text
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
README.md
CHANGELOG/README.md
CHANGELOG/vX.Y.md
audits/STATE_AUDITvX.Y.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
playtests/PLAYTEST_XX_vX.Y.md
```

`ROADMAP.md` et `TECHNICAL_DEBT.md` doivent être considérés comme localisés dans `docs/informations/`, pas à la racine.

## 10. Gestion des playtests

Les playtests doivent être documentés dans `playtests/`.

Règles :

- ne jamais pousser de logs bruts complets ;
- ne jamais pousser de sauvegardes testeurs ;
- ne jamais pousser de builds exportées ;
- reformuler les extraits de logs si nécessaire ;
- documenter clairement : contexte, machine, version testée, symptômes, conclusion, décision.

Nommage conseillé :

```text
playtests/PLAYTEST_01_v0.8.md
playtests/PLAYTEST_02_v0.10.md
```

## 11. Donjon et layouts

Avant toute modification de layout ou de symboles :

1. lire `ASSISTANT_WORKFLOW.md` ;
2. lire `docs/dungeon/FLOOR_DESIGN.md` ;
3. lire `docs/dungeon/FLOOR_VISUALIZER.md` ;
4. vérifier `scripts/dungeon/FloorDatabase.gd` ;
5. préserver strictement la lisibilité de la grille/tableau dans `FLOOR_VISUALIZER.md`.

Ne pas remplacer le visualiseur par un simple bloc ASCII, un format monospacé brut ou une variante CSS expérimentale sans demande explicite.

Les anciennes sauvegardes peuvent conserver des layouts mémorisés. Pour tester un nouveau layout, utiliser une nouvelle partie ou réinitialiser la sauvegarde de test.

## 12. Assets

Ne pas traiter les halos blancs autour des portraits ou sprites comme un style voulu. Ce sont des artefacts à éviter.

Pour les futurs assets :

- fond transparent propre ;
- contours sombres ou nets ;
- pas de halo blanc ;
- cohérence avec le style rétro sombre ;
- prudence avec les variations trop fortes entre frames.

## 13. Fichiers à ne pas pousser

```text
packs .zip générés
README_PACK.md
builds exportées
*.exe
*.pck
*.zip
logs bruts
captures système complètes
sauvegardes locales
dossier .godot/
build/
dist/
export/
*.tmp
*.bak
```

Les zips locaux de sécurité restent hors repo.

## 14. Préparation de release

Quand l'utilisateur valide qu'une série de changements est terminée :

1. préparer un pack documentaire complet ;
2. inclure le changelog de la version ;
3. mettre à jour l'index du changelog ;
4. mettre à jour `README.md` si la version publique ou les chemins changent ;
5. mettre à jour `docs/informations/ROADMAP.md` ;
6. mettre à jour `docs/informations/TECHNICAL_DEBT.md` ;
7. mettre à jour `IA_RELAIS.md` si la base de reprise change ;
8. créer un audit d'état si utile ;
9. fournir une note de release GitHub à copier.

Toujours séparer :

```text
Nouveaux fichiers
Fichiers mis à jour
Fichiers à ne pas pousser
Tests recommandés
Titre de release conseillé
Texte de release conseillé
```

## 15. Versioning

Ne pas accélérer artificiellement vers `v1.0`.

Le projet peut continuer ainsi :

```text
v0.9
v0.10
v0.11
...
```

`v1.0` doit être réservé à une version réellement complète, stable, documentée et exportable proprement.
