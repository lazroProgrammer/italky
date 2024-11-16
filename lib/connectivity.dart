import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  static Future<bool> internetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      return true;
    } else if (connectivityResult == ConnectivityResult.vpn) {
      return true;
    } else {
      return false;
    }
  }
}
