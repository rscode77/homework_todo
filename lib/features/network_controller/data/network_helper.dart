import 'package:connectivity_plus/connectivity_plus.dart';

import '../bloc/network_bloc.dart';

class NetworkHelper {
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        NetworkBloc().add(const NetworkNotify(isConnected: false));
      } else {
        NetworkBloc().add(const NetworkNotify(isConnected: true));
      }
    });
  }
}
