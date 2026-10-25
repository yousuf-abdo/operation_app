import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:operation_app/core/colors/app_colors.dart';
import 'package:operation_app/features/home/cubit/home_cubit.dart';
import 'package:operation_app/features/home/view/home_content.dart';
import 'package:operation_app/features/flight_depature/view/flight_depature.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  final List<Widget> _pages = const [
    HomeContent(), // 0: الرئيسية
    FlightDepature(airlineId: 107), // 1: المغادره
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: const Text(
            'mubeen',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.scaffoldBackground,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
        ),

        // الحفاظ على حالة الصفحات عند التنقل
        body: BlocBuilder<HomeCubit, int>(
          builder: (context, currentIndex) {
            return IndexedStack(index: currentIndex, children: _pages);
          },
        ),

        // البار السفلي باللون الرئيسي ومقوس للأعلى مع Elevation
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, -4), // ظل متجه للأعلى
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomItem(
                    context: context,
                    index: 0,
                    icon: Icons.home_rounded,
                    label: "الرئيسية",
                  ),
                  _buildBottomItem(
                    context: context,
                    index: 1,
                    icon: Icons.flight_rounded,
                    label: "رحلات اليوم",
                  ),
                  _buildBottomItem(
                    context: context,
                    index: 2,
                    icon: Icons.flight_takeoff_rounded,
                    label: "المغادره",
                  ),
                  _buildBottomItem(
                    context: context,
                    index: 3,
                    icon: Icons.flight_land_rounded,
                    label: "الوصول",
                  ),
                  // _buildBottomItem(
                  //   context: context,
                  //   index: 3,
                  //   icon: Icons.account_balance_rounded,
                  //   label: "الصندوق",
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
  }) {
    return BlocBuilder<HomeCubit, int>(
      builder: (context, currentIndex) {
        final isSelected = currentIndex == index;

        return InkWell(
          onTap: () => context.read<HomeCubit>().changeIndex(index),
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isSelected
                  ? Colors.white.withOpacity(0.18) // خلفية خفيفة عند التحديد
                  : Colors.transparent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? AppColors
                            .accentColor // لون التحديد المميز
                      : Colors.white.withOpacity(0.65),
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected
                        ? AppColors.accentColor
                        : Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
