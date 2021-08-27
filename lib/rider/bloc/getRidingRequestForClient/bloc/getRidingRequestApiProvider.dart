import 'dart:convert';

import 'package:get_smart_ride_cas/api/rider_api/rider_api.dart';
import 'package:get_smart_ride_cas/driver/view_object/driver_Riding_List.dart';
import "package:http/http.dart" as http;

abstract class ApiProvider {
  static String get baseURL => RiderApi.baseUrl;

  String get apiUrl;
  String get url => baseURL + apiUrl;
  http.Response response;
}

extension validateResponse on http.Response {
  bool isSuccessful() => statusCode == 200;
}

class RidingRequestApiProvider extends ApiProvider {
  @override
  String get apiUrl => "/api/RidingClient/PublicGetMyRidingRequestsForClient";
  String u =
      'http://admin.getsmartride.com/api/RidingClient/PublicGetMyRidingRequestsForClient';
  Future<List<DriverRidingModel>> getRidesList(
      String str1, String str2, String str3) async {
    print('API PROVIDER');
    final http.Response response = await http.post(u,
        body: jsonEncode(<String, String>{
          "Str1": str1.toString(),
          "Str2": str2.toString(),
          "Str3": str3.toString()
        }),
        headers: <String, String>{
          "Content-type": "application/json; charset=utf-8"
        });
    print("Response Status Code ${response.statusCode}");
    if (response.statusCode == 200) {
      var output = jsonDecode(response.body);
      print(output.toString());
      print("success");
      return DriverRidingModel.fromMapList(output);
    } else {
      throw Exception("failed to create....");
    }
  }
}
