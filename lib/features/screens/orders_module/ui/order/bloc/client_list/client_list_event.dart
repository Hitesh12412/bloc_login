abstract class ClientEvents {}

class FetchClientEvent extends ClientEvents {
  final String userId;
  final String? searchText;
  final bool isLoadMore;

  FetchClientEvent({
    required this.userId,
    this.searchText,
    this.isLoadMore = false,
  });
}
