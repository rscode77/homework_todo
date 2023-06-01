part of 'network_bloc.dart';

class NetworkState extends Equatable {
  const NetworkState({
    required this.networkStatus,
  });

  @override
  List<Object> get props => [networkStatus];

  final NetworkStatus networkStatus;

  NetworkState copyWith({
    NetworkStatus? networkStatus,
  }) {
    return NetworkState(
      networkStatus: networkStatus ?? this.networkStatus,
    );
  }
}
