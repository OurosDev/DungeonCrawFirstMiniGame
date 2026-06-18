# Feuille de route — DungeonCrawFirstMiniGame

## 1. Objectif du projet

Créer un dungeon crawler rétro en vue subjective, inspiré de l’esprit old-school et de jeux comme *Swords and Serpents* sur NES.

Le projet avance par petites versions pré-1.0, chacune devant rester testable et récupérable via un tag GitHub stable.

Objectifs de conception :

- exploration case par case ;
- groupe de quatre héros ;
- combats au tour par tour ;
- progression par étages ;
- difficulté parfois brutale, compensée par l’exploration, la préparation et la gestion des ressources ;
- documentation claire avant les ajouts de contenu.

---

## 2. Base de travail actuelle

```text
Version stable actuelle : v0.7.1
Release : v0.7.1 — Boss du gardien et retour titre après K.O.
```

Cette version complète une première boucle jouable :

1. créer un groupe ;
2. explorer l’étage 1 ;
3. accéder à l’étage 2 ;
4. trouver des coffres et des indices ;
5. récupérer la Clé du gardien ;
6. ouvrir la porte verrouillée du boss ;
7. affronter le Gardien des profondeurs ;
8. libérer l’accès au passage derrière lui ;
9. revenir à l’écran titre en cas de K.O. complet du groupe.

Historique détaillé des versions : voir `CHANGELOG/README.md`.

---

## 3. Documents de référence

```text
ROADMAP.md              = direction actuelle et prochaines priorités
FLOOR_DESIGN.md         = règles de conception des étages et symboles
FLOOR_VISUALIZER.md     = visualisation des layouts et variantes de planification
TECHNICAL_DEBT.md       = refactorisations utiles et dette technique connue
ASSISTANT_WORKFLOW.md   = règles de collaboration avec l’assistant
CHANGELOG/README.md     = historique synthétique des versions
CHANGELOG/*.md          = changelog détaillé par version
```

Rôle de `ROADMAP.md` : rester court, actuel et décisionnel.

À ne plus stocker directement ici :

- corps complets des anciennes releases ;
- longues notes de refactorisation ;
- instructions de collaboration avec l’assistant ;
- détails exhaustifs des layouts ;
- listes longues de systèmes déjà terminés.

---

## 4. Systèmes fonctionnels importants

### Donjon et exploration

- Déplacement case par case.
- Rotation gauche / droite.
- Murs, portes simples, portes ouvertes runtime.
- Étages 1 et 2.
- Escalier descendant `>` et escalier montant `<`.
- États d’étage mémorisés.
- Cellules découvertes de l’automap mémorisées par étage.
- Rencontres aléatoires par étage.
- Temple `O`.
- Boutique `B`.
- Coffres `C`.
- Messages / indices `M`.
- Porte verrouillée `L`.
- Boss / rencontre majeure `X`.

### Progression actuelle

- L’étage 2 contient une zone boss protégée par une porte verrouillée.
- La Clé du gardien est obtenue dans un coffre de l’étage 2.
- Le boss `gardien_boss_etage_2` réutilise le gardien normal avec seulement ses PV multipliés.
- Le boss disparaît après victoire.
- Le passage derrière lui devient accessible.
- L’escalier descendant derrière le boss est présent visuellement, mais ne mène pas encore à un étage 3.

### Combat

- Combat au tour par tour.
- Attaque physique.
- Magie offensive.
- Soin.
- Fuite.
- Drops réels ajoutés à l’inventaire.
- EXP.
- Boss fixe simple.
- Retour à l’écran titre après K.O. complet du groupe.

### Économie et équipement

- Inventaire commun de 24 emplacements.
- Piles de 9 objets, sauf exceptions.
- Or du groupe.
- Vente en boutique.
- Achat d’objets basiques.
- Prix d’achat = `sell_value × 4`.
- Objets de quête non vendables.
- Équipement par héros : Arme, Casque, Armure, Bouclier, Bijou.
- Bonus plats centralisés dans `ItemDatabase.gd`.

