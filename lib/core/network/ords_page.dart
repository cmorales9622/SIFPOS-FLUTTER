/// Sobre de paginación estándar que devuelve ORDS para una Collection Query:
/// { "items": [...], "hasMore": bool, "limit": n, "offset": n, "count": n, "links": [...] }
class OrdsPage<T> {
  OrdsPage({
    required this.items,
    required this.hasMore,
    required this.limit,
    required this.offset,
    required this.count,
  });

  factory OrdsPage.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final rawItems = (json['items'] as List<dynamic>? ?? const []);
    return OrdsPage<T>(
      items: rawItems
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] as bool? ?? false,
      limit: json['limit'] as int? ?? rawItems.length,
      offset: json['offset'] as int? ?? 0,
      count: json['count'] as int? ?? rawItems.length,
    );
  }

  final List<T> items;
  final bool hasMore;
  final int limit;
  final int offset;
  final int count;
}
