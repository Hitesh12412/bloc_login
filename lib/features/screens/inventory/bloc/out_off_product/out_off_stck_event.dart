abstract class OutOfStockEvents {}

class LoadOutOfStockEvent extends OutOfStockEvents {
  final String? pageNumber;
  final String? search_text;
  final String? branchId;
  final String? categoryId;
  final String? urgencyLevel;

  LoadOutOfStockEvent({
    this.pageNumber,
    this.search_text,
    this.branchId,
    this.categoryId,
    this.urgencyLevel,
  });
}
