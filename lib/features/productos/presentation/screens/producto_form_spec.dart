/// Especificación del formulario "Productos - Crear/Editar", tomada 1:1 de
/// la página APEX 502 de la app 123 (Módulo de Referencias 3.0): mismas
/// secciones (regiones), mismo orden de campos (p_item_sequence) y mismas
/// etiquetas (p_prompt). Las claves usan el nombre snake_case que ya expone
/// el JSON de ORDS (mismo que [Producto.toJson]/[Producto.fromJson]).
enum ProductoFieldType { text, number, checkbox, lookup, readOnly }

class ProductoFieldSpec {
  const ProductoFieldSpec({
    required this.key,
    required this.label,
    required this.type,
    this.trueValue,
    this.falseValue,
  });

  final String key;
  final String label;
  final ProductoFieldType type;

  /// Para [ProductoFieldType.checkbox]: valores que persiste la BD original
  /// (ej. S/N o A/I) en vez de un booleano real.
  final String? trueValue;
  final String? falseValue;
}

class ProductoFormSection {
  const ProductoFormSection(this.title, this.fields);

  final String title;
  final List<ProductoFieldSpec> fields;
}

const productoFormSections = <ProductoFormSection>[
  ProductoFormSection('Generales del artículo', [
    ProductoFieldSpec(key: 'producto', label: 'Tipo de referencia', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'referencia', label: 'Código de referencia', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'ref_alterna', label: 'Código de producto', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'ref_familia', label: 'Referencia familia', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'ref_prov', label: 'Ref. proveedor', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'codigo_de_barra', label: 'Código de barras', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'descripcion', label: 'Descripción', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'descripcion_ingles', label: 'Descripción en inglés', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'descripcion_alterna', label: 'Descripción alterna', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'precio', label: 'Precio', type: ProductoFieldType.number),
    ProductoFieldSpec(key: 'cod_itbms', label: 'Cod. ITBMS', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'departamento', label: 'Departamento', type: ProductoFieldType.lookup),
    ProductoFieldSpec(
      key: 'avtivacion',
      label: 'Activado / Desactivado',
      type: ProductoFieldType.checkbox,
      trueValue: 'A',
      falseValue: 'I',
    ),
    ProductoFieldSpec(
      key: 'no_mostrar',
      label: 'No mostrar',
      type: ProductoFieldType.checkbox,
      trueValue: 'S',
      falseValue: 'N',
    ),
  ]),
  ProductoFormSection('Categorías', [
    ProductoFieldSpec(key: 'co_sub_clase1', label: 'Categoría', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'co_subclase_5', label: 'Sub-categoría', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'co_sub_clase2', label: 'Género', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'co_sub_clase3', label: 'Tipo', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'arancel', label: 'Arancel', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'co_textura', label: 'Capellado', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'tipo_textura', label: 'Tipo de composición', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'prepack', label: 'Forro', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'indice_prov', label: 'Suela', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'colores_variedad', label: 'Color variedad', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'colores_cantidad', label: 'Color cantidad', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'rango_tallas', label: 'Tallas', type: ProductoFieldType.lookup),
  ]),
  ProductoFormSection('Empaque / unidades', [
    ProductoFieldSpec(key: 'unidad_medida', label: 'U.M. venta', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'uni_compra', label: 'U.M. compra', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'equiv_venta', label: 'Empaque venta', type: ProductoFieldType.text),
    ProductoFieldSpec(key: 'equiv_compra', label: 'Empaque compra', type: ProductoFieldType.text),
  ]),
  ProductoFormSection('Configuración de venta', [
    ProductoFieldSpec(
      key: 'clave',
      label: 'Siempre en inglés?',
      type: ProductoFieldType.checkbox,
      trueValue: 'S',
      falseValue: 'N',
    ),
    ProductoFieldSpec(
      key: 'itbm',
      label: 'ITBM',
      type: ProductoFieldType.checkbox,
      trueValue: 'S',
      falseValue: 'N',
    ),
    ProductoFieldSpec(key: 'plv', label: 'Forma de venta', type: ProductoFieldType.lookup),
  ]),
  ProductoFormSection('Proveedor / origen', [
    ProductoFieldSpec(key: 'codigo_comprador', label: 'Comprador', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'marca', label: 'Marca', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'pais_de_fabricacion', label: 'País', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'co_proveedor', label: 'Proveedor', type: ProductoFieldType.lookup),
  ]),
  ProductoFormSection('Cubicaje (bulto)', [
    ProductoFieldSpec(key: 'bulto_x', label: 'Bulto X', type: ProductoFieldType.number),
    ProductoFieldSpec(key: 'bulto_y', label: 'Bulto Y', type: ProductoFieldType.number),
    ProductoFieldSpec(key: 'bulto_z', label: 'Bulto Z', type: ProductoFieldType.number),
    ProductoFieldSpec(key: 'factor', label: 'U/M', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'cubicaje', label: 'Cubicaje', type: ProductoFieldType.readOnly),
  ]),
  ProductoFormSection('Cubicaje (pieza)', [
    ProductoFieldSpec(key: 'pieza_x', label: 'Pieza X', type: ProductoFieldType.number),
    ProductoFieldSpec(key: 'pieza_y', label: 'Pieza Y', type: ProductoFieldType.number),
    ProductoFieldSpec(key: 'pieza_z', label: 'Pieza Z', type: ProductoFieldType.number),
    ProductoFieldSpec(key: 'pieza_factor', label: 'U/M', type: ProductoFieldType.lookup),
    ProductoFieldSpec(key: 'pieza_cubicaje', label: 'Cubicaje', type: ProductoFieldType.readOnly),
  ]),
];
