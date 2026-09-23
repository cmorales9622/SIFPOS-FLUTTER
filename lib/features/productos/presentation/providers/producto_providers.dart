import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/ords_page.dart';
import '../../data/models/producto.dart';
import '../../data/repositories/producto_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final productoRepositoryProvider = Provider<ProductoRepository>(
  (ref) => ProductoRepository(ref.watch(apiClientProvider)),
);

/// Página de productos actualmente cargada (paginación simple offset/limit).
final productosPageProvider =
    FutureProvider.autoDispose.family<OrdsPage<Producto>, int>(
  (ref, offset) => ref.watch(productoRepositoryProvider).listar(offset: offset),
);
