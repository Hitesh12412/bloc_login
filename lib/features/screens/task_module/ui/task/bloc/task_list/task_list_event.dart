import 'package:equatable/equatable.dart';

abstract class TaskEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTaskEvent extends TaskEvents {
  final String userId;
  final String searchText;


  FetchTaskEvent({
    required this.userId, required this.searchText,
  });

  @override
  List<Object> get props => [userId,];
}
