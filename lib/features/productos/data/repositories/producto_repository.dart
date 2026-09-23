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
}
