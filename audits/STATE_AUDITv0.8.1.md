# STATE_AUDITv0.8.1 — Audit documentaire et état du repo

Date d'audit : 2026-06-19
Version de référence : `v0.8.1 — Stabilisation playtest et scaling fenêtre`
Branche vérifiée : `main`
Objectif : établir une photographie fiable de l'état du dépôt après `v0.8.1`, relever les incohérences documentaires et fixer la base de reprise.

---

## 1. Résumé exécutif

Le dépôt est dans un état sain pour un prototype pré-1.0.

La base récente `v0.8.1` est cohérente avec la release GitHub, le changelog `v0.8.1`, `project.godot` et le playtest 01 :

- renderer `Compatibility / OpenGL` ;
- scaling fenêtre `canvas_items + keep` ;
- playtest 01 documenté ;
- crashs Windows classés comme contrainte de renderer/export ;
- builds et logs hors repo.

La principale faiblesse constatée n'est pas gameplay, mais documentaire : certains fichiers de pilotage étaient encore en retard ou dupliqués.

---

## 2. État de version constaté

### 2.1 Dernière release

Dernière release visible :

```text
v0.8.1 — Stabilisation playtest et scaling fenêtre
```

Statut : latest.

Contenu annoncé :

- passage du projet en `Compatibility / OpenGL` ;
- correction du scaling de fenêtre avec `canvas_items + keep` ;
- règle de build Windows playtest en `Compatibility / OpenGL` ;
- incident de playtest documenté sans logs bruts ;
- builds `.exe`, `.pck`, `.zip` gardées hors repo.

### 2.2 État de `project.godot`

Réglages structurants :

```ini
config/features=PackedStringArray("4.6", "GL Compatibility")
window/size/viewport_width=1152
window/size/viewport_height=648
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"
window/stretch/scale=1.0
window/stretch/scale_mode="fractional"
renderer/rendering_method="gl_compatibility"
```

Actions input visibles :

```text
move_forward
move_back
turn_left
turn_right
confirm_action
back_action
```

Interprétation : `project.godot` est aligné avec `v0.8.1`.

---

## 3. Organisation générale du dépôt

### 3.1 Racine

Fichiers et dossiers principaux observés :

```text
.gitignore
README.md
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
ROADMAP.md
TECHNICAL_DEBT.md
project.godot
CHANGELOG/
assets/
audits/
docs/
playtests/
scenes/
scripts/
```

Rôle :

- `README.md` : présentation publique du projet ;
- `IA_RELAIS.md` : passage de main entre conversations ;
- `ASSISTANT_WORKFLOW.md` : règles de collaboration ;
- `ROADMAP.md` : priorités et direction ;
- `TECHNICAL_DEBT.md` : dette technique ;
- `CHANGELOG/` : historique des versions ;
- `audits/` : photographies d'état du repo ;
- `docs/dungeon/` : design et visualisation d'étages ;
- `playtests/` : synthèses propres des tests.

### 3.2 Scripts

Organisation observée :

```text
scripts/abilities/
scripts/audio/
scripts/characters/
scripts/combat/
scripts/core/
scripts/dungeon/
scripts/equipment/
scripts/inventory/
scripts/items/
scripts/monsters/
scripts/shop/
scripts/ui/
```

Rôles principaux :

- `abilities/` : données et base des compétences ;
- `audio/` : gestion audio globale ;
- `characters/` : héros, classes, portraits, jets de stats ;
- `combat/` : combat, récompenses, ordre de tour ;
- `core/` : session, sauvegarde, stats ;
- `dungeon/` : joueur grille, données d'étage, rendu, sauvegarde donjon ;
- `equipment/` : règles d'équipement ;
- `inventory/` : inventaire partagé ;
- `items/` : données et base d'objets ;
- `monsters/` : données et base de monstres ;
- `shop/` : règles de boutique ;
- `ui/` : interface, automap, menus, portraits, combat, statut.

### 3.3 Scènes

Le dossier `scenes/` ne montre plus les anciens fichiers temporaires `.tmp`.

Fichiers visibles :

```text
Dungeon.tscn
MainMenu.tscn
PartyCreation.tscn
```

---

## 4. Documentation constatée

### 4.1 Changelog

`CHANGELOG/README.md` référence les versions jusqu'à `v0.8.1`.

`CHANGELOG/v0.8.1.md` décrit correctement :

- le scaling ;
- le renderer ;
- la règle de playtest ;
- les fichiers concernés ;
- les éléments à ne pas pousser.

Statut : aligné.

