# Release GitHub — v0.11.3

## Tag

```text
v0.11.3
```

## Titre

```text
v0.11.3 — Fond de menu, polices et lisibilité UI
```

## Description courte

Release de polish visuel et de lisibilité : fond illustré du menu principal, polices OpenType, thème global, boutons d'exploration plus lisibles et correction du tooltip de coordonnées de la carte / automap.

## Notes de release

```markdown
## v0.11.3 — Fond de menu, polices et lisibilité UI

Cette version conserve la base `v0.11.2 — Polish menus et orientation des modèles 3D` et ajoute une passe d'identité visuelle et de lisibilité.

### Ajouts / améliorations

- Ajout d'un fond illustré dédié au menu principal.
- Ajout d'une police OpenType dédiée au titre du menu principal.
- Ajout d'un thème de police global pour l'interface du jeu.
- Placement du menu principal rendu plus facilement ajustable par constantes dans `MainMenu.gd`.
- Simplification des libellés des boutons d'exploration :
  - `Avancer`
  - `Reculer`
  - `Gauche`
  - `Droite`
  - `Carte`
  - `Menu`
- Correction du tooltip de coordonnées de carte / automap avec les coordonnées à deux chiffres.
- Le tooltip utilise désormais un format compact du type `X:12  Y:10`.

### Inchangé

- Aucun changement de gameplay.
- Aucun changement du format de sauvegarde.
- Aucun changement des layouts du donjon.
- Aucun nouvel état persistant.

### Tests recommandés

- Menu principal, Options, Nouvelle partie, Charger.
- Création d'équipe.
- Exploration souris et clavier.
- Carte agrandie et automap compacte.
- Tooltip coordonnées avec X/Y à deux chiffres.
- Inventaire, équipement, boutique, temple.
- Grimoire hors combat et grimoire de combat.
- Combat complet, boss, sauvegarde / chargement.
```
