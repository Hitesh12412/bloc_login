abstract class InventoryListEvents {}

class LoadInventoryListEvent extends InventoryListEvents {
  final String? pageNumber;
  final String? status;
  final String? search_text;

  LoadInventoryListEvent({
    this.pageNumber,
    this.status,
    this.search_text,
  });
}
