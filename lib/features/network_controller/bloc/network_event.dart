part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class NetworkNotify extends NetworkEvent {
  final bool isConnected;
  const NetworkNotify({
    required this.isConnected,
  });
}

class NetworkObserve extends NetworkEvent {}