### 4.2 Playtests

`playtests/README.md` contient les règles de nommage, les sections recommandées, les règles pour logs et builds.

`playtests/PLAYTEST_01_v0.8.md` documente :

- le test externe initial ;
- les crashs Windows ;
- la configuration Intel UHD Graphics ;
- la non-reproduction locale ;
- la résolution par build `Compatibility / OpenGL` ;
- le scaling corrigé en `v0.8.1`.

Statut : aligné avec `v0.8.1`.

### 4.3 Dungeon docs

`docs/dungeon/FLOOR_DESIGN.md` et `docs/dungeon/FLOOR_VISUALIZER.md` sont bien dans le dossier prévu.

`FLOOR_VISUALIZER.md` conserve le format attendu de grille/tableau avec symboles visibles et reste un outil de lecture, pas une source gameplay.

Statut : pas de modification nécessaire pour ce pack, sauf si le layout change plus tard.

---

## 5. Incohérences repérées avant synchronisation

### 5.1 ROADMAP.md en retard

Problème : `ROADMAP.md` indiquait encore `v0.7.1` comme version stable actuelle et proposait une prochaine version probable `v0.7.2` ou `v0.8`.

État réel : le dépôt et la release sont à `v0.8.1`.

Action recommandée : remplacer `ROADMAP.md` par une version courte et alignée sur `v0.8.1`.

### 5.2 TECHNICAL_DEBT.md en retard

Problème : le document parlait encore d'une première boucle stable jusqu'à `v0.7.1` et de points avant playtest externe.

État réel : le playtest 01 a eu lieu, le renderer de playtest est documenté et le scaling est corrigé.

Action recommandée : reclasser le scaling comme résolu, les crashs renderer comme contrainte d'export, et mettre à jour les priorités de dette.

### 5.3 README.md trop minimal

Problème : le `README.md` public ne décrit presque pas l'état jouable, les contrôles, le renderer, les règles de playtest ni l'organisation du dépôt.

Action recommandée : enrichir `README.md` sans le transformer en changelog.

### 5.4 Double ASSISTANT_WORKFLOW.md

Problème : il existe un `ASSISTANT_WORKFLOW.md` à la racine et un ancien `docs/ASSISTANT_WORKFLOW.md`.

Le fichier racine est plus complet et plus récent. Le fichier `docs/ASSISTANT_WORKFLOW.md` contient des règles obsolètes, notamment une base de travail `v0.8` avec `v0.8.1` encore présenté comme point prioritaire.

Action recommandée : conserver la source de vérité à la racine et remplacer `docs/ASSISTANT_WORKFLOW.md` par une note de redirection, ou supprimer le fichier si le dépôt est nettoyé plus tard.

### 5.5 Audit précédent dépassé

`audits/STATE_AUDITv0.8.md` reste utile comme historique, mais il est antérieur à `v0.8.1`.

Action recommandée : ajouter `audits/STATE_AUDITv0.8.1.md`.

---

## 6. Fichiers recommandés pour le pack documentaire

### Nouveaux fichiers

```text
audits/STATE_AUDITv0.8.1.md
```

### Fichiers mis à jour

```text
README.md
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
ROADMAP.md
TECHNICAL_DEBT.md
docs/ASSISTANT_WORKFLOW.md
```

### Fichiers non modifiés

```text
CHANGELOG/README.md
CHANGELOG/v0.8.1.md
playtests/README.md
playtests/PLAYTEST_01_v0.8.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
project.godot
```

### À ne pas pousser

```text
pack zip généré
README_PACK.md temporaire éventuel
builds .exe / .pck / .zip
logs bruts
captures système complètes
sauvegardes locales de testeurs
backups locaux
```

---

## 7. État recommandé après synchronisation

Après application du pack documentaire, la base de reprise doit être :

```text
v0.8.1 — base stable récente
Documentation alignée
Audit v0.8.1 présent
Workflow racine source de vérité
Ancien workflow docs neutralisé
Roadmap orientée v0.8.2 / v0.9
Dette technique reclassée post-playtest
README public informatif
```

---

## 8. Prochaine action recommandée

Ne pas ajouter directement l'étage 3 sans décider du périmètre.

Choix conseillé :

```text
Option A — v0.8.2
Polish, feedbacks, corrections post-playtest, nettoyage léger.

Option B — v0.9
Nouveau contenu visible : étage 3, symboles futurs, progression après boss.
```

Recommandation : commencer par `v0.8.2` si de nouveaux retours de playtest existent ou si l'objectif est de consolider la base avant contenu.
