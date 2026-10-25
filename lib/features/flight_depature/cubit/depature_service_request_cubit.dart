import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operation_app/core/functaions/secure_storage.dart';
import 'package:operation_app/core/functaions/api_client.dart';
import 'package:operation_app/features/flight_depature/model/depature_service_request_model.dart';
import 'package:operation_app/features/flight_depature/cubit/depature_service_request_state.dart';

class DepatureServiceRequestCubit extends Cubit<DepatureServiceRequestState> {
  DepatureServiceRequestCubit() : super(DepatureServiceRequestInitial());

  static DepatureServiceRequestCubit get(context) => BlocProvider.of(context);

  // الدالة التي تستقبل الأوبجكت بالكامل
  Future<void> saveDepartureData(Map<String, dynamic> requestData) async {
    emit(DepatureServiceRequestLoading()); // حالة بدء التحميل
    
    try {
       final response = await ApiClient.post(
          '/Flight/DepartureService', // أو المسار الخاص باللوقن
          body: requestData,
          authenticated: false, // لا يحتاج توكن لتسجيل الدخول
        );

      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200 && responseData['status'] == 'Success') {
        final depatureResponse = DepatureServiceRequestModel.fromJson(responseData);

        emit(DepatureServiceRequestLoadingSuccess(response: depatureResponse)); // حالة النجاح
      } else {
        emit(
          DepatureServiceRequestLoadingFailure(errorMessage: responseData['message'] ?? 'فشل اجراء العملية ، تأكد من صحة البيانات',
          ),
        );
      }
    } catch (error) {
      emit(DepatureServiceRequestLoadingFailure(errorMessage: error.toString())); // حالة الفشل
    }
  }

  
  // الدالة التي تستقبل الأوبجكت بالكامل
  Future<void> saveCompleteDepartureData(Map<String, dynamic> requestData) async {
    emit(DepatureServiceRequestLoading()); // حالة بدء التحميل
    
    try {
       final response = await ApiClient.put(
          '/Flight/DepartureFlight', // أو المسار الخاص باللوقن
          body: requestData,
          authenticated: false, // لا يحتاج توكن لتسجيل الدخول
        );

      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200 && responseData['status'] == 'Success') {
        final depatureResponse = DepatureServiceRequestModel.fromJson(responseData);

        emit(DepatureServiceRequestLoadingSuccess(response: depatureResponse)); // حالة النجاح
      } else {
        emit(
          DepatureServiceRequestLoadingFailure(errorMessage: responseData['message'] ?? 'فشل اجراء العملية ، تأكد من صحة البيانات',
          ),
        );
      }
    } catch (error) {
      emit(DepatureServiceRequestLoadingFailure(errorMessage: error.toString())); // حالة الفشل
    }
  }
}

