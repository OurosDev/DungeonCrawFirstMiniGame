# PLAYTEST_01 — v0.8

Numéro du playtest : 01  
Version testée : v0.8  
Date de début : 2026-06-18  
Date de fin : en cours  
Build testée : export Windows local de playtest  
Renderer : Forward+ / D3D12 au départ, test Vulkan non concluant, Compatibility / OpenGL validé  
Testeur(s) : testeur externe 01  
Statut : en cours  
Objectif : première validation externe de la boucle jouable, des contrôles souris/AZERTY et de la stabilité générale.

---

## 1. Résumé

Première session de playtest externe sur la version `v0.8`.

La session a d’abord révélé des crashs natifs Windows sur la machine du testeur, notamment devant un coffre et lors du chargement d’une sauvegarde. Ces crashs n’ont pas été reproduits sur la machine de développement.

Après investigation, l’incident est considéré comme réglé par procédure : les builds Windows de playtest doivent utiliser le renderer `Compatibility / OpenGL`.

La version `Compatibility / OpenGL` fonctionne chez le testeur. Le playtest peut donc continuer pour récolter du ressenti, des suggestions et d’éventuels bugs non bloquants.

---

## 2. Configuration testeur

Informations connues ou utiles :

```text
OS : Windows
GPU : Intel UHD Graphics
Build initiale : Windows export local v0.8
Renderer initial : Forward+ / D3D12
Test Vulkan : effectué, non concluant
Build validée : Compatibility / OpenGL
Installation : test final effectué hors OneDrive
```

Note : un test Vulkan hors OneDrive a également crashé. L’emplacement OneDrive n’est donc pas considéré comme la cause principale. Le facteur décisif retenu est le renderer.

---

## 3. Bugs bloquants

### P0.1 — Crash natif Windows devant le coffre étage 1 `Vector2i(5, 1)`

Statut : réglé par procédure d’export  
Reproductible chez développeur : non  
Reproductible chez testeur : oui avec build moderne, non avec Compatibility / OpenGL  
Version concernée : `v0.8` export Windows initial

Symptômes :

- crash natif Windows devant / lors de l’interaction avec le coffre de l’étage 1 `Vector2i(5, 1)` ;
- le coffre concerné devait donner de l’or ;
- le problème n’a pas été reproduit sur la machine de développement.

Résumé technique nettoyé :

```text
Crash natif Windows de type access violation.
Le crash arrive avec le renderer moderne utilisé par la build initiale.
La build Compatibility / OpenGL corrige le problème chez le testeur.
```

Décision :

```text
Ne pas modifier le gameplay du coffre pour ce point.
Utiliser Compatibility / OpenGL pour les builds Windows de playtest.
```

---

### P0.2 — Crash natif Windows lors du chargement de sauvegarde

Statut : réglé par procédure d’export  
Reproductible chez développeur : non  
Reproductible chez testeur : oui avec build moderne, non avec Compatibility / OpenGL  
Version concernée : `v0.8` export Windows initial

Symptômes :

- crash lors du chargement d’une sauvegarde ;
- suppression / recréation de sauvegarde insuffisante pour régler le problème avec la build moderne ;
- chargement fonctionnel avec la build Compatibility / OpenGL.

Résumé technique nettoyé :

```text
Le problème semble lié à la reconstruction / restauration graphique du donjon sous renderer moderne sur cette configuration.
La version Compatibility / OpenGL fonctionne.
```

Décision :

```text
Ne pas modifier immédiatement SaveManager ou DungeonSaveController pour cet incident.
Classer le problème comme contrainte de renderer / export playtest.
```

---

## 4. Bugs importants

À compléter après la journée complète de test.

---

## 5. Confort / polish

Point déjà connu côté développeur avant compilation finale des retours :

```text
Le redimensionnement de fenêtre peut casser les proportions visuelles.
Objectif v0.8.1 : scaling global proportionnel / effet zoom du jeu complet.
```

À compléter avec les retours du testeur.

---

## 6. Ressenti général

À compléter après la journée complète de test.

Questions utiles :

- Les contrôles souris sont-ils clairs ?
- Les contrôles AZERTY sont-ils naturels ?
- La boucle exploration / combat / loot / équipement est-elle comprise ?
- La difficulté semble-t-elle intéressante ou injuste ?
- Les messages et indices sont-ils lisibles ?
- Le boss et la clé sont-ils compréhensibles ?

---

## 7. Suggestions du testeur

À compléter après la journée complète de test.

Format recommandé :

```text
Suggestion :
Contexte :
Décision : retenue / reportée / rejetée
Raison :
```

---

## 8. Décisions retenues

Décisions déjà retenues :

```text
- Les builds Windows de playtest doivent utiliser Compatibility / OpenGL.
- Les builds .exe / .pck / .zip restent locales et ne sont pas poussées dans le repo.
- Les logs complets restent hors repo.
- Les fichiers de playtest peuvent utiliser des résumés nettoyés / réécrits des logs.
```

---

## 9. Décisions reportées ou rejetées

Décisions actuelles :

```text
- Ne pas modifier le gameplay des coffres pour le crash P0.1.
- Ne pas modifier immédiatement la sauvegarde pour le crash P0.2.
- Ne pas considérer OneDrive comme cause principale après le crash Vulkan hors OneDrive.
- Ne pas distribuer D3D12 / Vulkan aux testeurs modestes sauf test technique volontaire.
```

---

## 10. Résolution finale

État actuel : incident renderer considéré comme réglé.

```text
Correctif appliqué : changement de renderer pour les builds de playtest Windows
Renderer validé : Compatibility / OpenGL
Version concernée : v0.8 playtest local
Version de documentation prévue : v0.8.1 si une release de stabilisation est créée
Résultat après nouveau test : build Compatibility / OpenGL fonctionnelle chez le testeur
```

À compléter après compilation finale des retours :

```text
Fichiers modifiés :
Lien changelog :
Lien release :
Retours restants :
```
