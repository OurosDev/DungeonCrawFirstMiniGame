# ROADMAP — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version stable actuelle : `v0.11.1 — Carte agrandie et automap améliorée`

## Rôle du document

Cette roadmap sert à conserver le cap du projet, la vision longue et une proposition de priorités pour les prochaines phases. Elle ne doit pas devenir une simple liste de toutes les idées possibles.

Les idées non priorisées, reportées ou encore à discuter doivent être conservées dans :

```text
docs/informations/IDEAS.md
```

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
carte agrandie et automap améliorée
Compatibility / OpenGL
```

## Principes de design

```text
- Pas d'objets consommables pour le moment.
- Pas de potions pour le moment.
- L'inventaire doit rester centré sur l'équipement, l'or et les objets clés.
- Pas de journal de quête ni moniteur d'objectif explicite.
- L'absence de suivi de quête fait partie de la difficulté voulue.
- Les cartes ne doivent pas révéler d'informations non découvertes.
- Les indices doivent passer par le donjon, les messages, les couleurs et les feedbacks.
- Ne pas viser l'étage 3 comme priorité immédiate.
- Enrichir d'abord les systèmes autour de la boucle déjà complète.
- Préserver une interface jouable à la souris et au clavier AZERTY.
- Préférer des fonctionnalités durables aux ajouts de contenu rapides.
- Éviter les halos blancs et contours clairs non désirés.
```

## Versions récentes

### v0.10 — Grimoire de combat et ciblage des soins

```text
- Grimoire de combat propre au héros actif.
- Sorts actifs temporaires réinitialisés à chaque combat.
- Magie et Soin en actions directes.
- Soin en combat avec sélection par cadres.
- Journal Combat plus lisible : dégâts ennemis rouges, soins verts.
```

### v0.11-Polish — Cadres UI NineSlice et correction Prêtre

```text
- Texture de cadre UI NineSlice.
- Cadres principaux, héros, viewport, journal et automap texturés.
- Cadres et boutons des menus texturés.
- Long cadre derrière les commandes retiré.
- Base UI centralisée via UIFrameStyle.gd.
- Correction du libellé de classe : Prêtre.
```

### v0.11.1 — Carte agrandie et automap améliorée

```text
- Bouton Carte en exploration.
- Carte agrandie dans le viewport.
- Carte synchronisée avec l'automap.
- Aucune révélation de zones non découvertes.
- Coordonnées au survol souris des cases découvertes non-mur.
- Automap compacte sans titre et légèrement zoomée.
```

## Prochaines phases proposées

### Phase 1 — Finition UI post-carte

Objectif : consolider le polish visuel introduit par `v0.11` et `v0.11.1`.

Pistes :

```text
- vérifier le rendu de la carte en résolution native et en stretch ;
- vérifier l'automap compacte après plusieurs changements de fenêtre ;
- créer une texture dédiée aux boutons ;
- vérifier les états hover / pressed / disabled ;
- améliorer éventuellement les cadres actifs, dégâts, soin et sélection ;
- harmoniser les marges internes des panneaux ;
- conserver la lisibilité en basse résolution.
```

### Phase 2 — Playtest 02 post-v0.11.1

Objectif : vérifier que la boucle complète reste stable après l'ajout des grimoires, du polish UI et de la carte agrandie.

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
carte agrandie
automap compacte
tooltips coordonnées
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
playtests/PLAYTEST_02_v0.11.1.md
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

## Notes de versioning

Le projet reste en pré-1.0. Ne pas accélérer artificiellement vers `v1.0`.

Les versions peuvent continuer ainsi :

```text
v0.11.1
v0.12
v0.13
...
```

`v1.0` doit rester réservé à une version réellement complète, stable, documentée, exportable et suffisamment testée.
