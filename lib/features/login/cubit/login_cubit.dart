import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operation_app/core/functaions/api_client.dart';
import 'package:operation_app/core/functaions/secure_storage.dart';
import 'package:operation_app/features/login/cubit/login_state.dart';
import 'package:operation_app/features/login/model/login_request.dart';
import 'package:operation_app/features/login/model/login_response_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login(LoginRequestModel credentials) async {
    emit(LoginLoading());
    try {
      print("📤 Request Body: ${jsonEncode(credentials.toJson())}");
      // إرسال الطلب عبر الـ ApiClient الخاص بك
      final response = await ApiClient.post(
        '/Auth/Login', // أو المسار الخاص باللوقن
        body: credentials.toJson(),
        authenticated: false, // لا يحتاج توكن لتسجيل الدخول
      );
      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'Success') {
        final loginResponse = LoginResponseModel.fromJson(responseData);

        // حفظ التوكن في SecureStorage تلقائياً
        final token = loginResponse.data?.token;
        if (token != null && token.isNotEmpty) {
          await SecureStorage.saveToken(token);
        }

        emit(LoginSuccess(response: loginResponse));
      } else {
        emit(
          LoginFailure(
            errorMessage:
                responseData['message'] ?? 'فشل تسجيل الدخول، تأكد من البيانات',
          ),
        );
      }
    } catch (e, stackTrace) {
      print("❌ API Error: $e");
      print("❌ StackTrace: $stackTrace");
      emit(LoginFailure(errorMessage: 'تعذر الاتصال بالخادم: $e'));
    }
  }
}
