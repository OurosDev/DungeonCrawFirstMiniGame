# FLOOR_VISUALIZER

Visualisation des layouts du donjon.

Ce fichier sert à relire les étages plus facilement que dans le layout ASCII brut, notamment avant d’ajouter ou déplacer des coffres `C`, des messages `M`, des stèles de sort `S`, des combats fixes `F`, des boss `X`, des portes verrouillées `L` ou d’autres cases spéciales.

> Source de vérité gameplay : `scripts/dungeon/FloorDatabase.gd`.
>
> Synchronisation : état régénéré depuis `FloorDatabase.gd` pour `v0.13.1`, après l’ajout des stèles de sort `S`.
>
> Convention visuelle : les murs `#` sont affichés en `■`, les sols `.` sont volontairement laissés vides, et les symboles spéciaux restent visibles dans la grille.

---

## Légende

| Symbole affiché | Source layout | Signification |
|---|---|---|
| `■` | `#` | Mur |
| cellule vide | `.` | Sol / couloir |
| `D` | `D` | Porte fermée |
| `O` | `O` | Temple de guérison |
| `B` | `B` | Boutique |
| `C` | `C` | Coffre |
| `M` | `M` | Message / indication |
| `S` | `S` | Stèle de sort |
| `L` | `L` | Porte verrouillée |
| `X` | `X` | Boss / rencontre majeure |
| `>` | `>` | Escalier descendant |
| `<` | `<` | Escalier montant |

---

## État actuel en jeu

Cette section doit correspondre strictement aux layouts de `FloorDatabase.gd`.

### Étage 1 — Galeries de terre sombre

- Dimensions : `31 x 21`.
- Départ : `Vector2i(1, 1)`.
- Escalier descendant actif : `Vector2i(23, 17)`.
- Stèle de sort : `Vector2i(29, 13)` — `spell_ice_shard`.
- Correction confirmée : porte `D` replacée en `Vector2i(26, 13)`.

| y \ x | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | y |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 0 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | 0 |
| 1 | ■ |  |  | M | ■ | C | ■ |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | D | O | ■ | 1 |
| 2 | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ | ■ |  | ■ | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | 2 |
| 3 | ■ |  | ■ |  | ■ |  | ■ |  |  |  |  |  | ■ |  |  |  |  |  |  |  | ■ |  |  |  |  |  |  |  |  |  | ■ | 3 |
| 4 | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ |  |  | ■ | 4 |
| 5 | ■ |  | ■ |  | ■ |  |  |  |  |  | ■ |  |  |  |  |  |  |  |  |  | ■ |  |  |  | ■ |  |  |  |  |  | ■ | 5 |
| 6 | ■ |  | ■ |  | ■ |  | ■ | D | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ | 6 |
| 7 | ■ |  | ■ |  |  |  | ■ |  |  |  | ■ |  |  |  | ■ |  | ■ |  |  |  |  |  | ■ |  | ■ |  |  |  |  |  | ■ | 7 |
| 8 | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ | ■ | ■ |  | ■ | 8 |
| 9 | ■ |  |  |  |  |  | ■ |  |  |  |  |  | ■ |  |  |  | ■ |  | ■ |  |  |  |  |  |  |  |  | C | ■ |  | ■ | 9 |
| 10 | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ | 10 |
| 11 | ■ |  | ■ |  | ■ |  |  |  |  |  | ■ |  | ■ |  |  |  | ■ |  |  |  | ■ |  |  |  |  |  | ■ |  |  |  | ■ | 11 |
| 12 | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ |  |  |  | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ | 12 |
| 13 | ■ |  |  |  |  |  |  |  |  |  | ■ |  |  |  |  |  |  |  |  |  | ■ |  |  |  | ■ |  | D |  | ■ | S | ■ | 13 |
| 14 | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | 14 |
| 15 | ■ |  | ■ |  |  |  |  |  |  |  |  |  |  |  | D | B | ■ |  |  |  | ■ |  |  |  | ■ |  |  |  | ■ |  | ■ | 15 |
| 16 | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ | 16 |
| 17 | ■ |  | ■ |  | ■ |  |  |  | ■ |  |  |  |  |  |  |  |  |  | ■ |  | ■ |  | ■ | > | ■ |  | ■ |  | ■ |  | ■ | 17 |
| 18 | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ | ■ |  | ■ | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ | D | ■ | M |  |  | ■ |  | ■ | 18 |
| 19 | ■ |  |  |  | ■ |  |  |  |  |  |  |  |  |  |  | C | ■ |  |  |  | D |  | ■ |  |  |  | ■ |  |  |  | ■ | 19 |
| 20 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | 20 |
| y \ x | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | y |

