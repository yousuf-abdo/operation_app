import 'package:flutter/material.dart';
import 'package:operation_app/core/colors/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final TextStyle? floatingLabelStyle;
  final TextInputType keyboardType;
  final IconData? icon;
  final String? Function(String?)? validator;
  
  // إضافة معامل الـ decoration الجديد
  final InputDecoration? decoration;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.textStyle,
    this.floatingLabelStyle,
    this.cursorColor,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.validator,
    this.decoration, // تعريفه هنا
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    // التنسيق الافتراضي الخاص بك
    final defaultDecoration = InputDecoration(
      labelText: widget.label,
      labelStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 13,
      ),
      floatingLabelStyle: widget.floatingLabelStyle ??
          const TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w600,
          ),
      filled: true,
      fillColor: AppColors.cardColor,
      prefixIcon: widget.icon != null
          ? Icon(widget.icon, color: AppColors.textSecondary)
          : null,
      suffixIcon: widget.isPassword
          ? IconButton(
              icon: Icon(
                _obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _obscure = !_obscure;
                });
              },
            )
          : null,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      // هذا الجزء المسؤول عن شكل الإطار عندما يكون المؤشر خارج الحقل
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.inputBorder, // تأكد أن هذا اللون ليس شفافاً أو نفس لون الخلفية
          width: 1.2,
        ),
      ),
      // هذا الجزء المسؤول عن شكل الإطار عندما يكون المؤشر داخل الحقل
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.secondaryColor, 
          width: 1.8,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorColor, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.errorColor, width: 1.8),
      ),
    );

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      cursorColor: widget.cursorColor ?? AppColors.secondaryColor,
      style: widget.textStyle ??
          const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
      // هنا نستخدم التنسيق الممرر من الخارج وإلا نستخدم الافتراضي
      decoration: widget.decoration ?? defaultDecoration,
    );
  }
}