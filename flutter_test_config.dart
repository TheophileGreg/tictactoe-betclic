import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';

/// Configuration globale pour les tests Flutter.
///
/// Ce fichier est automatiquement chargé avant tous les tests.
/// Il permet de configurer les golden tests avec des polices personnalisées
/// et d'autres paramètres globaux.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      // Charger les polices pour les golden tests
      await loadAppFonts();
      
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      // Ignorer les différences de pixelation mineures
      defaultDiffTolerance: 0.5,
      
      // Définir le répertoire des goldens
      fileNameFactory: (String name) => 'goldens/$name.png',
    ),
  );
}

