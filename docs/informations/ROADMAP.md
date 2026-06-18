# Feuille de route — DungeonCrawFirstMiniGame

## 1. Objectif du projet

Créer un dungeon crawler rétro en vue subjective, inspiré de l'esprit old-school et de jeux comme *Swords and Serpents* sur NES.

Le projet avance par petites versions pré-1.0, chacune devant rester testable et récupérable via un tag GitHub stable.

Objectifs de conception :

- exploration case par case ;
- groupe de quatre héros ;
- combats au tour par tour ;
- progression par étages ;
- difficulté parfois brutale, compensée par l'exploration, la préparation et la gestion des ressources ;
- documentation claire avant les ajouts de contenu majeurs.

## 2. Base de travail actuelle

Version stable actuelle : `v0.8.2`

Release : `v0.8.2 — Refactorisations internes et stabilisation technique`

Cette base contient :

1. la boucle complète `v0.7.1` : création de groupe, exploration, étage 2, coffres, messages, clé du gardien, porte verrouillée, boss et retour titre après K.O. ;
2. les contrôles `v0.8` : souris, clavier AZERTY, commandes de combat et d'exploration plus accessibles ;
3. la stabilisation `v0.8.1` : renderer `Compatibility / OpenGL`, scaling de fenêtre `canvas_items + keep`, playtest 01 documenté, builds/logs hors repo ;
4. les refactorisations `v0.8.2` : extraction progressive de helpers depuis les grands contrôleurs du menu, du combat, du donjon, de la session et de la création d'équipe.

Historique détaillé : voir `CHANGELOG/README.md` et les fichiers `CHANGELOG/vX.Y.md`.

## 3. Documents de référence

```text
IA_RELAIS.md                              Passage de main entre conversations
ASSISTANT_WORKFLOW.md                     Règles de collaboration avec l'assistant
README.md                                 Présentation publique du projet
CHANGELOG/README.md                       Historique synthétique des versions
CHANGELOG/*.md                            Détail par version
audits/STATE_AUDITvX.Y.Z.md               Photographies d'état du repo
docs/informations/ROADMAP.md              Direction actuelle et prochaines priorités
docs/informations/TECHNICAL_DEBT.md       Refactorisations utiles et dette technique connue
docs/dungeon/FLOOR_DESIGN.md              Règles de conception des étages et symboles
docs/dungeon/FLOOR_VISUALIZER.md          Visualisation des layouts et variantes
playtests/README.md                       Règles de documentation des playtests
playtests/PLAYTEST_XX_vX.Y.md             Synthèses propres des tests
```

Rôle de `ROADMAP.md` : rester court, actuel et décisionnel.

À ne plus stocker directement ici :

- corps complets des anciennes releases ;
- longues notes de refactorisation ;
- instructions de collaboration avec l'assistant ;
- détails exhaustifs des layouts ;
- listes trop longues de systèmes déjà terminés.

## 4. Systèmes fonctionnels importants

### Donjon et exploration

- Déplacement case par case.
- Rotation gauche / droite.
- Murs, portes simples, portes ouvertes runtime.
- Étages 1 et 2.
- Escalier descendant `>` et escalier montant `<`.
- États d'étage mémorisés.
- Cellules découvertes de l'automap mémorisées par étage.
- Rencontres aléatoires par étage.
- Temple `O`.
- Boutique `B`.
- Coffres `C`.
- Messages / indices `M`.
- Porte verrouillée `L`.
- Boss / rencontre majeure `X`.

### Progression actuelle

- L'étage 2 contient une zone boss protégée par une porte verrouillée.
- La Clé du gardien est obtenue dans un coffre de l'étage 2.
- Le boss `gardien_boss_etage_2` réutilise le gardien normal avec ses PV multipliés.
- Le boss disparaît après victoire.
- Le passage derrière lui devient accessible.
- L'escalier descendant derrière le boss est présent visuellement, mais ne mène pas encore à un étage 3.

### Combat

- Combat au tour par tour.
- Attaque physique.
- Magie offensive.
- Soin.
- Fuite.
- Drops réels ajoutés à l'inventaire.
- EXP.
- Boss fixe simple.
- Retour à l'écran titre après K.O. complet du groupe.
- Validation souris de certaines étapes de combat.

### Économie et équipement

- Inventaire commun de 24 emplacements.
- Piles de 9 objets, sauf exceptions.
- Or du groupe.
- Vente en boutique.
- Achat d'objets basiques.
- Prix d'achat = `sell_value × 4`.
- Objets de quête non vendables.
- Équipement par héros : Arme, Casque, Armure, Bouclier, Bijou.
- Bonus plats centralisés dans `ItemDatabase.gd`.

### Interface et contrôles

- Commandes souris pour exploration.
- Commandes souris pour combat.
- Bouton menu en exploration.
- Contrôles AZERTY : `Z`, `Q`, `S`, `D`.
- `A` agit comme validation.
- `E` agit comme retour.
- Scaling fenêtre stabilisé par `canvas_items + keep`.

### Architecture après v0.8.2

