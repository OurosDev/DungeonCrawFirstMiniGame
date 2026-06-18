# FLOOR_VISUALIZER

Visualisation lisible des layouts du donjon.

Ce fichier sert à préparer les placements de coffres `C`, messages `M`, combats fixes `F`, boss `X`, portes verrouillées `L` ou passages secrets `S`, sans modifier directement les scripts du jeu.

---

## Objectifs

- Garder une section qui reflète strictement l'état actuel en jeu.
- Préparer une section séparée pour les variantes de planification.
- Conserver une lecture simple sur GitHub, sans HTML, CSS ni couleur.
- Afficher les chemins comme des cases vides pour réduire le bruit visuel.
- Garder les coordonnées `x` et `y` visibles autour des grilles.

---

## Légende

| Symbole | Affichage | Rôle |
|---|---|---|
| `#` | `■` | Mur |
| `.` | espace vide | Sol / couloir |
| `D` | `D` | Porte fermée |
| `d` | `d` | Porte ouverte runtime |
| `>` | `>` | Escalier descendant |
| `<` | `<` | Escalier montant |
| `O` | `O` | Temple |
| `B` | `B` | Boutique |
| `C` | `C` | Coffre |
| `M` | `M` | Message / PNJ neutre / indication |
| `F` | `F` | Combat fixe non-boss |
| `X` | `X` | Boss / rencontre majeure |
| `L` | `L` | Porte verrouillée |
| `S` | `S` | Passage secret |

---

## 1. État actuel en jeu

Cette section doit rester alignée avec `scripts/dungeon/FloorDatabase.gd`.

Ne pas tester les futurs coffres `C` ou messages `M` dans cette section. Les variantes doivent être placées dans la section suivante.

---

### Étage 1 — Galeries de terre sombre

Dimensions : **31 × 21**

```text
    0000000000111111111122222222223
    0123456789012345678901234567890
00  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  00
01  ■   ■ ■                     DO■  01
02  ■■■ ■ ■ ■■ ■■ ■■■■■■■■■■■■■■■■■  02
03  ■ ■ ■ ■     ■       ■         ■  03
04  ■ ■ ■ ■■■ ■■■■■■■■■ ■ ■■■■■■  ■  04
05  ■ ■ ■     ■         ■   ■     ■  05
06  ■ ■ ■ ■D■■■ ■■■ ■■■■■■■ ■ ■■■■■  06
07  ■ ■   ■   ■   ■ ■     ■ ■     ■  07
08  ■ ■■■ ■■■ ■■■ ■■■ ■ ■■■ ■■■■■ ■  08
09  ■     ■     ■   ■ ■         ■ ■  09
10  ■ ■ ■ ■■■■■ ■■■ ■ ■■■■■■■■■■■ ■  10
11  ■ ■ ■     ■ ■   ■   ■     ■   ■  11
12  ■ ■■■■■■■ ■ ■   ■ ■ ■ ■■■ ■ ■■■  12
13  ■         ■         ■   ■D  ■ ■  13
14  ■ ■■■■■■■■■■■■■■■■■ ■■■ ■■■ ■ ■  14
15  ■ ■           DB■   ■   ■   ■ ■  15
16  ■ ■ ■■■■■ ■■■ ■■■ ■ ■ ■■■ ■ ■ ■  16
17  ■ ■ ■   ■         ■ ■ ■>■ ■ ■ ■  17
18  ■ ■ ■ ■■■ ■■ ■■■■ ■ ■ ■D■   ■ ■  18
19  ■   ■           ■   D ■   ■   ■  19
20  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  20
    0123456789012345678901234567890
    0000000000111111111122222222223
```

#### Cases spéciales — étage 1

| Symbole | Coordonnée | Rôle |
|---|---:|---|
| `D` | `Vector2i(28, 1)` | Porte fermée |
| `O` | `Vector2i(29, 1)` | Temple |
| `D` | `Vector2i(7, 6)` | Porte fermée |
| `D` | `Vector2i(25, 13)` | Porte fermée |
| `D` | `Vector2i(14, 15)` | Porte fermée |
| `B` | `Vector2i(15, 15)` | Boutique |
| `>` | `Vector2i(23, 17)` | Escalier descendant |
| `D` | `Vector2i(23, 18)` | Porte fermée |
| `D` | `Vector2i(20, 19)` | Porte fermée |

---

### Étage 2 — Cryptes de pierre froide

