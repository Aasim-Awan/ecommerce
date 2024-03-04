import 'package:get/get.dart';
import 'package:shopperz/app/modules/home/model/brand_model.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';

class BrandController extends GetxController {
  final brandModel = BrandModel().obs;

  Future<void> fetchBrands() async {
    final data = await RemoteServices().fetchBrands();
    data.fold((error) => error, (brands) {
      brandModel.value = brands;
    });
  }

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }
}
