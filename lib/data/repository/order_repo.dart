import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/data/model/order_details_model.dart';
import 'package:shopperz/data/model/order_history_model.dart';
import 'package:shopperz/utils/api_list.dart';

class OrderRepo {

  static Future<BaseOptions> getBasseOptions() async {
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json, text/plain, */*",
        "Access-Control-Allow-Origin": "*",
        "x-api-key": ApiList.licenseCode.toString(),
      },
    );

    return options;
  }

  static Future<BaseOptions> getBasseOptionsWithToken() async {
    final store = GetStorage();
    var token = store.read('token');
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json, text/plain, */*",
        "Access-Control-Allow-Origin": "*",
        "x-api-key": ApiList.licenseCode.toString(),
        'Authorization': token
      },
    );

    return options;
  }

  static Future<OrderHistoryModel> getOrderHistory() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.orderHistory.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return OrderHistoryModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return OrderHistoryModel.fromJson(response.data);
  }

  static Future<OrderDetailsModel> getOrderDetails({required String id}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.orderDetails.toString() + id;
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return OrderDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return OrderDetailsModel.fromJson(response.data);
  }
  
}
