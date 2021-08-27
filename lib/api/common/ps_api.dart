import 'dart:convert';
import 'dart:io';

import 'package:get_smart_ride_cas/api/common/api_response.dart';
import 'package:get_smart_ride_cas/api/common/ps_object.dart';
import 'package:get_smart_ride_cas/api/common/ps_resource.dart';
import 'package:get_smart_ride_cas/api/common/ps_status.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';

abstract class PsApi {
  PsResource<T> psObjectConvert<T>(dynamic dataList, T data) {
    return PsResource<T>(dataList.status, dataList.message, data);
  }

  Future<List<dynamic>> getList(String url) async {
    final Client client = http.Client();
    try {
      final Response response = await client.get('${""}$url');

      if (response.statusCode == 200 &&
          response.body != null &&
          response.body != '') {
        // parse into List
        final List<dynamic> parsed = json.decode(response.body);

        return parsed;
      } else {
        throw Exception('Error in loading...');
      }
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> getServerCall<T extends PsObject<dynamic>, R>(
      T obj, String url) async {
    final Client client = http.Client();
    try {
      final Response response = await client.get('${""}$url');
      print('${"PsConfig.ps_app_url"}$url');
      final PsApiResponse psApiResponse = PsApiResponse(response);

      if (psApiResponse.isSuccessful()) {
        final dynamic hashMap = json.decode(response.body);

        if (!(hashMap is Map)) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data as dynamic));
          });
          return PsResource<R>(PsStatus.SUCCESS, '', tList ?? R);
        } else {
          return PsResource<R>(PsStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } catch (e) {
      print(e.toString());
      return PsResource<R>(PsStatus.ERROR, e.toString(), null); //e.message ??
    } finally {
      client.close();
    }
  }

  Future<PsResource<R>> postData<T extends PsObject<dynamic>, R>(
      T obj, String url, Map<dynamic, dynamic> jsonMap) async {
    print("=================== method is Called ===========");

    print("${jsonMap.toString()}");
    // final Client client = http.Client();
    try {
      final Response response = await http
          .post('$url',
              headers: <String, String>{
                "Content-Type": "application/json; charset=utf-8",
              },
              body: jsonEncode(jsonMap))
          .catchError((dynamic e) {
        print('** Error Post Data');
        print(e.message);
        return PsResource<R>(PsStatus.ERROR, 'Connection Error!', null);
      });

      final PsApiResponse psApiResponse = PsApiResponse(response);
      //   print("${response.body}");
      print("${response.statusCode}");
      print("${response.body}");

      if (psApiResponse.isSuccessful()) {
        final dynamic hashMap = json.decode(response.body);

        if (!(hashMap is Map)) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return PsResource<R>(PsStatus.SUCCESS, '', tList ?? R);
        } else {
          return PsResource<R>(PsStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } on SocketException catch (e) {
      print(e);
      return PsResource<R>(PsStatus.ERROR, 'Connection Error!', null);
    } on HttpException catch (e) {
      print(e);
      return PsResource<R>(PsStatus.ERROR, 'Connection Error!', null);
    } catch (e) {
      print(e.toString());
      return PsResource<R>(PsStatus.ERROR, e.toString(), null); //e.message ??s
    } finally {
      // client.close();
    }
  }

  Future<PsResource<R>> postUploadImage<T extends PsObject<dynamic>, R>(T obj,
      String url, String userId, String platformName, File imageFile) async {
    final Client client = http.Client();
    try {
      final ByteStream stream =
          http.ByteStream(Stream.castFrom(imageFile.openRead()));
      final int length = await imageFile.length();

      final Uri uri = Uri.parse('${""}$url');

      final MultipartRequest request = http.MultipartRequest('POST', uri);
      final MultipartFile multipartFile = http.MultipartFile(
          'file', stream, length,
          filename: basename(imageFile.path));

      request.fields['user_id'] = userId;
      request.fields['platform_name'] = platformName;
      request.files.add(multipartFile);
      final StreamedResponse response = await request.send();

      final PsApiResponse psApiResponse =
          PsApiResponse(await http.Response.fromStream(response));

      if (psApiResponse.isSuccessful()) {
        final dynamic hashMap = json.decode(psApiResponse.body);

        if (!(hashMap is Map)) {
          final List<T> tList = <T>[];
          hashMap.forEach((dynamic data) {
            tList.add(obj.fromMap(data));
          });
          return PsResource<R>(PsStatus.SUCCESS, '', tList ?? R);
        } else {
          return PsResource<R>(PsStatus.SUCCESS, '', obj.fromMap(hashMap));
        }
      } else {
        return PsResource<R>(PsStatus.ERROR, psApiResponse.errorMessage, null);
      }
    } finally {
      client.close();
    }
  }
}
