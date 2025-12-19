import 'package:bloc_login/features/screens/orders_module/ui/order/model/client_list/client_list_model_class.dart';

abstract class ClientStates {}

class InitialClientState extends ClientStates {}

class LoadingClientState extends ClientStates {}

class LoadingMoreClientState extends ClientStates {}

class LoadedClientState extends ClientStates {
  final ClientListModel model;
  final List<ClientData> clients;
  final bool hasNextPage;

  LoadedClientState({
    required this.model,
    required this.clients,
    required this.hasNextPage,
  });
}

class FailureClientState extends ClientStates {
  final String error;
  FailureClientState({required this.error});
}
