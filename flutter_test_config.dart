import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';

/// Global configuration for Flutter tests.
///
/// This file is automatically loaded before all tests.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      fileNameFactory: (String name) => name,
    ),
  );
}
