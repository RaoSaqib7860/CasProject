import 'dart:async';

import 'package:get_smart_ride_cas/driver/constant/ps_constants.dart';
import 'package:get_smart_ride_cas/rider/home/myController.dart';
import 'package:get_smart_ride_cas/widgets/flush_bar.dart';
import 'package:logging/logging.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api.dart';

HubConnection hubConnection;
final serverUrl =
    "${DriverApi.baseUrL}/ChatHub?Str1=${DriverConst.str1}&Str2=${DriverConst.str2}&Str3=${DriverConst.str3}&Str4=${DriverConst.str4}";
final hubProtLogger = Logger("SignalR - hub");

//    If youn want to also to log out transport messages:

final transportProtLogger = Logger("SignalR - transport");

//
//================== Create Driver HubConnectoin =======================\\
//
createServerConnection() {
  print(".abc..........$serverUrl");
  MyController.to.isConectionStarted = true;
  print(".abc.............create server method");
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  // If you want only to log out the message for the higer level hub protocol:
  // final hubProtLogger = Logger("SignalR - hub");
  // If youn want to also to log out transport messages:
  // final transportProtLogger = Logger("SignalR - transport");
  final httpOptions =
      new HttpConnectionOptions(logging: (Level, message) => null

          ///**************** */ print(" Hub Connection Msg : $message")
          );

  hubConnection =
      HubConnectionBuilder().withUrl(serverUrl, httpOptions).build();
  // serverMsg();
  // .configure Logging(hubProtLogger)
  ///
}

startServerConnection() async {
  print(".abc..................... start server");
  await hubConnection.start().then((value) {
    print(".abc--------------- Connection Start -------------");
  }).catchError((e) {
    print(".abc.............Server Error");
  });
}

onCloseServerConnection() async {
  print(".abc.............close server");
  hubConnection.onclose((error) {
    print("-------------------Connection is Closed --------------");
  });
}

// serverMsg() async {
//   hubConnection.on("ReceiveMessage", _handleDriverProvidedFunction);
// }
//
//
//
// _handleDriverProvidedFunction(List<Object> list) {
//   String serverMessageForDriver = list[0].toString();
//   print("......Msg From Server.......${serverMessageForDriver.toString()}");
//
//   var splitServerMessagePattern = serverMessageForDriver.split(",");
//
//   var serverMessageName = splitServerMessagePattern;
//
//   print("  Server Message at index 0. ${serverMessageName[0].toString()}");
//   //   print("  Server Message at index 3. ${serverMessageName[3].toString()}");
//   print("  Server Message at index 1. ${serverMessageName[1].toString()}");
//   if (serverMessageName[0].toString() == "[NewRidingRequest") {
//   } else if (serverMessageName[0].toString() == "[AcceptRidingRequest") {
//     print("........Request triger.........");
//     if (serverMessageName[1].toString() == " Alread Accepted by You") {
//     } else if (serverMessageName[3].toString() ==
//         " Request Accepted Successfully") {}
//   }
// }

Timer sendDriverLocationToClientTimer;
