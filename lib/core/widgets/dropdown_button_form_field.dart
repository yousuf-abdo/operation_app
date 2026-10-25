import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operation_app/core/functaions/secure_storage.dart';
import 'package:operation_app/core/functaions/api_client.dart';
import 'package:operation_app/features/flight_depature/model/aircraft_registeration_model.dart';

class AircraftRegDropdown extends StatefulWidget {
  final String url;
  final int? initialValue;
  final ValueChanged<int?> onChanged;

  const AircraftRegDropdown({
    super.key,
    required this.url,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<AircraftRegDropdown> createState() =>_AircraftRegDropdownState();
}

class _AircraftRegDropdownState extends State<AircraftRegDropdown> {
  List<AircraftRegModel> aircraftRegs = [];
  int? selectedId;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    selectedId = widget.initialValue;
    loadAircraftRegs();
  }

  Future<void> loadAircraftRegs() async {

    try {
      final response = await ApiClient.get(
        widget.url,
        authenticated: true,
      );

        print("📥 Status Code: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");
        
      if (response.statusCode == 200) {
        print("📥 Status Code: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");
        final Map<String, dynamic> responseData =
            jsonDecode(response.body);

        final List<dynamic> data = responseData['data'];

        final regs = data
            .map(
              (json) => AircraftRegModel.fromJson(
                json as Map<String, dynamic>,
              ),
            )
            .toList();

        if (!mounted) return;

        setState(() {
          aircraftRegs = regs;
          isLoading = false;

          if (selectedId != null &&
              !aircraftRegs.any((item) => item.id == selectedId)) {
            selectedId = null;
          }
        });

        widget.onChanged(selectedId);
      } else {
        throw Exception('فشل تحميل قائمة الطائرات');
      }
    } catch (e) {
        
        debugPrint('❌ Error: $e');
        // debugPrint('❌ StackTrace: $stackTrace');

      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isLoading = true;
                errorMessage = null;
              });
              loadAircraftRegs();
            },
            child: const Text('إعادة المحاولة'),
          ),
        ],
      );
    }

    return DropdownButtonFormField<int>(
      value: selectedId,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Aircraft Registration',
        border: OutlineInputBorder(),
      ),
      hint: const Text('Select Aircraft'),
      items: aircraftRegs.map((aircraft) {
        return DropdownMenuItem<int>(
          value: aircraft.id,
          child: Text(aircraft.registration ?? ''),
        );
      }).toList(),
      onChanged: (id) {
        setState(() {
          selectedId = id;
        });

        widget.onChanged(id);
      },
    );
  }
}
