# IA_RELAIS — Passage de main assistant

Date de création : 2026-06-19  
Projet : `DungeonCrawFirstMiniGame`  
Repo public : `https://github.com/OurosDev/DungeonCrawFirstMiniGame`  
Langue de travail : français

---

## 1. Rôle de ce fichier

Ce fichier sert de relais entre deux conversations avec l’assistant.

Au début d’une nouvelle conversation de travail sur ce projet, l’assistant doit :

1. lire ce fichier en premier ;
2. lire `ASSISTANT_WORKFLOW.md` ;
3. vérifier l’état réel du repo public sur `main` ;
4. consulter les documents structurants du repo ;
5. signaler toute incohérence entre ce fichier, le repo, les releases GitHub et les demandes de l’utilisateur.

Ce fichier ne remplace pas le repo. Il sert de synthèse de contexte et de point de départ.

---

## 2. Prompt court de reprise

À donner au nouvel assistant si nécessaire :

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame. Lis d’abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md. Ensuite vérifie l’état actuel du repo GitHub sur main, les changelogs, les audits, la roadmap, les documents dungeon et les playtests. Travaille en français, signale les incohérences, et fournis des packs complets de fichiers à remplacer quand tu modifies le projet. La base récente est v0.8.1 : Compatibility/OpenGL, scaling fenêtre canvas_items + keep, playtest 01 documenté, logs/builds hors repo.
```

---

## 3. État récent du projet

Dernière base technique/documentaire poussée connue :

```text
v0.8.1 — Stabilisation playtest et scaling fenêtre
```

À vérifier au démarrage :

```text
- le tag/release GitHub v0.8.1 existe-t-il déjà ?
- project.godot contient-il toujours Compatibility / OpenGL ?
- project.godot contient-il toujours canvas_items + keep ?
- CHANGELOG/v0.8.1.md est-il bien présent ?
- playtests/PLAYTEST_01_v0.8.md est-il à jour ?
```

État attendu de `project.godot` :

```ini
config/features=PackedStringArray("4.6", "GL Compatibility")

[display]
window/size/viewport_width=1152
window/size/viewport_height=648
window/stretch/mode="canvas_items"
window/stretch/aspect="keep"
window/stretch/scale=1.0
window/stretch/scale_mode="fractional"

