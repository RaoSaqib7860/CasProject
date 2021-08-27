import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/driver_api/driver_api_services.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_today_earnings.dart';

class DriverFromToDayEarnigRepository extends ApiServices {
  DriverFromToDayEarnigRepository._();

  List<DriverTodayEarning> driverTodayEarning = List();
  static final DriverFromToDayEarnigRepository _getRidingRequestRepository =
      DriverFromToDayEarnigRepository._();
  factory DriverFromToDayEarnigRepository() {
    return _getRidingRequestRepository;
  }
  // Future<PsResource<List<DriverTodayEarning>>> getFrom(
  //     Map<String, dynamic> map) async {
  //   print("REPOSITORY");
  //   return await DriverFromToDayEarnigRepository()
  //       .getDriverFromToTotalEarning(map);
  // }
}
