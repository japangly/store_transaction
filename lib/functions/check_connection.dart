import 'package:connectivity/connectivity.dart';

class CheckInternetConnection {
  ConnectivityResult connectivityResult;

  Future<bool> checkInternet() async {
    connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
