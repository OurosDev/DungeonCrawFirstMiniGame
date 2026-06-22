# Release GitHub — v0.13

## Tag

```text
v0.13
```

## Titre

```text
v0.13 — Magicka : progression magique, sorts actifs et poison
```

## Description courte

Release de progression magique : nouveaux sorts de Mage et de Prêtre, préparation hors combat des sorts actifs, sauvegarde des choix, soin de groupe et premier statut temporaire avec le poison.

## Notes de release

```markdown
## v0.13 — Magicka : progression magique, sorts actifs et poison

Cette version poursuit la consolidation de la boucle jouable après `v0.12`.

### Magie

- `Éclat de givre` est rééquilibré :
  - coût : 10 PM ;
  - dégâts : 12-24 ;
  - prérequis : Mage niveau 2 + découverte.
- Nouveau sort Mage niveau 5 : `Poison`.
  - coût : 10 PM ;
  - applique le statut Poison ;
  - inflige 5 à 10 % des PV max du monstre à chaque tick.
- Nouveau sort Prêtre niveau 5 : `Soin renforcé`.
  - coût : 9 PM ;
  - soin : 16-28 PV ;
  - cible : 1 allié.
- Nouveau sort découvert : `Soin de groupe`.
  - coût : 9 PM ;
  - soin : 7-13 PV ;
  - cible : toute l'équipe ;
  - découverte : étage 2, x21 y8.

### Statuts

- Ajout d'un premier système de statuts temporaires.
- Le poison se dissipe progressivement :
  - 1 chance sur 6 après le premier tick ;
  - 1 chance sur 4 après le deuxième ;
  - 1 chance sur 2 après le troisième ;
  - disparition automatique après le quatrième.
- Le boss gardien est immunisé au poison.

### Grimoire

- Le grimoire hors combat permet de préparer les sorts actifs.
- Les sorts préparés sont utilisés automatiquement au début des combats.
- Le grimoire de combat reste temporaire et n'écrase pas les choix hors combat.

### Sauvegarde

- Le format de sauvegarde passe en version 7.
- Nouveau champ : `active_ability_ids_by_party_slot`.
- Les découvertes de sorts restent sauvegardées via `discovered_ability_ids`.

### Scripts

- Les scripts modifiés pour ce bloc reçoivent l'en-tête :
  `VERSION SCRIPT / v0.13-Magicka`.

### Tests recommandés

- Vérifier Éclat de givre, Poison, Soin renforcé et Soin de groupe.
- Vérifier la découverte de Soin de groupe à l'étage 2 en x21 y8.
- Vérifier la préparation hors combat des sorts actifs.
- Vérifier la sauvegarde / chargement des sorts préparés.
- Vérifier que le poison n'affecte pas le boss gardien.
- Vérifier que le Soin de groupe ne demande pas de sélection de cible.
```
