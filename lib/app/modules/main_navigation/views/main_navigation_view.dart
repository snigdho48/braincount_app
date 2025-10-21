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
        width: 75 * Responsive.scale,
        height: 75 * Responsive.scale,
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
              color: const Color(0xFF85428C).withOpacity(0.4),
              blurRadius: 15 * Responsive.scale,
              spreadRadius: 3 * Responsive.scale,
              offset: Offset(0, -1 * Responsive.scale),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.changePage(1),
            customBorder: const CircleBorder(),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.clipboardCheck,
                color: Colors.white,
                size: 28 * Responsive.scale,
              ),
            ),
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
            inactiveColor: AppColors.secondaryText,
            iconSize: 26 * Responsive.scale,
            height: 60 * Responsive.scale,
            splashColor: AppColors.primary.withOpacity(0.2),
            splashSpeedInMilliseconds: 300,
            notchMargin: 6 * Responsive.scale,
            gapWidth: 100 * Responsive.scale,
            shadow: BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10 * Responsive.scale,
              offset: Offset(0, -2 * Responsive.scale),
            ),
          )),
    );
  }
}