---

## 5. Priorité de reprise

Avant d’ajouter beaucoup de contenu, faire un point commun sur les priorités de polish et de stabilité.

Axes à décider ensemble :

```text
A. Polish visuel avant playtest externe
B. Confort joueur et lisibilité des feedbacks
C. Refactorisations légères pour stabiliser la structure
D. Documentation et nettoyage projet
E. Nouveau contenu : étage 3, combats fixes F, grimoire, événements
```

Recommandation actuelle :

```text
Prochaine version probable : v0.7.2 ou v0.8
Objectif : préparation playtest externe
```

Le numéro exact dépendra du périmètre :

- `v0.7.2` si la version contient surtout documentation, polish mineur et correctifs ciblés ;
- `v0.8` si la version devient une vraie passe de polish visible ou ajoute une préparation playtest plus large.

---

## 6. Polish conseillé avant test externe

Priorité haute :

- améliorer le visuel 3D des escaliers `<` et `>` ;
- améliorer le rendu 3D des coffres `C` ;
- améliorer le rendu 3D des messages `M` ;
- améliorer le rendu 3D des portes verrouillées `L` ;
- ajouter un feedback plus clair après victoire contre le boss ;
- clarifier le feedback de consommation de la Clé du gardien ;
- clarifier les messages de coffre déjà ouvert ou vide, si nécessaire ;
- vérifier l’expérience K.O. après retour à l’écran titre.

Priorité moyenne :

- cadres UI plus propres ;
- début de `NinePatchRect` pour les panneaux principaux ;
- amélioration des fenêtres Inventaire / Statut / Équipement / Boutique ;
- amélioration visuelle du boss ou message de victoire plus marqué.

---

## 7. Refactorisations utiles à court terme

Voir `TECHNICAL_DEBT.md` pour le détail.

À privilégier avant de gros ajouts :

- centraliser les symboles de donjon ;
- centraliser les règles de marchabilité ;
- centraliser les règles de non-rencontre aléatoire ;
- clarifier les événements de cases spéciales `C`, `M`, `L`, `X` ;
- éviter une réécriture complète de `Dungeon.gd` tant que la boucle de jeu vient juste d’être stabilisée.

---

## 8. Contenu futur possible

### Progression

- Étage 3.
- Activation réelle de l’escalier `>` derrière le boss.
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
- Descriptions d’objets plus détaillées.
- Meilleur feedback de sauvegarde, mort, victoire et progression.

---

## 9. Règles de versioning

Ne pas accélérer artificiellement vers `v1.0`.

Le projet peut continuer en versions pré-1.0 :

```text
v0.7.2
v0.8
v0.9
v0.10
v0.11
...
```

`v1.0` doit rester réservé à une version réellement complète, avec :

- boucle de jeu solide ;
- plusieurs étages jouables ;
- progression claire ;
- économie stabilisée ;
- défaite gérée proprement ;
- boss / progression fonctionnels ;
- niveau de polish minimum ;
- outil de développement temporaire retiré ou désactivé clairement.

---

## 10. Checklist avant playtest externe

À remplir avant de partager à des testeurs :

- nouvelle partie fonctionnelle ;
- création d’équipe fonctionnelle ;
- sauvegarde / chargement testés ;
- passage étage 1 → étage 2 ;
- retour étage 2 → étage 1 ;
- coffres ouverts persistants ;
- messages `M` lisibles ;
- Clé du gardien récupérable ;
- porte verrouillée ouvrable ;
- clé consommée ;
- boss déclenché ;
- boss vaincu et disparu après rechargement ;
- retour écran titre après K.O. ;
- téléportation de développement assumée, désactivée ou documentée ;
- README / instructions de lancement suffisamment clairs pour un testeur.
