# Règles de collaboration avec l'assistant

Ce document regroupe les règles de travail utilisées pour les échanges autour du projet `DungeonCrawFirstMiniGame`.

Il sert à éviter de surcharger `ROADMAP.md` avec des consignes qui concernent surtout la manière de préparer les modifications, les releases, les tests, la documentation et le passage de main entre conversations.

---

## 1. Langue et style de réponse

- Toujours continuer en français.
- Réponses directes, lisibles et structurées.
- Signaler clairement les incohérences entre GitHub, les releases, les audits, les documents et la conversation.
- Ne pas accélérer artificiellement vers `v1.0`.
- Préférer des versions pré-1.0 : `v0.8.1`, `v0.8.2`, `v0.9`, `v0.10`, etc.

---

## 2. Démarrage d'une nouvelle conversation / relais IA

Au premier échange d'une nouvelle conversation de travail sur ce projet, l'assistant doit obligatoirement :

1. lire `IA_RELAIS.md` s'il existe ;
2. lire `ASSISTANT_WORKFLOW.md` à la racine ;
3. vérifier l'état actuel du repo public GitHub sur `main` ;
4. vérifier la dernière release / le dernier tag disponible ;
5. consulter les documents de pilotage et de contexte ;
6. signaler les incohérences entre `IA_RELAIS.md`, le repo, les releases, les audits, les changelogs, la roadmap et les fichiers dupliqués éventuels.

Documents à consulter en priorité :

```text
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
README.md
CHANGELOG/README.md
CHANGELOG/vX.Y.md le plus récent
audits/STATE_AUDITvX.Y.Z.md le plus récent
ROADMAP.md
TECHNICAL_DEBT.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
playtests/PLAYTEST_XX_vX.Y.md le plus récent
project.godot
```

L'assistant doit aussi prendre connaissance de l'arborescence complète du repo :

- identifier les dossiers et fichiers présents ;
- comprendre les liens entre scripts, scènes, assets et documents ;
- lire les fichiers texte utiles avant toute modification ;
- repérer les assets binaires par chemin et usage probable ;
- ne pas prétendre avoir inspecté le contenu interne d'un asset binaire sans l'avoir réellement ouvert ou analysé.

Pour les scripts, il faut au minimum comprendre les responsabilités des fichiers majeurs avant de proposer une modification.
Pour les assets binaires, il suffit généralement d'identifier leur emplacement, leur rôle et leurs références, sauf si la tâche concerne directement l'image, l'audio ou la scène.

La première réponse d'une nouvelle conversation doit résumer brièvement :

- état confirmé du repo ;
- dernière version/release détectée ;
- documents clés pris en compte ;
- incohérences éventuelles ;
- prochaine action proposée.

---

## 3. Vérifications avant modification

Avant de proposer un pack de scripts ou de documentation :

1. vérifier l'état actuel du repo public GitHub ;
2. vérifier les fichiers concernés sur `main` ;
3. tenir compte des releases déjà créées ;
4. signaler si la roadmap, les documents de design, les audits ou les scripts ne sont pas alignés ;
5. éviter de repartir d'un ancien fichier de test ou d'un pack précédent si le repo contient une version plus récente.

Quand un cache GitHub est suspect, utiliser une URL avec paramètre anti-cache.

---

## 4. Format attendu pour les modifications de scripts

Quand des scripts doivent être modifiés :

- fournir les scripts complets quand raisonnable ;
- sinon fournir un pack `.zip` de fichiers à remplacer ;
- éviter les snippets partiels sauf si le fichier est vraiment trop grand ;
- ajouter des commentaires de sections clairs quand ils manquent.

Exemples de sections :

```gdscript
# CONSTANTES
# INITIALISATION
# INTERFACE
# DONJON
# COMBAT
# SAUVEGARDE
# HELPERS
```

Avant les modifications, lister les fichiers concernés.

---

## 5. Format attendu pour les fichiers à pousser

Toujours séparer :

```text
Nouveaux fichiers
Fichiers mis à jour
Fichiers à supprimer
À ne pas pousser
```

Pour les releases, distinguer aussi :

```text
Fichiers gameplay / scripts
Fichiers documentation
Fichiers temporaires à ne pas pousser
```

Exemples de fichiers à ne pas pousser :

```text
packs zip générés localement
README_PACK.md temporaire
sauvegardes zip locales
dossier .godot/
build/
dist/
export/
*.exe
*.pck
*.zip
logs bruts
captures système complètes
sauvegardes locales de testeurs
fichiers de test temporaires
```

---

