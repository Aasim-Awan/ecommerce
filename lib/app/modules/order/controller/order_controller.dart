import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/model/order_details_model.dart';
import 'package:shopperz/data/model/order_history_model.dart';
import 'package:shopperz/data/repository/order_repo.dart';
import 'package:shopperz/data/server/app_server.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';

class OrderController extends GetxController {
  OrderHistoryModel? orderHistoryModel;
  OrderDetailsModel? orderDetailsModel;

  RxList<OrderHistoryModel> orderHistoryMap = <OrderHistoryModel>[].obs;
  RxList<OrderDetailsModel> orderDetailsMap = <OrderDetailsModel>[].obs;

  final isLoading = false.obs;

  final box = GetStorage();

  AppServer server = AppServer();

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') != false) {
      getOrderHistory();
    }
    super.onInit();
  }

  getOrderHistory() async {
    orderHistoryModel = await OrderRepo.getOrderHistory();

    orderHistoryMap.add(orderHistoryModel!);

    refresh();
  }

  getOrderDetails({required String id}) async {
    orderDetailsModel = await OrderRepo.getOrderDetails(id: id);

    orderDetailsMap.add(orderDetailsModel!);

    refresh();
  }

  cancelOrder({required String order_id}) async {
    isLoading(true);
    update();
    Map<String, String>? body = {
      "status": '15',
    };
    String jsonBody = json.encode(body);
    await server
        .postRequestWithToken(
      endPoint: ApiList.orderCancel + order_id,
      body: jsonBody,
    )
        .then((response) {
      if (response != null && response.statusCode == 200) {
        isLoading(false);
        customSnackbar("SUCCESS".tr, 'Order Canceled Successfully!'.toString().tr,
            AppColor.success);

        getOrderHistory();
        getOrderDetails(id: order_id);
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(response.body)["message"].toString().tr, AppColor.error);
      }
    });
  }
}
