import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operation_app/core/functaions/secure_storage.dart';
import 'package:operation_app/core/functaions/api_client.dart';
import 'package:operation_app/features/flight_depature/model/flight_depature_model.dart';
import 'package:operation_app/features/flight_depature/cubit/flight_depature_state.dart';

class FlightDepatureCubit extends Cubit<FlightDepatureState> {
  FlightDepatureCubit() : super(FlightDepatureInitial());

  static FlightDepatureCubit get(context) => BlocProvider.of(context);

  Future<void> loadingFlightDepature(int airlineId) async {
    emit(FlightDepatureLoading());

    try {
      final response = await ApiClient.get(
        '/Flight/FlightsDepature/$airlineId',
        authenticated: true,
      );

      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // تحويل JSON إلى Map
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // استخراج قائمة الرحلات من data
        final List<dynamic> data = responseData['data'];

        final flights = data
            .map((json) => FlightDepatureResponseModel.fromJson(json))
            .toList();

        emit(
          FlightDepatureLoadingSuccess(response: flights,),
        );
      } else {
        emit(
          FlightDepatureLoadingFailure(errorMessage: 'حدث خطأ أثناء جلب الرحلات',),
        );
      }
    } catch (e) {
      emit(
        FlightDepatureLoadingFailure(errorMessage: e.toString(),),
      );
    }
  }

}