Dimensions : **31 × 21**

```text
    0000000000111111111122222222223
    0123456789012345678901234567890
00  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  00
01  ■ D X>■         ■     ■       ■  01
02  ■ ■■■■■ ■■■■■■■ ■ ■■■ ■ ■■■■■ ■  02
03  ■   ■   ■       ■   ■ ■ ■     ■  03
04  ■■■ ■ ■ ■ ■■■■■■■ ■ ■ ■ ■ ■■■ ■  04
05  ■   ■ ■ ■ ■ DB■     ■ ■ ■   ■ ■  05
06  ■ ■■■ ■■■ ■ ■ ■■■■■ ■ ■ ■■■ ■ ■  06
07  ■   ■       ■       ■ ■ ■   ■ ■  07
08  ■ ■ ■■■■■■■■■ ■■■■■■■ ■ ■■■ ■ ■  08
09  ■ ■   ■   ■   ■      ■    ■   ■  09
10  ■ ■ ■ ■ ■ ■■■ ■ ■■■ ■■■ ■ ■■■ ■  10
11  ■   ■   ■   ■ ■           ■ ■ ■  11
12  ■■■ ■■■■■ ■ ■■■ ■■■ ■■■■■■■ ■ ■  12
13  ■ ■   ■   ■   ■   ■ ■       ■ ■  13
14  ■ ■■■ ■ ■ ■■■ ■■■ ■■■ ■ ■ ■ ■ ■  14
15  ■ ■ DO■   ■     ■     ■ ■ ■   ■  15
16  ■ ■ ■■■■■ ■ ■■■■■■■■■■■ ■ ■■■ ■  16
17  ■ ■   ■   ■           ■<■ ■   ■  17
18  ■ ■■■ ■ ■ ■■■■■ ■ ■■■■■■■ ■ ■ ■  18
19  ■       ■       ■             ■  19
20  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  20
    0123456789012345678901234567890
    0000000000111111111122222222223
```

#### Cases spéciales — étage 2

| Symbole | Coordonnée | Rôle |
|---|---:|---|
| `D` | `Vector2i(2, 1)` | Porte fermée |
| `X` | `Vector2i(4, 1)` | Boss / rencontre majeure |
| `>` | `Vector2i(5, 1)` | Escalier descendant |
| `D` | `Vector2i(12, 5)` | Porte fermée |
| `B` | `Vector2i(13, 5)` | Boutique |
| `D` | `Vector2i(4, 15)` | Porte fermée |
| `O` | `Vector2i(5, 15)` | Temple |
| `<` | `Vector2i(23, 17)` | Escalier montant |

---

## 2. Variantes de planification

Cette section servira à tester les modifications prévues avant de toucher à `FloorDatabase.gd`.

Règles d'utilisation :

- Copier une grille depuis la section **État actuel en jeu**.
- Remplacer uniquement des cases de sol vides par les symboles prévus.
- Ne pas placer de vraie clé tant que les portes verrouillées `L` ne sont pas codées.
- Ne pas placer de coffre sur une case réservée à une découverte de sort.
- Garder `M` pour les messages, PNJ neutres ou indices.
- Garder `F` pour les combats fixes non-boss.
- Garder `X` pour les boss ou rencontres majeures.

---

### Étage 1 — variante de planification

À compléter uniquement quand les emplacements `C` et `M` seront validés.

```text
Copier ici la grille de l'étage 1, puis remplacer certaines cases vides par :
- C pour un coffre ;
- M pour un message / PNJ neutre / indice.
```

---

### Étage 2 — variante de planification

À compléter uniquement quand les emplacements `C` et `M` seront validés.

```text
Copier ici la grille de l'étage 2, puis remplacer certaines cases vides par :
- C pour un coffre ;
- M pour un message / PNJ neutre / indice.
```

---

## Notes de maintenance

- Les coordonnées sont en `Vector2i(x, y)`.
- `x` augmente vers la droite.
- `y` augmente vers le bas.
- Les deux lignes du haut indiquent les dizaines puis les unités de `x`.
- Les deux lignes du bas répètent les unités puis les dizaines de `x`.
- Les coordonnées `y` sont affichées à gauche et à droite de chaque ligne.
- Les murs `#` sont affichés comme `■`.
- Les cases de sol `.` sont affichées comme des espaces vides.
- Ce fichier est un outil de lecture et de planification.
- La source gameplay reste `scripts/dungeon/FloorDatabase.gd`.
