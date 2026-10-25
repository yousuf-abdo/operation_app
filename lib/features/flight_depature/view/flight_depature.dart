import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operation_app/core/functaions/api_client.dart';
import 'package:operation_app/core/colors/app_colors.dart';
import 'package:operation_app/features/flight_depature/cubit/depature_service_request_cubit.dart';
import 'package:operation_app/features/flight_depature/cubit/flight_depature_cubit.dart';
import 'package:operation_app/features/flight_depature/cubit/flight_depature_state.dart';
import 'package:operation_app/features/flight_depature/model/flight_depature_model.dart';
import 'package:operation_app/features/flight_depature/view/depature_service_popup.dart';
import 'package:operation_app/features/flight_depature/view/depature_complete_popup.dart';

class FlightDepature extends StatelessWidget {
  static const String routeName = '/flightDepature';
  final int airlineId;

  const FlightDepature({super.key, required this.airlineId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FlightDepatureCubit()..loadingFlightDepature(airlineId),
      child: Scaffold(appBar: AppBar(title: const Text('Flights Departure')),
        body: BlocBuilder<FlightDepatureCubit, FlightDepatureState>(
          builder: (context, state) {
            // ========================= Initial =========================
            if (state is FlightDepatureInitial) {
              return const Center(child: Text('Loading...'));
            }

            // =========================  Loading  =========================
            if (state is FlightDepatureLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // ========================= Failure =========================
            if (state is FlightDepatureLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              );
            }

            // ========================= Success =========================
            
            if (state is FlightDepatureLoadingSuccess) 
            {
              final data = state.response;

              if (data.isEmpty) {
                return const Center(
                  child: Text('No flight departure data found'),
                );
              }

            return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final flight = data[index];

                  // Date: yyyy-MM-dd
                  final date = DateTime.tryParse(flight.takeOffDate ?? '');
                  final formattedTakeOffDate = date != null ? DateFormat('yyyy-MM-dd').format(date) : '-';

                  // ATD: HH:mm
                  final etd = flight.atd?.toString() ?? '';
                  final formattedETD = etd.isNotEmpty ? etd.substring(0, etd.length >= 5 ? 5 : etd.length) : '-';

                  // 1. Container الخارجي للظل (Shadow) والهوامش (Margin)
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    // 2. Material عشان لون الخلفية وتأثير الضغط يظهر بشكل صحيح
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      clipBehavior: Clip.antiAlias, // يمنع تأثير اللمس من الخروج برا الحواف
                      // 3. InkWell عشان الضغطة
                      child: InkWell(
                        onTap: () {
                          // نستدعي الدالة هنا ونمرر الـ ID الخاص بالرحلة
                          if(flight.status == 1)
                            openDeparturePopup(context, flight.id);
                          else
                            openDepartureCompletePopup(context, flight.id);
                        },
                        // 4. المحتوى الداخلي
                        child: Container(
                          // color:flight.status == 1 ? Colors.blue : Colors.red,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Flight icon
                                Container(
                                  width: 46,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.textPrimary.withOpacity(0.09),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.flight_takeoff_rounded,
                                    size: 24,
                                    color: AppColors.primaryColor, // تأكد من استدعاء AppColors
                                  ),
                                ),

                                const SizedBox(width: 14),

                                // Flight details
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // First row: 3 items
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: _buildFlightInfo(
                                              'Flight No',
                                              flight.flightNoName ?? '###',
                                              alignment: CrossAxisAlignment.start,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: _buildFlightInfo(
                                              'Registration',
                                              flight.registration ?? '-',
                                              alignment: CrossAxisAlignment.center,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: _buildFlightInfo(
                                              'To',
                                              flight.airportToNameEn ?? '-',
                                              alignment: CrossAxisAlignment.end,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 12),
                                        child: Divider(
                                          height: 1,
                                          color: Color(0xFFF1F5F9),
                                        ),
                                      ),

                                      // Second row: 2 items
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _buildFlightInfo(
                                              'Take Off On',
                                              formattedTakeOffDate,
                                              alignment: CrossAxisAlignment.start,
                                            ),
                                          ),
                                          
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: _buildFlightInfo(
                                              'ETD',
                                              formattedETD,
                                              alignment: CrossAxisAlignment.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            // ========================= Unknown State =========================
            return const SizedBox();
          },
        ),
      ),
    );
  }








  // ========================= Helper Methods =========================
  
Widget _buildFlightInfo(
  String label,
  String value, {
  required CrossAxisAlignment alignment,
}) {
  return Column(
    crossAxisAlignment: alignment,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 5),
      Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child:
            Text(
              value,
              textAlign: alignment == CrossAxisAlignment.end
                  ? TextAlign.end
                  : alignment == CrossAxisAlignment.center
                      ? TextAlign.center
                      : TextAlign.start,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade600,
                ),
            ),
          ),

      
    ],
  );
}


void openDeparturePopup(BuildContext context,int? towerDataId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return BlocProvider<DepatureServiceRequestCubit>(
        // مرر المتغيرات المطلوبة للـ Cubit (مثل towerDataId)
        create: (context) => DepatureServiceRequestCubit(),
        child: DeparturePopup(
          towerDataId: towerDataId,
        ),
      );
    },
  );
}


void openDepartureCompletePopup(BuildContext context,int? towerDataId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return BlocProvider<DepatureServiceRequestCubit>(
        // مرر المتغيرات المطلوبة للـ Cubit (مثل towerDataId)
        create: (context) => DepatureServiceRequestCubit(),
        child: DepartureCompletePopup(
          towerDataId: towerDataId,
        ),
      );
    },
  );
}
}