[rendering]
textures/canvas_textures/default_texture_filter=0
renderer/rendering_method="gl_compatibility"
```

Décisions validées récemment :

```text
- Les builds Windows de playtest utilisent Compatibility / OpenGL.
- Les builds .exe / .pck / .zip restent locales et hors repo.
- Les logs complets restent hors repo.
- Les fichiers playtests utilisent seulement des résumés nettoyés / réécrits.
- Le scaling fenêtre validé utilise canvas_items + keep.
- Le stretch viewport a été rejeté pour v0.8.1 car il réduisait la lisibilité des textes en 1080p.
```

---

## 4. Résumé du playtest 01

Fichier concerné :

```text
playtests/PLAYTEST_01_v0.8.md
```

Situation :

```text
PLAYTEST_01 — v0.8
Statut : en cours au moment du relais
Testeur : testeur externe 01
Objectif : boucle jouable, contrôles souris/AZERTY, stabilité générale
```

Incident majeur résolu :

```text
Crash natif Windows devant un coffre et lors du chargement de sauvegarde.
Non reproductible sur la machine de développement.
Builds modernes D3D12 / Vulkan non concluantes.
Build Compatibility / OpenGL validée chez le testeur.
```

Conclusion :

```text
Le problème est considéré comme résolu par procédure d’export.
Ne pas modifier le gameplay des coffres ou de la sauvegarde pour cet incident sans nouveau symptôme.
```

À faire plus tard :

```text
- intégrer les retours finaux du testeur ;
- séparer bugs, ressenti, suggestions et décisions ;
- ne jamais pousser les logs bruts.
```

---

## 5. Fonctionnalités majeures déjà en place

### Base jeu

```text
- Dungeon crawler rétro inspiré de Swords and Serpents NES.
- Godot 4.6.
- Rendu Compatibility / OpenGL pour les builds de test.
- Interface et contrôles souris / clavier AZERTY.
```

### Contrôles v0.8

```text
- Z : avancer
- Q : tourner à gauche
- S : reculer
- D : tourner à droite
- A : confirmer / équivalent Espace ou Entrée
- E : retour / équivalent Échap
- Commandes exploration cliquables
- Commandes combat cliquables
- Clic souris pour valider l’attente après dégâts en combat
```

### Donjon et étages

```text
- Étage 1 et étage 2.
- Transition étage 1 -> étage 2 via >
- Retour étage 2 -> étage 1 via <
- État par étage sauvegardé : portes ouvertes, cellules découvertes, boss vaincu, coffres ouverts.
```

### Symboles de layout

```text
# : mur
. : sol / couloir
D : porte fermée
d : porte ouverte runtime
> : escalier descendant
< : escalier montant
O : temple
B : boutique
C : coffre
M : message / indice
L : porte verrouillée
X : boss / rencontre majeure
F : combat fixe non boss réservé/futur
S : secret réservé/futur
P : piège réservé/futur
E : événement réservé/futur
R : rune/sort réservé/futur
```

### Systèmes gameplay

```text
- Inventaire partagé 24 slots.
- Stack max 9.
- Drops monstres ajoutés à l’inventaire.
- Équipement par héros : Arme, Casque, Armure, Bouclier, Bijou.
- Objets équipés retirés de l’inventaire et rendus au déséquipement.
- Bonus plats centralisés dans ItemDatabase.gd.
- Boutique : vente et achat d’objets de base.
- Prix d’achat boutique : sell_value × 4.
- Temple : restauration gratuite HP/MP complète.
- Coffres persistants.
- Messages / indices.
- Clé du gardien consommée à l’ouverture de la porte verrouillée du boss.
- Boss gardien étage 2 sur X, boss vaincu persistant.
- Retour titre après K.O. complet du groupe.
```

### Monstres intégrés

```text
zombie
gobelin
chauve_souris
troll
gardien
gardien_boss_etage_2
```

Le boss gardien réutilise les assets du gardien normal avec un multiplicateur de HP.

---

## 6. Documentation importante à consulter

Au démarrage d’une nouvelle conversation, consulter au minimum :

```text
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
README.md
CHANGELOG/README.md
CHANGELOG/v0.8.1.md
audits/STATE_AUDITv0.8.md
ROADMAP.md
TECHNICAL_DEBT.md
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
playtests/README.md
playtests/PLAYTEST_01_v0.8.md
project.godot
```

Rôle des documents :

```text
IA_RELAIS.md : synthèse de passage de main.
ASSISTANT_WORKFLOW.md : règles de collaboration et méthode de travail.
CHANGELOG/ : historique des versions.
audits/ : photographie fiable d’un état du repo.
ROADMAP.md : direction et priorités, peut être en retard.
TECHNICAL_DEBT.md : dettes et refactorisations.
docs/dungeon/FLOOR_DESIGN.md : règles de design d’étage.
docs/dungeon/FLOOR_VISUALIZER.md : visualisation lisible des layouts.
playtests/ : retours de test propres, sans logs bruts.
project.godot : configuration réelle du projet.
```

Priorité de confiance en cas d’incohérence :

```text
1. Repo vérifié sur main
2. Dernier audit d’état
3. Changelog correspondant à la version
4. IA_RELAIS.md
5. ROADMAP.md
6. Mémoire de conversation
```

Si le repo contredit ce fichier, signaler l’écart avant de proposer un pack.

---

## 7. Règles de modification

Toujours travailler ainsi :

```text
1. Vérifier le repo public avant de modifier.
2. Lister les fichiers concernés.
3. Préparer des fichiers complets ou un zip de remplacement.
4. Ajouter / maintenir les commentaires de sections dans les scripts.
5. Séparer nouveaux fichiers, fichiers mis à jour et fichiers à ne pas pousser.
6. Mettre à jour la documentation concernée avec les changements de code ou de procédure.
```

Ne pas pousser :

```text
README_PACK.md
packs .zip générés
builds .exe / .pck / .zip
logs bruts
captures système complètes
sauvegardes locales
dossier .godot/
build/
dist/
export/
```

---

## 8. Points à ne plus traiter comme ouverts

Ces points sont considérés comme réglés ou non bloquants :

```text
- Fichiers temporaires scenes/*.tmp : l’utilisateur indique qu’ils ont été supprimés depuis longtemps.
- Crash coffre / sauvegarde du playtest v0.8 : réglé par Compatibility / OpenGL.
- Scaling fenêtre v0.8.1 : réglé par canvas_items + keep.
- OneDrive : non retenu comme cause principale du crash, car Vulkan hors OneDrive crashait aussi.
```

Ne pas rouvrir ces points sans nouveau symptôme ou nouvelle preuve.

---

## 9. Prochaines pistes probables

Après finalisation/release de `v0.8.1` et réception des retours de playtest :

```text
- compléter playtests/PLAYTEST_01_v0.8.md ;
- décider si une v0.8.2 de retours playtest est utile ;
- reprendre le contenu ou polish pour v0.9 ;
- envisager une passe UI avec bordures texturées.
```

Pour les futures bordures UI :

```text
- préférer StyleBoxTexture pour les cadres Panel / PanelContainer / Button ;
- utiliser une texture 9-slice / 9-patch ;
- éviter de tout faire en NinePatchRect si le besoin est un thème global ;
- envisager plus tard un thème dédié, par exemple themes/dungeon_ui_theme.tres ;
- ne pas mélanger une refonte visuelle UI avec un gros changement gameplay.
```

---

## 10. Avertissements importants

```text
- Ne pas identifier le style du projet à partir des halos blancs des assets : ce sont des artefacts à éviter.
- Ne pas supposer que v1.0 approche automatiquement.
- Ne pas modifier les layouts sans vérifier FLOOR_VISUALIZER.md et FLOOR_DESIGN.md.
- Ne pas pousser les builds de playtest.
- Ne pas demander de logs bruts pour les commiter : les demander seulement en zip local temporaire si nécessaire pour analyse.
- Ne pas traiter ROADMAP.md comme source absolue si un audit ou un changelog plus récent le contredit.
```

---

## 11. Première réponse recommandée dans une nouvelle conversation

Après lecture de ce fichier et vérification du repo, répondre brièvement avec :

```text
- état confirmé du repo ;
- dernière version/release détectée ;
- documents clés lus ;
- incohérences éventuelles ;
- prochaine action proposée.
```

Ne pas commencer directement à modifier des fichiers sans ce point de synchronisation.
