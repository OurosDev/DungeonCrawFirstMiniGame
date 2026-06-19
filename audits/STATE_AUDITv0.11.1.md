# STATE_AUDIT v0.11.1 — DungeonCrawFirstMiniGame

Date d'audit : 2026-06-19

Version auditée / préparée : `v0.11.1 — Carte agrandie et automap améliorée`

## 1. Résumé

`v0.11.1` est une amélioration de qualité de vie issue du playtest. Elle ajoute une carte agrandie d'exploration dans le viewport, synchronisée avec l'automap compacte, sans révéler d'informations non découvertes.

La version améliore aussi l'automap compacte : suppression du titre, zoom léger, et coordonnées au survol souris sur les cases découvertes non-mur.

## 2. État public avant préparation

Avant cette préparation, le dépôt public contenait déjà `CHANGELOG/v0.11.md`, mais certains documents visibles sur `main`, notamment `README.md`, `IA_RELAIS.md` et `ASSISTANT_WORKFLOW.md`, pouvaient encore afficher `v0.10` comme base récente.

Le présent pack réaligne la documentation vers `v0.11.1`.

## 3. Scripts concernés

```text
scripts/ui/AutoMapUI.gd
scripts/ui/CommandOverlayUI.gd
scripts/ui/DungeonViewportUI.gd
scripts/ui/GameUI.gd
scripts/dungeon/Dungeon.gd
scripts/dungeon/DungeonInputController.gd
```

## 4. Fonctionnalités validées

### Carte agrandie

```text
- bouton Carte en exploration ;
- ouverture dans l'espace viewport ;
- fermeture par Retour ;
- fermeture par E / Échap ;
- déplacements bloqués pendant l'affichage ;
- carte absente en combat ;
- cadre texturé ;
- bouton Retour texturé ;
- bouton Retour réduit et placé en bas à gauche du cadre.
```

### Synchronisation carte / automap

```text
- même étage courant ;
- mêmes cellules découvertes ;
- même position joueur ;
- même orientation joueur ;
- mêmes symboles principaux ;
- aucune révélation de zones non découvertes.
```

### Coordonnées au survol

```text
- tooltip souris sur la carte agrandie ;
- tooltip souris sur l'automap compacte ;
- coordonnées visibles uniquement pour les cases découvertes non-mur ;
- pas de coordonnées sur les murs ;
- pas de coordonnées sur les cases non découvertes.
```

### Automap compacte

```text
- titre AUTOMAP retiré ;
- zoom léger ;
- conservation d'une fenêtre 15x11 ;
- tooltip coordonnées ajouté sans changer le gameplay.
```

## 5. Sauvegarde

Aucun changement du format de sauvegarde.

La carte agrandie réutilise les données existantes du donjon et de l'automap.

## 6. Design validé

Décisions retenues :

```text
- ajouter une aide de navigation sans journal de quête ;
- ne pas révéler de zones non découvertes ;
- ne pas ajouter de coordonnées fixes autour de la carte si le survol souris fonctionne ;
- limiter les coordonnées au survol souris ;
- conserver le style UI NineSlice de v0.11 ;
- ne pas changer le gameplay combat ;
- ne pas toucher aux consommables ou au contenu de donjon.
```

## 7. Points de vigilance

```text
- vérifier le comportement du tooltip après redimensionnement de fenêtre ;
- vérifier les étages 1 et 2 ;
- vérifier que les déplacements restent bloqués pendant la carte ;
- vérifier que l'automap compacte reste lisible ;
- vérifier que le bouton Retour reste cliquable malgré sa petite taille.
```

## 8. Tests recommandés avant tag

```text
1. Lancer le projet.
2. Explorer quelques cases.
3. Ouvrir Carte.
4. Vérifier que seules les zones découvertes sont visibles.
5. Vérifier la position et l'orientation du joueur.
6. Fermer avec Retour.
7. Ouvrir Carte puis fermer avec E.
8. Ouvrir Carte puis fermer avec Échap.
9. Vérifier que Z/Q/S/D ne déplacent pas le joueur pendant l'affichage de la carte.
10. Survoler une case découverte non-mur : coordonnées visibles.
11. Survoler un mur : pas de coordonnées.
12. Survoler une case non découverte : pas de coordonnées.
13. Vérifier l'automap compacte sans titre.
14. Vérifier les coordonnées au survol sur l'automap compacte.
15. Tester étage 1.
16. Tester étage 2.
17. Entrer en combat et vérifier que la carte n'est pas affichée.
18. Redimensionner la fenêtre.
19. Sauvegarder / charger après exploration.
```

## 9. Conclusion

`v0.11.1` améliore la lisibilité et la planification de l'exploration sans modifier la difficulté de progression ni introduire de suivi explicite d'objectifs. La carte reste une extension de l'automap, pas un système de quête.
