import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operation_app/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:operation_app/core/functaions/api_client.dart';
import 'package:operation_app/core/widgets/custom_text_field.dart';
import 'package:operation_app/features/flight_depature/cubit/depature_service_request_cubit.dart';
import 'package:operation_app/features/flight_depature/model/depature_service_request_model.dart';
import 'package:operation_app/features/flight_depature/cubit/depature_service_request_state.dart';

class DepartureCompletePopup extends StatefulWidget {
  final int? towerDataId;

  const DepartureCompletePopup({
    super.key,
    required this.towerDataId,
  });

  @override
  State<DepartureCompletePopup> createState() => _DepartureCompletePopupState();
}

class _DepartureCompletePopupState extends State<DepartureCompletePopup> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  
  bool hasPushback = false;

  @override
  void dispose() {
    // It's important to dispose controllers to prevent memory leaks
    dateController.dispose();
    timeController.dispose();

    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    // 1. أضفنا كلمة return هنا 👇
    return BlocConsumer<DepatureServiceRequestCubit, DepatureServiceRequestState>(
      listener: (context, state) {
        // الاستماع للحالات (Success, Error)
        if (state is DepatureServiceRequestLoadingSuccess) {
          // إغلاق النافذة عند النجاح
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data saved successfully!')),
          );
        } else if (state is DepatureServiceRequestLoadingFailure) {
          // إظهار رسالة خطأ عند الفشل
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          title: const Text('Flight Departure Details'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 36, bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [ 
                  const SizedBox(height: 12),

                  // ----------------------------------------
                  // حقل اختيار التاريخ (Date Picker)
                  // ----------------------------------------
                  TextFormField(
                    controller: dateController,
                    readOnly: true, // يمنع الكتابة اليدوية، ويسمح بالضغط فقط
                    decoration: getDefaultDecoration('Select Date').copyWith(
                      // استخدمنا copyWith لتغيير الأيقونة الافتراضية
                      prefixIcon: const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                    ),
                    onTap: () async {
                      // فتح نافذة اختيار التاريخ
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), // التاريخ الافتراضي
                        firstDate: DateTime(2000),   // أقدم تاريخ مسموح
                        lastDate: DateTime(2100),    // أبعد تاريخ مسموح
                      );

                      if (pickedDate != null) {
                        // تنسيق التاريخ (مثال: 2023-10-25)
                        String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        dateController.text = formattedDate; // عرض التاريخ في الحقل
                      }
                    },
                  ),

                  const SizedBox(height: 12),

                  // ----------------------------------------
                  // حقل اختيار الوقت (Time Picker)
                  // ----------------------------------------
                  TextFormField(
                    controller: timeController,
                    readOnly: true,
                    decoration: getDefaultDecoration('Select Time').copyWith(
                      prefixIcon: const Icon(Icons.access_time_outlined, color: Colors.grey),
                    ),
                    onTap: () async {
                      // فتح نافذة اختيار الوقت
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        final String formattedTime = '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        // التأكد من أن الـ context لا يزال موجوداً قبل استخدام format
                        if (context.mounted) {
                          // تنسيق وعرض الوقت (مثال: 10:30 AM)
                          // timeController.text = pickedTime.format(context); 
                          timeController.text = formattedTime; // عرض الوقت في الحقل 
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  
                ],
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                var requestBody = {
                  "id": widget.towerDataId, // تأكد من تمرير towerDataId بشكل صحيح
                  "takeOffDate": dateController.text.isNotEmpty ? dateController.text : null,
                  "atd": timeController.text.isNotEmpty ? timeController.text : null,
                };
                
                // 2. قمنا بإضافة استدعاء دالة الحفظ هنا 👇
                context.read<DepatureServiceRequestCubit>().saveCompleteDepartureData(requestBody);
                // Navigator.pop(context);
                // يمكنك إضافة أي منطق إضافي بعد الحفظ إذا لزم الأمر
              },
              icon: const Icon(Icons.save_outlined),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
              ),
              label: const Text('Save'),
            ),
          ],
        );
      },
    ); // تم إضافة الفاصلة المنقوطة هنا بشكل صحيح
  }

  InputDecoration getDefaultDecoration(String label) {
  return InputDecoration(
    labelText: label,
    prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
    filled: true,
    fillColor: Colors.white,
    // المؤشر خارج الحقل
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.grey, // لون الإطار عندما لا يكون الحقل نشطاً
        width: 1.5,
      ),
    ),
    // المؤشر داخل الحقل
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.blue, // لون الإطار عندما يكون الحقل نشطاً
        width: 2.0,
      ),
    ),
  );
}
}