#### Cases spéciales — Étage 1

| Symbole | Coordonnée | Type |
|---|---:|---|
| `M` | `Vector2i(3, 1)` | Message / indication |
| `C` | `Vector2i(5, 1)` | Coffre |
| `D` | `Vector2i(28, 1)` | Porte fermée |
| `O` | `Vector2i(29, 1)` | Temple de guérison |
| `D` | `Vector2i(7, 6)` | Porte fermée |
| `C` | `Vector2i(27, 9)` | Coffre |
| `D` | `Vector2i(26, 13)` | Porte fermée |
| `S` | `Vector2i(29, 13)` | Stèle de sort |
| `D` | `Vector2i(14, 15)` | Porte fermée |
| `B` | `Vector2i(15, 15)` | Boutique |
| `>` | `Vector2i(23, 17)` | Escalier descendant |
| `D` | `Vector2i(23, 18)` | Porte fermée |
| `M` | `Vector2i(25, 18)` | Message / indication |
| `C` | `Vector2i(15, 19)` | Coffre |
| `D` | `Vector2i(20, 19)` | Porte fermée |

#### Coffres — Étage 1

| Coordonnée | Contenu | Description |
|---:|---|---|
| `Vector2i(5, 1)` | `25` or | Petit coffre caché dans les premières galeries. |
| `Vector2i(15, 19)` | `tarnished_ring` | Coffre ancien placé dans une impasse profonde. |
| `Vector2i(27, 9)` | `small_shield` | Coffre utile pour préparer la descente. |

#### Messages — Étage 1

| Coordonnée | Texte |
|---:|---|
| `Vector2i(3, 1)` | Une inscription gravée indique : les vieux coffres gardent parfois plus que de l'or. |
| `Vector2i(25, 18)` | L'air venu d'en bas est plus froid. Préparez-vous avant de descendre. |

#### Stèles de sort — Étage 1

| Coordonnée | Sort découvert | Note |
|---:|---|---|
| `Vector2i(29, 13)` | `spell_ice_shard` | Stèle d'Éclat de givre. |

---

### Étage 2 — Cryptes de pierre froide

- Dimensions : `31 x 21`.
- Départ : `Vector2i(23, 17)`.
- Escalier montant / retour vers l’étage 1 : `Vector2i(23, 17)`.
- Escalier descendant futur derrière le boss : `Vector2i(5, 1)`.
- Porte verrouillée du gardien : `Vector2i(2, 1)`.
- Stèle de sort : `Vector2i(21, 8)` — `spell_group_heal`.

| y \ x | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | y |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 0 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | 0 |
| 1 | ■ | M | L |  | X | > | ■ |  |  |  |  |  |  |  |  |  | ■ |  |  |  |  |  | ■ |  |  |  |  |  |  |  | ■ | 1 |
| 2 | ■ |  | ■ | ■ | ■ | ■ | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ |  | ■ | 2 |
| 3 | ■ |  |  |  | ■ |  |  |  | ■ |  |  |  |  |  |  |  | ■ |  |  |  | ■ |  | ■ |  | ■ |  |  |  |  |  | ■ | 3 |
| 4 | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ | 4 |
| 5 | ■ |  |  |  | ■ |  | ■ |  | ■ |  | ■ |  | D | B | ■ |  |  |  |  |  | ■ |  | ■ |  | ■ |  |  |  | ■ |  | ■ | 5 |
| 6 | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | 6 |
| 7 | ■ |  |  |  | ■ |  |  |  |  |  |  |  | ■ |  |  |  |  |  |  |  | ■ |  | ■ |  | ■ | C |  |  | ■ |  | ■ | 7 |
| 8 | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ | S | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | 8 |
| 9 | ■ |  | ■ |  |  |  | ■ |  |  |  | ■ |  |  |  | ■ |  |  |  |  |  |  | ■ |  |  |  |  | ■ |  |  |  | ■ | 9 |
| 10 | ■ |  | ■ |  | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ | 10 |
| 11 | ■ |  |  | M | ■ |  |  |  | ■ |  |  |  | ■ |  | ■ |  |  |  |  |  |  |  |  |  |  |  | ■ |  | ■ |  | ■ | 11 |
| 12 | ■ | ■ | ■ |  | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ | 12 |
| 13 | ■ | C | ■ |  |  |  | ■ |  |  |  | ■ |  |  |  | ■ |  |  |  | ■ |  | ■ |  |  |  |  |  |  |  | ■ |  | ■ | 13 |
| 14 | ■ |  | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ |  | ■ |  | ■ | 14 |
| 15 | ■ |  | ■ |  | D | O | ■ |  |  |  | ■ |  |  |  |  | C | ■ |  |  |  |  |  | ■ |  | ■ |  | ■ |  |  |  | ■ | 15 |
| 16 | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ |  | ■ | 16 |
| 17 | ■ |  | ■ |  |  |  | ■ |  |  |  | ■ |  |  |  |  |  |  |  |  |  |  | M | ■ | < | ■ |  | ■ |  |  |  | ■ | 17 |
| 18 | ■ |  | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ | ■ | ■ | ■ | ■ | ■ | ■ |  | ■ |  | ■ |  | ■ | 18 |
| 19 | ■ |  |  |  |  |  |  |  | ■ |  |  |  |  |  |  |  | ■ |  |  |  |  |  |  |  |  |  |  |  |  |  | ■ | 19 |
| 20 | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | ■ | 20 |
| y \ x | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | y |

