# Spécifications Images Open Graph

Ce document détaille les spécifications pour créer les images de partage social (Open Graph).

## 📐 Dimensions Requises

### Open Graph Image (Facebook, LinkedIn)
- **Nom du fichier:** `og-image.jpg`
- **Dimensions:** 1200 x 630 pixels
- **Format:** JPG ou PNG
- **Taille max:** < 1 MB
- **Ratio:** 1.91:1

### Twitter Card Image
- **Nom du fichier:** `twitter-image.jpg`
- **Dimensions:** 1200 x 600 pixels (ou utiliser la même que OG)
- **Format:** JPG ou PNG
- **Taille max:** < 1 MB
- **Ratio:** 2:1

## 🎨 Contenu Suggéré

### Éléments à Inclure

1. **Logo AccessDevOps**
   - Visible et lisible
   - Positionnement : Haut gauche ou centré

2. **Titre Principal**
   ```
   DevOps & Infrastructure
   Success as a Service
   ```

3. **Sous-titre / Slogan**
   ```
   Spend less. Stay secure.
   Get real human experts to manage your infrastructure.
   ```

4. **Métriques Clés (Optionnel)**
   ```
   167+ Customers | 1,084+ Servers | 24/7 Support
   ```

5. **Call-to-Action**
   ```
   accessdevops.com
   ```

### Palette de Couleurs
- **Bleu principal:** `#3B82F6` (blue-600)
- **Cyan accent:** `#06B6D4` (cyan-600)
- **Fond:** Blanc `#FFFFFF` ou gradient bleu
- **Texte:** Gris foncé `#1E293B` (slate-900)

## 🛠️ Outils pour Créer les Images

### Option 1: Canva (Recommandé)
1. Aller sur https://www.canva.com/
2. Créer un design "Custom size" 1200x630px
3. Utiliser un template "Social Media" ou partir de zéro
4. Télécharger en JPG (qualité haute)

### Option 2: Figma
1. Créer un Frame 1200x630px
2. Designer l'image
3. Exporter en JPG (2x quality)

### Option 3: Adobe Photoshop / Illustrator
1. Nouveau document 1200x630px
2. Résolution: 72 DPI
3. Mode couleur: RGB
4. Exporter pour Web (JPG, qualité 80-90)

### Option 4: En Ligne (Gratuit)
- https://www.remove.bg/ - Retirer le fond du logo
- https://www.photopea.com/ - Éditeur Photoshop-like gratuit
- https://placid.app/ - Templates OG automatiques

## ✅ Checklist Qualité

Avant de valider l'image :
- [ ] Dimensions exactes (1200x630px pour OG)
- [ ] Texte lisible même en miniature
- [ ] Logo visible et clair
- [ ] Pas de texte trop près des bords (safe zone: 40px)
- [ ] Contraste suffisant entre texte et fond
- [ ] Taille fichier < 1 MB
- [ ] Format JPG ou PNG
- [ ] Teste le rendu sur mobile

## 📍 Placement des Fichiers

Une fois créées, placer les images dans :
```
public/
├── og-image.jpg         (1200x630px)
└── twitter-image.jpg    (1200x600px ou même que OG)
```

Les URLs seront automatiquement :
```
https://votredomaine.com/og-image.jpg
https://votredomaine.com/twitter-image.jpg
```

## 🧪 Tester les Images

### Facebook Debugger
1. Aller sur https://developers.facebook.com/tools/debug/
2. Entrer votre URL
3. Cliquer "Scrape Again" si déjà crawlé
4. Vérifier le preview de l'image

### Twitter Card Validator
1. Aller sur https://cards-dev.twitter.com/validator
2. Entrer votre URL
3. Vérifier le preview

### LinkedIn Post Inspector
1. Aller sur https://www.linkedin.com/post-inspector/
2. Entrer votre URL
3. Vérifier le preview

## 💡 Bonnes Pratiques

### DO ✅
- Utiliser des couleurs contrastées
- Garder le design simple et épuré
- Inclure le logo de manière visible
- Utiliser une police lisible (minimum 24px)
- Respecter la safe zone (40px des bords)
- Optimiser la taille du fichier
- Tester sur mobile et desktop

### DON'T ❌
- Ne pas mettre trop de texte
- Éviter les polices trop fines
- Ne pas utiliser d'images pixelisées
- Éviter les dégradés complexes
- Ne pas dépasser 1 MB
- Éviter le texte sur fond peu contrasté

## 📋 Template de Contenu

```
┌─────────────────────────────────────────────────┐
│                                                 │
│   [LOGO]         AccessDevOps                   │
│                                                 │
│                                                 │
│       DevOps & Infrastructure                   │
│       Success as a Service                      │
│                                                 │
│   Spend less. Stay secure.                      │
│   Get real human experts.                       │
│                                                 │
│   167+ Customers • 1,084+ Servers • 24/7        │
│                                                 │
│                                                 │
│                  accessdevops.com               │
│                                                 │
└─────────────────────────────────────────────────┘
```

## 🎯 Exemple d'Image OG Réussie

Une bonne image OG pour AccessDevOps devrait :

1. **Être immédiatement compréhensible**
   - Le visiteur doit savoir de quoi il s'agit en 2 secondes

2. **Refléter la marque**
   - Couleurs cohérentes avec le site
   - Logo bien visible

3. **Être attractive**
   - Design professionnel
   - Incite au clic

4. **Être lisible en miniature**
   - Texte assez grand
   - Pas trop d'éléments

---

**Une fois les images créées et placées dans `public/`, elles seront automatiquement utilisées lors des partages sur les réseaux sociaux!** 🎉
