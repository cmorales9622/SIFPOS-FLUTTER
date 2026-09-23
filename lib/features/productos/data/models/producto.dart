import 'package:json_annotation/json_annotation.dart';

part 'producto.g.dart';

/// Representa una fila del endpoint ORDS `flutter_app/Productos`, que expone
/// la tabla de referencias/artículos del esquema SIFCOWEB (migrado de APEX
/// app 101 / 123, páginas "Productos" y "Mantenimiento de Referencias").
///
/// Todos los campos son nullable porque en el sistema origen la enorme
/// mayoría de columnas se dejan en null salvo que el tipo de producto las
/// use (ej. neumáticos, tallas, prendas).
@JsonSerializable(fieldRename: FieldRename.snake)
class Producto {
  Producto({
    this.noCia,
    this.correlativo,
    this.producto,
    this.referencia,
    this.estatusDetalle,
    this.medidasBulto,
    this.nuJuego,
    this.pesoBulto,
    this.precioEspecial,
    this.precioMinimoVenta,
    this.precioMayorista,
    this.tallas,
    this.stockMinimo,
    this.stockMaximo,
    this.siguienteSeqHis,
    this.refProv,
    this.refAlterna,
    this.pBCaja,
    this.proporcionPorTalla,
    this.codigoClase,
    this.tipoProduc,
    this.clave,
    this.claseBulto,
    this.categoria,
    this.cantTransito,
    this.cantFisica,
    this.cantComprometida,
    this.cantidadPorBulto,
    this.descripcionAlterna,
    this.descripcion,
    this.cubicaje,
    this.coSublinea,
    this.costoProm,
    this.costoFob,
    this.costoCif,
    this.colores,
    this.bultosCantidad,
    this.arancel,
    this.variantes,
    this.valorFis,
    this.uniCompra,
    this.unidadMedida,
    this.tLlegada,
    this.preProm,
    this.porcIncre,
    this.paisDeFabricacion,
    this.numeroLetra,
    this.marca,
    this.subMarca,
    this.malEstado,
    this.codigoDeBarra,
    this.coProveedor,
    this.fisicoInicial,
    this.indiceProv,
    this.indiceMarca,
    this.grupos,
    this.agrupar,
    this.fechaCreacion,
    this.tamano,
    this.prepack,
    this.grupoPlv,
    this.fisicoAnterior,
    this.inicialAnterior,
    this.noMostrar,
    this.plv,
    this.avtivacion,
    this.costoDuty,
    this.equivVenta,
    this.equivCompra,
    this.costoRoyalty,
    this.costoSourcingfee,
    this.costoInicial,
    this.codigoTemporada,
    this.cantComprometidaFuturo,
    this.codColor,
    this.coTextura,
    this.fechaUltCompra,
    this.fechaUltVenta,
    this.fechaUltAjuste,
    this.fechaUltDev,
    this.cantComprometidaFut,
    this.cantTransitoFut,
    this.itbm,
    this.pesoNeto,
    this.rangoTallas,
    this.rangoColor,
    this.precioLetra,
    this.tejido,
    this.descripcionIngles,
    this.costoMoneda,
    this.empaqueSugerido,
    this.precioUsa,
    this.codigoComprador,
    this.observaciones,
    this.empaqueInterno,
    this.empaque,
    this.factor,
    this.noEntrada,
    this.composicion,
    this.descTalla,
    this.coSubClase1,
    this.coSubClase2,
    this.coSubClase3,
    this.coSubClase4,
    this.foto,
    this.bultoX,
    this.bultoY,
    this.bultoZ,
    this.nlPmv,
    this.nlPm,
    this.inicial,
    this.precioTemporal,
    this.fechaFotos,
    this.coloresCantidad,
    this.coloresVariedad,
    this.costoCaf,
    this.fotoCatalogo,
    this.costoCxp,
    this.anchoNeumatico,
    this.altoNeumatico,
    this.rinNeumatico,
    this.capacidadCargaNeumatico,
    this.rangoVelocidadNeumatico,
    this.runflatNeumatico,
    this.piezaX,
    this.piezaY,
    this.piezaZ,
    this.piezaCubicaje,
    this.piezaFactor,
    this.coSubclase5,
    this.cantReservada,
    this.tipoTextura,
    this.departamento,
    this.invObjGasto,
    this.invGrupo,
    this.invSubgrupo,
    this.tipoInv,
    this.codItbms,
    this.porcComision,
    this.refFamilia,
    this.descripcionCompleta,
    this.flagDevolucion,
    this.precio,
    this.afectaInv,
    this.flagFavorito,
    this.codigoDeBarra2,
    this.codigoDeBarra3,
    this.precioVariable,
  });

  factory Producto.fromJson(Map<String, dynamic> json) =>
      _$ProductoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductoToJson(this);

