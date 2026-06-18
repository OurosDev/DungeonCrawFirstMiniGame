# FLOOR_VISUALIZER

Visualisation des layouts du donjon.

Ce fichier sert à relire les étages plus facilement que dans le layout ASCII brut, notamment avant d’ajouter des coffres `C`, des messages `M`, des combats fixes `F` ou des boss `X`.

> Note : ce fichier utilise du HTML avec styles intégrés pour faire un essai de coloration des symboles dans un aperçu Markdown local, par exemple VS Code. Certaines plateformes, dont GitHub selon le rendu appliqué, peuvent retirer les styles HTML et afficher une version moins colorée.

---

## Légende

| Symbole logique | Affichage dans la grille | Rôle |
|---|---|---|
| `#` | `■` | Mur |
| `.` | espace vide | Sol / couloir |
| `D` | <span style="color:#b8793a;font-weight:700;">D</span> | Porte fermée |
| `d` | <span style="color:#d0a05f;font-weight:700;">d</span> | Porte ouverte |
| `>` | <span style="color:#4f8cff;font-weight:700;">&gt;</span> | Escalier descendant |
| `<` | <span style="color:#73c7ff;font-weight:700;">&lt;</span> | Escalier montant |
| `O` | <span style="color:#55c878;font-weight:700;">O</span> | Temple |
| `B` | <span style="color:#ff9d3b;font-weight:700;">B</span> | Boutique |
| `C` | <span style="color:#ffd447;font-weight:700;">C</span> | Coffre |
| `M` | <span style="color:#c77dff;font-weight:700;">M</span> | Message / PNJ neutre / indication |
| `F` | <span style="color:#c96a4a;font-weight:700;">F</span> | Combat fixe |
| `X` | <span style="color:#ff4a4a;font-weight:700;">X</span> | Boss / rencontre majeure |
| `P` | <span style="color:#c76f2b;font-weight:700;">P</span> | Piège |
| `E` | <span style="color:#35d0c8;font-weight:700;">E</span> | Événement |
| `R` | <span style="color:#8f8cff;font-weight:700;">R</span> | Rune / sort visible |
| `L` | <span style="color:#8c52ff;font-weight:700;">L</span> | Porte verrouillée |
| `S` | <span style="color:#9a9a9a;font-weight:700;">S</span> | Passage secret |

---

## 1. État actuel en jeu

Cette section reflète strictement les layouts actuellement implémentés.

Les cases de sol / couloir sont volontairement laissées vides pour améliorer la lisibilité générale.

### Étage 1 — Galeries de terre sombre

Dimensions : **31 × 21**.

```text
   0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
```

<pre style="font-family:monospace;line-height:1.15;">
00 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 00
01 ■   ■ ■                     <span style="color:#b8793a;font-weight:700;">D</span><span style="color:#55c878;font-weight:700;">O</span>■ 01
02 ■■■ ■ ■ ■■ ■■ ■■■■■■■■■■■■■■■■■ 02
03 ■ ■ ■ ■     ■       ■         ■ 03
04 ■ ■ ■ ■■■ ■■■■■■■■■ ■ ■■■■■■  ■ 04
05 ■ ■ ■     ■         ■   ■     ■ 05
06 ■ ■ ■ ■<span style="color:#b8793a;font-weight:700;">D</span>■■■ ■■■ ■■■■■■■ ■ ■■■■■ 06
07 ■ ■   ■   ■   ■ ■     ■ ■     ■ 07
08 ■ ■■■ ■■■ ■■■ ■■■ ■ ■■■ ■■■■■ ■ 08
09 ■     ■     ■   ■ ■         ■ ■ 09
10 ■ ■ ■ ■■■■■ ■■■ ■ ■■■■■■■■■■■ ■ 10
11 ■ ■ ■     ■ ■   ■   ■     ■   ■ 11
12 ■ ■■■■■■■ ■ ■   ■ ■ ■ ■■■ ■ ■■■ 12
13 ■         ■         ■   ■<span style="color:#b8793a;font-weight:700;">D</span>  ■ ■ 13
14 ■ ■■■■■■■■■■■■■■■■■ ■■■ ■■■ ■ ■ 14
15 ■ ■           <span style="color:#b8793a;font-weight:700;">D</span><span style="color:#ff9d3b;font-weight:700;">B</span>■   ■   ■   ■ ■ 15
16 ■ ■ ■■■■■ ■■■ ■■■ ■ ■ ■■■ ■ ■ ■ 16
17 ■ ■ ■   ■         ■ ■ ■<span style="color:#4f8cff;font-weight:700;">&gt;</span>■ ■ ■ ■ 17
18 ■ ■ ■ ■■■ ■■ ■■■■ ■ ■ ■<span style="color:#b8793a;font-weight:700;">D</span>■   ■ ■ 18
19 ■   ■           ■   <span style="color:#b8793a;font-weight:700;">D</span> ■   ■   ■ 19
20 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 20
</pre>

