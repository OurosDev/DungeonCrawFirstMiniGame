# ASSISTANT_WORKFLOW — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version de référence : `v0.11.1 — Carte agrandie et automap améliorée`

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
CHANGELOG/v0.11.1.md
audits/STATE_AUDITv0.11.1.md
docs/informations/ROADMAP.md
docs/informations/IDEAS.md
docs/informations/TECHNICAL_DEBT.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
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

## 8. Base actuelle v0.11.1

`v0.11.1` ajoute une carte agrandie d'exploration et améliore l'automap compacte.

Fonctionnalités validées :

```text
- bouton Carte en exploration ;
- carte agrandie affichée dans le viewport ;
- carte synchronisée avec l'automap ;
- aucune révélation de zones non découvertes ;
- fermeture par Retour, E ou Échap ;
- bouton Retour texturé dans le coin bas gauche du cadre ;
- tooltip de coordonnées au survol souris ;
- tooltip disponible sur carte agrandie et automap compacte ;
- pas de tooltip sur les murs ;
- pas de tooltip sur les cases non découvertes ;
- titre AUTOMAP retiré ;
- automap légèrement zoomée en conservant 15x11 cases.
```

Scripts concernés par `v0.11.1` :

```text
scripts/ui/AutoMapUI.gd
scripts/ui/CommandOverlayUI.gd
scripts/ui/DungeonViewportUI.gd
scripts/ui/GameUI.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonInputController.gd
```

## 9. Base v0.11 conservée

`v0.11-Polish` améliore l'identité visuelle de l'interface avec un cadre NineSlice sombre et corrige le libellé de classe d'Eldric.

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

## 10. Base v0.10 conservée

`v0.10` ajoute le grimoire de combat et le ciblage des soins en combat.

Fonctionnalités conservées :

```text
- bouton Grimoire pendant le combat ;
- grimoire de combat propre au héros actif ;
- sorts actifs temporaires réinitialisés à chaque combat ;
- bouton Magie lançant directement le sort offensif actif ;
- bouton Soin lançant directement le sort de soin actif ;
- soin en combat avec sélection directe par cadres de héros ;
- prévisualisation PV sur la cible ;
- prévisualisation PM sur le lanceur ;
- contrôles souris ;
- contrôles flèches / Entrée / Échap ;
- contrôles AZERTY ZQSD / A / E ;
- canal Combat coloré ligne par ligne.
```

## 11. Relecture régulière des documents de pilotage

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

## 12. ROADMAP.md et IDEAS.md

`docs/informations/ROADMAP.md` et `docs/informations/IDEAS.md` ont des rôles distincts.

```text
ROADMAP.md = cap, vision, prochaines phases probables, priorités.
IDEAS.md = boîte à idées, pistes non priorisées, envies à ne pas perdre.
```

Règles importantes :

- conserver une vision long terme ;
- conserver les contraintes de design actuelles visibles ;
- ne jamais effacer une idée de `IDEAS.md` par simple nettoyage ;
- ne retirer une idée que si elle est réalisée et que l'utilisateur confirme explicitement son retrait.

## 13. Tests recommandés par type de pack

### Pack UI / carte

```text
ouverture / fermeture Carte
Retour souris
E / Échap
blocage des déplacements pendant la carte
aucune carte en combat
étage 1
étage 2
zones non découvertes masquées
tooltip coordonnées sur cases découvertes non-mur
pas de tooltip sur murs
pas de tooltip sur cases non découvertes
automap compacte
redimensionnement fenêtre
```

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

## 14. Renderer et builds de test

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

## 15. Documentation et chemins actuels

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
```

## 16. Règles de design du jeu

Règles actuellement importantes :

```text
ne pas ajouter d'objets consommables pour le moment
ne pas ajouter de potions pour le moment
ne pas ajouter de journal de quête ou moniteur d'objectif
ne pas révéler d'informations non découvertes sur la carte
ne pas viser l'étage 3 comme priorité immédiate
enrichir d'abord la boucle complète existante avec des fonctionnalités
préserver une part de difficulté liée à l'absence de suivi explicite
privilégier les indices, feedbacks et couleurs de messages plutôt qu'une checklist
```
