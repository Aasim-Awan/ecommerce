import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/order/controller/return_controller.dart';
import 'package:shopperz/app/modules/order/widgets/return_order.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class ReturnOrdersScreen extends StatefulWidget {
  const ReturnOrdersScreen({super.key});

  @override
  State<ReturnOrdersScreen> createState() => _ReturnOrdersScreenState();
}

class _ReturnOrdersScreenState extends State<ReturnOrdersScreen> {
  ReturnController returnController = Get.put(ReturnController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (box.read('isLogedIn') != false)
    {
      returnController.getReturnOrders();
    }
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: const AppBarWidget3(text: ''),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
        child: TextWidget(
          text: 'RETURN_ORDERS'.tr,
          color: AppColor.primaryColor,
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(
        height: 12.h,
      ),
      Expanded(
        child: RefreshIndicator(
            color: AppColor.primaryColor,
            onRefresh: () async {
              if (box.read('isLogedIn') != false)
              {
                returnController.getReturnOrders();
              }
            },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Obx(
                    ()=> returnController.returnOrdersMap.isNotEmpty && returnController.returnOrdersModel!.data!.length > 0? 
                    ListView.builder(
                      itemCount: returnController.returnOrdersModel!.data!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: ReturnOrderWidget(
                            returnData: returnController.returnOrdersModel!.data![index],
                          ),
                        );
                      },
                    ): Padding(
                        padding: EdgeInsets.only(top: 100.h),
                        child: Center(
                                child: Image.asset(AppImages.emptyIcon,height: 300.h,width: 300.w,),
                              ),
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
        ]),
      ),
    );
  }
}
