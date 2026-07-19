import 'package:equatable/equatable.dart';

class PaginatedResponse<T> extends Equatable {
  final List<T> items;
  final int currentPage;
  final bool hasNextPage;
  final int pageSize;
  final int totalItems;

  const PaginatedResponse({
    required this.items,
    required this.currentPage,
    required this.hasNextPage,
    this.pageSize = 20,
    this.totalItems = 0,
  });

  factory PaginatedResponse.empty() {
    return const PaginatedResponse(
      items: [],
      currentPage: 1,
      hasNextPage: false,
      pageSize: 20,
      totalItems: 0,
    );
  }

  @override
  List<Object?> get props => [items, currentPage, hasNextPage, pageSize, totalItems];
}
