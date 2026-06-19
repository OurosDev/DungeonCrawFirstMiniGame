# IA_RELAIS — Passage de main assistant

Date de mise à jour : 2026-06-19

Projet : `DungeonCrawFirstMiniGame`

Repo public : `https://github.com/OurosDev/DungeonCrawFirstMiniGame`

Langue de travail : français

Base récente vérifiée / préparée : `v0.9 — Grimoire hors combat et sélection de cible`

## 1. Rôle de ce fichier

Ce fichier sert de relais entre deux conversations avec l'assistant.

Au début d'une nouvelle conversation de travail sur ce projet, l'assistant doit :

1. lire ce fichier en premier ;
2. lire `ASSISTANT_WORKFLOW.md` à la racine ;
3. vérifier l'état réel du repo public sur `main` ;
4. consulter les documents structurants du repo ;
5. signaler toute incohérence entre ce fichier, le repo, les releases GitHub, les audits, les changelogs et les demandes de l'utilisateur.

La source de vérité reste toujours le repo vérifié sur `main`, puis l'audit le plus récent, puis le changelog, puis ce fichier, puis la roadmap.

## 2. Prompt court de reprise

À donner au nouvel assistant si nécessaire :

```text
Nous continuons le projet Godot public DungeonCrawFirstMiniGame. Lis d'abord IA_RELAIS.md puis ASSISTANT_WORKFLOW.md. Ensuite vérifie l'état actuel du repo GitHub sur main, les changelogs, les audits, la roadmap dans docs/informations, les documents dungeon et les playtests. Travaille en français, signale les incohérences, et fournis des packs complets de fichiers à remplacer quand tu modifies le projet.

La base récente est v0.9 : grimoire hors combat avec soins, sélection de cible par cadres héros, prévisualisation PV/PM, contrôles souris/flèches/ZQSD/A/E, messages colorés, sans journal de quête, sans consommables et sans nouveau format de sauvegarde volontaire. La base renderer reste Compatibility/OpenGL avec scaling fenêtre canvas_items + keep.
```

## 3. État confirmé récent

Dernière release à préparer / vérifier :

```text
v0.9 — Grimoire hors combat et sélection de cible
```

Base précédente :

```text
v0.8.2 — Refactorisations internes et stabilisation technique
```

`v0.9` est une version de gameplay ciblée. Elle ajoute une première fonction réelle au grimoire sans changer la philosophie du jeu : le grimoire sert à utiliser des sorts hors combat, pas à suivre les quêtes.

## 4. Fonctionnalité v0.9 : grimoire hors combat

### Scripts principaux

Nouveaux scripts :

```text
scripts/ui/menu/GrimoireMenuView.gd
scripts/ui/hero_selection/HeroFrameSelectionController.gd
```

Scripts modifiés :

```text
scripts/ui/InGameMenuPanelUI.gd
scripts/ui/LogPanelUI.gd
scripts/ui/PartyStatusUI.gd
```

### Comportement validé

```text
- Grimoire accessible depuis le menu en jeu.
- Boutons compacts : Nom du lanceur — Nom du sort.
- Sélection d'un sort de soin hors combat.
- Sélection de cible via cadres héros latéraux.
- Le premier héros est sélectionné par défaut.
- Bordure verte sur la cible active.
- Survol souris déplace la sélection.
- Clic souris valide la cible.
- Flèches et ZQSD déplacent la cible.
- Entrée/A valide.
- Échap/E annule.
- Prévisualisation de soin sur la barre de PV de la cible uniquement.
- Prévisualisation du coût PM sur la barre de mana du lanceur uniquement.
- Son de soin et flash vert à la validation.
- Retour à l'état normal après validation.
```

### Contraintes de design validées

```text
- Pas de journal de quête.
- Pas de moniteur d'objectif.
- Pas de liste automatique d'indices.
- Pas de consommables pour le moment.
- Le grimoire sert d'interface d'action magique hors combat.
- Les informations importantes passent par le canal de messages existant, avec variations de couleur si utile.
```

## 5. Base technique héritée de v0.8.2

`v0.8.2` a refactorisé les scripts lourds sans changement volontaire de gameplay.

### Menu en jeu

Fichier principal conservé :

```text
scripts/ui/InGameMenuPanelUI.gd
```

Helpers :

