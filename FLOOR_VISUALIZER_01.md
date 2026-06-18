# FLOOR_VISUALIZER

Visualisation des layouts du donjon.

Ce fichier sert à relire les étages plus facilement que dans le layout ASCII brut, notamment avant d’ajouter des coffres `C`, des messages `M`, des combats fixes `F` ou des boss `X`.

> Note : ce fichier utilise des tableaux HTML avec styles intégrés. Le rendu est surtout prévu pour un aperçu Markdown local, par exemple VS Code. Certaines plateformes peuvent retirer les couleurs HTML et afficher une version moins lisible.

---

## Légende

| Symbole logique | Affichage dans la grille | Rôle |
|---|---|---|
| `#` | ■ | Mur |
| `.` | cellule vide | Sol / couloir |
| `D` | <span style="color:#b9783d; font-weight:bold;">D</span> | Porte fermée |
| `d` | <span style="color:#d8a35d; font-weight:bold;">d</span> | Porte ouverte |
| `>` | <span style="color:#4f8cff; font-weight:bold;">&gt;</span> | Escalier descendant |
| `<` | <span style="color:#6ec6ff; font-weight:bold;">&lt;</span> | Escalier montant |
| `O` | <span style="color:#58c46b; font-weight:bold;">O</span> | Temple |
| `B` | <span style="color:#f29a38; font-weight:bold;">B</span> | Boutique |
| `C` | <span style="color:#d6b13f; font-weight:bold;">C</span> | Coffre |
| `M` | <span style="color:#b779ff; font-weight:bold;">M</span> | Message / PNJ neutre / indication |
| `F` | <span style="color:#c76a4a; font-weight:bold;">F</span> | Combat fixe |
| `X` | <span style="color:#ff4d4d; font-weight:bold;">X</span> | Boss / rencontre majeure |
| `P` | <span style="color:#c97128; font-weight:bold;">P</span> | Piège |
| `E` | <span style="color:#4fd1c5; font-weight:bold;">E</span> | Événement |
| `R` | <span style="color:#8b7cff; font-weight:bold;">R</span> | Rune / sort visible |
| `L` | <span style="color:#9b5de5; font-weight:bold;">L</span> | Porte verrouillée |
| `S` | <span style="color:#9ca3af; font-weight:bold;">S</span> | Passage secret |

---

## 1. État actuel en jeu

Cette section reflète strictement les layouts actuellement implémentés.
Les cases de sol / couloir sont volontairement laissées vides pour améliorer la lisibilité générale.

### Étage 1 — Galeries de terre sombre

Dimensions : **31 × 21**.

<table style="border-collapse:collapse; border-spacing:0; margin:8px 0 14px 0;">
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;"></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">0</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">1</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">2</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">3</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">4</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">5</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">6</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">7</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">8</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">9</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">10</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">11</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">12</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">13</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">14</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">15</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">16</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">17</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">18</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">19</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">20</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">21</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">22</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">23</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">24</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">25</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">26</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">27</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">28</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">29</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">30</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;"></td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">0</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">0</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">1</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#b9783d; font-weight:bold;">D</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#58c46b; font-weight:bold;">O</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">1</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">2</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">2</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">3</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">3</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">4</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">4</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">5</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">5</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">6</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#b9783d; font-weight:bold;">D</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">6</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">7</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">7</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">8</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">8</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">9</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">9</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">10</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">10</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">11</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">11</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">12</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">12</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">13</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#b9783d; font-weight:bold;">D</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">13</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">14</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">14</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">15</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#b9783d; font-weight:bold;">D</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#f29a38; font-weight:bold;">B</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">15</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">16</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">16</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">17</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#4f8cff; font-weight:bold;">&gt;</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">17</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">18</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#b9783d; font-weight:bold;">D</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">18</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">19</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#b9783d; font-weight:bold;">D</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">19</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">20</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">20</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;"></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">0</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">1</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">2</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">3</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">4</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">5</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">6</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">7</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">8</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">9</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">10</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">11</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">12</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">13</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">14</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">15</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">16</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">17</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">18</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">19</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">20</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">21</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">22</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">23</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">24</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">25</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">26</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">27</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">28</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">29</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">30</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;"></td>
  </tr>
</table>

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

Dimensions : **31 × 21**.

<table style="border-collapse:collapse; border-spacing:0; margin:8px 0 14px 0;">
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;"></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">0</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">1</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">2</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">3</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">4</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">5</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">6</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">7</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">8</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">9</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">10</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">11</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">12</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">13</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">14</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">15</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">16</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">17</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">18</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">19</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">20</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">21</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">22</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">23</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">24</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">25</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">26</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">27</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">28</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">29</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">30</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;"></td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">0</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">0</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">1</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#b9783d; font-weight:bold;">D</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#ff4d4d; font-weight:bold;">X</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#4f8cff; font-weight:bold;">&gt;</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">1</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">2</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">2</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">3</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">3</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">4</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">4</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">5</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#b9783d; font-weight:bold;">D</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#f29a38; font-weight:bold;">B</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">5</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">6</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">6</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">7</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">7</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">8</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">8</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">9</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">9</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">10</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">10</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">11</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">11</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">12</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">12</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">13</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">13</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">14</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">14</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">15</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#b9783d; font-weight:bold;">D</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#58c46b; font-weight:bold;">O</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">15</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">16</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">16</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">17</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;"><span style="color:#6ec6ff; font-weight:bold;">&lt;</span></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">17</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">18</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">18</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">19</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818;">&nbsp;</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">19</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">20</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; background:#181818; font-weight:bold;">■</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">20</td>
  </tr>
  <tr>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;"></td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">0</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">1</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">2</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">3</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">4</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">5</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">6</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">7</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">8</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">9</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">10</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">11</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">12</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">13</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">14</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">15</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">16</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">17</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">18</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">19</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">20</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">21</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">22</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">23</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">24</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">25</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">26</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">27</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">28</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">29</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;">30</td>
    <td style="border:1px solid #333; width:22px; height:22px; text-align:center; vertical-align:middle; font-family:monospace; font-size:14px; line-height:22px; padding:0; font-size:11px; color:#888; background:#111;"></td>
  </tr>
</table>

#### Cases spéciales — étage 2

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
- Les murs `#` sont affichés comme des carrés `■` sans couleur dédiée.
- Les cases de sol `.` sont affichées comme des cellules vides.
- Les symboles spéciaux sont colorés via HTML/CSS inline pour cet essai.
- Pour ajouter un coffre, remplacer une case de sol `.` par `C` dans la variante de planification.
- Pour ajouter un message ou PNJ neutre, remplacer une case de sol `.` par `M` dans la variante de planification.
- Pour un combat fixe non-boss, utiliser `F`.
- Pour un boss ou une rencontre majeure, utiliser `X`.
