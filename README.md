# SIFPOS Flutter

Migración a Flutter del sistema SIFPOS (Oracle APEX), originalmente compuesto
por 3 aplicaciones APEX sobre el esquema `SIFCOWEB`:

- **App 101 – SIFPOS 4.5**: caja/POS, compras, inventario, ventas, cotizaciones,
  facturas, comisiones, devoluciones y mesas (restaurante).
- **App 123 – Módulo de Referencias 3.0**: mantenimiento de productos/referencias.
- **App 126 – CRM v2.1**: clientes/leads, oportunidades, documentos, facturación.

Orden de migración acordado: **POS/Ventas → Inventario/Productos → CRM**.

## Arquitectura

- **Backend**: se reutiliza la base Oracle existente vía **ORDS** (Oracle REST
  Data Services). Cada módulo de negocio expone servicios RESTful definidos en
  SQL Workshop → RESTful Services, bajo el módulo `flutter_app`.
- **Cliente**: Flutter, prioridad **Web** (con miras a escritorio y luego
  móvil), usando:
  - `dio` para el cliente HTTP.
  - `flutter_riverpod` para manejo de estado/DI.
  - `json_serializable` para (de)serialización de modelos.
  - `go_router` (pendiente de integrar en el router principal a medida que
    crezcan las pantallas).

Estructura de carpetas por *feature* (`lib/features/<modulo>/data|presentation`),
con utilidades transversales en `lib/core/` (cliente HTTP, configuración de
entorno, paginación ORDS).

## Configuración de la API (ORDS)

La URL base de ORDS se pasa por `--dart-define`, no se hardcodea:

```bash
flutter run -d chrome --dart-define=ORDS_BASE_URL=https://fevosweb.com/ords/dev2/sifco_world
```

Si no se especifica, se usa el valor por defecto en `lib/core/config/env.dart`.

⚠️ **Pendiente de seguridad**: el endpoint `flutter_app/Productos` está
actualmente expuesto sin autenticación. Antes de ir a producción hay que
protegerlo con OAuth2 (`OAUTH.CREATE_CLIENT` en ORDS) y hacer que
`ApiClient.setBearerToken` reciba el token real desde el flujo de login.

## Módulo Productos (primer avance)

- `lib/features/productos/data/models/producto.dart`: modelo que refleja 1:1
  el contrato JSON real devuelto por `flutter_app/Productos` (paginación
  estándar de ORDS: `items`, `hasMore`, `limit`, `offset`, `count`, `links`).
- `lib/features/productos/data/repositories/producto_repository.dart`:
  acceso al endpoint.
- `lib/features/productos/presentation/`: providers de Riverpod y pantalla de
  listado con paginación anterior/siguiente.

## Comandos útiles

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # regenerar *.g.dart
flutter analyze
flutter test
flutter build web --release
```
