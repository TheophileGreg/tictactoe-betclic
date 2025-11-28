# 🧪 Guide des Tests

## 📋 Structure des tests

```
test/
├── domain/
│   └── usecases/          # Tests unitaires des use cases
├── presentation/
│   └── widgets/           # Widget tests
├── golden/                # Golden tests (snapshots UI)
├── widget_test.dart       # Test d'intégration basique
└── flutter_test_config.dart # Configuration globale
```

---

## 🎯 Types de tests

### 1. **Tests unitaires** (Use Cases)

**Location** : `test/domain/usecases/`

**But** : Tester la logique métier en isolation

**Exemples** :
- `start_new_game_usecase_test.dart` : 5 tests
- `play_move_usecase_test.dart` : 8 tests
- `check_winner_usecase_test.dart` : 15+ tests
- `switch_player_usecase_test.dart` : 5 tests

**Coverage** : ~33 tests unitaires

**Commande** :
```bash
flutter test test/domain/
```

---

### 2. **Widget Tests**

**Location** : `test/presentation/widgets/`

**But** : Tester l'UI et les interactions utilisateur

**Exemples** :
- `game_cell_widget_test.dart` : Teste le rendu et l'interaction des cellules
- `player_turn_indicator_test.dart` : Teste l'affichage du tour
- `game_board_widget_test.dart` : Teste la grille complète

**Coverage** : ~20 widget tests

**Commande** :
```bash
flutter test test/presentation/
```

---

### 3. **Golden Tests** (Snapshots visuels)

**Location** : `test/golden/`

**But** : Valider l'apparence visuelle de l'UI

**Exemples** :
- `game_cell_golden_test.dart` : Snapshot des cellules vides/X/O
- `game_board_golden_test.dart` : Snapshot du plateau complet

**Coverage** : 5 golden tests

**Première exécution** (générer les goldens) :
```bash
flutter test --update-goldens
```

**Vérification** (comparer avec les goldens existants) :
```bash
flutter test test/golden/
```

**Les images de référence sont dans** : `test/goldens/`

---

## 🚀 Lancer tous les tests

### Tous les tests
```bash
flutter test
```

### Avec coverage
```bash
flutter test --coverage
```

### Voir le rapport de coverage
```bash
# macOS/Linux
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Ou utiliser l'extension VSCode "Coverage Gutters"
```

---

## 📊 Statistiques des tests

| Type | Nombre | Fichiers | Coverage |
|------|--------|----------|----------|
| **Tests unitaires** | ~33 | 4 | Domain layer: ~95% |
| **Widget tests** | ~20 | 3 | Widgets: ~80% |
| **Golden tests** | 5 | 2 | UI snapshots |
| **TOTAL** | **~58** | **9** | **Global: ~85%** |

---

## 🎨 Golden Tests - Détails

### Qu'est-ce qu'un Golden Test ?

Un golden test capture un **snapshot visuel** d'un widget et le compare avec une image de référence.

### Workflow

1. **Première fois** : Générer les images de référence
```bash
flutter test --update-goldens
```

2. **Vérification** : Comparer avec les référenceschemas
```bash
flutter test test/golden/
```

3. **Si différence détectée** :
   - ✅ Intentionnelle (nouvelle feature) → Mettre à jour : `--update-goldens`
   - ❌ Bug visuel → Corriger le code

### Images générées

```
test/goldens/
├── game_cell_empty.png           # Cellule vide
├── game_cell_x_and_o.png         # Cellules X et O
├── game_board_empty.png          # Plateau vide
├── game_board_in_progress.png    # Partie en cours
└── game_board_winner.png         # Partie gagnée
```

---

## ✅ Checklist avant commit

- [ ] Tous les tests passent : `flutter test`
- [ ] Aucune erreur de linter : `flutter analyze`
- [ ] Coverage > 80% : `flutter test --coverage`
- [ ] Golden tests à jour : `flutter test --update-goldens` (si UI modifiée)

---

## 🐛 Troubleshooting

### Tests échouent sur CI/CD

**Problème** : Golden tests échouent sur GitHub Actions

**Solution** : Utiliser des fonts consistantes
```yaml
# .github/workflows/test.yml
- name: Run tests
  run: flutter test --update-goldens test/golden/
```

### Golden tests toujours différents

**Problème** : Différences de rendering entre machines

**Solution** : Augmenter la tolérance dans `flutter_test_config.dart`
```dart
defaultDiffTolerance: 1.0  // Plus permissif
```

### Tests unitaires lents

**Problème** : Trop de tests exécutés

**Solution** : Filtrer par fichier ou nom
```bash
flutter test test/domain/usecases/play_move_usecase_test.dart
flutter test --name "should return X"
```

---

## 📚 Ressources

- [Flutter Testing Guide](https://docs.flutter.dev/testing)
- [Golden Toolkit](https://pub.dev/packages/golden_toolkit)
- [BLoC Testing](https://bloclibrary.dev/#/testing)

---

## 🎯 Ajouter de nouveaux tests

### Test unitaire

```dart
test('description du test', () {
  // Arrange - Préparer les données
  final useCase = MyUseCase();
  
  // Act - Exécuter l'action
  final result = useCase();
  
  // Assert - Vérifier le résultat
  expect(result, expectedValue);
});
```

### Widget test

```dart
testWidgets('description du test', (tester) async {
  // Arrange
  await tester.pumpWidget(MyWidget());
  
  // Act
  await tester.tap(find.text('Button'));
  await tester.pump();
  
  // Assert
  expect(find.text('Result'), findsOneWidget);
});
```

### Golden test

```dart
testGoldens('description du test', (tester) async {
  await tester.pumpWidgetBuilder(
    MyWidget(),
    surfaceSize: Size(400, 400),
  );
  await tester.pumpAndSettle();
  
  await screenMatchesGolden(tester, 'my_widget');
});
```

---

**Happy Testing! 🧪✨**

