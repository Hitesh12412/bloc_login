abstract class SupportDetailEvents {}

class FetchSupportDetailEvent extends SupportDetailEvents {
  final int supportId;

  FetchSupportDetailEvent({required this.supportId});
}