```text
scripts/ui/menu/MenuUIFactory.gd
scripts/ui/menu/DevTeleportMenuView.gd
scripts/ui/menu/InventoryMenuView.gd
scripts/ui/menu/ShopMenuView.gd
scripts/ui/menu/StatusEquipmentMenuView.gd
scripts/ui/menu/GrimoireMenuView.gd
```

### Sélection de cadres héros

```text
scripts/ui/hero_selection/HeroFrameSelectionController.gd
```

Ce contrôleur doit être considéré comme réutilisable. Il ne doit pas rester lié exclusivement au grimoire si d'autres mécaniques ciblant un héros apparaissent.

### Combat

Fichier principal conservé :

```text
scripts/combat/CombatManager.gd
```

Helpers :

```text
scripts/combat/CombatActorAccess.gd
scripts/combat/CombatAccuracyResolver.gd
scripts/combat/CombatDamageResolver.gd
scripts/combat/CombatAbilityResolver.gd
scripts/combat/CombatTargetSelector.gd
scripts/combat/CombatLogHelper.gd
```

### Donjon

Fichier principal conservé :

```text
scripts/dungeon/Dungeon.gd
```

Helpers :

```text
scripts/dungeon/DungeonMapHelper.gd
scripts/dungeon/DungeonFloorStateHelper.gd
scripts/dungeon/DungeonAutoMapHelper.gd
```

### Session globale

Fichier principal conservé :

```text
scripts/core/GameSession.gd
```

Helpers :

```text
scripts/core/session/GameSessionFloorStateHelper.gd
scripts/core/session/GameSessionShopHelper.gd
scripts/core/session/GameSessionEquipmentHelper.gd
```

### Création d'équipe

Fichier principal conservé :

```text
scripts/ui/PartyCreationUI.gd
```

Helpers :

```text
scripts/ui/party_creation/PartyCreationUIFactory.gd
scripts/ui/party_creation/PartyCreationHeroBuilder.gd
scripts/ui/party_creation/PartyCreationSummaryHelper.gd
```

## 6. Base technique toujours valable depuis v0.8.1

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

Décisions validées :

```text
- Les builds Windows de playtest utilisent Compatibility / OpenGL.
- Les builds .exe / .pck / .zip restent locales et hors repo.
- Les logs complets restent hors repo.
- Les fichiers playtests utilisent seulement des résumés nettoyés / réécrits.
- Le scaling fenêtre validé utilise canvas_items + keep.
- Le stretch viewport a été rejeté pour v0.8.1 car il réduisait la lisibilité des textes en 1080p.
```

## 7. Fonctionnalités majeures déjà en place

### Base jeu

```text
- Dungeon crawler rétro inspiré de Swords and Serpents NES.
- Godot 4.6.
- Rendu Compatibility / OpenGL pour les builds de test.
- Interface et contrôles souris / clavier AZERTY.
```

### Contrôles

