import 'package:equatable/equatable.dart';

abstract class TaskEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTaskEvent extends TaskEvents {
  final String userId;

  FetchTaskEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId,];
}
