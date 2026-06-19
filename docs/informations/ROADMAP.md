# ROADMAP — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version stable actuelle : `v0.11 — Cadres UI NineSlice et correction Prêtre`

## Rôle du document

Cette roadmap sert à conserver le cap du projet, la vision longue et une proposition de priorités pour les prochaines phases. Elle ne doit pas devenir une simple liste de toutes les idées possibles.

Les idées non priorisées, reportées ou encore à discuter doivent être conservées dans :

```text
docs/informations/IDEAS.md
```

Règle importante : lorsqu'une idée sort de la roadmap parce qu'elle n'est pas prioritaire, elle doit être déplacée ou conservée dans `IDEAS.md` plutôt que supprimée définitivement.

## Vision du projet

`DungeonCrawFirstMiniGame` est un dungeon crawler rétro en vue subjective, inspiré par l'esprit NES / Swords and Serpents, avec une boucle volontairement lisible mais exigeante.

La priorité actuelle n'est pas de multiplier trop vite le contenu brut. Le projet doit d'abord enrichir et consolider la boucle complète déjà jouable :

```text
création de groupe
exploration étage 1 / étage 2
portes, temples, boutiques, coffres, messages
objets clés de quête
boss fixe du gardien
combat tour par tour
inventaire commun
équipement
grimoires hors combat et combat
sauvegarde / chargement
contrôles souris + AZERTY
interface texturée NineSlice
Compatibility / OpenGL
```

Le contenu supplémentaire, comme l'étage 3, doit arriver seulement quand la boucle actuelle est suffisamment riche, stable et agréable à rejouer.

## Principes de design

```text
- Pas d'objets consommables pour le moment.
- Pas de potions pour le moment.
- L'inventaire doit rester centré sur l'équipement, l'or et les objets clés.
- Pas de journal de quête ni moniteur d'objectif explicite.
- L'absence de suivi de quête fait partie de la difficulté voulue.
- Les indices doivent passer par le donjon, les messages, les couleurs et les feedbacks.
- Ne pas viser l'étage 3 comme priorité immédiate.
- Enrichir d'abord les systèmes autour de la boucle déjà complète.
- Préserver une interface jouable à la souris et au clavier AZERTY.
- Préférer des fonctionnalités durables aux ajouts de contenu rapides.
- Éviter les halos blancs et contours clairs non désirés.
```

## Versions récentes

### v0.8.1 — Stabilisation playtest et scaling fenêtre

```text
- Renderer Compatibility / OpenGL.
- Scaling fenêtre canvas_items + keep.
- Playtest 01 documenté.
- Logs et builds hors repo.
```

### v0.8.2 — Refactorisations internes et stabilisation technique

```text
- Refactorisation du menu en jeu.
- Refactorisation du combat.
- Refactorisation du donjon.
- Refactorisation de GameSession.
- Refactorisation de la création d'équipe.
```

### v0.9 — Grimoire hors combat et sélection de cible

```text
- Grimoire hors combat.
- Soins hors combat.
- Sélection de cible par cadres de héros.
- Prévisualisation PV/PM.
- Messages importants plus lisibles.
```

### v0.10 — Grimoire de combat et ciblage des soins

```text
- Grimoire de combat propre au héros actif.
- Sorts actifs temporaires réinitialisés à chaque combat.
- Magie et Soin en actions directes.
- Soin en combat avec sélection par cadres.
- Journal Combat plus lisible : dégâts ennemis rouges, soins verts.
```

### v0.11 — Cadres UI NineSlice et correction Prêtre

```text
- Texture de cadre UI NineSlice.
- Cadres principaux, héros, viewport, journal et automap texturés.
- Cadres et boutons des menus texturés.
- Long cadre derrière les commandes retiré.
- Base UI centralisée via UIFrameStyle.gd.
- Correction du libellé de classe : Prêtre.
```

## Prochaines phases proposées

Ces phases sont une proposition d'ordre de travail. Elles peuvent évoluer, mais il faut conserver une vision de 3 à 5 étapes pour éviter de perdre le cap long terme.

### Phase 1 — Finition UI NineSlice et boutons dédiés

Objectif : consolider le polish visuel introduit par `v0.11`.

Pistes :

```text
- créer une texture dédiée aux boutons ;
- vérifier tous les états hover / pressed / disabled ;
- améliorer éventuellement les cadres actifs, dégâts, soin et sélection ;
- harmoniser les marges internes des panneaux ;
- vérifier le rendu en résolution native et en stretch ;
- conserver la lisibilité en basse résolution.
```

