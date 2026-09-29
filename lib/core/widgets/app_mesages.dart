import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:operation_app/core/colors/app_colors.dart';

class AppMessage {
  // رسالة النجاح
  static void success(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: AppColors.successColor,
      icon: const Icon(Icons.check_circle_rounded, color: AppColors.whiteColor),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(14),
      flushbarPosition: FlushbarPosition.TOP,
      messageColor: AppColors.whiteColor,
      messageSize: 14,
      boxShadows: [
        BoxShadow(
          color: AppColors.successColor.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    ).show(context);
  }

  // رسالة الخطأ
  static void error(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: AppColors.errorColor,
      icon: const Icon(
        Icons.error_outline_rounded,
        color: AppColors.whiteColor,
      ),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(14),
      flushbarPosition: FlushbarPosition.TOP,
      messageColor: AppColors.whiteColor,
      messageSize: 14,
      boxShadows: [
        BoxShadow(
          color: AppColors.errorColor.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    ).show(context);
  }

  // رسالة التنبيه / التحذير
  static void warning(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: AppColors.warningColor,
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: AppColors.whiteColor,
      ),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(14),
      flushbarPosition: FlushbarPosition.TOP,
      messageColor: AppColors.whiteColor,
      messageSize: 14,
      boxShadows: [
        BoxShadow(
          color: AppColors.warningColor.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    ).show(context);
  }

  // رسالة إشعار عامة بلون الهوية (Primary Navy)
  static void info(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: AppColors.primaryColor,
      icon: const Icon(
        Icons.info_outline_rounded,
        color: AppColors.secondaryColor,
      ),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(14),
      flushbarPosition: FlushbarPosition.TOP,
      messageColor: AppColors.whiteColor,
      messageSize: 14,
      boxShadows: [
        BoxShadow(
          color: AppColors.primaryColor.withOpacity(0.25),
          offset: const Offset(0, 4),
          blurRadius: 10,
        ),
      ],
    ).show(context);
  }
}
