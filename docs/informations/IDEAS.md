# IDEAS — DungeonCrawFirstMiniGame

Date de création : 2026-06-19

Base de référence : `v0.11 — Cadres UI NineSlice et correction Prêtre`

## Rôle du document

Ce fichier sert de boîte à idées longue durée pour les fonctionnalités, améliorations, pistes techniques et envies à ne pas perdre. Il complète la roadmap sans la remplacer :

```text
ROADMAP.md = cap, priorités, prochaines phases probables.
IDEAS.md = réserve d'idées non priorisées ou reportées.
```

## Règle de conservation

Ne jamais supprimer une idée de ce fichier par simple nettoyage.

Une idée ne doit être retirée que si :

```text
1. la fonctionnalité / action / modification a bien été réalisée ;
2. l'utilisateur confirme explicitement que l'information peut être retirée de IDEAS.md.
```

Si une idée devient prioritaire, elle peut être copiée ou promue dans `ROADMAP.md`, mais elle ne doit pas forcément être supprimée de `IDEAS.md` immédiatement.

Si une idée est abandonnée ou repoussée très loin, elle doit être déplacée dans une section adaptée plutôt que supprimée sans confirmation.

## Interface et identité visuelle

```text
- Refonte visuelle des cadres par NinePatch / NineSlice.
- Création ou intégration d'un ninesheet / atlas de cadres texturés.
- Harmonisation des cadres du menu, combat, inventaire, grimoire, statut et équipement.
- Amélioration visuelle des fenêtres sans perte de lisibilité.
- Conservation du scaling canvas_items + keep.
- Éviter les contours blancs / halos sur les assets et cadres.
- Améliorer progressivement les icônes ou marqueurs UI si nécessaire.
- Créer une texture dédiée aux boutons, distincte de la texture de cadre principale.
- Créer éventuellement des variantes de cadres pour les états actifs, dégâts, soin ou sélection.
```

## Grimoire, magie et sorts

```text
- Grimoire hors combat individuel par héros.
- Sorts actifs configurables hors combat quand plusieurs sorts seront disponibles.
- Sorts utilisables seulement en combat visibles mais grisés dans le grimoire hors combat.
- Système sauvegardé de sorts connus / découverts.
- Sorts offensifs supplémentaires pour le Mage.
- Sorts de soin supplémentaires pour le Prêtre.
- Sorts utilitaires hors combat : téléportation, retour, révélation, protection ou équivalent.
- Sorts de soutien en combat : protection, bénédiction, réduction de dégâts, etc.
- Meilleur affichage des sorts disponibles / indisponibles.
- Messages de grimoire plus typés si la coloration textuelle devient fragile.
```

## Combat

```text
- Étendre le système de sorts de combat sans ralentir les actions Magie et Soin.
- Garder les boutons Magie et Soin directs, sans menu superflu.
- Réutiliser la sélection par cadres héros pour d'autres actions ciblées.
- Ajouter des sorts ou actions ciblant les alliés autrement que par soin.
- Ajouter des comportements ennemis plus variés plus tard.
- Ajouter des boss plus structurés avec plusieurs étapes ou messages spécifiques.
- Surveiller CombatManager.gd si les ajouts de sorts le font regrossir.
```

## Donjon et événements

```text
- Événements fixes simples dans les étages existants.
- Interactions liées à des objets clés.
- Portes ou passages conditionnels plus variés.
- Messages M plus importants, avec couleur ou feedback spécifique.
- Inscriptions ou indices à forte valeur sans journal de quête.
- Mini-objectifs implicites sans checklist.
- Réutilisation de symboles existants si possible avant d'en ajouter trop.
- Étage 3 plus tard, quand la boucle des deux premiers étages sera suffisamment enrichie.
```

## Équipement, objets clés et récompenses

```text
- Comparaison d'équipement avant équiper.
- Meilleur feedback des bonus/malus d'équipement.
- Objets plus spécialisés par classe.
- Objets clés plus structurants.
- Coffres contenant des récompenses plus mémorables sans consommables.
- Confirmation avant vente importante.
- Meilleure indication des objets non vendables / non jetables.
- Équipement lié à des passages, indices ou mini-objectifs.
```

## Messages, feedbacks et lisibilité

```text
- Messages typés pour remplacer la détection textuelle si les couleurs deviennent fragiles.
- Couleurs spécifiques pour objet clé, inscription, sauvegarde, avertissement, soin, dégâts ennemis.
- Feedback plus clair après boss vaincu.
- Feedback plus clair quand une porte verrouillée est ouverte.
- Feedback plus clair quand un coffre est déjà ouvert.
- Feedback de montée de niveau plus visible.
- Résumé de victoire plus lisible si nécessaire.
```

## Playtests et exports

```text
- Playtest 02 post-v0.11.
- Tests complets Mage + Prêtre après les grimoires.
- Tests UI en résolution native et en stretch.
- Tests boss / K.O. / sauvegarde / chargement après combats.
- Exports Compatibility / OpenGL par défaut pour les testeurs.
- Documentation des playtests sans logs bruts.
- Synthèse des problèmes matériels / renderer si nouveaux cas.
```

## Technique et architecture

```text
- Ne pas relancer de grosse refactorisation sans raison concrète.
- Surveiller les systèmes magie, input, journal de combat et PartyStatusUI.
- Surveiller UIFrameStyle.gd si plusieurs variantes de cadres apparaissent.
- Évaluer proprement les impacts sauvegarde avant tout système persistant de sorts.
- Si un système de messages typés est ajouté, centraliser les types au lieu de multiplier les heuristiques texte.
- Continuer à privilégier les helpers / vues dédiées quand un contrôleur recommence à grossir.
```

## Idées explicitement reportées pour le moment

```text
- Objets consommables.
- Potions.
- Journal de quête.
- Moniteur d'objectif.
- Étage 3 immédiat.
- Passage rapide à v1.0.
```

Ces idées ne sont pas forcément interdites pour toujours, mais elles ne correspondent pas à la direction immédiate du projet.
