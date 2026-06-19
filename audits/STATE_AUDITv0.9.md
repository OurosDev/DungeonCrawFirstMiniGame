# STATE_AUDIT v0.9 — DungeonCrawFirstMiniGame

Date d'audit : 2026-06-19

Version auditée / préparée : `v0.9 — Grimoire hors combat et sélection de cible`

## 1. Résumé

`v0.9` ajoute une première fonctionnalité de grimoire hors combat à la base stabilisée `v0.8.2`.

La version conserve la boucle jouable existante :

```text
création d'équipe -> exploration -> combats -> coffres/messages -> clé du gardien -> porte verrouillée -> boss -> passage derrière le boss
```

La nouveauté principale est l'utilisation de sorts de soin hors combat, avec sélection directe de la cible via les cadres de personnages latéraux.

## 2. État documentaire connu

À la préparation de cet audit, les documents visibles sur `main` indiquaient déjà `v0.8.2` comme base de référence dans `ASSISTANT_WORKFLOW.md` et `IA_RELAIS.md`.

Le présent pack met à jour la documentation vers `v0.9`.

Documents à remplacer ou ajouter avec cette release :

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

## 3. Scripts concernés par v0.9

### Nouveaux scripts

```text
scripts/ui/menu/GrimoireMenuView.gd
scripts/ui/hero_selection/HeroFrameSelectionController.gd
```

### Scripts modifiés

```text
scripts/ui/InGameMenuPanelUI.gd
scripts/ui/LogPanelUI.gd
scripts/ui/PartyStatusUI.gd
```

## 4. Fonctionnalités ajoutées

### Grimoire hors combat

- Le menu en jeu permet d'ouvrir le grimoire.
- Le grimoire affiche les sorts disponibles sous forme compacte.
- Le premier cas d'usage est le soin hors combat.
- Le grimoire refuse l'utilisation en combat.
- Le grimoire refuse les soins impossibles : PM insuffisants ou cible déjà au maximum de PV.

### Sélection de cible

- La sélection se fait directement sur les cadres de héros latéraux.
- Le premier héros est sélectionné par défaut.
- Une bordure verte indique la cible active.
- La souris permet de survoler et cliquer les cadres.
- Les flèches et `ZQSD` permettent de déplacer la cible.
- `A` / `Entrée` valide.
- `E` / `Échap` annule.

### Prévisualisations

- La cible affiche une prévisualisation du soin prévu sur sa barre de PV.
- Le lanceur affiche une prévisualisation du coût PM sur sa barre de mana.
- Les prévisualisations disparaissent après validation ou annulation.

### Messages

- `LogPanelUI.gd` utilise un rendu riche pour colorer les messages importants.
- Les messages importants deviennent plus lisibles sans ajouter de journal de quête.

## 5. Corrections intégrées pendant la phase v0.9

Corrections appliquées avant préparation de release :

```text
- remplacement de String.escape_bbcode() par une fonction locale compatible ;
- correction du crash au clic sur cadre héros pendant gui_input ;
- différé des validations souris pour éviter de libérer des objets verrouillés ;
- suppression des en-têtes redondants dans le grimoire ;
- alignement des contrôles avec les entrées existantes ZQSD/A/E ;
- prévisualisation PV limitée à la cible active ;
- ajout de la prévisualisation PM uniquement sur le lanceur.
```

## 6. Sauvegarde

Aucun nouveau format de sauvegarde volontaire.

Les données modifiées par le grimoire sont déjà persistées :

```text
- hp ;
- max_hp ;
- mp ;
- max_mp ;
- classe/niveau des héros.
```

Les sorts disponibles sont déduits des classes/niveaux pour cette première version.

Risque futur : un système de sorts découverts nécessitera une persistance dédiée, mais il n'est pas nécessaire pour `v0.9`.

## 7. Design validé

Décisions de design pour la suite :

```text
- le grimoire est une interface d'action magique hors combat ;
- pas de consommables pour le moment ;
- pas de journal de quête ;
- pas de moniteur d'objectif ;
- pas de suivi automatique des indices ;
- améliorer la lisibilité via le canal de messages plutôt que par une checklist ;
- éviter l'étage 3 comme priorité immédiate.
```

## 8. Points de vigilance

### UI

`PartyStatusUI.gd` a reçu de nouvelles responsabilités visuelles. À surveiller si d'autres mécaniques ciblant les héros apparaissent.

### Input

La sélection de cadre ne doit pas recréer une logique isolée qui diverge de l'input général. Elle doit continuer à rester compatible avec souris, flèches et AZERTY.

### Messages colorés

Le système actuel peut rester simple, mais si les couleurs deviennent difficiles à maintenir, créer un système de catégories de messages plutôt qu'empiler des détections textuelles.

## 9. Tests recommandés avant tag

```text
1. Nouvelle partie avec Prêtresse.
2. Combat pour perdre des PV.
3. Ouverture du grimoire hors combat.
4. Vérification du bouton compact : Lanceur — Sort.
5. Sélection de cible souris.
6. Sélection de cible flèches.
7. Sélection de cible ZQSD.
8. Validation avec A / Entrée / clic.
9. Annulation avec E / Échap.
10. Vérification prévisualisation PV cible.
11. Vérification prévisualisation PM lanceur.
12. Sauvegarde après soin.
13. Chargement après soin.
14. Test rapide boutique / inventaire / équipement.
15. Test rapide combat après utilisation du grimoire.
```

## 10. Conclusion

`v0.9` est une version de gameplay ciblée et cohérente avec la boucle existante.

Elle enrichit le jeu sans ajouter de contenu brut, sans consommables, sans journal de quête et sans changement volontaire de sauvegarde.

La base peut maintenant servir à tester plus sérieusement les sorts hors combat et préparer plus tard des sorts utilitaires.
