# ROADMAP — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Version stable actuelle : `v0.12 — Équilibrage combat, sort découvert et corrections UI`

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
```

## Prochaines phases proposées

### Phase 1 — Playtest 02 post-v0.12

À tester :

```text
menu principal avec image de fond
Options
Nouvelle partie
création d'équipe
couleurs des rolls
validation des quatre héros
progression jusqu'à découverte d'Éclat de givre
Mage niveau 1 / niveau 2
grimoire de combat
coût d'Étincelle
coût d'Éclat de givre
sauvegarde / chargement après découverte
PV des monstres normaux
boss gardien
écran équipement
carte agrandie
automap compacte
journal / combat / retour journal
boutique
temple
grimoire hors combat
soins hors combat
soins en combat
```

Sortie attendue :

```text
playtests/PLAYTEST_02_v0.12.md
```

### Phase 2 — Progression magique plus riche

Pistes :

```text
- nouveaux sorts offensifs simples ;
- nouveaux sorts de soin ;
- premiers sorts utilitaires hors combat ;
- grimoire hors combat individuel par héros ;
- choix de sorts actifs avant combat quand il y aura assez de sorts ;
- découvertes de sorts supplémentaires liées à l'exploration.
```

### Phase 3 — Finition UI post-polices

Pistes :

```text
- vérifier les écrans qui contiennent beaucoup de texte ;
- vérifier les états hover / pressed / disabled ;
- améliorer les cadres actifs, dégâts, soin et sélection ;
- harmoniser les marges internes des panneaux ;
- vérifier les tooltips en basse résolution ;
- créer une texture dédiée aux boutons si la texture de cadre principale reste trop générique.
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
