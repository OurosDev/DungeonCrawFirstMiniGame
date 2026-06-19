# STATE_AUDIT v0.10 — DungeonCrawFirstMiniGame

Date d'audit : 2026-06-19

Version auditée / préparée : `v0.10 — Grimoire de combat et ciblage des soins`

## 1. Résumé

`v0.10` poursuit la consolidation de la boucle jouable existante en améliorant le combat magique.

La base précédente `v0.9` ajoutait le grimoire hors combat et la sélection de cible par cadres. `v0.10` réutilise cette base pour le combat : le soin en combat peut maintenant cibler directement un héros, et le héros actif dispose d'un grimoire de combat temporaire pour vérifier ou changer son sort actif.

## 2. État public avant préparation

Avant cette préparation, le dépôt public indiquait encore `v0.9 — Grimoire hors combat et sélection de cible` comme version stable récente.

Documents structurants visibles sur `main` avant le passage à `v0.10` :

```text
README.md
IA_RELAIS.md
ASSISTANT_WORKFLOW.md
CHANGELOG/README.md
CHANGELOG/v0.9.md
audits/STATE_AUDITv0.9.md
docs/informations/ROADMAP.md
docs/informations/TECHNICAL_DEBT.md
```

Le présent pack met à jour cette documentation vers `v0.10`.

## 3. Scripts concernés par v0.10

### Nouveau script

```text
scripts/ui/menu/CombatGrimoireMenuView.gd
```

### Scripts modifiés

```text
scripts/combat/CombatManager.gd
scripts/dungeon/DungeonInputController.gd
scripts/ui/InGameMenuPanelUI.gd
scripts/ui/LogPanelUI.gd
```

## 4. Fonctionnalités validées

### Grimoire de combat

- Le combat peut afficher un bouton `Grimoire`.
- Le grimoire de combat concerne uniquement le héros actif.
- Les sorts actifs sont temporaires et réinitialisés à chaque début de combat.
- Sélectionner le sort déjà actif ferme le grimoire sans consommer le tour.
- Revenir en arrière ferme le grimoire sans consommer le tour.
- Changer réellement le sort actif consomme l'action du tour.

### Actions directes

- `Magie` utilise directement le sort offensif actif.
- `Soin` utilise directement le sort de soin actif.
- `Soin` ne passe plus par un panneau central : la sélection par cadres démarre immédiatement.

### Sélection de cible

- La cible de soin en combat se choisit via les cadres de héros latéraux.
- La sélection fonctionne à la souris.
- La sélection fonctionne avec les flèches.
- La sélection fonctionne avec `ZQSD`.
- `A` / `Entrée` valide.
- `E` / `Échap` annule.
- La cible affiche une bordure verte.
- La cible affiche une prévisualisation PV.
- Le lanceur affiche une prévisualisation PM.

### Journal Combat

- Les dégâts du joueur vers les monstres conservent la couleur combat actuelle.
- Les dégâts ennemis vers les héros sont colorés en rouge.
- Les soins sont colorés en vert.
- La coloration est appliquée ligne par ligne.

## 5. Sauvegarde

Aucun changement volontaire du format de sauvegarde.

Les sorts actifs en combat sont temporaires :

```text
entrée en combat -> réinitialisation des sorts actifs de base
sort changé pendant le combat -> valable seulement pour le combat en cours
fin ou abandon de combat -> aucune préférence persistée
```

Un futur système de sorts actifs persistants devra être traité séparément, probablement quand le grimoire hors combat deviendra individuel par héros.

## 6. Design validé

Décisions retenues :

```text
- le grimoire hors combat reste dédié aux actions magiques hors combat ;
- le grimoire de combat est distinct et lié au héros actif ;
- les boutons Magie et Soin doivent rester rapides et directs ;
- la sélection de cible par cadres est une brique UI réutilisable ;
- pas de consommables pour le moment ;
- pas de journal de quête ;
- pas d'étage 3 comme priorité immédiate.
```

## 7. Points de vigilance

### Sorts actifs futurs

Pour le moment, les sorts actifs sont réinitialisés au début du combat. Si le joueur doit un jour préparer ses sorts hors combat, il faudra ajouter une persistance propre et probablement rendre le grimoire hors combat individuel par héros.

### CombatManager

`CombatManager.gd` reste un contrôleur central sensible. Les prochaines évolutions de sorts devront rester progressives, avec packs testables et validation locale.

### LogPanelUI

La coloration actuelle du combat repose encore sur une analyse textuelle des lignes. Si le journal combat devient plus riche, il faudra envisager des catégories de message explicites plutôt que d'accumuler des règles de texte.

## 8. Tests recommandés avant tag

```text
1. Combat avec Mage.
2. Vérifier bouton Magie direct.
3. Vérifier bouton Grimoire.
4. Ouvrir Grimoire puis valider le sort déjà actif : pas de perte de tour.
5. Combat avec Prêtresse.
6. Vérifier bouton Soin direct.
7. Vérifier sélection de cible par cadres.
8. Tester souris.
9. Tester flèches.
10. Tester ZQSD.
11. Tester A / Entrée.
12. Tester E / Échap.
13. Vérifier prévisualisation PV cible.
14. Vérifier prévisualisation PM lanceur.
15. Vérifier soin réel + consommation PM.
16. Vérifier riposte ennemie après action consommée.
17. Vérifier couleurs du canal Combat.
18. Vérifier victoire, fuite, K.O. et retour titre.
19. Sauvegarder hors combat après plusieurs combats.
20. Charger la sauvegarde.
```

## 9. Conclusion

`v0.10` est une version de gameplay structurante pour le système de magie en combat. Elle ne multiplie pas encore les sorts, mais prépare une base plus claire pour le faire plus tard : sorts actifs, grimoire de combat, ciblage allié visuel et journal combat plus lisible.
