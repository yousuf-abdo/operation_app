import 'package:flutter/material.dart';
import 'package:operation_app/core/colors/app_colors.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    const scaffoldBg = Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // 1. الهيدر المقوس من الأسفل
            _buildCurvedHeader(context),

            // 2. محتوى الصفحة والبطاقات
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // بطاقة رحلات الوصول
                  _buildFlightSummaryCard(
                    title: 'رحلات الوصول (Arrivals)',
                    subtitle: 'آخر التحديثات لرحلات الهبوط اليوم',
                    badgeText: '8 رحلات اليوم',
                    badgeColor: const Color(0xFFE6F4EA),
                    badgeTextColor: const Color(0xFF137333),
                    icon: Icons.flight_land_rounded,
                    flights: [
                      _FlightItem(
                        airline: 'بدر للطيران',
                        flightNumber: 'J4-341',
                        route: 'القاهرة (CAI) ➔ بورتسودان (PZU)',
                        time: '11:45 ص',
                        status: 'في الموعد',
                        statusColor: const Color(0xFF137333),
                      ),
                      _FlightItem(
                        airline: 'تاركو للطيران',
                        flightNumber: '3T-202',
                        route: 'جدة (JED) ➔ بورتسودان (PZU)',
                        time: '01:15 م',
                        status: 'هبطت',
                        statusColor: AppColors.primaryColor,
                      ),
                    ],
                    onViewAll: () {},
                  ),

                  const SizedBox(height: 18),

                  // بطاقة رحلات المغادرة
                  _buildFlightSummaryCard(
                    title: 'رحلات المغادرة (Departures)',
                    subtitle: 'الرحلات المجدولة للإقلاع',
                    badgeText: '5 رحلات متبقية',
                    badgeColor: const Color(0xFFFEF7E0),
                    badgeTextColor: const Color(0xFFB06000),
                    icon: Icons.flight_takeoff_rounded,
                    flights: [
                      _FlightItem(
                        airline: 'طيران الإمارات',
                        flightNumber: 'EK-734',
                        route: 'بورتسودان (PZU) ➔ دبي (DXB)',
                        time: '03:30 م',
                        status: 'مفتوح للوزن',
                        statusColor: AppColors.accentColor,
                      ),
                      _FlightItem(
                        airline: 'بدر للطيران',
                        flightNumber: 'J4-118',
                        route: 'بورتسودان (PZU) ➔ مسقط (MCT)',
                        time: '05:00 م',
                        status: 'مجدولة',
                        statusColor: const Color(0xFF5F6368),
                      ),
                    ],
                    onViewAll: () {},
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت الهيدر المقوس من الأسفل
  Widget _buildCurvedHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 26),
      child: Row(
        children: [
          // صورة المستخدم الرمزية أو الشعار
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.18),
              border: Border.all(color: Colors.white30, width: 1.5),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),

          // اسم المستخدم والشركة
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'أحمد المصطفى',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  children: [
                    Icon(
                      Icons.business_rounded,
                      color: Color(0xFFB2DFDB),
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'وكالة الأفق لخدمات الطيران',
                      style: TextStyle(
                        color: Color(0xFFE0F2F1),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // زر التحديث أو الحالة السريعة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 4, backgroundColor: Color(0xFF4CAF50)),
                SizedBox(width: 6),
                Text(
                  'نشط',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت الكارد الموحد لعرض الرحلات
  Widget _buildFlightSummaryCard({
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required IconData icon,
    required List<_FlightItem> flights,
    required VoidCallback onViewAll,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الكارد والأيقونة
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: badgeTextColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),

          // عناصر الرحلات
          ...flights.map((flight) => _buildFlightTile(flight)),

          // زر عرض الكل
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: onViewAll,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 13,
                color: AppColors.accentColor,
              ),
              label: const Text(
                'عرض تفاصيل كل الرحلات',
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // صف تفاصيل الرحلة الواحدة
  Widget _buildFlightTile(_FlightItem flight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // وقت الرحلة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(
              flight.time,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xFF334155),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // تفاصيل شركة الطيران والمسار
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      flight.airline,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '(${flight.flightNumber})',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  flight.route,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),

          // شارة حالة الرحلة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: flight.statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              flight.status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: flight.statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// نموذج مساعد لعرض بيانات الرحلات الوهمية
class _FlightItem {
  final String airline;
  final String flightNumber;
  final String route;
  final String time;
  final String status;
  final Color statusColor;

  _FlightItem({
    required this.airline,
    required this.flightNumber,
    required this.route,
    required this.time,
    required this.status,
    required this.statusColor,
  });
}