## 6. Organisation documentaire

Organisation actuelle recommandée :

```text
README.md
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
ROADMAP.md
TECHNICAL_DEBT.md
CHANGELOG/
audits/
docs/
  dungeon/
    FLOOR_DESIGN.md
    FLOOR_VISUALIZER.md
playtests/
```

Règles :

- `README.md` reste à la racine ;
- `IA_RELAIS.md` reste à la racine et sert de passage de main entre conversations ;
- `ASSISTANT_WORKFLOW.md` reste à la racine pour accès rapide ;
- `CHANGELOG/` reste à la racine ;
- `audits/` contient les audits d'état ;
- `docs/dungeon/` contient les documents de conception et visualisation d'étages ;
- `playtests/` contient les synthèses propres des sessions de test.

Ne pas déplacer immédiatement tous les fichiers Markdown pour le seul rangement. Profiter d'une mise à jour réelle d'un document pour le déplacer au bon emplacement si nécessaire.

Important : s'il existe un ancien `docs/ASSISTANT_WORKFLOW.md`, le considérer comme obsolète ou comme simple redirection vers `../ASSISTANT_WORKFLOW.md`. La source de vérité est le fichier racine `ASSISTANT_WORKFLOW.md`.

---

## 7. Préférences de documentation

- `ROADMAP.md` doit rester court et orienté décisions.
- Les détails de versions doivent aller dans `CHANGELOG/`.
- Les règles de construction d'étage doivent rester dans `docs/dungeon/FLOOR_DESIGN.md`.
- La validation visuelle des layouts doit rester dans `docs/dungeon/FLOOR_VISUALIZER.md`.
- Les refactorisations et dettes techniques doivent aller dans `TECHNICAL_DEBT.md`.
- Les consignes de collaboration doivent rester dans ce fichier.
- Les retours de test doivent aller dans `playtests/`.
- Le relais de conversation doit aller dans `IA_RELAIS.md`.

---

## 8. Audits d'état

Les audits d'état doivent être placés dans `audits/`.

Convention de nommage :

```text
STATE_AUDITvX.X.X.md
```

Exemple :

```text
audits/STATE_AUDITv0.8.1.md
```

Chaque audit doit inclure en en-tête :

- date d'audit ;
- version de référence ;
- branche vérifiée ;
- objectif de l'audit.

Pour déterminer l'état réel du projet, privilégier :

1. le repo vérifié sur `main` ;
2. l'audit d'état le plus récent ;
3. le changelog ;
4. `IA_RELAIS.md` ;
5. la roadmap.

La roadmap sert à orienter les prochaines décisions, mais elle peut être en retard sur l'état réel du dépôt.

---

## 9. Préparation documentaire des releases

Lors de la préparation d'une future release, proposer aussi les mises à jour documentaires nécessaires.

À vérifier systématiquement :

- ajouter ou mettre à jour le fichier `CHANGELOG/vX.Y.md` correspondant à la release ;
- mettre à jour `CHANGELOG/README.md` pour référencer la nouvelle version ;
- mettre à jour `ROADMAP.md` si la version stable actuelle, la prochaine direction ou les priorités changent ;
- mettre à jour `TECHNICAL_DEBT.md` si une dette technique est ajoutée, résolue ou reclassée ;
- mettre à jour `docs/dungeon/FLOOR_DESIGN.md` si les règles de construction d'étage ou la nomenclature changent ;
- mettre à jour `docs/dungeon/FLOOR_VISUALIZER.md` si les layouts, symboles ou variantes de planification changent ;
- mettre à jour `playtests/` si une session de test apporte des informations utiles ;
- mettre à jour `IA_RELAIS.md` quand une conversation longue se termine ou quand un changement de base doit être transmis ;
- mettre à jour ce fichier si les règles de collaboration changent.

Ne pas pousser les `README_PACK.md` générés localement, sauf décision explicite.

---

## 10. Règles spécifiques à FLOOR_VISUALIZER.md

Lors d'une mise à jour de `docs/dungeon/FLOOR_VISUALIZER.md` :

- conserver l'affichage des cartes sous forme de tableau / grille ;
- respecter les normes de remplissage déjà en place ;
- afficher les murs en carrés `■` ;
- laisser les sols / couloirs en cellules vides ;
- garder les symboles spéciaux visibles tels quels : `D`, `O`, `B`, `C`, `M`, `L`, `X`, etc. ;
- ne pas remplacer le visualiseur par un bloc texte monospacé ;
- ne pas utiliser de version CSS/couleur expérimentale sauf demande explicite ;
- reconstruire la section `État actuel en jeu` depuis `FloorDatabase.gd` ;
- conserver les variantes dans une section séparée.

