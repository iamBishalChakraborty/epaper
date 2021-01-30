import 'package:connectivity/connectivity.dart';

Future<bool> getConnectivity() async {
  var connectivity = await Connectivity().checkConnectivity();
  if (connectivity == ConnectivityResult.mobile)
    return true;
  else if (connectivity == ConnectivityResult.wifi)
    return true;
  else
    return false;
}
