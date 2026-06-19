# v0.11.2 — Polish menus et orientation des modèles 3D

Release de polish post-`v0.11.1`.

Cette version améliore les écrans d'entrée du jeu, clarifie les boutons de roll de la création d'équipe et corrige l'orientation de plusieurs modèles 3D spéciaux pour éviter qu'ils fassent face aux murs.

## Ajouts principaux

### Menu principal

- Boutons du menu principal texturés.
- Panneau Options texturé.
- Grand cadre autour de `DONJON DES SERPENTS` retiré.
- Titre texte conservé.
- Pas d'image de fond ajoutée.

### Création d'équipe

- Cadre principal texturé.
- Boutons de création d'équipe texturés.
- Boutons de classe texturés.

### Aide au survol des boutons de roll

Ajout d'une fenêtre flottante près du curseur pour expliquer :
```text
Relancer
Stocker
Reprendre
```

### Orientation des modèles 3D spéciaux

Règle d'orientation des modèles spéciaux :
1. conserver l'orientation naturelle si elle regarde déjà une case `.`;
2. sinon, chercher une case `.` adjacente ;
3. sinon, chercher une case praticable non-mur ;
4. sinon, conserver l'orientation naturelle.

Modèles concernés :
- `M` = message / stèle ;
- `C` = coffre ;
- `O` = temple ;
- `B` = boutique.


Orientations modifiées :

Étage 1 :
- Message `M` (3, 1) : nord -> ouest
- Coffre `C` (5, 1) : nord -> sud
- Coffre `C` (27, 9) : nord -> ouest
- Coffre `C` (15, 19) : nord -> ouest

Étage 2 :
- Message `M` (1, 1) : nord -> sud
- Coffre `C` (25, 7) : nord -> est
- Coffre `C` (1, 13) : nord -> sud
- Coffre `C` (15, 15) : nord -> ouest
- Message `M` (21, 17) : nord -> ouest

Orientations conservées :

Étage 1 :
- Temple `O` (29, 1) : conservé ouest
- Boutique `B` (15, 15) : conservé ouest
- Message `M` (25, 18) : conservé nord

Étage 2 :
- Boutique `B` (13, 5) : conservé ouest
- Message `M` (3, 11) : conservé nord
- Temple `O` (5, 15) : conservé ouest


## Fichiers principaux concernés

Scripts :
```text
scripts/ui/MainMenu.gd
scripts/ui/PartyCreationUI.gd
scripts/dungeon/DungeonRenderer.gd
```

Documentation :
```text
CHANGELOG/v0.11.2.md
CHANGELOG/README.md
README.md
ASSISTANT_WORKFLOW.md
IA_RELAIS.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
audits/STATE_AUDITv0.11.2.md
```

## Sauvegarde

Pas de changement du format de sauvegarde.
