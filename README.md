# 🎮 Tic Tac Toe - Flutter Web App

Application de jeu Tic Tac Toe développée avec Flutter, suivant les principes de Clean Architecture.

## 🌐 Application en ligne

**URL de production** : https://tictactoe-betclic-784fe.web.app

---

## 🚀 Déploiement automatique

Cette application est déployée automatiquement sur Firebase Hosting à chaque push sur la branche `main`.

### Workflow :
```
git push → GitHub Actions → Tests → Build → Deploy Firebase ✅
```

Pour plus de détails, voir [FIREBASE_SETUP.md](FIREBASE_SETUP.md)

---

## 📐 Architecture

**Clean Architecture** avec séparation stricte des couches :

```
lib/
├── domain/          # Logique métier (Pure Dart)
├── application/     # State Management (BLoC)
└── presentation/    # UI (Widgets)
```

### Stack technique :
- **Framework** : Flutter 3.24+
- **State Management** : flutter_bloc
- **Architecture** : Clean Architecture
- **Tests** : Unit tests, Widget tests, Golden tests
- **CI/CD** : GitHub Actions
- **Hosting** : Firebase Hosting

---

## 🎯 Fonctionnalités

✅ **Gameplay complet**
- Plateau 3×3 interactif
- Alternance automatique des joueurs
- Détection de victoire (8 lignes possibles)
- Détection de match nul
- Animations fluides

✅ **UI/UX moderne**
- Design Material 3
- Thème personnalisé
- Responsive
- Animations d'entrée des symboles

✅ **Code de qualité**
- Tests unitaires (~33 tests)
- Widget tests (~20 tests)
- Golden tests (5 snapshots)
- Documentation DartDoc complète
- Coverage > 85%

---

## 🛠️ Développement local

### Prérequis
- Flutter SDK 3.24+
- Dart 3.0+

### Installation

```bash
# Cloner le projet
git clone https://github.com/TON_USERNAME/tictactoe-betclic.git
cd clean_tic_tac_toe

# Installer les dépendances
flutter pub get

# Lancer l'app
flutter run -d chrome
```

### Tests

```bash
# Lancer tous les tests
flutter test

# Tests unitaires uniquement
flutter test test/domain/

# Widget tests
flutter test test/presentation/

# Golden tests
flutter test test/golden/

# Avec coverage
flutter test --coverage
```

---

## 📦 Build

```bash
# Build web optimisé
flutter build web --release --web-renderer auto

# Les fichiers sont dans : build/web/
```

---

## 🚀 Déploiement

Le déploiement est **100% automatique** via GitHub Actions.

### Pour déployer une mise à jour :

```bash
# 1. Faire tes modifications
# 2. Commit & Push
git add .
git commit -m "Nouvelle fonctionnalité"
git push

# 3. Attendre ~2-3 minutes
# 4. ✅ App mise à jour sur https://tictactoe-betclic-784fe.web.app
```

### Workflow GitHub Actions

Fichiers de configuration :
- `.github/workflows/firebase-hosting-merge.yml` - Déploiement production
- `.github/workflows/firebase-hosting-pull-request.yml` - Preview des PRs

---

## 📊 Structure du projet

```
clean_tic_tac_toe/
├── lib/
│   ├── domain/              # Logique métier
│   │   ├── entities/        # 5 entités (Player, Cell, etc.)
│   │   └── usecases/        # 4 use cases
│   ├── application/         # BLoC
│   │   └── game/            # GameBloc + Events + States
│   ├── presentation/        # UI
│   │   ├── screens/         # HomeScreen, GameScreen
│   │   └── widgets/         # Composants réutilisables
│   └── core/
│       └── theme/           # Thème de l'app
├── test/
│   ├── domain/              # Tests unitaires
│   ├── presentation/        # Widget tests
│   └── golden/              # Golden tests
├── .github/workflows/       # CI/CD
└── firebase.json            # Config Firebase
```

---

## 🎨 Design System

### Couleurs
- **Player X** : Indigo (#6366F1)
- **Player O** : Pink (#EC4899)
- **Background** : Slate 50 (#F8FAFC)

### Animations
- Durée : 300ms
- Curve : easeInOut
- Effets : Scale + Fade

---

## 📚 Documentation

- [FIREBASE_SETUP.md](FIREBASE_SETUP.md) - Configuration Firebase détaillée
- [TEST_README.md](test/TEST_README.md) - Guide des tests
- [IMPLEMENTATION.md](IMPLEMENTATION.md) - Détails d'implémentation

### DartDoc

Générer la documentation :
```bash
dart doc .
open doc/api/index.html
```

---

## 🔒 Sécurité

- ✅ HTTPS forcé (Firebase)
- ✅ Security headers configurés
- ✅ Content Security Policy
- ✅ Pas de données sensibles dans le code

---

## 📈 Statistiques

| Métrique | Valeur |
|----------|--------|
| **Tests** | ~58 tests |
| **Coverage** | ~85% |
| **Lignes de code** | ~1700 |
| **Documentation** | ~550 lignes DartDoc |
| **Build time** | ~30 secondes |

---

## 🤝 Contribution

### Workflow de développement

1. **Créer une branche**
```bash
git checkout -b feature/ma-nouvelle-feature
```

2. **Développer + Tests**
```bash
flutter test
```

3. **Commit**
```bash
git add .
git commit -m "feat: ajout de la fonctionnalité X"
```

4. **Push + Pull Request**
```bash
git push origin feature/ma-nouvelle-feature
```

5. **GitHub Actions** va :
   - Lancer les tests
   - Créer un preview URL
   - Commenter la PR

6. **Merge** → Déploiement automatique en production !

---

## 🐛 Problèmes connus

Aucun pour le moment ! 🎉

---

## 📄 Licence

Projet de test technique - Tous droits réservés

---

## 👨‍💻 Auteur

Test technique Flutter - Clean Tic Tac Toe

**Technologies** : Flutter • Dart • Firebase • GitHub Actions  
**Architecture** : Clean Architecture • BLoC Pattern  
**Qualité** : Tests unitaires • Widget tests • Golden tests  

---

## 🎯 Améliorations futures possibles

- [ ] Mode sombre
- [ ] IA pour jouer contre l'ordinateur
- [ ] Historique des parties
- [ ] Statistiques de victoires/défaites
- [ ] Multijoueur en ligne
- [ ] Sons et vibrations
- [ ] Support tablette

---

**🌐 App en ligne** : https://tictactoe-betclic-784fe.web.app

**🔥 Déploiement** : Automatique via GitHub Actions
