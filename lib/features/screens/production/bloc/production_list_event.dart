abstract class ProductionListEvents {}

class FetchProductionListEvent extends ProductionListEvents {
  final String? ProductionCategoryId;
  final String? pageNumber;
  final String? status;

  FetchProductionListEvent({
    this.ProductionCategoryId,
    this.pageNumber,
    this.status,
  });
}