#### Cases spéciales — Étage 2

| Symbole | Coordonnée | Type |
|---|---:|---|
| `M` | `Vector2i(1, 1)` | Message / indication |
| `L` | `Vector2i(2, 1)` | Porte verrouillée |
| `X` | `Vector2i(4, 1)` | Boss / rencontre majeure |
| `>` | `Vector2i(5, 1)` | Escalier descendant |
| `D` | `Vector2i(12, 5)` | Porte fermée |
| `B` | `Vector2i(13, 5)` | Boutique |
| `C` | `Vector2i(25, 7)` | Coffre |
| `S` | `Vector2i(21, 8)` | Stèle de sort |
| `M` | `Vector2i(3, 11)` | Message / indication |
| `C` | `Vector2i(1, 13)` | Coffre |
| `D` | `Vector2i(4, 15)` | Porte fermée |
| `O` | `Vector2i(5, 15)` | Temple de guérison |
| `C` | `Vector2i(15, 15)` | Coffre |
| `M` | `Vector2i(21, 17)` | Message / indication |
| `<` | `Vector2i(23, 17)` | Escalier montant |

#### Coffres — Étage 2

| Coordonnée | Contenu | Description |
|---:|---|---|
| `Vector2i(1, 13)` | `boss_door_key_floor_2` | Coffre important lié à la porte du gardien. |
| `Vector2i(15, 15)` | `reinforced_leather` | Coffre d'équipement au cœur des cryptes. |
| `Vector2i(25, 7)` | `50` or | Cache d'or dans une impasse secondaire. |

#### Messages — Étage 2

| Coordonnée | Texte |
|---:|---|
| `Vector2i(21, 17)` | Des traces anciennes mènent vers l'ouest. Quelque chose semble garder les profondeurs. |
| `Vector2i(3, 11)` | Une voix lointaine murmure : la voie du gardien ne s'ouvre qu'à ceux qui fouillent les impasses. |
| `Vector2i(1, 1)` | Une présence puissante se tient derrière cette porte. Ce passage n'est pas encore prêt. |

#### Stèles de sort — Étage 2

| Coordonnée | Sort découvert | Note |
|---:|---|---|
| `Vector2i(21, 8)` | `spell_group_heal` | Stèle de Soin de groupe. |

#### Porte verrouillée — Étage 2

| Coordonnée | Clé requise | Message verrouillé | Message d'ouverture |
|---:|---|---|---|
| `Vector2i(2, 1)` | `boss_door_key_floor_2` | La porte du gardien est verrouillée. Il manque une clé ancienne. | La clé du gardien tourne dans la serrure. La porte s'ouvre, et la clé disparaît. |

#### Boss — Étage 2

| Coordonnée | Boss | Note |
|---:|---|---|
| `Vector2i(4, 1)` | `gardien_boss_etage_2` | Boss du gardien ; devient généralement `.` après victoire. |

---

## Variantes non implémentées / notes de planification

Aucune variante de layout non implémentée n’est active dans ce fichier pour le moment.

Les variantes futures doivent rester séparées de la section `État actuel en jeu` afin de ne pas les confondre avec le layout réellement présent dans `FloorDatabase.gd`.

---

## Checklist de maintenance

Avant de modifier ce fichier :

```text
[ ] Lire ASSISTANT_WORKFLOW.md.
[ ] Lire docs/dungeon/FLOOR_DESIGN.md.
[ ] Vérifier scripts/dungeon/FloorDatabase.gd sur main ou utiliser la version locale fournie si elle est plus récente.
[ ] Reconstruire la section État actuel en jeu depuis FloorDatabase.gd.
[ ] Conserver le format tableau / grille.
[ ] Conserver les coordonnées x/y autour des grilles.
[ ] Ne pas remplacer les grilles par du texte monospacé.
[ ] Garder les variantes dans une section séparée.
```
