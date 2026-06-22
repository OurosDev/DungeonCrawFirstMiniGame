# ROADMAP — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Version stable actuelle : `v0.13.1 — Correctifs UI, stèles de sort et flags de build`

## Vision

`DungeonCrawFirstMiniGame` est un dungeon crawler rétro en vue subjective, inspiré par l'esprit NES / Swords and Serpents, avec une boucle volontairement lisible mais exigeante.

La priorité actuelle n'est pas de multiplier trop vite le contenu brut. Le projet doit d'abord enrichir et consolider la boucle complète déjà jouable.

## Versions récentes

```text
v0.12 — Équilibrage combat, sort découvert et corrections UI
v0.13 — Magicka : progression magique, sorts actifs et poison
v0.13.1 — Correctifs UI, stèles de sort et flags de build
```

## Base actuelle

La base `v0.13.1` stabilise l'interface et la lisibilité après Magicka :

```text
- flag de build pour la téléportation de développement ;
- stèles de sort représentées par S et par un modèle 3D ;
- fermeture cohérente avec X dans le menu d'aventure et la carte agrandie ;
- correction des commandes d'exploration après fermeture du menu ;
- inventaire plus propre et mieux ajusté.
```

## Prochaines phases proposées

### Phase 1 — Playtest post-v0.13.1

À tester :

```text
nouvelle partie
sauvegarde / chargement
DevFlags avec true puis false
stèles de sort étage 1 et étage 2
orientation des stèles
menu d'aventure avec Échap
menu d'aventure avec X
inventaire vide
inventaire rempli
carte agrandie avec X
boucle complète étage 1 -> étage 2 -> boss
```

Sortie attendue possible :

```text
playtests/PLAYTEST_03_v0.13.1.md
```

### Phase 2 — Stabilisation magie / statuts

Pistes :

```text
- ajuster les coûts de PM ;
- ajuster les dégâts d'Éclat de givre ;
- ajuster le poison si trop fort ou trop faible ;
- décider si certains monstres pourront empoisonner les héros ;
- ajouter une interface plus visible pour les statuts ;
- documenter les statuts dans un fichier technique si le système s'étend.
```

### Phase 3 — Polish UI ciblé

Pistes :

```text
- harmoniser les boutons X entre les écrans ;
- vérifier l'inventaire avec beaucoup d'objets ;
- vérifier l'équipement sur petites résolutions ;
- vérifier le grimoire avec plusieurs sorts ;
- inspecter les marges des menus après chaque correction.
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
