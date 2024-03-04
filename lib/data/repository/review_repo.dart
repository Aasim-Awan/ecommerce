import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopperz/data/model/review_details_model.dart';
import 'package:shopperz/utils/api_list.dart';

class ReviewRepo {

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

  static Future<ReviewDetailsModel> getReviewDetails({required String review_id}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.showReview.toString() + review_id;
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return ReviewDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return ReviewDetailsModel.fromJson(response.data);
  }

  deleteImage({required String review_id, required String index}) async {
    var response;
    var dio = Dio(
      await getBasseOptionsWithToken(),
    );
    String url = ApiList.deleteImage.toString() + review_id + '/'+ index;
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
    return response;
  }
}
