# ROADMAP — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version stable actuelle : `v0.11.2 — Polish menus et orientation des modèles 3D`

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
```

## Versions récentes

```text
v0.10 — Grimoire de combat et ciblage des soins
v0.11-Polish — Cadres UI NineSlice et correction Prêtre
v0.11.1 — Carte agrandie et automap améliorée
v0.11.2 — Polish menus et orientation des modèles 3D
```

## Prochaines phases proposées

### Phase 1 — Playtest 02 post-v0.11.2

À tester :
```text
menu principal
Options
Nouvelle partie
création d'équipe
tooltips Relancer / Stocker / Reprendre
validation des quatre héros
carte agrandie
automap compacte
orientation du premier M
coffres et messages réorientés
temples et boutiques
grimoire hors combat
grimoire de combat
soins hors combat
soins en combat
journal Combat coloré
boss gardien
sauvegarde / chargement
```

Sortie attendue :
```text
playtests/PLAYTEST_02_v0.11.2.md
```

### Phase 2 — Finition UI post-menus

Pistes :
```text
- créer une texture dédiée aux boutons ;
- vérifier les états hover / pressed / disabled ;
- améliorer les cadres actifs, dégâts, soin et sélection ;
- harmoniser les marges internes des panneaux ;
- vérifier les tooltips en basse résolution.
```

### Phase 3 — Progression magique plus riche

Pistes :
```text
- nouveaux sorts offensifs simples ;
- nouveaux sorts de soin ;
- premiers sorts utilitaires hors combat ;
- grimoire hors combat individuel par héros ;
- choix de sorts actifs avant combat quand il y aura assez de sorts.
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