  // Identificación / clave de negocio.
  final String? noCia;
  final String? correlativo;
  final String? producto;
  final String? referencia;
  final String? refProv;
  final String? refAlterna;
  final String? refFamilia;

  // Descripción y catalogación.
  final String? medidasBulto;
  final num? nuJuego;
  final String? descripcion;
  final String? descripcionAlterna;
  final String? descripcionIngles;
  final String? descripcionCompleta;
  final String? categoria;
  final String? codigoClase;
  final String? tipoProduc;
  final String? claseBulto;
  final String? clave;
  final String? tallas;
  final String? rangoTallas;
  final String? descTalla;
  final String? tamano;
  final String? colores;
  final String? rangoColor;
  final String? codColor;
  final num? coloresCantidad;
  final num? coloresVariedad;
  final String? tejido;
  final String? composicion;

  // Códigos de barra y empaque.
  final String? codigoDeBarra;
  final String? codigoDeBarra2;
  final String? codigoDeBarra3;
  final String? empaque;
  final String? empaqueInterno;
  final String? empaqueSugerido;
  final num? pBCaja;
  final num? prepack;
  final num? uniCompra;
  final num? unidadMedida;
  final num? equivVenta;
  final num? equivCompra;
  final num? proporcionPorTalla;
  final num? cantidadPorBulto;
  final num? bultosCantidad;

  // Proveedor / origen / marca.
  final String? coProveedor;
  final String? marca;
  final String? subMarca;
  final String? paisDeFabricacion;
  final String? codigoComprador;
  final num? indiceProv;
  final num? indiceMarca;
  final String? codigoTemporada;
  final String? noEntrada;

  // Inventario / cantidades.
  final num? cantFisica;
  final num? cantTransito;
  final num? cantComprometida;
  final num? cantComprometidaFuturo;
  final num? cantComprometidaFut;
  final num? cantTransitoFut;
  final num? cantReservada;
  final num? stockMinimo;
  final num? stockMaximo;
  final num? fisicoInicial;
  final num? fisicoAnterior;
  final num? inicialAnterior;
  final num? inicial;
  final num? siguienteSeqHis;
  final String? malEstado;
  final String? estatusDetalle;
  final String? noMostrar;
  final String? plv;
  final String? avtivacion;
  final String? afectaInv;
  final String? flagDevolucion;
  final String? flagFavorito;

  // Precios y costos.
  final num? precio;
  final num? precioEspecial;
  final num? precioMinimoVenta;
  final num? precioMayorista;
  final num? precioUsa;
  final num? precioTemporal;
  final String? precioLetra;
  final num? precioVariable;
  final num? costoProm;
  final num? costoFob;
  final num? costoCif;
  final num? costoCaf;
  final num? costoCxp;
  final num? costoDuty;
  final num? costoRoyalty;
  final num? costoSourcingfee;
  final num? costoInicial;
  final String? costoMoneda;
  final num? porcIncre;
  final num? porcComision;
  final num? preProm;

  // Impuestos.
  final String? itbm;
  final String? codItbms;

  // Dimensiones / peso.
  final num? pesoBulto;
  final num? pesoNeto;
  final num? cubicaje;
  final num? factor;
  final num? bultoX;
  final num? bultoY;
  final num? bultoZ;
  final num? piezaX;
  final num? piezaY;
  final num? piezaZ;
  final num? piezaCubicaje;
  final num? piezaFactor;

  // Clasificación jerárquica (sub-clases / departamento / línea contable).
  final String? coSublinea;
  final num? coSubClase1;
  final num? coSubClase2;
  final num? coSubClase3;
  final num? coSubClase4;
  @JsonKey(name: 'co_subclase_5')
  final String? coSubclase5;
  final String? departamento;
  final String? invObjGasto;
  final String? invGrupo;
  final String? invSubgrupo;
  final String? tipoInv;
  final String? grupos;
  final String? agrupar;
  final String? grupoPlv;
  final num? coTextura;
  final String? tipoTextura;
  final String? arancel;
  final String? variantes;
  final num? valorFis;
  final String? numeroLetra;
  final String? tLlegada;

  // Neumáticos (línea de producto especializada del catálogo).
  final num? anchoNeumatico;
  final num? altoNeumatico;
  final String? rinNeumatico;
  final String? capacidadCargaNeumatico;
  final String? rangoVelocidadNeumatico;
  final String? runflatNeumatico;

  // Fotos / observaciones.
  final String? foto;
  final String? fotoCatalogo;
  final DateTime? fechaFotos;
  final String? observaciones;

  // Fechas de auditoría / movimiento.
  final DateTime? fechaCreacion;
  final DateTime? fechaUltCompra;
  final DateTime? fechaUltVenta;
  final DateTime? fechaUltAjuste;
  final DateTime? fechaUltDev;
  final num? nlPmv;
  final num? nlPm;
}
