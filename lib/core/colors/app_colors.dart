import 'package:flutter/material.dart';

class AppColors {
  // الألوان الأساسية المستخرجة من الشعار
  static const Color primaryColor = Color(
    0xFF0B1B61,
  ); // الكحلي الداكن (الهوية والعناوين)
  static const Color secondaryColor = Color(
    0xFF29B6F6,
  ); // السماوي (العناصر التفاعلية والأيقونات النشطة)
  static const Color accentColor = Color(
    0xFFF58220,
  ); // البرتقالي (أزرار اتخاذ الإجراء والـ Badges)

  // ألوان الخلفيات والأسطح
  static const Color scaffoldBackground = Color(
    0xFFF8FAFC,
  ); // خلفية التطبيق العامة
  static const Color cardColor = Color(0xFFFFFFFF); // خلفية البطاقات والحاويات
  static const Color whiteColor = Color(0xFFFFFFFF); // الأبيض الصافي

  // ألوان النصوص والحدود
  static const Color textPrimary = Color(0xFF0B132B); // النص الأساسي الداكن
  static const Color textSecondary = Color(0xFF64748B); // النص الفرعي والرمادي
  static const Color inputBorder = Color(0xFFE2E8F0); // حدود الحقول غير النشطة

  // ألوان الحالات والنظام
  static const Color successColor = Color(0xFF10B981); // النجاح
  static const Color warningColor = Color(0xFFF59E0B); // التنبيه
  static const Color errorColor = Color(0xFFEF4444); // الخطأ والتحذيرات
}
