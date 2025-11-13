abstract class PurchaseListEvents {}

class FetchPurchaseListEvent extends PurchaseListEvents {
  final String? PurchaseCategoryId;
  final String? pageNumber;
  final String? status;

  FetchPurchaseListEvent({
    this.PurchaseCategoryId,
    this.pageNumber,
    this.status,
  });
}
