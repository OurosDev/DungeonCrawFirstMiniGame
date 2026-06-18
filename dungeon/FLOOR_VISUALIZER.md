# FLOOR_VISUALIZER

Visualisation des layouts du donjon.

Ce fichier sert à relire les étages plus facilement que dans le layout ASCII brut,
notamment avant d’ajouter ou déplacer des coffres `C`, des messages `M`, des combats fixes `F`,
des boss `X`, des portes verrouillées `L` ou d’autres cases spéciales.

> Note : ce fichier utilise des tableaux HTML simples pour conserver une vraie grille lisible
> dans un aperçu Markdown. Les cases de sol / couloir sont volontairement laissées vides.

---

## Légende

| Symbole logique | Affichage dans la grille | Rôle |
|---|---|---|
| `#` | carré `■` | Mur |
| `.` | cellule vide | Sol / couloir |
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
| `P` | `P` | Piège |
| `E` | `E` | Événement |
| `R` | `R` | Rune / sort visible |
| `L` | `L` | Porte verrouillée |
| `S` | `S` | Passage secret |

---

## 1. État actuel en jeu

Cette section reflète strictement les layouts actuellement implémentés dans `scripts/dungeon/FloorDatabase.gd`.

Ne pas y placer les variantes prévues pour les versions futures.

### Étage 1 — Galeries de terre sombre

Dimensions : **31 × 21**.

<table>
<tr><th>Y\X</th><th>0</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th><th>10</th><th>11</th><th>12</th><th>13</th><th>14</th><th>15</th><th>16</th><th>17</th><th>18</th><th>19</th><th>20</th><th>21</th><th>22</th><th>23</th><th>24</th><th>25</th><th>26</th><th>27</th><th>28</th><th>29</th><th>30</th><th>Y</th></tr>
<tr><th>0</th><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><th>0</th></tr>
<tr><th>1</th><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>M</td><td>■</td><td>C</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>D</td><td>O</td><td>■</td><th>1</th></tr>
<tr><th>2</th><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><th>2</th></tr>
<tr><th>3</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>3</th></tr>
<tr><th>4</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>4</th></tr>
<tr><th>5</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>5</th></tr>
<tr><th>6</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>D</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><th>6</th></tr>
<tr><th>7</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>7</th></tr>
<tr><th>8</th><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><th>8</th></tr>
<tr><th>9</th><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>C</td><td>■</td><td>&nbsp;</td><td>■</td><th>9</th></tr>
<tr><th>10</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><th>10</th></tr>
<tr><th>11</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>11</th></tr>
<tr><th>12</th><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><th>12</th></tr>
<tr><th>13</th><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>D</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>13</th></tr>
<tr><th>14</th><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>14</th></tr>
<tr><th>15</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>D</td><td>B</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>15</th></tr>
<tr><th>16</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>16</th></tr>
<tr><th>17</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>></td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>17</th></tr>
<tr><th>18</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>D</td><td>■</td><td>M</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>18</th></tr>
<tr><th>19</th><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>C</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>D</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>19</th></tr>
<tr><th>20</th><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><th>20</th></tr>
<tr><th>Y\X</th><th>0</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th><th>10</th><th>11</th><th>12</th><th>13</th><th>14</th><th>15</th><th>16</th><th>17</th><th>18</th><th>19</th><th>20</th><th>21</th><th>22</th><th>23</th><th>24</th><th>25</th><th>26</th><th>27</th><th>28</th><th>29</th><th>30</th><th>Y</th></tr>
</table>

#### Cases spéciales — étage 1

| Symbole | Coordonnée | Rôle | Note |
|---|---:|---|---|
| `M` | `Vector2i(3, 1)` | Message / PNJ neutre / indication | Message : indice sur les coffres. |
| `C` | `Vector2i(5, 1)` | Coffre | Coffre : +25 or. |
| `D` | `Vector2i(28, 1)` | Porte fermée | Porte d’accès au temple. |
| `O` | `Vector2i(29, 1)` | Temple | Temple de guérison. |
| `D` | `Vector2i(7, 6)` | Porte fermée | Porte simple. |
| `C` | `Vector2i(27, 9)` | Coffre | Coffre : `small_shield`. |
| `D` | `Vector2i(25, 13)` | Porte fermée | Porte simple. |
| `D` | `Vector2i(14, 15)` | Porte fermée | Porte d’accès boutique. |
| `B` | `Vector2i(15, 15)` | Boutique | Boutique. |
| `>` | `Vector2i(23, 17)` | Escalier descendant | Transition active vers l’étage 2. |
| `D` | `Vector2i(23, 18)` | Porte fermée | Porte simple près de l’escalier. |
| `M` | `Vector2i(25, 18)` | Message / PNJ neutre / indication | Message : avertissement avant l’étage 2. |
| `C` | `Vector2i(15, 19)` | Coffre | Coffre : `tarnished_ring`. |
| `D` | `Vector2i(20, 19)` | Porte fermée | Porte simple. |

#### Données liées — étage 1

| Élément | Coordonnée | Note |
|---|---:|---|
| Départ | `Vector2i(1, 1)` | Point de départ de l’étage 1. |
| Escalier descendant actif | `Vector2i(23, 17)` | Transition vers l’étage 2. |
| Découverte de sort | `Vector2i(29, 13)` | `spell_ice_shard`, définie par table de données, pas par symbole visible dans le layout. |

---

### Étage 2 — Cryptes de pierre froide

Dimensions : **31 × 21**.

