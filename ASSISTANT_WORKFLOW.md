# ASSISTANT_WORKFLOW — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version de référence : `v0.11 — Cadres UI NineSlice et correction Prêtre`

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
CHANGELOG/v0.11.md
audits/STATE_AUDITv0.11.md
docs/informations/ROADMAP.md
docs/informations/IDEAS.md
docs/informations/TECHNICAL_DEBT.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
playtests/PLAYTEST_XX_vX.Y.md
project.godot
```

La source de vérité vérifiable principale reste l'état réel du repo sur `main`.

Si un document est en retard, le signaler clairement. Si l'assistant a un doute sur la version d'un fichier GitHub, si un fichier est trop long/difficile à consulter, ou si des modifications locales non poussées peuvent rendre GitHub obsolète, il doit demander à l'utilisateur de fournir le fichier local concerné plutôt que d'improviser.

## 2. Sources de vérité et base locale active

Le repo GitHub public sur `main` est la source vérifiable principale, mais il peut être en retard par rapport à l'état local de l'utilisateur.

Règles :

- si l'utilisateur indique avoir appliqué un pack local non encore poussé, cet état local devient la base de travail fonctionnelle pour la suite ;
- les fichiers locaux fournis explicitement par l'utilisateur pour la tâche en cours sont prioritaires pour cette tâche ;
- cette priorité locale ne doit pas exclure la consultation du repo GitHub ;
- cette priorité locale ne doit pas empêcher l'utilisation ou la modification de fichiers du repo GitHub quand cela améliore la cohérence globale, la documentation, la comparaison ou la préparation de release ;
- l'assistant doit signaler explicitement quand il travaille sur une base locale supposée plutôt que sur l'état GitHub vérifié ;
- si une modification dépend d'un fichier local non poussé, demander le fichier local concerné plutôt que reconstruire à partir d'une version GitHub possiblement obsolète ;
- ne pas considérer la mémoire de conversation comme plus fiable qu'un fichier de repo vérifié ou qu'un fichier local fourni par l'utilisateur ;
- quand une release vient d'être publiée, attendre ou revérifier `main` si GitHub semble encore afficher une version précédente.

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

## 3. Langue et format de réponse

- Travailler en français.
- Être direct et précis.
- Signaler les incohérences entre repo, mémoire, documents et demandes utilisateur.
- Donner des fichiers complets quand c'est raisonnable.
- Quand plusieurs fichiers sont concernés, fournir un pack complet téléchargeable en priorité.
- Les fichiers individuels peuvent être donnés en complément, mais le pack reste le livrable principal.

## 4. Conception avant modification sensible

Avant de modifier un système sensible, l'assistant doit d'abord résumer la conception prévue.

Systèmes sensibles :

```text
sauvegarde / chargement
combat
GameSession
inventaire / équipement
sorts / grimoire
input global
UI partagée comme PartyStatusUI
FloorDatabase / layouts
symboles et règles de cases du donjon
```

La conception préalable doit préciser :

```text
objectif gameplay ou technique
comportement attendu
fichiers probablement concernés
systèmes connexes à surveiller
risques connus
points à ne pas casser
tests à prévoir
```

Le pack de scripts ne doit être préparé qu'après validation explicite ou implicite de cette conception par l'utilisateur.

## 5. Périmètre évolutif maîtrisé

Le périmètre d'un pack doit être maîtrisé, mais pas verrouillé artificiellement. L'assistant doit annoncer les fichiers et systèmes probablement concernés, mais il doit garder la possibilité de toucher un système connexe si cela rend l'implémentation plus saine, plus stable ou plus durable.

Règles :

- ne pas contourner un système central uniquement pour limiter le nombre de fichiers modifiés ;
- si une fonctionnalité dépend naturellement de la sauvegarde, de `GameSession`, du combat, de l'input ou d'une UI partagée, évaluer si modifier proprement ce système est préférable à une solution locale fragile ;
- privilégier une séparation propre plutôt qu'une surcharge supplémentaire d'un contrôleur déjà lourd ;
- si deux approches sont possibles, comparer brièvement l'option locale minimale et l'option plus structurelle ;
- expliquer pourquoi un système connexe est touché ou volontairement laissé intact ;
- élargir le pack seulement si cela améliore la stabilité, la cohérence ou la préparation des évolutions futures.

Exemple : si une fonctionnalité de sorts actifs peut être faite sans sauvegarde, mais qu'un stockage sauvegardé préparerait mieux un futur grimoire individuel, l'assistant doit comparer les deux options au lieu d'éviter automatiquement `SaveManager.gd`.

## 6. Workflow général de modification

Avant toute modification importante :

1. vérifier l'état actuel du repo ou la base locale fournie ;
2. identifier les fichiers concernés ;
3. expliquer le périmètre évolutif maîtrisé ;
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

## 7. Workflow spécial refactorisation

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

Ne pas proposer de refactorisation générale sans raison concrète. Refactoriser seulement si :

- un script devient difficile à modifier ;
- une fonctionnalité nouvelle serait risquée sans extraction ;
- un bug montre une responsabilité mal isolée ;
- l'utilisateur demande explicitement une passe technique.

## 8. Base actuelle v0.11

`v0.11` améliore l'identité visuelle de l'interface avec un cadre NineSlice sombre et corrige le libellé de classe d'Eldric.

Fonctionnalités validées :

```text
- texture assets/ui/frames/texture_cadre_ui.png ;
- helper scripts/ui/theme/UIFrameStyle.gd ;
- StyleBoxTexture pour les cadres principaux ;
- cadres héros, viewport, journal et automap texturés ;
- cadres et boutons des menus texturés ;
- boutons de commandes exploration/combat texturés ;
- suppression du long cadre derrière les boutons de commandes ;
- correction Prêtresse -> Prêtre ;
- normalisation des anciennes sauvegardes vers Prêtre.
```

Points à surveiller :

```text
- une texture dédiée aux boutons sera probablement nécessaire ;
- vérifier régulièrement la lisibilité en basse résolution ;
- vérifier les états visuels de sélection, dégâts, soin et héros actif ;
- ne pas casser le scaling canvas_items + keep.
```

Scripts concernés par `v0.11` :

```text
scripts/ui/theme/UIFrameStyle.gd
scripts/ui/GameUI.gd
scripts/ui/PartyStatusUI.gd
scripts/ui/DungeonViewportUI.gd
scripts/ui/CommandOverlayUI.gd
scripts/ui/LogPanelUI.gd
scripts/ui/AutoMapUI.gd
scripts/ui/menu/MenuUIFactory.gd
scripts/characters/ClassDatabase.gd
scripts/characters/CharacterData.gd
scripts/items/ItemDatabase.gd
scripts/core/SaveManager.gd
scripts/ui/PartyCreationUI.gd
```

Asset concerné par `v0.11` :

```text
assets/ui/frames/texture_cadre_ui.png
```

## 9. Base héritée de v0.10

`v0.10` ajoute le grimoire de combat et le ciblage des soins en combat.

Fonctionnalités conservées :

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

## 10. Base héritée de v0.9

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

Le grimoire ne doit pas devenir un journal de quête.

Les informations importantes peuvent être mieux colorées dans le canal de messages existant, mais sans checklist ni suivi d'objectifs explicite.

## 11. Base technique héritée de v0.8.2

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

## 12. Relecture régulière des documents de pilotage

L'assistant doit relire régulièrement les documents présents dans `docs/` pour conserver une cohérence entre les décisions, la dette technique et l'état réel du projet.

Moments où cette relecture est obligatoire :

```text
au début d'une nouvelle conversation de travail
avant de proposer une nouvelle direction de gameplay
avant de modifier un système sensible
avant une refactorisation importante
avant une préparation de release
avant toute modification de layout, symbole ou visualiseur d'étage
si l'utilisateur signale une incohérence documentaire
```

Documents à surveiller en priorité :

```text
docs/informations/ROADMAP.md
docs/informations/IDEAS.md
docs/informations/TECHNICAL_DEBT.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
playtests/PLAYTEST_XX_vX.Y.md
audits/STATE_AUDITvX.Y.md
```

Rôle de ces documents :

- `ROADMAP.md` oriente les priorités et évite de partir vers une piste contraire à la direction actuelle ;
- `IDEAS.md` conserve les idées longues, non priorisées ou reportées sans les perdre ;
- `TECHNICAL_DEBT.md` garde les risques connus, refactorisations utiles et points à éviter ;
- les audits donnent une photographie fiable de l'état réel du repo à une version donnée ;
- les documents `docs/dungeon/` encadrent les layouts, symboles et visualisations ;
- les playtests gardent une trace propre des problèmes constatés sans pousser de logs bruts.

Si un document est en retard mais que la tâche actuelle ne nécessite pas de le corriger immédiatement, le signaler et reporter sa mise à jour à la prochaine release ou passe documentaire.

## 13. ROADMAP.md et IDEAS.md

`docs/informations/ROADMAP.md` et `docs/informations/IDEAS.md` ont des rôles distincts.

```text
ROADMAP.md = cap, vision, prochaines phases probables, priorités.
IDEAS.md = boîte à idées, pistes non priorisées, envies à ne pas perdre.
```

### Mise à jour de ROADMAP.md

L'assistant peut modifier la roadmap sans demander une confirmation spécifique à chaque fois, mais il doit respecter ces règles :

- conserver une vision long terme, pas seulement l'état de la dernière release ;
- conserver une proposition de 3 à 5 prochaines phases quand c'est pertinent ;
- ne pas supprimer silencieusement une direction importante déjà discutée ;
- si une idée quitte la roadmap parce qu'elle n'est plus prioritaire, la conserver ou la déplacer dans `IDEAS.md` ;
- garder les contraintes de design actuelles visibles : pas de consommables, pas de journal de quête, pas d'étage 3 immédiat ;
- garder les priorités cohérentes avec `TECHNICAL_DEBT.md`, les audits et les playtests ;
- ne pas transformer la roadmap en simple changelog ;
- ne pas transformer la roadmap en boîte à idées exhaustive.

Avant de modifier `ROADMAP.md`, relire au minimum :

```text
docs/informations/ROADMAP.md
docs/informations/IDEAS.md
docs/informations/TECHNICAL_DEBT.md
CHANGELOG/README.md
l'audit le plus récent si disponible
```

### Mise à jour de IDEAS.md

`IDEAS.md` est conservateur : il sert à ne pas perdre les idées.

Règles strictes :

- ne jamais effacer une idée par simple nettoyage ;
- ne retirer une idée que si la fonctionnalité / action / modification a bien été effectuée et que l'utilisateur confirme explicitement son retrait du fichier ;
- si une idée devient prioritaire, elle peut être copiée ou promue dans `ROADMAP.md` sans être automatiquement supprimée de `IDEAS.md` ;
- si une idée devient moins pertinente, la déplacer dans une section reportée ou à discuter plutôt que la supprimer ;
- ajouter les nouvelles idées dans une section claire, même si elles ne sont pas prioritaires ;
- ne pas présenter le contenu de `IDEAS.md` comme une promesse de développement.

## 14. Tests recommandés par type de pack

L'assistant doit proposer des tests adaptés au type de modification.

### Pack combat

```text
attaque héros
attaque ennemi
magie
soin
sélection souris
sélection ZQSD / A / E
fuite
victoire
K.O.
boss si concerné
journal Combat
sauvegarde hors combat après combat
```

### Pack UI / menu

```text
ouverture / fermeture
souris
clavier ZQSD / A / E
retour / annulation
validation répétée
changement de résolution
absence de panneau bloquant les clics
aucune action importante inaccessible
```

### Pack sauvegarde

```text
nouvelle partie
ancienne sauvegarde
sauvegarde puis chargement
changement d'étage
inventaire
équipement
or
coffres
portes
boss vaincu
cellules automap découvertes
```

### Pack donjon / layout

```text
nouvelle partie ou sauvegarde réinitialisée
étage 1
étage 2
portes
escaliers
coffres
messages
temples
boutiques
porte verrouillée
boss
automap
rencontres aléatoires
```

## 15. Renderer et builds de test

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

## 16. Documentation et chemins actuels

Chemins actuels importants :

```text
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
README.md
CHANGELOG/vX.Y.md
audits/STATE_AUDITvX.Y.md
docs/informations/ROADMAP.md
docs/informations/IDEAS.md
docs/informations/TECHNICAL_DEBT.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
playtests/PLAYTEST_XX_vX.Y.md
```

`ROADMAP.md`, `IDEAS.md` et `TECHNICAL_DEBT.md` doivent être considérés comme localisés dans `docs/informations/`, pas à la racine.

## 17. Gestion des playtests

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

## 18. Donjon et layouts

Avant toute modification de layout ou de symboles :

1. lire `ASSISTANT_WORKFLOW.md` ;
2. lire `docs/dungeon/FLOOR_DESIGN.md` ;
3. lire `docs/dungeon/FLOOR_VISUALIZER.md` ;
4. vérifier `scripts/dungeon/FloorDatabase.gd` ;
5. préserver strictement la lisibilité de la grille/tableau dans `FLOOR_VISUALIZER.md`.

Ne pas remplacer le visualiseur par un simple bloc ASCII, un format monospacé brut ou une variante CSS expérimentale sans demande explicite.

Les anciennes sauvegardes peuvent conserver des layouts mémorisés. Pour tester un nouveau layout, utiliser une nouvelle partie ou réinitialiser la sauvegarde de test.

## 19. Règles de design du jeu

Règles actuellement importantes :

```text
ne pas ajouter d'objets consommables pour le moment
ne pas ajouter de potions pour le moment
ne pas ajouter de journal de quête ou moniteur d'objectif
ne pas viser l'étage 3 comme priorité immédiate
enrichir d'abord la boucle complète existante avec des fonctionnalités
préserver une part de difficulté liée à l'absence de suivi explicite
privilégier les indices, feedbacks et couleurs de messages plutôt qu'une checklist
```
