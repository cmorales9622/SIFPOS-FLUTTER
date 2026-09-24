import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/producto.dart';
import '../providers/producto_providers.dart';
import 'producto_form_spec.dart';

/// Formulario de creación/edición de Producto, replicando la organización
/// por secciones y el orden de campos de la página APEX 502
/// ("Productos - Crear", app 123). Ver [productoFormSections].
///
/// Los campos "lookup" (antes NATIVE_POPUP_LOV en APEX) se muestran como
/// texto libre porque todavía no exponemos las tablas de referencia
/// (marcas, proveedores, categorías, etc.) como endpoints ORDS.
class ProductoFormScreen extends ConsumerStatefulWidget {
  const ProductoFormScreen({super.key, this.initial});

  /// null = creación de un producto nuevo; no-null = edición.
  final Producto? initial;

  @override
  ConsumerState<ProductoFormScreen> createState() => _ProductoFormScreenState();
}

class _ProductoFormScreenState extends ConsumerState<ProductoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, dynamic> _values;
  final Map<String, TextEditingController> _controllers = {};
  bool _saving = false;

  bool get _isEditing => widget.initial != null;

  @override
  void initState() {
    super.initState();
    _values = Map<String, dynamic>.from(widget.initial?.toJson() ?? {});
    for (final section in productoFormSections) {
      for (final field in section.fields) {
        if (field.type == ProductoFieldType.checkbox) continue;
        _controllers[field.key] =
            TextEditingController(text: _values[field.key]?.toString() ?? '');
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  bool _checkboxValue(ProductoFieldSpec field) {
    return _values[field.key]?.toString() == field.trueValue;
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    for (final section in productoFormSections) {
      for (final field in section.fields) {
        if (field.type == ProductoFieldType.number) {
          final text = _controllers[field.key]!.text.trim();
          _values[field.key] = text.isEmpty ? null : num.tryParse(text);
        } else if (field.type != ProductoFieldType.checkbox &&
            field.type != ProductoFieldType.readOnly) {
          final text = _controllers[field.key]!.text.trim();
          _values[field.key] = text.isEmpty ? null : text;
        }
      }
    }

    final producto = Producto.fromJson(_values);
    setState(() => _saving = true);
    try {
      final repo = ref.read(productoRepositoryProvider);
      if (_isEditing) {
        await repo.actualizar(widget.initial!.referencia!, producto);
      } else {
        await repo.crear(producto);
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo guardar: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar producto' : 'Nuevo producto'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final section in productoFormSections) _buildSection(section),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _guardar,
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Guardar'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(ProductoFormSection section) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(section.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            for (final field in section.fields) _buildField(field),
          ],
        ),
      ),
    );
  }

  Widget _buildField(ProductoFieldSpec field) {
    switch (field.type) {
      case ProductoFieldType.checkbox:
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(field.label),
          value: _checkboxValue(field),
          onChanged: (checked) {
            setState(() {
              _values[field.key] =
                  (checked ?? false) ? field.trueValue : field.falseValue;
            });
          },
        );
      case ProductoFieldType.readOnly:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text('${field.label}: ${_values[field.key] ?? '—'}'),
        );
      case ProductoFieldType.number:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: TextFormField(
            controller: _controllers[field.key],
            decoration: InputDecoration(labelText: field.label),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        );
      case ProductoFieldType.text:
      case ProductoFieldType.lookup:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: TextFormField(
            controller: _controllers[field.key],
            decoration: InputDecoration(
              labelText: field.label,
              suffixIcon: field.type == ProductoFieldType.lookup
                  ? const Icon(Icons.search)
                  : null,
            ),
            validator: field.key == 'descripcion'
                ? (value) => (value == null || value.trim().isEmpty)
                    ? 'La descripción es obligatoria'
                    : null
                : null,
          ),
        );
    }
  }
}