<table>
<tr><th>Y\X</th><th>0</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th><th>10</th><th>11</th><th>12</th><th>13</th><th>14</th><th>15</th><th>16</th><th>17</th><th>18</th><th>19</th><th>20</th><th>21</th><th>22</th><th>23</th><th>24</th><th>25</th><th>26</th><th>27</th><th>28</th><th>29</th><th>30</th><th>Y</th></tr>
<tr><th>0</th><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><th>0</th></tr>
<tr><th>1</th><td>■</td><td>M</td><td>L</td><td>&nbsp;</td><td>X</td><td>></td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>1</th></tr>
<tr><th>2</th><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><th>2</th></tr>
<tr><th>3</th><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>3</th></tr>
<tr><th>4</th><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><th>4</th></tr>
<tr><th>5</th><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>D</td><td>B</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>5</th></tr>
<tr><th>6</th><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>6</th></tr>
<tr><th>7</th><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>C</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>7</th></tr>
<tr><th>8</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>8</th></tr>
<tr><th>9</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>9</th></tr>
<tr><th>10</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><th>10</th></tr>
<tr><th>11</th><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>M</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>11</th></tr>
<tr><th>12</th><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>12</th></tr>
<tr><th>13</th><td>■</td><td>C</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>13</th></tr>
<tr><th>14</th><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>14</th></tr>
<tr><th>15</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>D</td><td>O</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>C</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>15</th></tr>
<tr><th>16</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><th>16</th></tr>
<tr><th>17</th><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>M</td><td>■</td><td><</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>17</th></tr>
<tr><th>18</th><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>■</td><th>18</th></tr>
<tr><th>19</th><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>■</td><th>19</th></tr>
<tr><th>20</th><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><td>■</td><th>20</th></tr>
<tr><th>Y\X</th><th>0</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th><th>10</th><th>11</th><th>12</th><th>13</th><th>14</th><th>15</th><th>16</th><th>17</th><th>18</th><th>19</th><th>20</th><th>21</th><th>22</th><th>23</th><th>24</th><th>25</th><th>26</th><th>27</th><th>28</th><th>29</th><th>30</th><th>Y</th></tr>
</table>

#### Cases spéciales — étage 2

| Symbole | Coordonnée | Rôle | Note |
|---|---:|---|---|
| `M` | `Vector2i(1, 1)` | Message / PNJ neutre / indication | Message : avertissement boss. |
| `L` | `Vector2i(2, 1)` | Porte verrouillée | Porte verrouillée liée à la Clé du gardien. |
| `X` | `Vector2i(4, 1)` | Boss / rencontre majeure | Boss actif : `gardien_boss_etage_2`. |
| `>` | `Vector2i(5, 1)` | Escalier descendant | Escalier descendant futur derrière le boss. |
| `D` | `Vector2i(12, 5)` | Porte fermée | Porte d’accès boutique. |
| `B` | `Vector2i(13, 5)` | Boutique | Boutique. |
| `C` | `Vector2i(25, 7)` | Coffre | Coffre : +50 or. |
| `M` | `Vector2i(3, 11)` | Message / PNJ neutre / indication | Message : indice vers la clé / impasse. |
| `C` | `Vector2i(1, 13)` | Coffre | Coffre : Clé du gardien. |
| `D` | `Vector2i(4, 15)` | Porte fermée | Porte d’accès temple. |
| `O` | `Vector2i(5, 15)` | Temple | Temple de guérison. |
| `C` | `Vector2i(15, 15)` | Coffre | Coffre : `reinforced_leather`. |
| `M` | `Vector2i(21, 17)` | Message / PNJ neutre / indication | Message : direction générale vers l’ouest. |
| `<` | `Vector2i(23, 17)` | Escalier montant | Escalier montant actif vers l’étage 1. |

#### Données liées — étage 2

| Élément | Coordonnée | Note |
|---|---:|---|
| Départ / escalier montant | `Vector2i(23, 17)` | Retour vers l’étage 1. |
| Escalier descendant futur | `Vector2i(5, 1)` | Placé derrière le boss, destination future. |
| Coffre clé | `Vector2i(1, 13)` | Contient `boss_door_key_floor_2`. |
| Porte verrouillée boss | `Vector2i(2, 1)` | Consomme `boss_door_key_floor_2` à l’ouverture. |
| Boss | `Vector2i(4, 1)` | Déclenche `gardien_boss_etage_2`, puis disparaît après victoire. |

---

## 2. Variantes de planification

Cette section sert à tester les modifications de layout avant de les coder dans `FloorDatabase.gd`.

Pour le moment, aucune variante active n’est conservée dans ce document.

Règles pour ajouter une future variante :

- conserver le même format de grille que la section actuelle ;
- indiquer clairement que la variante ne reflète pas encore l’état en jeu ;
- lister toutes les coordonnées ajoutées ou modifiées ;
- ne pas remplacer la section `État actuel en jeu` par une variante ;
- reconstruire la section actuelle depuis `FloorDatabase.gd` après intégration réelle dans les scripts.

---

## 3. Règle de maintenance

`FloorDatabase.gd` est la source gameplay réelle.

Ce fichier doit être mis à jour lorsque :

- un symbole est ajouté, déplacé ou retiré dans un layout ;
- une coordonnée spéciale change ;
- un coffre, message, boss, escalier ou lieu spécial est ajouté ;
- une variante de planification devient l’état réel du jeu.

La première section doit toujours représenter le jeu tel qu’il est réellement implémenté.
