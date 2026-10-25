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

class DeparturePopup extends StatefulWidget {
  final int? towerDataId;

  const DeparturePopup({
    super.key,
    required this.towerDataId,
  });

  @override
  State<DeparturePopup> createState() => _DeparturePopupState();
}

class _DeparturePopupState extends State<DeparturePopup> {
  final TextEditingController paxCountController = TextEditingController(text: '0');
  final TextEditingController internationalPaxCountController = TextEditingController(text: '0');
  final TextEditingController freightLoadController = TextEditingController(text: '0');
  final TextEditingController normalMailController = TextEditingController(text: '0');
  final TextEditingController rapidMailController = TextEditingController(text: '0');
  final TextEditingController ambulanceCarCountController = TextEditingController(text: '0');
  final TextEditingController fireFightingCarCountController = TextEditingController(text: '0');
  final TextEditingController hasPushbackCountController = TextEditingController(text: '0');
  
  bool hasPushback = false;

  @override
  void dispose() {
    // It's important to dispose controllers to prevent memory leaks
    paxCountController.dispose();
    internationalPaxCountController.dispose();
    freightLoadController.dispose();
    normalMailController.dispose();
    rapidMailController.dispose();
    ambulanceCarCountController.dispose();
    fireFightingCarCountController.dispose();
    hasPushbackCountController.dispose();
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
                  CustomTextField(
                    label: 'Pax Count',
                    controller: paxCountController,
                    keyboardType: TextInputType.number,
                    icon: Icons.people_outline,
                    decoration: getDefaultDecoration('Pax Count'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'International Pax Count',
                    controller: internationalPaxCountController,
                    keyboardType: TextInputType.number,
                    icon: Icons.people_outline,
                    decoration: getDefaultDecoration('International Pax Count'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Freight Load (Exp)/TN',
                    controller: freightLoadController,
                    keyboardType: TextInputType.number,
                    icon: Icons.airport_shuttle_outlined,
                    decoration: getDefaultDecoration('Freight Load (Exp)/TN'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Normal Mail (Exp)/KG',
                    controller: normalMailController,
                    keyboardType: TextInputType.number,
                    icon: Icons.email_outlined,
                    decoration: getDefaultDecoration('Normal Mail (Exp)/KG'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Rapid Mail (Exp)/KG',
                    controller: rapidMailController,
                    keyboardType: TextInputType.number,
                    icon: Icons.email_outlined,
                    decoration: getDefaultDecoration('Rapid Mail (Exp)/KG'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Ambulance Car Count',
                    controller: ambulanceCarCountController,
                    keyboardType: TextInputType.number,
                    icon: Icons.medical_services_outlined,
                    decoration: getDefaultDecoration('Ambulance Car Count'),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Fire Fighting Car Count',
                    controller: fireFightingCarCountController,
                    keyboardType: TextInputType.number,
                    icon: Icons.fire_truck_outlined,
                    decoration: getDefaultDecoration('Fire Fighting Car Count'),
                  ),
                  const SizedBox(height: 8),
                  
                  CheckboxListTile(
                    value: hasPushback,
                    onChanged: (value) {
                      setState(() {
                        hasPushback = value ?? false;
                      });
                    },
                    title: const Text('Used Pushback'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: AppColors.inputBorder,
                      ),
                    ),
                    activeColor: AppColors.secondaryColor,
                  ),
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
                  "towerDataId": widget.towerDataId, // تأكد من تمرير towerDataId بشكل صحيح
                  "paxCount": int.tryParse(paxCountController.text) ?? 0,
                  "internationalPaxCount": int.tryParse(internationalPaxCountController.text) ?? 0,
                  "freightLoad": double.tryParse(freightLoadController.text) ?? 0.0,
                  "normalMail": double.tryParse(normalMailController.text) ?? 0.0,
                  "rapidMail": double.tryParse(rapidMailController.text) ?? 0.0,
                  "ambulanceCarCount": int.tryParse(ambulanceCarCountController.text) ?? 0,
                  "fireFightingCarCount": int.tryParse(fireFightingCarCountController.text) ?? 0,
                  "hasPushback": hasPushback,
                };
                
                // 2. قمنا بإضافة استدعاء دالة الحفظ هنا 👇
                context.read<DepatureServiceRequestCubit>().saveDepartureData(requestBody);
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

