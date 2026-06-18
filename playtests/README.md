# Playtests — DungeonCrawFirstMiniGame

Ce dossier contient les synthèses propres des sessions de playtest.

Il ne doit pas contenir de logs bruts, d’archives de logs, de sauvegardes locales, d’exécutables ou de fichiers exportés.

---

## Convention de nommage

```text
PLAYTEST_XX_vX.Y.md
```

Exemples :

```text
PLAYTEST_01_v0.8.md
PLAYTEST_02_v0.8.1.md
PLAYTEST_03_v0.9.md
```

Si une session concerne une build spéciale, garder de préférence un seul fichier principal par vague de test, puis préciser la variante dans l’en-tête ou dans la section de configuration.

---

## En-tête obligatoire

Chaque fichier de playtest doit commencer par :

```md
# PLAYTEST_XX — vX.Y

Numéro du playtest : XX  
Version testée : vX.Y  
Date de début : AAAA-MM-JJ  
Date de fin : en cours / AAAA-MM-JJ  
Build testée : description courte  
Renderer : Compatibility / OpenGL, Forward+, D3D12, Vulkan, etc.  
Testeur(s) : testeur externe 01, développeur, etc.  
Statut : en cours / terminé / archivé  
Objectif : objectif court du test
```

---

## Sections recommandées

```md
## 1. Résumé
## 2. Configuration testeur
## 3. Bugs bloquants
## 4. Bugs importants
## 5. Confort / polish
## 6. Ressenti général
## 7. Suggestions du testeur
## 8. Décisions retenues
## 9. Décisions reportées ou rejetées
## 10. Résolution finale
```

---

## Règles pour les logs

Les logs complets ne doivent jamais être poussés dans le repo.

Utiliser uniquement :

- des extraits nettoyés ;
- des résumés réécrits ;
- des informations anonymisées ;
- les lignes strictement utiles au diagnostic.

Les vrais logs doivent rester stockés localement hors repo.  
Si une analyse technique demande les logs complets, ils doivent être fournis sous forme de pack `.zip` temporaire, puis exclus du repo.

---

## Règles pour les builds de test

Les builds de playtest restent locales.

À ne pas pousser :

```text
*.exe
*.pck
*.zip
build/
dist/
export/
logs bruts
sauvegardes locales
```

Pour les builds Windows destinées aux testeurs, utiliser par défaut :

```text
Compatibility / OpenGL
```
