import 'dart:convert';

import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/models/user_model.dart';
import 'package:shopperz/app/modules/auth/views/reset_password.dart';
import 'package:shopperz/app/modules/navbar/views/navbar_view.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';

import '../../../../data/server/app_server.dart';
import '../../../../utils/api_list.dart';

class OTPController extends GetxController {
  final isLoading = false.obs;
  final resendLoading = false.obs;
  final userModel = UserModel().obs;

  AuthController authController = Get.put(AuthController());

  Future<void> verifyOTPWithEmail(
      {required String email, required String token}) async {
    isLoading(true);
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.verifyEmail, body: {
        "email": email,
        "token": token,
      });

      if (resonse.statusCode == 201) {
        isLoading(false);
        customSnackbar("SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.success);
        final token = jsonDecode(resonse.body)["token"];
        box.write("token", 'Bearer $token');
        box.write("isLogedIn", true);
        Get.offAll(() => const NavBarView());
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> verifyOTPWithPhone(
      {required String phone,
      required String token,
      required String country_code}) async {
    isLoading(true);
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.verifyPhone, body: {
        "phone": phone,
        "country_code": country_code,
        "token": token,
      });

      if (resonse.statusCode == 201) {
        isLoading(false);
        customSnackbar("SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.success);
        final token = jsonDecode(resonse.body)["token"];
        box.write("token", 'Bearer $token');
        box.write("isLogedIn", true);
        Get.offAll(() => const NavBarView());
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> verifyOTPWithEmailForForget(
      {required String email, required String token}) async {
    isLoading(true);
    try {
      final resonse = await AppServer()
          .httpPost(endPoint: ApiList.verifyForgotEmail, body: {
        "email": email,
        "token": token,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar("SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.success);
        Get.to(() => ResetPasswordScreen(emailOrPhone: '',));
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> verifyOTPWithPhoneForForget(
      {required String phone,
      required String token,
      required String country_code}) async {
    isLoading(true);
    try {
      final resonse = await AppServer()
          .httpPost(endPoint: ApiList.verifyForgotPhone, body: {
        "phone": phone,
        "country_code": country_code,
        "token": token,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar("SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.success);
        Get.to(() => ResetPasswordScreen(emailOrPhone: "",));
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> resendOTPWithEmail({required String email}) async {
    isLoading(true);
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.resendOTPEmail, body: {
        "email": email,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar("SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.success);
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> resendOTPWithPhone(
      {required String phone, required String country_code}) async {
    isLoading(true);
    try {
      final resonse =
          await AppServer().httpPost(endPoint: ApiList.resendOTPPhone, body: {
        "email": phone,
        "country_code": country_code,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar("SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.success);
      } else {
        isLoading(false);
        customSnackbar("ERROR".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> resendOTPWithEmailForForget({required String email}) async {
    isLoading(true);
    try {
      final resonse = await AppServer()
          .httpPost(endPoint: ApiList.resendForgotOTPEmail, body: {
        "email": email,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar("SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.success);
      } else {
        isLoading(false);
        customSnackbar(
            "ERROR".tr,
            jsonDecode(resonse.body)["errors"]['email'][0].toString().tr,
            AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }

  Future<void> resendOTPWithPhoneForForget(
      {required String phone, required String country_code}) async {
    isLoading(true);
    try {
      final resonse = await AppServer()
          .httpPost(endPoint: ApiList.resendForgotOTPPhone, body: {
        "phone": phone,
        "country_code": country_code,
      });

      if (resonse.statusCode == 200) {
        isLoading(false);
        customSnackbar("SUCCESS".tr,
            jsonDecode(resonse.body)["message"].toString().tr, AppColor.success);
      } else {
        isLoading(false);
        customSnackbar(
            "ERROR".tr,
            jsonDecode(resonse.body)["errors"]['phone'][0].toString().tr,
            AppColor.error);
      }
    } catch (e) {
      isLoading(false);
      customSnackbar("ERROR".tr, e.toString(), AppColor.error);
    }
  }
}
