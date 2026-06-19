# STATE_AUDIT v0.11 — DungeonCrawFirstMiniGame

Date d'audit : 2026-06-19

Version auditée / préparée : `v0.11 — Cadres UI NineSlice et correction Prêtre`

## 1. Résumé

`v0.11` poursuit la consolidation de la boucle existante en améliorant l'apparence de l'interface sans changer le gameplay.

La version introduit une texture de cadre NineSlice sombre, appliquée aux panneaux principaux, cadres héros, menus et boutons. Elle inclut également une correction de cohérence : la classe masculine d'Eldric est désormais `Prêtre`.

## 2. État public avant préparation

Avant cette préparation, le dépôt public indiquait `v0.10 — Grimoire de combat et ciblage des soins` comme version stable récente.

Documents structurants visibles sur `main` avant le passage à `v0.11` :

```text
README.md
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
CHANGELOG/README.md
CHANGELOG/v0.10.md
audits/STATE_AUDITv0.10.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
docs/informations/IDEAS.md
```

Le présent pack met à jour cette documentation vers `v0.11`.

## 3. Assets concernés

### Nouvel asset

```text
assets/ui/frames/texture_cadre_ui.png
```

Caractéristiques :

```text
dimensions : 96x96 px
marges NineSlice panneaux : 16 px
marges NineSlice boutons : 8 px dans le helper
style : dark fantasy rétro, bronze sombre, pierre usée
centre sombre opaque
pas de halo blanc
```

## 4. Scripts concernés par l'UI

### Nouveau script

```text
scripts/ui/theme/UIFrameStyle.gd
```

### Scripts modifiés

```text
scripts/ui/GameUI.gd
scripts/ui/PartyStatusUI.gd
scripts/ui/DungeonViewportUI.gd
scripts/ui/CommandOverlayUI.gd
scripts/ui/LogPanelUI.gd
scripts/ui/AutoMapUI.gd
scripts/ui/menu/MenuUIFactory.gd
```

## 5. Scripts concernés par le hotfix Prêtre

```text
scripts/characters/ClassDatabase.gd
scripts/characters/CharacterData.gd
scripts/items/ItemDatabase.gd
scripts/core/SaveManager.gd
scripts/ui/PartyCreationUI.gd
```

## 6. Fonctionnalités validées

### Interface principale

- Les cadres principaux utilisent la texture NineSlice.
- Les cadres des héros utilisent le nouveau rendu.
- Le viewport central, le journal et l'automap sont harmonisés.
- Les boutons d'exploration et de combat sont texturés.
- Le long cadre derrière les commandes est retiré.
- La lisibilité générale reste correcte.

### Menus

- Les panneaux créés par `MenuUIFactory.gd` utilisent le style texturé.
- Les boutons créés par la fabrique utilisent le style texturé.
- Les vues de menu héritant du thème prennent le rendu texturé quand elles n'ont pas d'override local.
- Inventaire, boutique, statut, équipement et grimoires restent utilisables.

### Correction Prêtre

- La liste des classes affiche `Prêtre`.
- La création de groupe assigne Eldric à `Prêtre`.
- Les restrictions d'équipement utilisent le nom corrigé.
- Les anciennes valeurs sont normalisées vers `Prêtre`.
- Les sauvegardes restent compatibles.

## 7. Sauvegarde

Aucun changement volontaire du format de sauvegarde.

Le champ `job` est normalisé pour éviter les incohérences entre l'ancien libellé et le nouveau libellé :

```text
ancien libellé -> Prêtre
Prêtre -> Prêtre
```

## 8. Design validé

Décisions retenues :

```text
- améliorer l'UI sans bouleverser la composition ;
- utiliser une première texture commune pour les cadres et boutons ;
- accepter temporairement que les boutons utilisent la même texture que les panneaux ;
- prévoir une texture dédiée aux boutons plus tard ;
- conserver Compatibility / OpenGL ;
- conserver le scaling canvas_items + keep ;
- éviter les halos blancs ;
- ne pas ajouter de consommables ;
- ne pas ajouter de journal de quête ;
- ne pas viser l'étage 3 comme priorité immédiate.
```

## 9. Points de vigilance

### Boutons

La texture actuelle fonctionne sur les boutons, mais elle n'a pas été conçue spécifiquement pour eux.

Amélioration future probable :

```text
assets/ui/frames/texture_bouton_ui.png
```

ou équivalent.

### UI texturée

Les états visuels doivent rester lisibles :

```text
héros actif
sélection verte
dégâts reçus
soin
bouton hover
bouton pressed
bouton disabled
```

### Documentation / workflow

Le workflow a été précisé : la priorité donnée aux fichiers locaux fournis par l'utilisateur ne doit pas exclure la consultation, l'utilisation ou la modification des fichiers GitHub quand cela est pertinent.

## 10. Tests recommandés avant tag

```text
1. Lancer le projet.
2. Vérifier l'exploration.
3. Tester les boutons Z / Q / S / D / menu à la souris.
4. Tester le combat.
5. Tester Attaquer / Magie / Grimoire / Fuir.
6. Tester Soin avec sélection par cadres.
7. Vérifier que le long cadre derrière les commandes a disparu.
8. Vérifier les cadres héros.
9. Vérifier le viewport.
10. Vérifier le journal.
11. Vérifier l'automap.
12. Ouvrir le menu en jeu.
13. Tester inventaire.
14. Tester boutique.
15. Tester statut.
16. Tester équipement.
17. Tester grimoire hors combat.
18. Tester grimoire de combat.
19. Tester options.
20. Redimensionner la fenêtre.
21. Créer une nouvelle partie.
22. Vérifier que la classe affichée est Prêtre.
23. Sauvegarder.
24. Charger.
25. Vérifier qu'Eldric reste Prêtre.
```

## 11. Conclusion

`v0.11` est une version de polish visuel et de cohérence. Elle ne change pas la boucle de gameplay, mais améliore fortement la présentation de l'interface en posant une base NineSlice réutilisable.

La correction `Prêtre` règle une incohérence visible dans plusieurs menus et rend la classe cohérente avec le personnage d'Eldric.
