# STATE_AUDIT v0.11.2 — DungeonCrawFirstMiniGame

Date d'audit : 2026-06-19

Version auditée / préparée : `v0.11.2 — Polish menus et orientation des modèles 3D`

## Résumé

`v0.11.2` est une release de polish post-`v0.11.1`.

Elle regroupe :
- polish du menu principal ;
- polish de la création d'équipe ;
- aide contextuelle pour les boutons de roll ;
- règle d'orientation des modèles 3D spéciaux.

## Scripts concernés

```text
scripts/ui/MainMenu.gd
scripts/ui/PartyCreationUI.gd
scripts/dungeon/DungeonRenderer.gd
```

## Fonctionnalités validées

Menu principal :
```text
- boutons texturés ;
- panneau Options texturé ;
- grand cadre autour du titre DONJON DES SERPENTS retiré ;
- titre texte conservé ;
- aucune image de fond ajoutée.
```

Création d'équipe :
```text
- cadre principal texturé ;
- boutons de roll texturés ;
- boutons de classe texturés ;
- bouton Valider ce héros texturé ;
- bouton Retour au menu texturé ;
- comportement de création conservé.
```

Tooltips de roll :
```text
- tooltip sur Relancer ;
- tooltip sur Stocker ;
- tooltip sur Reprendre ;
- fenêtre près du curseur ;
- fenêtre limitée aux bords de l'écran ;
- aucun changement de logique des rolls.
```

Orientation des modèles 3D :
```text
- règle automatique ajoutée dans DungeonRenderer.gd ;
- priorité à une case "." adjacente ;
- fallback vers une case praticable non-mur ;
- modèles concernés : M, C, O, B ;
- aucun layout modifié.
```

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


## Sauvegarde

Aucun changement du format de sauvegarde.

## Tests recommandés avant tag

```text
1. Lancer le projet.
2. Vérifier le menu principal.
3. Vérifier les boutons texturés.
4. Vérifier que le grand cadre du titre n'apparaît plus.
5. Ouvrir Options puis revenir.
6. Lancer Nouvelle partie.
7. Vérifier l'écran de création d'équipe.
8. Survoler Relancer / Stocker / Reprendre.
9. Vérifier que les tooltips restent dans l'écran.
10. Valider les quatre héros.
11. Explorer jusqu'au premier M de l'étage 1.
12. Vérifier que le premier M ne fait plus face au mur.
13. Vérifier les coffres et messages réorientés.
14. Vérifier temples et boutiques.
15. Tester étage 1 et étage 2.
16. Vérifier les interactions M/C/O/B.
17. Sauvegarder / charger.
```
