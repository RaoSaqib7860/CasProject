import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getRidingRequestApiProvider.dart';

class GetRidingRequestRepository {
  GetRidingRequestRepository._();

  List<DriverRidingModel> subCategoryList = List();
  static final GetRidingRequestRepository _getRidingRequestRepository =
      GetRidingRequestRepository._();
  factory GetRidingRequestRepository() {
    return _getRidingRequestRepository;
  }
  Future loadRidingRequestList(String str1, String str2, String str3) async {
    print("REPOSITORY");
    return await RidingRequestApiProvider().getRidesList(str1, str2, str3);
  }
}
