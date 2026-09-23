/// Configuración de entorno para la API de ORDS.
///
/// La URL base se pasa en build/run time con:
///   flutter run --dart-define=ORDS_BASE_URL=https://fevosweb.com/ords/dev2/sifco_world
class Env {
  static const String ordsBaseUrl = String.fromEnvironment(
    'ORDS_BASE_URL',
    defaultValue: 'https://fevosweb.com/ords/dev2/sifco_world',
  );

  /// Módulo REST donde viven los endpoints de la app Flutter.
  static const String flutterModulePath = 'flutter_app';
}
