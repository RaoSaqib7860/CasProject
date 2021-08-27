import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import 'package:get_smart_ride_cas/rider/bloc/getRidingRequestForClient/bloc/getDriverDataBloc/bloc/getDriverDataApiProvider.dart';
import 'package:get_smart_ride_cas/rider/objects/penalty.dart';

import 'getPenaltyApiProvider.dart';

class GetRiderPenaltyRepository {
  GetRiderPenaltyRepository._();

  static final GetRiderPenaltyRepository _getriderPenaltyRepository =
      GetRiderPenaltyRepository._();
  factory GetRiderPenaltyRepository() {
    return _getriderPenaltyRepository;
  }
  Future loadRiderPenaltyList(int ridingRequestId) async {
    print("REPOSITORY");
    return await GetRiderPenaltyApiProvider()
        .getRiderPenaltyList(ridingRequestId);
  }
}
