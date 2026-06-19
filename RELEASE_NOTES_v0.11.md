# Release GitHub proposée

## Tag

```text
v0.11
```

## Titre

```text
v0.11 — Cadres UI NineSlice et correction Prêtre
```

## Description

```markdown
## Objectif

Cette version améliore l'identité visuelle de l'interface avec une première texture de cadre NineSlice sombre, appliquée aux cadres principaux, aux menus et aux boutons.

Elle inclut aussi un hotfix de cohérence : la classe d'Eldric est désormais nommée `Prêtre`.

## Ajouts et améliorations

- Ajout de `assets/ui/frames/texture_cadre_ui.png`.
- Ajout de `scripts/ui/theme/UIFrameStyle.gd`.
- Application de la texture aux cadres héros, viewport, journal, automap et panneaux principaux.
- Application de la texture aux cadres et boutons des menus.
- Application de la texture aux boutons d'exploration et de combat.
- Suppression du long cadre derrière les boutons de déplacement et de combat.
- Correction du libellé de classe `Prêtre`.
- Normalisation des anciennes valeurs de classe pour préserver la compatibilité des sauvegardes.

## Notes

- Les boutons utilisent encore la texture de cadre principale avec des marges réduites.
- Une texture dédiée aux boutons pourra être ajoutée plus tard.
- Pas de nouveau contenu de donjon.
- Pas de consommables.
- Pas de journal de quête.
- Pas de changement volontaire du format de sauvegarde.

## Tests locaux

Tests validés sur l'interface principale, les menus, les boutons d'exploration, les boutons de combat, le grimoire, la boutique, l'inventaire, le statut, l'équipement, la création de groupe, la sauvegarde et le chargement.
```
