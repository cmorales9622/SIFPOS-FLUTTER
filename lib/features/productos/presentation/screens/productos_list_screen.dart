import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/models/producto.dart';
import '../providers/producto_providers.dart';
import 'producto_form_screen.dart';

class ProductosListScreen extends ConsumerStatefulWidget {
  const ProductosListScreen({super.key});

  @override
  ConsumerState<ProductosListScreen> createState() =>
      _ProductosListScreenState();
}

class _ProductosListScreenState extends ConsumerState<ProductosListScreen> {
  int _offset = 0;
  static const _limit = 25;

  @override
  Widget build(BuildContext context) {
    final pageAsync = ref.watch(productosPageProvider(_offset));
    final currency = NumberFormat.currency(locale: 'es_PA', symbol: r'$');

    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(context, null),
        child: const Icon(Icons.add),
      ),
      body: pageAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'No se pudo cargar la lista de productos.\n$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (page) => Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: page.items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final producto = page.items[index];
                  return ListTile(
                    onTap: () => _abrirFormulario(context, producto),
                    title: Text(producto.descripcion ?? producto.referencia ?? '—'),
                    subtitle: Text(
                      [
                        if (producto.referencia != null) 'Ref: ${producto.referencia}',
                        if (producto.codigoDeBarra != null)
                          'Barra: ${producto.codigoDeBarra}',
                      ].join('   '),
                    ),
                    trailing: producto.precio != null
                        ? Text(currency.format(producto.precio))
                        : null,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _offset > 0
                        ? () => setState(() => _offset = (_offset - _limit).clamp(0, 1 << 30))
                        : null,
                    child: const Text('Anterior'),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: page.hasMore
                        ? () => setState(() => _offset += _limit)
                        : null,
                    child: const Text('Siguiente'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _abrirFormulario(BuildContext context, Producto? producto) async {
    final guardado = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => ProductoFormScreen(initial: producto),
      ),
    );
    if (guardado == true) {
      ref.invalidate(productosPageProvider(_offset));
    }
  }
}
