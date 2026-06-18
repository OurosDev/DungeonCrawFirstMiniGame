# Règles de collaboration avec l’assistant

Ce document regroupe les règles de travail utilisées pour les échanges autour du projet `DungeonCrawFirstMiniGame`.

Il sert à éviter de surcharger `ROADMAP.md` avec des consignes qui concernent surtout la manière de préparer les modifications, les releases, les tests et la documentation.

---

## 1. Langue et style de réponse

- Toujours continuer en français.
- Réponses directes, lisibles et structurées.
- Signaler clairement les incohérences entre GitHub, les releases et la conversation.
- Ne pas accélérer artificiellement vers `v1.0`.
- Préférer des versions pré-1.0 : `v0.8`, `v0.8.1`, `v0.9`, `v0.10`, etc.

---

## 2. Vérifications avant modification

Avant de proposer un pack de scripts ou de documentation :

1. vérifier l’état actuel du repo public GitHub ;
2. vérifier les fichiers concernés sur `main` ;
3. tenir compte des releases déjà créées ;
4. signaler si la roadmap, les documents de design ou les scripts ne sont pas alignés ;
5. éviter de repartir d’un ancien fichier de test ou d’un pack précédent si le repo contient une version plus récente.

Quand un cache GitHub est suspect, utiliser une URL avec paramètre anti-cache.

---

## 3. Format attendu pour les modifications de scripts

Quand des scripts doivent être modifiés :

- fournir les scripts complets quand raisonnable ;
- sinon fournir un pack `.zip` de fichiers à remplacer ;
- éviter les snippets partiels sauf si le fichier est vraiment trop grand ;
- ajouter des commentaires de sections clairs :

```gdscript
# CONSTANTES
# INITIALISATION
# INTERFACE
# DONJON
# COMBAT
# SAUVEGARDE
# HELPERS
```

Avant les modifications, lister les fichiers concernés.

---

## 4. Format attendu pour les fichiers à pousser

Toujours séparer :

```text
Nouveaux fichiers
Fichiers mis à jour
À ne pas pousser
```

Pour les releases, distinguer aussi :

```text
Fichiers gameplay / scripts
Fichiers documentation
Fichiers temporaires à ne pas pousser
```

Exemples de fichiers à ne pas pousser :

```text
packs zip générés localement
README_PACK.md temporaire
sauvegardes zip locales
dossier .godot/
build/
dist/
export/
*.exe
*.pck
*.zip
logs bruts
captures système complètes
sauvegardes locales de testeurs
fichiers de test temporaires
```

---

## 5. Organisation documentaire

Organisation actuelle recommandée :

```text
README.md
ASSISTANT_WORKFLOW.md
ROADMAP.md
TECHNICAL_DEBT.md
CHANGELOG/
audits/
docs/
  dungeon/
    FLOOR_DESIGN.md
    FLOOR_VISUALIZER.md
playtests/
```

Règles :

- `README.md` reste à la racine ;
- `ASSISTANT_WORKFLOW.md` peut rester à la racine pour accès rapide ;
- `CHANGELOG/` reste à la racine ;
- `audits/` contient les audits d’état ;
- `docs/dungeon/` contient les documents de conception et visualisation d’étages ;
- `playtests/` contient les synthèses propres des sessions de test.

Ne pas déplacer immédiatement tous les fichiers Markdown pour le seul rangement.  
Profiter d’une mise à jour réelle d’un document pour le déplacer au bon emplacement si nécessaire.

---

## 6. Préférences de documentation

- `ROADMAP.md` doit rester court et orienté décisions.
- Les détails de versions doivent aller dans `CHANGELOG/`.
- Les règles de construction d’étage doivent rester dans `FLOOR_DESIGN.md`.
- La validation visuelle des layouts doit rester dans `FLOOR_VISUALIZER.md`.
- Les refactorisations et dettes techniques doivent aller dans `TECHNICAL_DEBT.md`.
- Les consignes de collaboration doivent rester dans ce fichier.
- Les retours de test doivent aller dans `playtests/`.

---

## 7. Audits d’état

Les audits d’état doivent être placés dans `audits/`.

Convention de nommage :

```text
STATE_AUDITvX.X.X.md
```

Exemple :

```text
audits/STATE_AUDITv0.8.md
```

Chaque audit doit inclure en en-tête :

- date d’audit ;
- version de référence ;
- branche vérifiée ;
- objectif de l’audit.

Pour déterminer l’état réel du projet, privilégier :

1. l’audit d’état le plus récent ;
2. le changelog ;
3. le repo vérifié ;
4. la roadmap.

La roadmap sert à orienter les prochaines décisions, mais elle peut être en retard sur l’état réel du dépôt.

---

## 8. Préparation documentaire des releases

Lors de la préparation d’une future release, proposer aussi les mises à jour documentaires nécessaires.

À vérifier systématiquement :

- ajouter ou mettre à jour le fichier `CHANGELOG/vX.Y.md` correspondant à la release ;
- mettre à jour `CHANGELOG/README.md` pour référencer la nouvelle version ;
- mettre à jour `ROADMAP.md` si la version stable actuelle, la prochaine direction ou les priorités changent ;
- mettre à jour `TECHNICAL_DEBT.md` si une dette technique est ajoutée, résolue ou reclassée ;
- mettre à jour `FLOOR_DESIGN.md` si les règles de construction d’étage ou la nomenclature changent ;
- mettre à jour `FLOOR_VISUALIZER.md` si les layouts, symboles ou variantes de planification changent ;
- mettre à jour `playtests/` si une session de test apporte des informations utiles ;
- mettre à jour ce fichier si les règles de collaboration changent.

