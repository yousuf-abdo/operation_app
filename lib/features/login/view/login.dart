import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:operation_app/core/colors/app_colors.dart';
import 'package:operation_app/core/widgets/app_mesages.dart';
import 'package:operation_app/core/widgets/custom_text_field.dart';
import 'package:operation_app/features/home/view/home.dart';
import 'package:operation_app/features/login/cubit/login_cubit.dart';
import 'package:operation_app/features/login/cubit/login_state.dart';
import 'package:operation_app/features/login/model/login_request.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = LoginCubit.get(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            final userName =
                state.response.data?.airlineAgent?.nameAr ??
                state.response.data?.userName ??
                '';

            AppMessage.success(
              context,
              userName.isNotEmpty
                  ? 'مرحباً بك $userName'
                  : 'تم تسجيل الدخول بنجاح',
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );

            // الانتقال للشاشة الرئيسية بعد تسجيل الدخول
            // Navigator.pushReplacementNamed(context, '/home');
          } else if (state is LoginFailure) {
            // إظهار رسالة الخطأ أو خطأ الاتصال
            AppMessage.error(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return Stack(
            children: [
              // 1. محتوى شاشة تسجيل الدخول
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Header الهوية والشعار
                    Container(
                      height: size.height * 0.38,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36),
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.whiteColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/logo.jpg',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.flight_takeoff_rounded,
                                      size: 46,
                                      color: AppColors.primaryColor,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'مرحباً بك',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'سجّل دخولك للوصول إلى رحلاتك وخدماتك',
                              style: TextStyle(
                                color: Color(0xFFCBD5E1),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // بطاقة نموذج تسجيل الدخول
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 28,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                label: 'اسم المستخدم / رقم الهاتف',
                                controller: _phoneController,
                                keyboardType: TextInputType.text,
                                icon: Icons.person_outline_rounded,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'يرجى إدخال اسم المستخدم أو رقم الهاتف';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 18),

                              CustomTextField(
                                label: 'كلمة المرور',
                                controller: _passwordController,
                                isPassword: true,
                                icon: Icons.lock_outline_rounded,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'يرجى إدخال كلمة المرور'
                                    : null,
                              ),

                              const SizedBox(height: 10),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'نسيت كلمة المرور؟',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              // زر تسجيل الدخول الثابت بنصه
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accentColor,
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            cubit.login(
                                              LoginRequestModel(
                                                UserName: _phoneController.text,
                                                password:
                                                    _passwordController.text,
                                              ),
                                            );
                                          }
                                        },
                                  child: const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. طبقة التحميل الشاملة (Full Screen Overlay) بمربعات الألوان
              // طبقة تحميل شفافة تمنع اللمس وتُظهر المربعات فقط
              if (isLoading)
                const ModalBarrier(
                  dismissible: false,
                  color: Colors.transparent, // شفاف تماماً بدون تعتيم
                ),

              if (isLoading)
                const Center(
                  child: SpinKitCubeGrid(
                    size: 60.0,
                    color: AppColors.accentColor,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
