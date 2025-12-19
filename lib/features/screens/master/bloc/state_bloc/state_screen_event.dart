abstract class StateEvent {}

class FetchStateEvent extends StateEvent {
  final int countryId;

  FetchStateEvent(this.countryId);
}
