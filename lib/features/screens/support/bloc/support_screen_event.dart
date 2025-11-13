abstract class SupportListEvents {}

class FetchSupportListEvent extends SupportListEvents {
  final String? supportCategoryId;
  final String? pageNumber;
  final String? status;
  final String? searchText;

  FetchSupportListEvent({
    this.supportCategoryId,
    this.pageNumber,
    this.status,
    this.searchText,
  });
}
