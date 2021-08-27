import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getDriverDataBloc/bloc/getDriverDataApiProvider.dart';

import 'getRideBillApiProvider.dart';

class GetRideBillRepository {
  GetRideBillRepository._();

  List<DriverRidingModel> subCategoryList = List();
  static final GetRideBillRepository _getRideBillRepository =
      GetRideBillRepository._();
  factory GetRideBillRepository() {
    return _getRideBillRepository;
  }
  Future loadGetRideBillList(int ridingRequestId) async {
    print("REPOSITORY");
    return await GetRideBillApiProvider().getRideBillList(ridingRequestId);
  }
}
