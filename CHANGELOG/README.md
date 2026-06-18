# Changelog — DungeonCrawFirstMiniGame

Ce dossier contient l'historique des versions du projet.

## Versions

| Version | Titre | Type | Résumé |
|---|---|---|---|
| `v0.8.2` | Refactorisations internes et stabilisation technique | Maintenance | Extraction progressive de helpers depuis les grands contrôleurs : menu, combat, donjon, session et création d'équipe. Aucun changement volontaire de gameplay. |
| `v0.8.1` | Stabilisation playtest et scaling fenêtre | Correctif | Renderer `Compatibility / OpenGL`, scaling fenêtre `canvas_items + keep`, règles de build playtest et documentation de l'incident Windows. |
| `v0.8` | Prise en main souris et clavier AZERTY | Ergonomie | Commandes souris en exploration/combat, bouton menu, contrôles AZERTY et validation souris des étapes de combat. |
| `v0.7.1` | Boss du gardien et retour titre après K.O. | Gameplay | Activation du boss fixe de l'étage 2, boss vaincu persistant et retour titre après K.O. complet. |
| `v0.7` | Coffres, messages et clé du gardien | Gameplay | Coffres persistants, indices, porte verrouillée et clé du gardien. |
| `v0.6.1` | Stabilisation multi-étages | Correctif | Retour étage 2 -> étage 1, états par étage, sauvegarde/chargement multi-étages. |
| `v0.6` | Transition étage 2 | Gameplay | Ajout de l'étage 2, transition descendante, table de rencontres dédiée et marqueur boss futur. |
| `v0.5.2` | Achat boutique | Gameplay | Achat d'objets basiques, prix d'achat, refus si or/inventaire insuffisant. |
| `v0.5.1` | Hotfix stats | Correctif | Correction du retour de stats héros à 1/1/1/1 après création ou chargement. |
| `v0.5` | Boutique de base | Gameplay | Première base boutique. |
| `v0.4` | Équipement de base | Gameplay | Slots d'équipement, restrictions de classe, bonus plats et sauvegarde de l'équipement. |
| `v0.3` | Inventaire | Gameplay | Inventaire partagé, drops réels, sauvegarde/chargement d'inventaire. |
| `v0.2` | Temple, audio et sprites monstres | Gameplay / polish | Temple de guérison, variation audio, correctifs UI et sprites dédiés de monstres. |
| `v0.1` | Base stable initiale | Base | Première base jouable stable. |

## Règles

- Un fichier `vX.Y.md` doit être ajouté pour chaque release significative.
- Les correctifs mineurs peuvent utiliser `vX.Y.Z`.
- Ne pas accélérer artificiellement vers `v1.0`.
- Les builds exportées, logs bruts et zips temporaires ne doivent pas être ajoutés au dépôt.
- Les releases techniques doivent préciser explicitement si le gameplay et le format de sauvegarde sont inchangés.