```text
- Z : avancer
- Q : tourner à gauche
- S : reculer
- D : tourner à droite
- A : confirmer / équivalent Espace ou Entrée
- E : retour / équivalent Échap
- Commandes exploration cliquables
- Commandes combat cliquables
- Clic souris pour valider l'attente après dégâts en combat
- Grimoire : souris, flèches, ZQSD, A/E
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
- Drops monstres ajoutés à l'inventaire.
- Équipement par héros : Arme, Casque, Armure, Bouclier, Bijou.
- Objets équipés retirés de l'inventaire et rendus au déséquipement.
- Bonus plats centralisés dans ItemDatabase.gd.
- Boutique : vente et achat d'objets de base.
- Prix d'achat boutique : sell_value × 4.
- Temple : restauration gratuite HP/MP complète.
- Grimoire : soins hors combat.
- Coffres persistants.
- Messages / indices.
- Clé du gardien consommée à l'ouverture de la porte verrouillée du boss.
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

## 8. Documentation importante à consulter

Au démarrage d'une nouvelle conversation, consulter au minimum :

```text
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
README.md
CHANGELOG/README.md
CHANGELOG/v0.9.md
audits/STATE_AUDITv0.9.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
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
audits/ : photographie fiable d'un état du repo.
docs/informations/ROADMAP.md : direction et priorités, peut être en retard.
docs/informations/TECHNICAL_DEBT.md : dettes et refactorisations.
docs/dungeon/FLOOR_DESIGN.md : règles de design d'étage.
docs/dungeon/FLOOR_VISUALIZER.md : visualisation lisible des layouts.
playtests/ : retours de test propres, sans logs bruts.
project.godot : configuration réelle du projet.
```

Priorité de confiance en cas d'incohérence :

```text
1. Repo vérifié sur main
2. Dernier audit d'état
3. Changelog correspondant à la version
4. IA_RELAIS.md
5. ROADMAP.md
6. Mémoire de conversation
```

Si le repo contredit ce fichier, signaler l'écart avant de proposer un pack.

## 9. Règles de modification

Toujours travailler ainsi :

```text
1. Vérifier le repo public avant de modifier.
2. Lister les fichiers concernés.
3. Préparer des fichiers complets ou un zip de remplacement.
4. Ajouter / maintenir les commentaires de sections dans les scripts.
5. Séparer nouveaux fichiers, fichiers mis à jour et fichiers à ne pas pousser.
6. Mettre à jour la documentation concernée seulement au bon moment du workflow.
```

Règle spéciale pour les refactorisations ou modifications importantes :

```text
1. L'utilisateur fait d'abord un zip local de sécurité.
2. L'assistant fournit un pack complet de scripts à remplacer.
3. L'utilisateur teste localement.
4. Si les tests sont OK, l'utilisateur fait un nouveau zip local.
5. On continue avec la refactorisation suivante.
6. La documentation et la release sont préparées seulement quand la série de refactorisations est terminée.
```

Si l'assistant a un doute sur un fichier GitHub ou si l'état local de l'utilisateur peut différer de `main`, il doit demander le fichier local concerné.

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

## 10. Points à ne plus traiter comme ouverts

Ces points sont considérés comme réglés ou non bloquants :

```text
- Fichiers temporaires scenes/*.tmp : supprimés.
- Crash coffre / sauvegarde du playtest v0.8 : réglé par Compatibility / OpenGL.
- Scaling fenêtre v0.8.1 : réglé par canvas_items + keep.
- OneDrive : non retenu comme cause principale du crash, car Vulkan hors OneDrive crashait aussi.
- Première passe de refactorisation des scripts lourds : validée en v0.8.2.
- Grimoire de soins hors combat : validé en v0.9.
```

Ne pas rouvrir ces points sans nouveau symptôme ou nouvelle preuve.

## 11. Prochaines pistes probables

Après `v0.9` :

```text
- playtest court post-v0.9 ;
- polish du grimoire si de nouveaux retours apparaissent ;
- futurs sorts utilitaires hors combat, notamment téléportation ou retour ;
- amélioration progressive des messages importants colorés ;
- feedbacks de boss, mort, sauvegarde et progression ;
- centralisation progressive des symboles et règles de cases ;
- étage 3 seulement après décision claire de périmètre, pas comme priorité immédiate.
```

Contraintes de direction :

```text
- ne pas proposer d'objets consommables pour le moment ;
- ne pas transformer le grimoire en journal de quête ;
- ne pas ajouter un suivi explicite d'objectifs ;
- privilégier les fonctionnalités qui enrichissent la boucle existante.
```

Pour les futures bordures UI :

```text
- préférer StyleBoxTexture pour les cadres Panel / PanelContainer / Button ;
- utiliser une texture 9-slice / 9-patch ;
- éviter de tout faire en NinePatchRect si le besoin est un thème global ;
- envisager plus tard un thème dédié, par exemple themes/dungeon_ui_theme.tres ;
- ne pas mélanger une refonte visuelle UI avec un gros changement gameplay.
```

## 12. Avertissements importants

```text
- Ne pas identifier le style du projet à partir des halos blancs des assets : ce sont des artefacts à éviter.
- Ne pas supposer que v1.0 approche automatiquement.
- Ne pas modifier les layouts sans vérifier FLOOR_VISUALIZER.md et FLOOR_DESIGN.md.
- Pour FLOOR_VISUALIZER.md, conserver le format tableau/grille avec coordonnées.
- Ne pas pousser les builds de playtest.
- Ne pas demander de logs bruts pour les commiter : les demander seulement en zip local temporaire si nécessaire pour analyse.
- Ne pas traiter docs/informations/ROADMAP.md comme source absolue si un audit ou un changelog plus récent le contredit.
```

## 13. Première réponse recommandée dans une nouvelle conversation

Après lecture de ce fichier et vérification du repo, répondre brièvement avec :

```text
- état confirmé du repo ;
- dernière version/release détectée ;
- documents clés lus ;
- incohérences éventuelles ;
- prochaine action proposée.
```

Ne pas commencer directement à modifier des fichiers sans ce point de synchronisation.