Ne pas pousser les `README_PACK.md` générés localement, sauf décision explicite.

---

## 9. Règles spécifiques à FLOOR_VISUALIZER.md

Lors d’une mise à jour de `FLOOR_VISUALIZER.md` :

- conserver l’affichage des cartes sous forme de tableau / grille ;
- respecter les normes de remplissage déjà en place ;
- afficher les murs en carrés `■` ;
- laisser les sols / couloirs en cellules vides ;
- garder les symboles spéciaux visibles tels quels : `D`, `O`, `B`, `C`, `M`, `L`, `X`, etc. ;
- ne pas remplacer le visualiseur par un bloc texte monospacé ;
- ne pas utiliser de version CSS/couleur expérimentale sauf demande explicite ;
- reconstruire la section `État actuel en jeu` depuis `FloorDatabase.gd` ;
- conserver les variantes dans une section séparée.

`FloorDatabase.gd` reste la source gameplay réelle.  
`FLOOR_VISUALIZER.md` est un outil de lecture et de planification, pas une source gameplay.

---

## 10. Règles de playtest

Les retours de playtest doivent être documentés dans `playtests/`.

Convention de nommage :

```text
PLAYTEST_XX_vX.Y.md
```

Exemples :

```text
playtests/PLAYTEST_01_v0.8.md
playtests/PLAYTEST_02_v0.8.1.md
playtests/PLAYTEST_03_v0.9.md
```

Chaque fichier de playtest doit indiquer en en-tête :

- numéro du playtest ;
- version testée ;
- date ou période ;
- build / renderer ;
- testeur(s) ;
- statut ;
- objectif.

Les retours doivent être séparés au minimum en :

```text
Bugs bloquants
Bugs importants
Confort / polish
Ressenti
Suggestions
Décisions retenues
Décisions reportées ou rejetées
```

---

## 11. Logs, captures et données de test

Les logs complets ne doivent jamais être poussés dans le repo.

Les fichiers `playtests/` doivent utiliser seulement :

- des extraits nettoyés ;
- des résumés réécrits ;
- des formulations anonymisées ;
- les informations strictement utiles au diagnostic.

À éviter dans le repo :

```text
logs bruts complets
chemins Windows complets avec noms d’utilisateur
identifiants machine
captures système complètes
sauvegardes locales de testeurs
archives de logs
```

Les vrais logs restent stockés localement hors repo par le développeur.  
Si une analyse technique nécessite les logs complets, demander un pack `.zip` temporaire.

---

## 12. Builds de playtest et renderer

Les builds de playtest ne doivent pas être poussées dans le repo.

À ne pas pousser :

```text
*.exe
*.pck
*.zip
build/
dist/
export/
```

Pour les builds Windows destinées aux testeurs, utiliser uniquement le renderer :

```text
Compatibility / OpenGL
```

Cette règle vient du playtest `v0.8` :

- un testeur externe a rencontré des crashs natifs Windows avec les builds modernes `Forward+ / D3D12` ;
- une tentative Vulkan n’a pas résolu le problème ;
- le test Vulkan hors OneDrive a également crashé ;
- la build `Compatibility / OpenGL` a fonctionné correctement ;
- l’incident est donc considéré comme résolu par procédure d’export.

Conclusion pratique :

```text
Pour les playtests Windows, exporter en Compatibility / OpenGL par défaut.
Ne pas perdre de temps à distribuer des builds D3D12 / Vulkan aux testeurs modestes sauf test technique volontaire.
```

---

## 13. Règles visuelles du projet

- Style : dungeon crawler rétro inspiré de *Swords and Serpents* NES.
- Les contours blancs autour des portraits, personnages ou monstres ne sont pas voulus.
- Les halos blancs sont des artefacts de détourage à éviter.
- Les assets doivent garder des contours propres, sombres, lisibles et sans halo clair.

---

## 14. Règles de release

- Le user fait une sauvegarde zip locale du projet à chaque release.
- Les releases doivent rester petites et testables.
- Les tags doivent servir de points de retour fiables.
- Après une release, vérifier si la documentation doit être mise à jour.
- Ne pas considérer que `v1.0` arrive automatiquement après `v0.9`.

---

## 15. Points de vigilance spécifiques

- Les anciennes sauvegardes peuvent conserver d’anciens layouts mémorisés.
- Pour tester un changement de layout, utiliser une nouvelle partie ou réinitialiser la sauvegarde de test.
- L’outil de téléportation de développement est temporaire.
- Il doit être désactivé ou supprimé avant une version finale propre.
- En cas de crash testeur non reproductible localement, récupérer les logs Godot avant de modifier le gameplay.
- Si un crash est résolu par configuration d’export ou renderer, documenter la procédure avant de modifier le code.

---

## 16. Dernière base de travail connue

```text
v0.8 — Prise en main souris et clavier AZERTY
```

Contenu majeur :

- commandes d’exploration cliquables ;
- commandes de combat cliquables ;
- bouton menu en exploration ;
- contrôles AZERTY `ZQSD` ;
- `A` équivalent à `Espace` / `Entrée` ;
- `E` équivalent à `Échap` ;
- validation des dégâts au clic ;
- build playtest locale envoyée à un testeur.

Point prioritaire déjà identifié pour `v0.8.1` :

```text
Correction de la mise à l’échelle de fenêtre / scaling global proportionnel.
```
