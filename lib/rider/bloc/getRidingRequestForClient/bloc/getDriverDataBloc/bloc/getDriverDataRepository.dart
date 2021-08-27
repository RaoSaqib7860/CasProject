import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getDriverDataBloc/bloc/getDriverDataApiProvider.dart';

class GetDriverDataRepository {
  GetDriverDataRepository._();

  List<DriverRidingModel> subCategoryList = List();
  static final GetDriverDataRepository _getDriverDataRepository =
      GetDriverDataRepository._();
  factory GetDriverDataRepository() {
    return _getDriverDataRepository;
  }
  Future loadDriverDataList(int driverId) async {
    print("REPOSITORY");
    return await GetDriverDataApiProvider().getDriverDataList(driverId);
  }
}
