import 'package:dio/dio.dart';

import '../config/env.dart';

/// Cliente HTTP centralizado para consumir los servicios REST de ORDS.
class ApiClient {
  ApiClient() : dio = Dio(BaseOptions(
          baseUrl: '${Env.ordsBaseUrl}/${Env.flutterModulePath}/',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Accept': 'application/json'},
        ));

  final Dio dio;

  /// Adjunta el token OAuth2 a cada request una vez que el endpoint
  /// esté protegido en ORDS. Ver README del proyecto para el flujo de login.
  void setBearerToken(String? token) {
    if (token == null) {
      dio.options.headers.remove('Authorization');
    } else {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
