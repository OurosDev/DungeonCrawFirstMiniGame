# IA_RELAIS — Passage de main assistant

Date de mise à jour : 2026-06-19
Projet : `DungeonCrawFirstMiniGame`
Repo public : `https://github.com/OurosDev/DungeonCrawFirstMiniGame`
Langue de travail : français
Base récente vérifiée : `v0.8.1 — Stabilisation playtest et scaling fenêtre`

---

## 1. Rôle de ce fichier

Ce fichier sert de relais entre deux conversations avec l'assistant.

Au début d'une nouvelle conversation de travail sur ce projet, l'assistant doit :

1. lire ce fichier en premier ;
2. lire `ASSISTANT_WORKFLOW.md` à la racine ;
3. vérifier l'état réel du repo public sur `main` ;
4. consulter les documents structurants du repo ;
5. signaler toute incohérence entre ce fichier, le repo, les releases GitHub, les audits, les changelogs et les demandes de l'utilisateur.

La source de vérité reste toujours le repo vérifié sur `main`, puis l'audit le plus récent, puis le changelog, puis ce fichier, puis la roadmap.

---

## 2. État confirmé récent

Dernière release GitHub connue :

```text
v0.8.1 — Stabilisation playtest et scaling fenêtre
```

Cette version est un correctif de stabilisation après `v0.8`.

Points confirmés :

- le projet est configuré en `GL Compatibility` ;
- le scaling fenêtre utilise `canvas_items + keep` ;
- les contrôles souris et clavier AZERTY de `v0.8` sont intégrés ;
- le playtest 01 est documenté dans `playtests/PLAYTEST_01_v0.8.md` ;
- les crashs Windows du playtest sont traités comme un problème de renderer/export, pas comme un bug gameplay confirmé ;
- les builds Windows de playtest doivent être exportées en `Compatibility / OpenGL` par défaut ;
- les builds, logs bruts, sauvegardes testeurs et zips locaux restent hors repo.

---

## 3. Boucle jouable actuelle

Le jeu contient actuellement :

- création d'un groupe de quatre héros ;
- exploration case par case ;
- deux étages ;
- états d'étages sauvegardés ;
- automap par étage ;
- rencontres aléatoires par étage ;
- combat au tour par tour ;
- inventaire partagé ;
- équipement de base par héros ;
- boutique avec vente et achat ;
- temple de guérison ;
- coffres ;
- messages / indices ;
- Clé du gardien ;
- porte verrouillée ;
- boss fixe `gardien_boss_etage_2` ;
- disparition persistante du boss après victoire ;
- retour titre après K.O. complet du groupe.

L'escalier derrière le boss est présent visuellement, mais ne mène pas encore à un étage 3.

---

## 4. Organisation documentaire actuelle

Fichiers importants :

```text
README.md
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
ROADMAP.md
TECHNICAL_DEBT.md
CHANGELOG/README.md
CHANGELOG/v0.8.1.md
audits/STATE_AUDITv0.8.1.md
playtests/README.md
playtests/PLAYTEST_01_v0.8.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
project.godot
```

`ASSISTANT_WORKFLOW.md` à la racine est la source de vérité pour les règles de collaboration.

Si `docs/ASSISTANT_WORKFLOW.md` existe encore, il doit être considéré comme obsolète ou comme une simple redirection vers le fichier racine. Ne pas utiliser son ancien contenu comme référence principale.

---

## 5. Incohérences repérées lors de l'audit v0.8.1

L'audit documentaire a repéré plusieurs documents en retard avant synchronisation :

- `ROADMAP.md` indiquait encore `v0.7.1` comme base stable ;
- `TECHNICAL_DEBT.md` parlait encore d'une boucle stable jusqu'à `v0.7.1` ;
- `audits/STATE_AUDITv0.8.md` restait utile mais antérieur à `v0.8.1` ;
- `README.md` était encore très minimal pour un dépôt public jouable ;
- un ancien `docs/ASSISTANT_WORKFLOW.md` existait en doublon et contenait des règles obsolètes.

Le pack documentaire `v0.8.1_doc_sync` doit corriger cette situation.

---

## 6. Prochaine direction recommandée

Ne pas ajouter immédiatement un gros bloc de contenu sans tenir compte du playtest.

Priorités recommandées :

1. poursuivre ou clôturer proprement le playtest 01 si de nouveaux retours arrivent ;
2. traiter les retours de confort ou bugs confirmés ;
3. améliorer les feedbacks joueur : boss, clé, coffres, sauvegarde, K.O. ;
4. faire seulement des refactorisations légères et ciblées ;
5. préparer ensuite `v0.8.2` ou `v0.9` selon le périmètre.

Interprétation de version :

- `v0.8.2` : correctifs, polish, documentation, confort post-playtest ;
- `v0.9` : nouveau contenu visible, étage 3 ou progression supplémentaire.

---

## 7. Points techniques à ne pas oublier

- Les anciennes sauvegardes peuvent conserver d'anciens layouts mémorisés.
- Pour tester un changement de layout, utiliser une nouvelle partie ou réinitialiser une sauvegarde de test.
- Le renderer recommandé pour playtest Windows est `Compatibility / OpenGL`.
- Les logs bruts ne doivent jamais être poussés.
- Les builds `.exe`, `.pck`, `.zip` ne doivent jamais être poussées.
- L'outil de téléportation de développement est temporaire et devra être désactivé ou supprimé avant une version finale propre.
- Les contours blancs / halos clairs autour des portraits ou sprites ne font pas partie du style voulu.

---

## 8. Prompt court de reprise

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame. Lis d'abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md. Vérifie ensuite l'état actuel du repo GitHub sur main, la dernière release, les changelogs, les audits, la roadmap, les documents dungeon et les playtests. Travaille en français, signale les incohérences, et fournis des packs complets de fichiers à remplacer quand tu modifies le projet. La base récente est v0.8.1 : Compatibility/OpenGL, scaling fenêtre canvas_items + keep, playtest 01 documenté, logs/builds hors repo. La documentation a été synchronisée par le pack v0.8.1_doc_sync, avec un nouvel audit v0.8.1 et une neutralisation de l'ancien doublon docs/ASSISTANT_WORKFLOW.md.
```