Points de vigilance :

```text
- ne pas casser le scaling canvas_items + keep ;
- ne pas rendre les cadres trop chargés ;
- ne pas réduire la lisibilité des textes ;
- garder les boutons immédiatement reconnaissables et cliquables.
```

### Phase 2 — Playtest 02 post-v0.11

Objectif : vérifier que la boucle complète reste stable après l'ajout des grimoires, du ciblage des soins et du nouveau rendu UI.

À tester :

```text
grimoire hors combat
grimoire de combat
soins hors combat
soins en combat
prévisualisation PV/PM
combat mage
combat prêtre
journal Combat coloré
boutons texturés
menus texturés
victoire
fuite
K.O.
boss gardien
sauvegarde / chargement
boutique
équipement
changement d'étage
```

Sortie attendue :

```text
playtests/PLAYTEST_02_v0.11.md
```

Ne pas pousser les logs bruts, builds exportées ou sauvegardes locales.

### Phase 3 — Progression magique plus riche

Objectif : préparer le système de sorts pour aller au-delà des sorts de base actuels.

Pistes compatibles avec l'état actuel :

```text
- nouveaux sorts offensifs simples ;
- nouveaux sorts de soin ;
- premiers sorts utilitaires hors combat ;
- meilleure séparation entre sorts utilisables hors combat et en combat ;
- grimoire hors combat individuel par héros ;
- sorts visibles mais grisés selon contexte ;
- choix de sorts actifs avant combat, seulement quand il y aura assez de sorts pour le justifier.
```

Dette potentielle à traiter avant ou pendant cette phase :

```text
- système de sorts connus / découverts ;
- compatibilité des anciennes sauvegardes si de nouveaux champs sont ajoutés ;
- éventuel stockage des préférences de sorts actifs ;
- éviter d'improviser directement dans SaveManager ou CharacterData sans conception préalable.
```

### Phase 4 — Événements fixes et interactions de donjon

Objectif : enrichir les deux premiers étages sans ajouter immédiatement un nouvel étage.

Pistes :

```text
- événements fixes simples ;
- interactions liées à des objets clés ;
- inscriptions ou messages plus importants ;
- portes ou passages conditionnels ;
- récompenses non consommables ;
- petits choix ou mini-objectifs sans journal de quête explicite.
```

Règle de design : l'information doit rester dans le donjon et les messages, pas dans une checklist.

### Phase 5 — Équipement, objets clés et récompenses structurantes

Objectif : donner plus de poids aux coffres, à l'équipement et aux objets clés sans introduire de consommables.

Pistes :

```text
- comparaison d'équipement plus lisible ;
- objets d'équipement plus typés par classe ;
- objets clés plus structurants ;
- récompenses de coffres mieux différenciées ;
- confirmation avant vente importante ;
- feedbacks plus clairs quand un objet ne peut pas être vendu ou équipé.
```

## Priorités plus tardives

```text
- messages typés pour remplacer la coloration textuelle si le journal devient fragile ;
- nouveaux monstres ou variations de monstres ;
- boss plus structurés ;
- nouveaux sprites ou animations ;
- sons et musiques additionnels ;
- étage 3 quand la boucle actuelle aura été davantage enrichie ;
- exports de playtest plus encadrés ;
- meilleure documentation joueur à terme.
```

## Éléments volontairement non prioritaires

```text
- objets consommables ;
- potions ;
- journal de quête ;
- moniteur d'objectif ;
- étage 3 immédiat ;
- grosse refactorisation générale non motivée ;
- accélération artificielle vers v1.0.
```

Ces éléments peuvent être rediscutés plus tard, mais ils ne doivent pas être proposés comme prochaine étape par défaut.

## Lien avec IDEAS.md

`docs/informations/IDEAS.md` contient les pistes non priorisées ou reportées.

Règles :

```text
- La roadmap garde le cap et les prochaines phases probables.
- IDEAS.md conserve les idées à ne pas perdre.
- Une idée peut remonter de IDEAS.md vers la roadmap si elle devient prioritaire.
- Une idée retirée de la roadmap doit être conservée dans IDEAS.md sauf si elle est abandonnée explicitement.
```

## Notes de versioning

Le projet reste en pré-1.0. Ne pas accélérer artificiellement vers `v1.0`.

Les versions peuvent continuer ainsi :

```text
v0.11
v0.12
v0.13
...
```

`v1.0` doit rester réservé à une version réellement complète, stable, documentée, exportable et suffisamment testée.
