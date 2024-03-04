import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/data/model/order_history_model.dart';
import 'package:shopperz/data/model/pages_model.dart';
import 'package:shopperz/data/model/profile_address_model.dart';
import 'package:shopperz/data/model/profile_model.dart';
import 'package:shopperz/data/model/total_complete_orders_model.dart';
import 'package:shopperz/data/model/total_orders_count_model.dart';
import 'package:shopperz/data/model/total_return_orders_model.dart';
import 'package:shopperz/data/model/total_wallet_balance.dart';
import 'package:shopperz/utils/api_list.dart';

class ProfileRepo {

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

  static Future<ProfileModel> getProfile() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.profile.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ProfileModel.fromJson(response.data);
  }

  static Future<PagesModel> getPages() async {
    var response;
    var dio = Dio(
      await getBasseOptions(),
    );
    String url = ApiList.pages.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return PagesModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return PagesModel.fromJson(response.data);
  }

  static Future<ProfileAddressModel> getAddress() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.address.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ProfileAddressModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ProfileAddressModel.fromJson(response.data);
  }

  static Future<TotalOrdersCount> getTotalOrdersCount() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.totalOrdersCount.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return TotalOrdersCount.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return TotalOrdersCount.fromJson(response.data);
  }

  static Future<TotalCompleteOrdersCount> getTotalCompleteOrdersCount() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.totalCompleteOrdersCount.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return TotalCompleteOrdersCount.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return TotalCompleteOrdersCount.fromJson(response.data);
  }

  static Future<TotalReturnOrdersCount> getTotalReturnOrdersCount() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.totalReturnOrdersCount.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return TotalReturnOrdersCount.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return TotalReturnOrdersCount.fromJson(response.data);
  }

  static Future<TotalWalletBalance> getTotalWalletBalance() async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.totalWalletBalanceCount.toString();
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return TotalWalletBalance.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return TotalWalletBalance.fromJson(response.data);
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
  
}
