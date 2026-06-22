# Release GitHub — v0.12

## Tag

```text
v0.12
```

## Titre

```text
v0.12 — Équilibrage combat, sort découvert et corrections UI
```

## Description courte

Release de progression et équilibrage : coût du sort de base du Mage augmenté, Éclat de givre utilisable en combat après découverte, PV des monstres normaux augmentés, et corrections UI autour des rolls, de l'équipement et du canal Journal/Combat.

## Notes de release

```markdown
## v0.12 — Équilibrage combat, sort découvert et corrections UI

Cette version poursuit la consolidation de la boucle jouable après `v0.11.3`.

### Gameplay / combat

- Le sort de base du Mage coûte désormais 6 PM au lieu de 3 PM.
- Le sort `Éclat de givre`, découvert à l'étage 1, peut être utilisé en combat par un Mage compatible.
- La découverte du sort est sauvegardée dans la progression du groupe.
- Les monstres normaux gagnent environ 25 % de PV :
  - Zombie : 12 -> 15
  - Chauve-souris : 8 -> 10
  - Gobelin : 16 -> 20
  - Troll : 34 -> 43
  - Gardien : 45 -> 56
- Le boss gardien reste à 225 PV.

### Sauvegarde

- Le format de sauvegarde passe en version 6.
- Nouveau champ : `discovered_ability_ids`.
- Les anciennes sauvegardes restent compatibles.

### Interface

- Les valeurs de rolls de création d'équipe sont colorées :
  - 10 en vert ;
  - 5 en jaune ;
  - 4 ou moins en rouge.
- L'écran `Statut > Équipement` est ajusté :
  - `Accessoire` n'est plus caché ;
  - les cadres inutiles autour des slots et du bouton retour sont retirés ;
  - l'indication basse inutile est supprimée.
- Le canal affiché revient automatiquement sur `Journal` en sortie de combat.

### Tests recommandés

- Découverte et utilisation d'Éclat de givre.
- Sauvegarde / chargement après découverte.
- Vérification des PV des monstres normaux.
- Vérification du boss gardien.
- Création d'équipe avec rolls colorés.
- Écran équipement sur les quatre héros.
- Entrée / sortie de combat avec canaux Journal / Combat.
```
