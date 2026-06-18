# Règles de collaboration avec l’assistant

Ce document regroupe les règles de travail utilisées pour les échanges autour du projet.

Il sert à éviter de surcharger `ROADMAP.md` avec des consignes qui concernent surtout la manière de préparer les modifications.

---

## 1. Langue et style de réponse

- Toujours continuer en français.
- Réponses directes, lisibles et structurées.
- Signaler clairement les incohérences entre GitHub, les releases et la conversation.
- Ne pas accélérer artificiellement vers `v1.0`.
- Préférer des versions pré-1.0 : `v0.7.2`, `v0.8`, `v0.8.1`, `v0.9`, `v0.10`, etc.

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
fichiers de test temporaires
```

---

## 5. Organisation documentaire cible

L’organisation documentaire peut être appliquée progressivement, au moment où les fichiers concernés sont mis à jour.

Structure cible :

```text
README.md
CHANGELOG/
audits/
docs/
  ROADMAP.md
  TECHNICAL_DEBT.md
  ASSISTANT_WORKFLOW.md
  dungeon/
    FLOOR_DESIGN.md
    FLOOR_VISUALIZER.md
```

Règles :

- `README.md` reste à la racine ;
- `CHANGELOG/` reste à la racine ;
- `audits/` contient les audits d’état ;
- `docs/` contient les documents de pilotage, dette technique et collaboration ;
- `docs/dungeon/` contient les documents de conception et visualisation d’étages.

Ne pas déplacer immédiatement tous les fichiers Markdown pour le seul rangement.  
Profiter d’une mise à jour réelle d’un document pour le déplacer au bon emplacement.

---

## 6. Préférences de documentation

- `ROADMAP.md` doit rester court et orienté décisions.
- Les détails de versions doivent aller dans `CHANGELOG/`.
- Les règles de construction d’étage doivent rester dans `FLOOR_DESIGN.md`.
- La validation visuelle des layouts doit rester dans `FLOOR_VISUALIZER.md`.
- Les refactorisations et dettes techniques doivent aller dans `TECHNICAL_DEBT.md`.
- Les consignes de collaboration doivent rester dans ce fichier.

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

## 10. Règles visuelles du projet

- Style : dungeon crawler rétro inspiré de *Swords and Serpents* NES.
- Les contours blancs autour des portraits ou personnages ne sont pas voulus.
- Les halos blancs sont des artefacts de détourage à éviter.
- Les assets doivent garder des contours propres, sombres, lisibles et sans halo clair.

---

## 11. Règles de release

- Le user fait une sauvegarde zip locale du projet à chaque release.
- Les releases doivent rester petites et testables.
- Les tags doivent servir de points de retour fiables.
- Après une release, vérifier si la documentation doit être mise à jour.
- Ne pas considérer que `v1.0` arrive automatiquement après `v0.9`.

---

## 12. Points de vigilance spécifiques

- Les anciennes sauvegardes peuvent conserver d’anciens layouts mémorisés.
- Pour tester un changement de layout, utiliser une nouvelle partie ou réinitialiser la sauvegarde de test.
- L’outil de téléportation de développement est temporaire.
- Il doit être désactivé ou supprimé avant une version finale propre.
- En cas de crash testeur non reproductible localement, récupérer les logs Godot avant de modifier le gameplay.
- Les builds locales `.exe`, `.pck` et `.zip` de playtest ne doivent pas être poussées dans le repo.

---

## 13. Dernière base de travail connue

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
