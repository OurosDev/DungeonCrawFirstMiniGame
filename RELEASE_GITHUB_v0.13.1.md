# Release GitHub — v0.13.1

## Tag

```text
v0.13.1
```

## Titre

```text
v0.13.1 — Correctifs UI, stèles de sort et flags de build
```

## Description courte

Release de stabilisation après Magicka : flag de build pour la téléportation dev, stèles de sort visibles en 3D, correction de fermeture du menu d'aventure, polish inventaire et bouton X sur la carte agrandie.

## Notes de release

```markdown
## v0.13.1 — Correctifs UI, stèles de sort et flags de build

Cette version stabilise la base `v0.13 — Magicka`.

### Build / outils de développement

- Ajout de `scripts/core/BuildFlags.gd`.
- Ajout du flag `DEV_TELEPORT_ENABLED`.
- La téléportation de développement peut être masquée et bloquée sans retirer les scripts.
- Avant export playtest/exécutable, vérifier que `DEV_TELEPORT_ENABLED` est à `false`.

### Stèles de sort

- Nouveau symbole de carte : `S`.
- `S` représente une stèle de sort.
- Les découvertes de `Éclat de givre` et `Soin de groupe` utilisent maintenant une stèle dédiée.
- Ajout d'un modèle 3D de stèle magique.
- Les stèles s'orientent vers le chemin quand c'est possible.
- La stèle reste visible après découverte du sort.
    - `FLOOR_DESIGN.md` et `FLOOR_VISUALIZER.md` sont synchronisés avec le symbole `S`.

### Menu d'aventure

- Correction d'un bug où les boutons d'exploration pouvaient rester invisibles ou inactifs après fermeture du menu avec Échap.
- Ajout d'un bouton `X` en haut à droite du menu.
- Échap et `X` passent par une fermeture propre qui restaure les commandes d'exploration.

### Inventaire

- Suppression d'un cadre parasite sous / autour du bouton `Retour menu`.
- Suppression du texte d'aide superflu.
- Réajustement vertical des cadres.
- Le bouton `Retour menu` reste correctement dans le cadre principal.

### Carte agrandie

- Suppression du bouton `Retour`.
- Ajout d'un bouton `X` en haut à droite, cohérent avec le menu d'aventure.
- La fermeture restaure les commandes d'exploration.

### Tests recommandés

- Tester `DEV_TELEPORT_ENABLED` à `true` puis `false`.
- Vérifier les stèles de sort aux deux étages.
- Vérifier l'orientation des stèles.
- Vérifier la fermeture du menu d'aventure avec Échap et avec `X`.
- Vérifier l'inventaire vide et rempli.
- Vérifier la carte agrandie avec le bouton `X`.
```
