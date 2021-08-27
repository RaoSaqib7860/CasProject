import 'dart:convert';

import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import 'package:get_smart_ride_cas/rider/objects/getDriverData.dart';
import 'package:get_smart_ride_cas/rider/objects/getRideBill.dart';
import "package:http/http.dart" as http;

abstract class ApiProvider {
  http.Response response;
}

extension validateResponse on http.Response {
  bool isSuccessful() => statusCode == 200;
}

class GetRideBillApiProvider extends ApiProvider {
  @override
  // String get apiUrl => "/api/RidingClient/PublicGetMyRidingRequestsForClient";

  Future<List<GetRideBill>> getRideBillList(int ridingRequestId) async {
    print('API PROVIDER');
    final http.Response response = await http.post(RiderApi.publicGetRideBill,
        body: jsonEncode(
            <String, String>{"RidingRequestId": ridingRequestId.toString()}),
        headers: <String, String>{
          "Content-type": "application/json; charset=utf-8"
        });
    print("Response Status Code ${response.statusCode}");
    if (response.statusCode == 200) {
      var output = jsonDecode(response.body);
      print(output.toString());
      print("success");
      return GetRideBill.fromMapList(output);
    } else {
      throw Exception("failed to create....");
    }
  }
}
