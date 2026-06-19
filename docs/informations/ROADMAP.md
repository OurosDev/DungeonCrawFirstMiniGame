# ROADMAP — DungeonCrawFirstMiniGame

Date de mise à jour : 2026-06-19

Version stable actuelle : `v0.10 — Grimoire de combat et ciblage des soins`

## Vision actuelle

Le projet doit continuer à enrichir la boucle jouable complète existante plutôt que viser trop vite du contenu supplémentaire.

La priorité n'est pas l'étage 3, ni l'ajout de consommables. La priorité est de consolider les systèmes qui rendent les deux premiers étages plus intéressants : magie, grimoire, lisibilité, événements, progression par objets clés, équipement, feedbacks et playtests.

## Base jouable actuelle

```text
création d'équipe
exploration de deux étages
portes / temples / boutiques
coffres / messages
clé du gardien
porte verrouillée
boss fixe du gardien
combat tour par tour
inventaire commun
équipement
grimoire hors combat
grimoire de combat
sauvegarde / chargement
contrôles souris + AZERTY
Compatibility / OpenGL
```

## Versions récentes

### v0.8.1 — Stabilisation playtest et scaling fenêtre

- Renderer `Compatibility / OpenGL`.
- Scaling fenêtre `canvas_items + keep`.
- Playtest 01 documenté.
- Logs et builds hors repo.

### v0.8.2 — Refactorisations internes et stabilisation technique

- Refactorisation du menu en jeu.
- Refactorisation du combat.
- Refactorisation du donjon.
- Refactorisation de `GameSession`.
- Refactorisation de la création d'équipe.

### v0.9 — Grimoire hors combat et sélection de cible

- Grimoire hors combat.
- Soins hors combat.
- Sélection de cible par cadres de héros.
- Prévisualisation PV/PM.
- Messages importants plus lisibles.

### v0.10 — Grimoire de combat et ciblage des soins

- Grimoire de combat propre au héros actif.
- Sorts actifs temporaires réinitialisés à chaque combat.
- `Magie` et `Soin` en actions directes.
- Soin en combat avec sélection par cadres.
- Journal Combat plus lisible : dégâts ennemis rouges, soins verts.

## Priorités recommandées à court terme

### 1. Playtest ciblé post-v0.10

Objectif : vérifier que la boucle complète reste stable avec le grimoire de combat.

À tester :

```text
grimoire hors combat
grimoire de combat
soin en combat
prévisualisation PV/PM
combat mage
combat prêtresse
victoire
fuite
K.O.
sauvegarde / chargement
boutique
équipement
boss gardien
```

### 2. Amélioration progressive du système de sorts

Pistes compatibles avec la vision actuelle :

```text
nouveaux sorts offensifs simples
nouveaux sorts de soin
sorts utilitaires hors combat plus tard
sorts actifs configurables plus tard
grimoire individuel par héros plus tard
système sauvegardé de sorts connus/découverts seulement quand nécessaire
```

À éviter pour l'instant :

```text
objets consommables
potions
journal de quête
moniteur d'objectif
étage 3 immédiat
multiplication trop rapide du contenu
```

### 3. Lisibilité et feedbacks

Améliorer les retours joueur sans transformer le jeu en checklist :

```text
messages importants mieux différenciés
feedbacks de boss / clé / porte / coffre
feedbacks de montée de niveau
journal Combat plus robuste si les textes se multiplient
```

### 4. Équipement et objets clés

L'inventaire doit rester centré sur :

```text
équipement
objets clés de quête
or
```

Les consommables ne correspondent pas à la direction actuelle du jeu.

## Priorités plus tardives

```text
nouveaux monstres ou variations de monstres
nouveaux sorts et effets
événements fixes plus riches
boss plus structurés
étage 3 quand la boucle actuelle sera suffisamment enrichie
exports de playtest plus encadrés
```

## Notes de versioning

Le projet reste en pré-1.0. Ne pas accélérer vers `v1.0`.

Les versions peuvent continuer ainsi :

```text
v0.10
v0.11
v0.12
...
```

`v1.0` doit rester réservé à une version réellement complète, stable, documentée, exportable et suffisamment testée.
