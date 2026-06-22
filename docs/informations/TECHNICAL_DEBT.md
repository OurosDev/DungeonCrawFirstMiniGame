# TECHNICAL_DEBT — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-22

Base actuelle : `v0.13.1 — Correctifs UI, stèles de sort et flags de build`

## Résumé

`v0.13.1` stabilise plusieurs points apparus après `v0.13 — Magicka`.

Elle réduit la dette autour :

- des outils de développement intégrés ;
- de la lisibilité des découvertes de sorts ;
- de la fermeture de menus ;
- de l'ajustement du menu inventaire.

## Dette réduite

### Téléportation de développement

Nouveau fichier :

```text
scripts/core/BuildFlags.gd
```

Point de contrôle unique :

```gdscript
const DEV_TELEPORT_ENABLED: bool = false
```

La téléportation ne dépend plus d'une suppression manuelle de scripts avant export.

À surveiller :

```text
- vérifier le flag avant export ;
- éviter de multiplier les flags dispersés ;
- documenter tout nouveau flag dans BuildFlags.gd.
```

### Stèles de sort

Nouveau symbole :

```text
S = Stèle de sort
```

Les découvertes de sorts ne reposent plus seulement sur une logique invisible ou un marqueur plat.

À surveiller :

```text
- orientation des stèles futures ;
- lisibilité de S dans l'automap ;
- cohérence entre FloorDatabase.gd et FLOOR_VISUALIZER.md lors d'une future mise à jour dungeon.
```

### Fermeture de menus

Le menu d'aventure et la carte agrandie disposent maintenant d'un bouton `X`.

Correction importante :

```text
les commandes d'exploration sont explicitement restaurées après fermeture du menu d'aventure.
```

À surveiller :

```text
- éviter les doubles chemins de fermeture ;
- faire passer les fermetures souris et clavier par les mêmes fonctions ;
- vérifier que les overlays réaffichent correctement les commandes exploration.
```

### Inventaire

Le menu inventaire a été compacté :

```text
- suppression du cadre parasite sous Retour menu ;
- suppression du texte d'aide superflu ;
- réajustement vertical du bouton Retour menu ;
- zone d'inventaire agrandie sans dépasser du cadre principal.
```

À surveiller :

```text
- inventaire rempli ;
- petites résolutions ;
- cohérence avec le futur système d'équipement ;
- lisibilité des lignes d'objets.
```

## Points de vigilance persistants

### 1. Scripts UI longs

Certains scripts UI restent longs et sensibles :

```text
scripts/ui/DungeonViewportUI.gd
scripts/ui/InGameMenuPanelUI.gd
```

Règle :

```text
demander les versions locales si elles ont été modifiées récemment ;
fournir des scripts complets ;
éviter les patchs partiels.
```

### 2. FloorDatabase / visualisation

Les cases `S` doivent être reflétées plus tard dans les documents dungeon si ceux-ci sont mis à jour :

```text
docs/dungeon/FLOOR_DESIGN.md
docs/dungeon/FLOOR_VISUALIZER.md
```

Ne pas modifier ces documents sans reconstruire depuis `FloorDatabase.gd`.

### 3. Statuts temporaires

Le poison reste le seul statut actif pour le moment.

Ne pas ajouter trop vite d'autres statuts avant playtest.

## À ne pas faire pour le moment

```text
- ajouter des objets consommables ;
- ajouter des potions ;
- créer un journal de quête ;
- créer un moniteur d'objectif ;
- révéler des informations non découvertes sur la carte ;
- ajouter l'étage 3 avant d'enrichir davantage la boucle actuelle ;
- ajouter trop de statuts avant d'avoir testé le poison ;
- changer le format de sauvegarde sans nécessité claire ;
- fournir des patchs partiels au lieu de scripts complets.
```

## Recommandation immédiate

Après `v0.13.1`, privilégier :

```text
1. playtest court post-release ;
2. vérifier les exports avec DEV_TELEPORT_ENABLED = false ;
3. vérifier l'orientation des stèles ;
4. vérifier la stabilité des menus souris/clavier ;
5. seulement ensuite, poursuivre vers magie/statuts ou polish UI ciblé.
```
