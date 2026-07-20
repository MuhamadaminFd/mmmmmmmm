class PaginatedResponse<T> {
  final List<T> items;
  final int currentPage;
  final bool hasNextPage;
  final int pageSize;
  final int totalItems;

  PaginatedResponse({
    required this.items,
    required this.currentPage,
    required this.hasNextPage,
    required this.pageSize,
    required this.totalItems,
  });
}
