import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopperz/utils/svg_icon.dart';

import '../../../../config/theme/app_color.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    this.onTap,
    this.svgIcon,
    this.title,
  });

  final void Function()? onTap;
  final String? svgIcon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryBackgroundColor,
      elevation: 0,
      toolbarHeight: 48.h,
      leadingWidth: 100.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Image.asset(
          "assets/images/LUSSOROMAN_logo.png",
          height: 20.h,
          width: 73.w,
        ),
      ),
      title: Text(
        title ?? "Lussoro Man",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: AppColor.textColor,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(right: 16.w, left: 16.w),
            child: SvgPicture.asset(
              svgIcon ?? "",
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
      ],
    );
  }
}
