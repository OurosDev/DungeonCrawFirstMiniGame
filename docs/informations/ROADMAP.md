# ROADMAP — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Version stable actuelle : `v0.13 — Magicka : progression magique, sorts actifs et poison`

## Vision

`DungeonCrawFirstMiniGame` est un dungeon crawler rétro en vue subjective, inspiré par l'esprit NES / Swords and Serpents, avec une boucle volontairement lisible mais exigeante.

La priorité actuelle n'est pas de multiplier trop vite le contenu brut. Le projet doit d'abord enrichir et consolider la boucle complète déjà jouable.

## Principes de design

```text
- Pas d'objets consommables pour le moment.
- Pas de potions pour le moment.
- Pas de journal de quête ni moniteur d'objectif explicite.
- Les cartes ne doivent pas révéler d'informations non découvertes.
- Les modèles lisibles ou interactifs ne doivent pas faire face à un mur si un chemin adjacent existe.
- Ne pas viser l'étage 3 comme priorité immédiate.
- Enrichir d'abord les systèmes autour de la boucle déjà complète.
- Vérifier la lisibilité des écrans après chaque changement de police ou de thème global.
- Sauvegarder toute progression durable.
```

## Versions récentes

```text
v0.10 — Grimoire de combat et ciblage des soins
v0.11-Polish — Cadres UI NineSlice et correction Prêtre
v0.11.1 — Carte agrandie et automap améliorée
v0.11.2 — Polish menus et orientation des modèles 3D
v0.11.3 — Fond de menu, polices et lisibilité UI
v0.12 — Équilibrage combat, sort découvert et corrections UI
v0.13 — Magicka : progression magique, sorts actifs et poison
```

## Prochaines phases proposées

### Phase 1 — Playtest 03 post-v0.13

À tester :

```text
nouvelle partie
montée en niveau du Mage
montée en niveau du Prêtre
découverte Éclat de givre
découverte Soin de groupe étage 2 x21 y8
préparation hors combat de sorts actifs
sauvegarde / chargement des sorts préparés
grimoire de combat temporaire
Poison sur monstres normaux
Poison sur boss gardien
Soin renforcé
Soin de groupe
boutique
temple
inventaire
équipement
boss
```

Sortie attendue :

```text
playtests/PLAYTEST_03_v0.13.md
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

### Phase 3 — Nouveaux sorts simples

Pistes :

```text
- sort offensif supplémentaire pour Mage ;
- sort utilitaire hors combat ;
- sort de soutien simple pour Prêtre ;
- découverte de sorts par exploration, sans journal de quête.
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
