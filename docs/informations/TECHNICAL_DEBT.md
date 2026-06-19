# TECHNICAL_DEBT — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Base actuelle : `v0.11.2 — Polish menus et orientation des modèles 3D`

## Résumé

`v0.11.2` ajoute principalement du polish UI et une règle de rendu. Aucun format de sauvegarde n'est modifié.

## Dette réduite

### UI NineSlice v0.11+

Base :
```text
scripts/ui/theme/UIFrameStyle.gd
assets/ui/frames/texture_cadre_ui.png
```

`v0.11.2` étend la cohérence visuelle au menu principal et à la création d'équipe.

### Orientation modèles spéciaux v0.11.2

`DungeonRenderer.gd` calcule désormais l'orientation de certains modèles spéciaux à partir du layout courant.

Modèles concernés :
```text
M
C
O
B
```

Aucun layout n'est modifié.

## Points de vigilance

Menu principal et création d'équipe :
```text
lisibilité des boutons texturés
panneau Options
tooltips Relancer / Stocker / Reprendre
position des tooltips en basse résolution
validation des héros
```

Orientation des modèles 3D spéciaux :
```text
premier M de l'étage 1
coffres réorientés
messages réorientés
temples et boutiques conservés
interactions M/C/O/B
compatibilité avec futurs étages
```

Texture dédiée aux boutons :
```text
assets/ui/frames/texture_bouton_ui.png
```

Cette piste reste utile si les boutons actuels sont jugés trop proches des cadres.

## À ne pas faire pour le moment

```text
- ajouter des objets consommables ;
- ajouter des potions ;
- créer un journal de quête ;
- créer un moniteur d'objectif ;
- révéler des informations non découvertes sur la carte ;
- ajouter l'étage 3 avant d'enrichir davantage la boucle actuelle ;
- changer le format de sauvegarde sans nécessité claire.
```