```text
   0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
```

### Cases spéciales — étage 1

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

Dimensions : **31 × 21**.

```text
   0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
```

<pre style="font-family:monospace;line-height:1.15;">
00 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 00
01 ■ <span style="color:#b8793a;font-weight:700;">D</span> <span style="color:#ff4a4a;font-weight:700;">X</span><span style="color:#4f8cff;font-weight:700;">&gt;</span>■         ■     ■       ■ 01
02 ■ ■■■■■ ■■■■■■■ ■ ■■■ ■ ■■■■■ ■ 02
03 ■   ■   ■       ■   ■ ■ ■     ■ 03
04 ■■■ ■ ■ ■ ■■■■■■■ ■ ■ ■ ■ ■■■ ■ 04
05 ■   ■ ■ ■ ■ <span style="color:#b8793a;font-weight:700;">D</span><span style="color:#ff9d3b;font-weight:700;">B</span>■     ■ ■ ■   ■ ■ 05
06 ■ ■■■ ■■■ ■ ■ ■■■■■ ■ ■ ■■■ ■ ■ 06
07 ■   ■       ■       ■ ■ ■   ■ ■ 07
08 ■ ■ ■■■■■■■■■ ■■■■■■■ ■ ■■■ ■ ■ 08
09 ■ ■   ■   ■   ■      ■    ■   ■ 09
10 ■ ■ ■ ■ ■ ■■■ ■ ■■■ ■■■ ■ ■■■ ■ 10
11 ■   ■   ■   ■ ■           ■ ■ ■ 11
12 ■■■ ■■■■■ ■ ■■■ ■■■ ■■■■■■■ ■ ■ 12
13 ■ ■   ■   ■   ■   ■ ■       ■ ■ 13
14 ■ ■■■ ■ ■ ■■■ ■■■ ■■■ ■ ■ ■ ■ ■ 14
15 ■ ■ <span style="color:#b8793a;font-weight:700;">D</span><span style="color:#55c878;font-weight:700;">O</span>■   ■     ■     ■ ■ ■   ■ 15
16 ■ ■ ■■■■■ ■ ■■■■■■■■■■■ ■ ■■■ ■ 16
17 ■ ■   ■   ■           ■<span style="color:#73c7ff;font-weight:700;">&lt;</span>■ ■   ■ 17
18 ■ ■■■ ■ ■ ■■■■■ ■ ■■■■■■■ ■ ■ ■ 18
19 ■       ■       ■             ■ 19
20 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 20
</pre>

```text
   0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
```

### Cases spéciales — étage 2

| Symbole | Coordonnée | Rôle |
|---|---:|---|
| `D` | `Vector2i(2, 1)` | Porte fermée |
| `X` | `Vector2i(4, 1)` | Boss / rencontre majeure temporaire |
| `>` | `Vector2i(5, 1)` | Escalier descendant futur / visuel non actif |
| `D` | `Vector2i(12, 5)` | Porte fermée |
| `B` | `Vector2i(13, 5)` | Boutique |
| `D` | `Vector2i(4, 15)` | Porte fermée |
| `O` | `Vector2i(5, 15)` | Temple |
| `<` | `Vector2i(23, 17)` | Escalier montant |

---

## 2. Variantes de planification

Cette section servira à tester les emplacements futurs sans modifier la lecture de l’état actuel.

À utiliser plus tard pour préparer :

- `C` : coffres ;
- `M` : messages / PNJ neutres / indices ;
- `F` : combats fixes non-boss ;
- `X` : boss / rencontres majeures ;
- `L` : portes verrouillées ;
- `S` : passages secrets.

### Étage 1 — variante v0.7 proposée

À compléter après validation du rendu HTML/CSS.

### Étage 2 — variante v0.7 proposée

À compléter après validation du rendu HTML/CSS.

---

## Notes de maintenance

- Les coordonnées sont en `Vector2i(x, y)`.
- `x` augmente vers la droite.
- `y` augmente vers le bas.
- Les coordonnées `x` sont affichées au-dessus et sous chaque grille.
- Les coordonnées `y` sont affichées à gauche et à droite de chaque grille.
- Les murs `#` sont affichés comme des carrés sombres `■`.
- Les cases de sol `.` sont affichées comme des espaces vides.
- Les symboles spéciaux sont colorés via HTML/CSS inline pour cet essai.
- Pour ajouter un coffre, remplacer une case de sol `.` par `C` dans la variante de planification.
- Pour ajouter un message ou PNJ neutre, remplacer une case de sol `.` par `M` dans la variante de planification.
- Pour un combat fixe non-boss, utiliser `F`.
- Pour un boss ou une rencontre majeure, utiliser `X`.