Plusieurs grands scripts restent les points d'entrée principaux, mais délèguent maintenant des responsabilités spécialisées :

- `InGameMenuPanelUI.gd` délègue les écrans de menu à `scripts/ui/menu/` ;
- `CombatManager.gd` délègue plusieurs règles de combat à des resolvers/helpers ;
- `Dungeon.gd` délègue des helpers de carte, d'état d'étage et d'automap ;
- `GameSession.gd` délègue des helpers d'état d'étage, boutique et équipement ;
- `PartyCreationUI.gd` délègue la construction UI, la création des héros et les résumés.

## 5. Priorité de reprise

Après `v0.8.2`, le projet dispose d'une base plus saine pour reprendre soit le polish post-playtest, soit les premiers ajouts visibles de contenu.

Axes à décider ensemble :

```text
A. Finaliser / poursuivre le playtest 01 sur base Compatibility / OpenGL
B. Corriger les éventuels retours de confort issus du playtest
C. Améliorer les feedbacks de progression, mort, boss, coffres et sauvegarde
D. Centraliser les symboles et règles de cases du donjon
E. Préparer le contenu suivant : étage 3, combats fixes F, grimoire, événements
```

Recommandation actuelle :

```text
Prochaine version probable : v0.8.3 ou v0.9
Objectif v0.8.3 : polish / confort / documentation / correctifs post-playtest
Objectif v0.9 : nouveau contenu visible ou début d'étage 3
```

Le numéro exact dépendra du périmètre :

- `v0.8.3` si la version contient surtout du polish, de la documentation, des corrections ciblées ou des ajustements de playtest ;
- `v0.9` si la version ajoute un vrai bloc de contenu visible ou une progression nouvelle.

## 6. Polish conseillé avant gros contenu

Priorité haute :

- compiler la suite du playtest 01 si de nouveaux retours arrivent ;
- vérifier le confort de la build `Compatibility / OpenGL` sur d'autres machines ;
- améliorer le feedback après victoire contre le boss ;
- clarifier le feedback de consommation de la Clé du gardien ;
- clarifier les messages de coffre déjà ouvert ou vide, si nécessaire ;
- vérifier l'expérience K.O. après retour à l'écran titre ;
- améliorer la lisibilité des retours de sauvegarde / chargement.

Priorité moyenne :

- améliorer le visuel 3D des escaliers `<` et `>` ;
- améliorer le rendu 3D des coffres `C` ;
- améliorer le rendu 3D des messages `M` ;
- améliorer le rendu 3D des portes verrouillées `L` ;
- cadres UI plus propres ;
- début de `NinePatchRect` ou `StyleBoxTexture` pour les panneaux principaux ;
- amélioration des fenêtres Inventaire / Statut / Équipement / Boutique ;
- amélioration visuelle ou textuelle de la victoire boss.

## 7. Refactorisations restantes utiles

Voir `docs/informations/TECHNICAL_DEBT.md` pour le détail.

Après `v0.8.2`, les gros contrôleurs les plus visibles ont été allégés. Les refactorisations restantes doivent être plus ciblées :

- centraliser les symboles de donjon ;
- centraliser les règles de marchabilité ;
- centraliser les règles de non-rencontre aléatoire ;
- clarifier progressivement les événements de cases spéciales `C`, `M`, `L`, `X`, `O`, `B`, `<`, `>` ;
- conserver `Dungeon.gd`, `CombatManager.gd` et `GameSession.gd` comme façades publiques plutôt que multiplier les dépendances directes.

## 8. Contenu futur possible

### Progression

- Étage 3.
- Activation réelle de l'escalier `>` derrière le boss.
- Nouveau thème visuel.
- Nouvelle table de rencontre.

### Donjon

- Combats fixes non-boss `F`.
- Passages secrets `S`.
- Pièges `P`.
- Événements simples `E`.
- Runes ou découvertes visibles `R`.

### Combat

- Attaques spéciales de boss.
- Récompense ou drop unique du boss.
- Message ou écran de victoire boss.
- Animations damage / attaque plus lisibles.

### Interface

- Grimoire fonctionnel.
- Descriptions d'objets plus détaillées.
- Meilleur feedback de sauvegarde, mort, victoire et progression.

## 9. Règles de versioning

Ne pas accélérer artificiellement vers `v1.0`.

Le projet peut continuer en versions pré-1.0 :

```text
v0.8.3
v0.9
v0.10
v0.11
...
```

`v1.0` doit rester réservé à une version réellement complète, avec une progression suffisante, une boucle de jeu stabilisée, une documentation claire et une version exportable propre.

## 10. Notes de vigilance

- Les anciennes sauvegardes peuvent conserver d'anciens layouts mémorisés.
- Pour tester un changement de layout, utiliser une nouvelle partie ou réinitialiser la sauvegarde de test.
- Les builds de playtest restent locales.
- Les logs bruts complets restent hors repo.
- Le renderer de playtest Windows recommandé est `Compatibility / OpenGL`.
- L'outil de téléportation de développement est temporaire et devra être retiré ou désactivé avant une version finale propre.
