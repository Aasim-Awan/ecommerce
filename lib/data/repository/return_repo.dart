import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/data/model/return_order_details_model.dart';
import 'package:shopperz/data/model/return_orders_model.dart';
import 'package:shopperz/data/model/return_reason_model.dart';
import 'package:shopperz/utils/api_list.dart';

class ReturnRepo {

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

  static Future<ReturnReasonModel> getReturnReason() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.showReturnReason.toString() + '?status=5';
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ReturnReasonModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ReturnReasonModel.fromJson(response.data);
  }
  
  static Future<ReturnOrdersModel> getReturnOrders() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.showReturnOrders.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ReturnOrdersModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ReturnOrdersModel.fromJson(response.data);
  }

  static Future<ReturnOrdersDetailsModel> getReturnOrdersDetails({required String return_id}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.showReturnOrdersDetails.toString() + return_id;
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ReturnOrdersDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ReturnOrdersDetailsModel.fromJson(response.data);
  }
}