`FloorDatabase.gd` reste la source gameplay réelle. `FLOOR_VISUALIZER.md` est un outil de lecture et de planification, pas une source gameplay.

---

## 11. Règles de playtest

Les retours de playtest doivent être documentés dans `playtests/`.

Convention de nommage :

```text
PLAYTEST_XX_vX.Y.md
```

Exemples :

```text
playtests/PLAYTEST_01_v0.8.md
playtests/PLAYTEST_02_v0.8.1.md
playtests/PLAYTEST_03_v0.9.md
```

Chaque fichier de playtest doit indiquer en en-tête :

- numéro du playtest ;
- version testée ;
- date ou période ;
- build / renderer ;
- testeur(s) ;
- statut ;
- objectif.

Les retours doivent être séparés au minimum en :

```text
Bugs bloquants
Bugs importants
Confort / polish
Ressenti
Suggestions
Décisions retenues
Décisions reportées ou rejetées
```

---

## 12. Logs, captures et données de test

Les logs complets ne doivent jamais être poussés dans le repo.

Les fichiers `playtests/` doivent utiliser seulement :

- des extraits nettoyés ;
- des résumés réécrits ;
- des formulations anonymisées ;
- les informations strictement utiles au diagnostic.

À éviter dans le repo :

```text
logs bruts complets
chemins Windows complets avec noms d'utilisateur
identifiants machine
captures système complètes
sauvegardes locales de testeurs
archives de logs
```

Les vrais logs restent stockés localement hors repo par le développeur.

Si une analyse technique nécessite les logs complets, demander un pack `.zip` temporaire.

---

## 13. Builds de playtest et renderer

Les builds de playtest ne doivent pas être poussées dans le repo.

À ne pas pousser :

```text
*.exe
*.pck
*.zip
build/
dist/
export/
```

Pour les builds Windows destinées aux testeurs, utiliser par défaut :

```text
Compatibility / OpenGL
```

Cette règle vient du playtest `v0.8` :

- un testeur externe a rencontré des crashs natifs Windows avec les builds modernes `Forward+ / D3D12` ;
- une tentative Vulkan n'a pas résolu le problème ;
- le test Vulkan hors OneDrive a également crashé ;
- la build `Compatibility / OpenGL` a fonctionné correctement ;
- l'incident est donc considéré comme résolu par procédure d'export.

Conclusion pratique : pour les playtests Windows, exporter en `Compatibility / OpenGL` par défaut. Ne pas distribuer de builds D3D12 / Vulkan aux testeurs modestes sauf test technique volontaire.

---

## 14. Règles visuelles du projet

- Style : dungeon crawler rétro inspiré de *Swords and Serpents* NES.
- Les contours blancs autour des portraits, personnages ou monstres ne sont pas voulus.
- Les halos blancs sont des artefacts de détourage à éviter.
- Les assets doivent garder des contours propres, sombres, lisibles et sans halo clair.

---

## 15. Règles de release

- Le user fait une sauvegarde zip locale du projet à chaque release.
- Les releases doivent rester petites et testables.
- Les tags doivent servir de points de retour fiables.
- Après une release, vérifier si la documentation doit être mise à jour.
- Ne pas considérer que `v1.0` arrive automatiquement après `v0.9`.

---

## 16. Points de vigilance spécifiques

- Les anciennes sauvegardes peuvent conserver d'anciens layouts mémorisés.
- Pour tester un changement de layout, utiliser une nouvelle partie ou réinitialiser la sauvegarde de test.
- L'outil de téléportation de développement est temporaire.
- Il doit être désactivé ou supprimé avant une version finale propre.
- En cas de crash testeur non reproductible localement, récupérer les logs Godot avant de modifier le gameplay.
- Les builds locales `.exe`, `.pck` et `.zip` de playtest ne doivent pas être poussées dans le repo.

---

## 17. Dernière base de travail connue

```text
v0.8.1 — Stabilisation playtest et scaling fenêtre
```

Contenu majeur à retenir :

- base `v0.8` avec commandes souris et clavier AZERTY ;
- `project.godot` configuré en `GL Compatibility` ;
- scaling fenêtre corrigé par `canvas_items + keep` ;
- playtest 01 documenté ;
- crashs Windows traités comme contrainte renderer/export ;
- builds, logs et sauvegardes de test hors repo ;
- audit documentaire `v0.8.1` recommandé comme photographie actuelle du dépôt.
