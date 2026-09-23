import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sifpos_flutter/core/network/ords_page.dart';
import 'package:sifpos_flutter/features/productos/data/models/producto.dart';
import 'package:sifpos_flutter/features/productos/data/repositories/producto_repository.dart';
import 'package:sifpos_flutter/features/productos/presentation/providers/producto_providers.dart';
import 'package:sifpos_flutter/main.dart';

class _FakeProductoRepository implements ProductoRepository {
  @override
  Future<OrdsPage<Producto>> listar({int limit = 25, int offset = 0}) async {
    return OrdsPage<Producto>(
      items: [Producto(descripcion: 'Producto de prueba', referencia: 'REF-1')],
      hasMore: false,
      limit: limit,
      offset: offset,
      count: 1,
    );
  }
}

void main() {
  testWidgets('La app arranca y muestra la pantalla de Productos',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productoRepositoryProvider.overrideWithValue(_FakeProductoRepository()),
        ],
        child: const SifposApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Productos'), findsOneWidget);
    expect(find.text('Producto de prueba'), findsOneWidget);
  });
}
