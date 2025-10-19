import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import '../controllers/main_navigation_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../tasks/views/task_list_view.dart';
import '../../profile/views/profile_view.dart';

class MainNavigationView extends GetView<MainNavigationController> {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const DashboardView(),
      const TaskListView(),
      const ProfileView(),
    ];

    final iconList = <IconData>[
      Icons.home,
      Icons.person,
    ];

    return Scaffold(
      extendBody: true,
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: pages,
          )),
      floatingActionButton: Container(
        width: Responsive.sp(60),
        height: Responsive.sp(60),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE786C2), // Pink
              Color(0xFF85428C), // Purple
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: Responsive.sp(12),
              spreadRadius: Responsive.sp(0),
              offset: Offset(0, Responsive.sp(1)),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => controller.changePage(1),
          child: FaIcon(
            FontAwesomeIcons.clipboardCheck,
            color: Colors.white,
            size: Responsive.sp(26),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: controller.currentIndex.value == 1 ? 0 : controller.currentIndex.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: Responsive.radiusLg,
            rightCornerRadius: Responsive.radiusLg,
            onTap: (index) {
              // Map indices: 0 = Home, 1 = Profile (Tasks is FAB)
              if (index == 0) {
                controller.changePage(0); // Home
              } else if (index == 1) {
                controller.changePage(2); // Profile
              }
            },
            backgroundColor: AppColors.cardBackground,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.textGrey,
            iconSize: Responsive.sp(26),
            height: Responsive.sp(60),
            splashColor: AppColors.primary.withOpacity(0.2),
            splashSpeedInMilliseconds: 300,
            notchMargin: Responsive.sp(8),
            shadow: BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: Responsive.sp(10),
              offset: Offset(0, -Responsive.sp(2)),
            ),
          )),
    );
  }
}
