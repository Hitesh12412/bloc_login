abstract class CityEvent {}

class FetchCityEvent extends CityEvent {
  final int stateId;

  FetchCityEvent(this.stateId);
}
