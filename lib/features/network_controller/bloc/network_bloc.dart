import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homework_todo/features/network_controller/data/network_helper.dart';

import '../../../config/enums.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  static final NetworkBloc _instance = NetworkBloc._();
  factory NetworkBloc() => _instance;

  NetworkBloc._() : super(const NetworkState(networkStatus: NetworkStatus.connected)) {
    on<NetworkObserve>((event, emit) {
      NetworkHelper.observeNetwork();
    });
    on<NetworkNotify>((event, emit) {
      event.isConnected
          ? emit(state.copyWith(networkStatus: NetworkStatus.connected))
          : emit(state.copyWith(
              networkStatus: NetworkStatus.disconnected,
            ));
    });
  }
}
