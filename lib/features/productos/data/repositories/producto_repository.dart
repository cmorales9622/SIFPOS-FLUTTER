import '../../../../core/network/api_client.dart';
import '../../../../core/network/ords_page.dart';
import '../models/producto.dart';

/// Encapsula el acceso al recurso `Productos` expuesto por ORDS
/// (`{ORDS_BASE_URL}/flutter_app/Productos`).
class ProductoRepository {
  ProductoRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<OrdsPage<Producto>> listar({int limit = 25, int offset = 0}) async {
    final response = await _apiClient.dio.get(
      'Productos',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    return OrdsPage.fromJson(
      response.data as Map<String, dynamic>,
      Producto.fromJson,
    );
  }

  /// Inserta un producto nuevo.
  ///
  /// Requiere que en ORDS exista un handler POST para `flutter_app/Productos`
  /// (la prueba inicial solo confirmó el handler GET). Si el POST no está
  /// definido todavía, esta llamada falla con 404/405.
  Future<Producto> crear(Producto producto) async {
    final response = await _apiClient.dio.post(
      'Productos',
      data: producto.toJson(),
    );
    return Producto.fromJson(response.data as Map<String, dynamic>);
  }

  /// Actualiza un producto existente, identificado por su referencia.
  ///
  /// Requiere un handler PUT en `flutter_app/Productos/{referencia}` en ORDS.
  Future<Producto> actualizar(String referencia, Producto producto) async {
    final response = await _apiClient.dio.put(
      'Productos/$referencia',
      data: producto.toJson(),
    );
    return Producto.fromJson(response.data as Map<String, dynamic>);
  }
}
