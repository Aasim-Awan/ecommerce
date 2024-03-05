import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shopperz/utils/api_list.dart';

class AppServer {
  getRequest(
      {required String endPoint,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    final dio = Dio();
    final store = GetStorage();
    var token = store.read('token');
    try {
      return dio.get(endPoint,
          options: Options(
            headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*",
            "x-api-key": ApiList.licenseCode.toString(),
            'Authorization': token
          },
           validateStatus: (_) => true,
 contentType: Headers.jsonContentType,
 responseType:ResponseType.json,
          ), queryParameters: queryParameters);
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final errorMessage = 'Error $statusCode';
        return Left(errorMessage);
      } else {
        const errorMessage = 'No Internet';
        return const Left(errorMessage);
      }
    } catch (e) {
      final errorMessage = 'Error: $e';
      return Left(errorMessage);
    }
  }

  postRequest(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      Object? body}) async {
    final dio = Dio();

    try {
      return dio.post(endPoint,
          options: Options(headers: headers),
          queryParameters: queryParameters,
          data: body);
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final errorMessage = 'Error $statusCode';
        return Left(errorMessage);
      } else {
        const errorMessage = 'No Internet';
        return const Left(errorMessage);
      }
    } catch (e) {
      final errorMessage = 'Error: $e';
      return Left(errorMessage);
    }
  }

  httpPost({
    required String endPoint,
    Object? body,
    Map<String, String>? headers,
  }) async {
    try {
      return http.post(Uri.parse(endPoint), body: body, headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        "x-api-key": ApiList.licenseCode.toString(),
      },);
    } catch (e) {
      final errorMessage = 'Error: $e';
      return Left(errorMessage);
    }
  }

  multipartRequest(endPoint, filepath) async {
    final store = GetStorage();
    var token = store.read('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
      "Access-Control-Allow-Origin": "*",
      "x-api-key": ApiList.licenseCode.toString(),
      'Authorization': token
    };

    HttpClient client = HttpClient();
    try {
      var request;
      request = http.MultipartRequest('POST', Uri.parse(endPoint!))
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', filepath!));

      return await request.send();
    } catch (error) {
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  multipartRequestReviewUpdate(endPoint, filepath) async {
    final store = GetStorage();
    var token = store.read('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
      "Access-Control-Allow-Origin": "*",
      "x-api-key": ApiList.licenseCode.toString(),
      'Authorization': token
    };

    HttpClient client = HttpClient();
    try {
      var request;
      request = http.MultipartRequest('POST', Uri.parse(endPoint!))
        ..headers.addAll(headers);

      request.files.add(http.MultipartFile(
          'image',
          File(filepath!.path).readAsBytes().asStream(),
          File(filepath!.path).lengthSync(),
          filename: filepath!.path.split("/").last));

      var response = await request.send();

      return response;
    } catch (error) {
      print(error);
      return null;
    } finally {
      client.close();
    }
  }

  multipartRequestForReview(
      endPoint, List<File?>? images, product_id, star, review) async {
    final store = GetStorage();
    var token = store.read('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
      "Access-Control-Allow-Origin": "*",
      "x-api-key": ApiList.licenseCode.toString(),
      'Authorization': token
    };

    try {
      if (images!.isEmpty) {
        var request;
        request = http.MultipartRequest('POST', Uri.parse(endPoint!))
          ..headers.addAll(headers);

        request.fields['product_id'] = product_id;
        request.fields['review'] = review;
        request.fields['star'] = star;

        var response = await request.send();

        return response;
      } else if (images.isNotEmpty) {
        var request;
        request = http.MultipartRequest('POST', Uri.parse(endPoint!))
          ..headers.addAll(headers);

        if (images.length > 0) {
          for (var i = 0; i < images.length; i++) {
            request.files.add(http.MultipartFile(
                'images[]',
                File(images[i]!.path).readAsBytes().asStream(),
                File(images[i]!.path).lengthSync(),
                filename: images[i]!.path.split("/").last));
          }
        }

        request.fields['product_id'] = product_id;
        request.fields['review'] = review;
        request.fields['star'] = star;

        var response = await request.send();

        return response;
      }
    } catch (error) {
      return null;
    }
  }

  multipartRequestForReturn(endPoint, List<File?>? images, order_id,
      return_reason_id, order_serial_no, jsonFile, note) async {
    final store = GetStorage();
    var token = store.read('token');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json, text/plain, */*",
      "Access-Control-Allow-Origin": "*",
      "x-api-key": ApiList.licenseCode.toString(),
      'Authorization': token
    };

    try {
      if (images!.isEmpty) {
        var request;
        request = http.MultipartRequest('POST', Uri.parse(endPoint!))
          ..headers.addAll(headers);

        request.fields['order_id'] = order_id.toString();
        request.fields['note'] = note.toString();
        request.fields['return_reason_id'] = return_reason_id.toString();
        request.fields['order_serial_no'] = order_serial_no.toString();
        request.fields['products'] = jsonFile.toString();

        var response = await request.send();

        return response;
      } else if (images.isNotEmpty) {
        var request;
        request = http.MultipartRequest('POST', Uri.parse(endPoint!))
          ..headers.addAll(headers);

        if (images.length > 0) {
          for (var i = 0; i < images.length; i++) {
            request.files.add(http.MultipartFile(
                'image[]',
                File(images[i]!.path).readAsBytes().asStream(),
                File(images[i]!.path).lengthSync(),
                filename: images[i]!.path.split("/").last));
          }
        }

        request.fields['order_id'] = order_id.toString();
        request.fields['note'] = note.toString();
        request.fields['return_reason_id'] = return_reason_id.toString();
        request.fields['order_serial_no'] = order_serial_no.toString();
        request.fields['products'] = jsonFile.toString();

        var response = await request.send();

        return response;
      }
    } catch (error) {
      return null;
    }
  }

  static String? bearerToken;

  static initClass({String? token}) {
    final box = GetStorage();
    return bearerToken = box.read('token');
  }

  getRequestWithoutToken({String? endPoint}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.get(Uri.parse(endPoint!),
          headers: _getHttpHeadersNotToken());
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  postRequestWithToken({String? endPoint, String? body}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.post(Uri.parse(endPoint!),
          headers: _getHttpHeaders(), body: body);
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  putRequest({String? endPoint, String? body}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.put(Uri.parse(endPoint!),
          headers: _getHttpHeaders(), body: body);
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  deleteRequest({String? endPoint, headers}) async {
    HttpClient client = HttpClient();
    try {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return await http.delete(Uri.parse(endPoint!),
          headers: headers);
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }

  static Map<String, String> _getHttpHeaders() {
    Map<String, String> headers = Map<String, String>();
    headers['Authorization'] = initClass();
    headers['x-api-key'] = ApiList.licenseCode.toString();
    headers['content-type'] = 'application/json';
    headers['Accept'] = "application/json, text/plain, */*";
    return headers;
  }

  static Map<String, String> _getHttpHeadersNotToken() {
    Map<String, String> headers = Map<String, String>();
    headers['x-api-key'] = ApiList.licenseCode.toString();
    headers['content-type'] = 'application/json';
    headers['Accept'] = "application/json, text/plain, */*";
    return headers;
  }

  static Map<String, String> getAuthHeaders() {
    Map<String, String> headers = Map<String, String>();
    headers['x-api-key'] = ApiList.licenseCode.toString();
    headers['content-type'] = 'application/json';
    headers['Accept'] = "application/json, text/plain, */*";

    return headers;
  }
}
