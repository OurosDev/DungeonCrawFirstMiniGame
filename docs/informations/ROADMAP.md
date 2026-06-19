# ROADMAP — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version de référence : `v0.9 — Grimoire hors combat et sélection de cible`

## 1. État actuel

La base récente est `v0.9`.

Le jeu possède maintenant une boucle complète courte mais jouable :

```text
création d'équipe -> exploration étage 1 -> étage 2 -> clé du gardien -> porte verrouillée -> boss -> passage derrière le boss
```

La base comprend :

```text
- exploration case par case ;
- deux étages ;
- transitions entre étages ;
- sauvegarde / chargement ;
- automap ;
- combats aléatoires ;
- combat de boss fixe ;
- retour titre après K.O. ;
- inventaire partagé ;
- équipement ;
- boutique ;
- temple de guérison ;
- coffres et messages ;
- clé de progression ;
- contrôles souris, flèches et AZERTY ;
- renderer Compatibility / OpenGL ;
- grimoire de soins hors combat.
```

`v0.8.2` a réduit la dette des grands contrôleurs. `v0.9` ajoute une fonctionnalité de gameplay sans étendre le contenu brut.

## 2. Direction de design actuelle

La priorité n'est pas d'ajouter immédiatement un étage 3.

La priorité est d'enrichir la boucle existante avec des fonctionnalités cohérentes :

```text
- grimoire hors combat ;
- sorts utilitaires futurs ;
- meilleurs feedbacks ;
- lisibilité des messages importants ;
- polish UI ciblé ;
- équilibrage ;
- playtests.
```

Contraintes de design validées :

```text
- pas d'objets consommables pour le moment ;
- pas de potions ;
- pas de journal de quête ;
- pas de moniteur d'objectif ;
- pas de checklist d'indices ;
- conserver une difficulté d'exploration old-school ;
- utiliser le canal de messages existant pour les informations importantes.
```

Le grimoire doit rester une interface d'action magique hors combat. Sa première fonction est le soin, et ses extensions futures doivent rester dans cette logique.

## 3. Priorité courte recommandée après v0.9

### Option A — Playtest court post-v0.9

Objectif : vérifier que le grimoire fonctionne bien dans une session complète et que la sélection de cible reste intuitive.

À tester :

```text
- nouvelle partie ;
- grimoire avec Prêtresse ;
- soin hors combat après combat ;
- prévisualisation PV/PM ;
- souris ;
- flèches ;
- ZQSD ;
- A/E ;
- sauvegarde après utilisation du grimoire ;
- chargement après PV/PM modifiés ;
- combat, boutique, inventaire et équipement après utilisation du grimoire.
```

Un fichier possible :

```text
playtests/PLAYTEST_02_v0.9.md
```

### Option B — Polish du grimoire

À faire seulement si les tests montrent un besoin :

```text
- ajuster les proportions UI ;
- améliorer les couleurs de prévisualisation ;
- améliorer la bordure verte ;
- éviter toute ambiguïté entre lanceur et cible ;
- améliorer les messages de refus.
```

### Option C — Feedbacks de progression

Sans journal de quête :

```text
- messages de clé plus visibles ;
- messages de porte verrouillée plus clairs ;
- messages de boss vaincu plus marquants ;
- messages de sauvegarde/chargement plus lisibles ;
- différencier couleur système, indice, avertissement, combat, grimoire.
```

## 4. Prochaine fonctionnalité probable après stabilisation

### Sorts utilitaires hors combat

Le socle du grimoire peut servir plus tard à :

```text
- téléportation ;
- retour à l'entrée ;
- retour au temple ;
- révélation limitée d'une zone de carte ;
- protection temporaire hors combat si compatible avec la vision du jeu.
```

Ces sorts devront être traités prudemment car ils peuvent modifier fortement l'équilibre et la tension d'exploration.

### Découverte de sorts

Pour des sorts avancés, il faudra probablement ajouter un système persistant :

```text
- sorts découverts ;
- sorts connus ;
- runes ou apprentissages ;
- sauvegarde dédiée des découvertes magiques.
```

À ne pas faire tant que le besoin n'est pas clair.

## 5. Contenu futur mais non prioritaire

### Étage 3

L'étage 3 reste une piste future, mais il n'est pas prioritaire juste après `v0.9`.

Avant de l'ajouter, il vaut mieux :

```text
- vérifier que la boucle actuelle est agréable ;
- stabiliser le grimoire ;
- clarifier les feedbacks ;
- équilibrer les soins hors combat ;
- faire au moins un playtest court de la version v0.9.
```

### Nouveaux monstres / sprites

Possible plus tard, si un nouvel étage ou un nouveau type de zone le justifie.

### Nouveaux équipements

Possible plus tard, mais ne doit pas devenir un remplacement indirect des consommables. Les équipements doivent rester centrés sur les classes, les choix de build simples et les récompenses durables.

## 6. Dette technique à surveiller

Points à surveiller après `v0.9` :

```text
- `PartyStatusUI.gd` devient plus complexe avec sélection de cadre et prévisualisations ;
- `InGameMenuPanelUI.gd` reste une façade centrale importante ;
- `HeroFrameSelectionController.gd` doit rester réutilisable et ne pas se spécialiser trop fortement sur le grimoire ;
- les couleurs de messages doivent rester maintenables ;
- les futurs sorts hors combat ne doivent pas dupliquer la logique d'input.
```

## 7. Versioning conseillé

Ne pas accélérer vers `v1.0`.

Suites possibles :

```text
v0.9.1 — Correctifs / polish grimoire si nécessaire
v0.10 — Sort utilitaire hors combat ou feedbacks avancés
v0.11 — Nouvelle étape de contenu seulement si la boucle actuelle est stabilisée
```

`v1.0` doit rester réservé à une version plus complète, plus stable, mieux équilibrée et exportable proprement.
