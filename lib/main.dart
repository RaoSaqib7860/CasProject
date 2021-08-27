import 'package:firebase_core/firebase_core.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_smart_ride_cas/Commons/hub_connection.dart';
import 'package:get_smart_ride_cas/driver/bloc/getdriverridelist_bloc.dart';
import 'package:get_smart_ride_cas/driver/repository/driver_profile/bloc/driverprofile_bloc.dart';
import 'package:get_smart_ride_cas/driver/repository/initial_requirements/bloc/driverinitialrequirements_bloc.dart';
import 'package:signalr_core/signalr_core.dart';
import 'app/app.dart';
import 'app/theme/colors.dart';
import 'rider/bloc/getRidingRequestForClient/bloc/getDriverDataBloc/bloc/getdriverdata_bloc.dart';
import 'rider/bloc/getRidingRequestForClient/bloc/getRideBill/bloc/getridebill_bloc.dart';
import 'rider/bloc/getRidingRequestForClient/bloc/getridingrquestforclientbloc_bloc.dart';
import 'package:get/get.dart';
import 'package:get_smart_ride_cas/api/rider_api/waiting_controller.dart';
import 'package:get_smart_ride_cas/rider/home/myController.dart';
HubConnection hubConnection;
Future<void> preCache() async {
  FlareCache.doesPrune = false;
  await cachedActor(
    AssetFlare(
      bundle: rootBundle,
      name: 'images/elms_bg_splash.flr',
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
     Get.put(MyController(), permanent: true);
    
    Get.put(WaitingController());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.mainColor,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: AppColors.mainColor,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  preCache().then(
    (value) => runApp(
      BlocProvider<DriverprofileBloc>(
        create: (context) => DriverprofileBloc(),
        child: BlocProvider<DriverinitialrequirementsBloc>(
          create: (context) => DriverinitialrequirementsBloc(),
          child: BlocProvider<GetdriverridelistBloc>(
            create: (context) => GetdriverridelistBloc(),
            child: BlocProvider<GetridingrquestforclientblocBloc>(
              create: (BuildContext context) =>
                  GetridingrquestforclientblocBloc(),
              child: BlocProvider<GetdriverdataBloc>(
                create: (context) => GetdriverdataBloc(),
                child: BlocProvider<GetridebillBloc>(
                  create: (context) => GetridebillBloc(),
                  child: GetSmartRideApp(),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// BlocProvider<GetdriverridelistBloc>(
//       create: (context) => GetdriverridelistBloc(), child: GetSmartRideApp())));

/*
(value) => runApp(BlocProvider<GetridingrquestforclientblocBloc>(
        create: (BuildContext context) => GetridingrquestforclientblocBloc(),
        child: BlocProvider<GetdriverdataBloc>(
          create: (context) => GetdriverdataBloc(),
          child: BlocProvider<GetridebillBloc>(
            create: (context) => GetridebillBloc(),
            child: GetSmartRideApp(),
          ),
        ))),
*/
