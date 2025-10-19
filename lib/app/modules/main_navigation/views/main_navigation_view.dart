import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import '../controllers/main_navigation_controller.dart';
import '../../../core/theme/app_colors.dart';
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

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: pages,
      )),
      bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar(
        icons: const [
          FontAwesomeIcons.house,
          FontAwesomeIcons.listCheck,
          FontAwesomeIcons.user,
        ],
        activeIndex: controller.currentIndex.value,
        gapLocation: GapLocation.none,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        onTap: controller.changeTab,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.textGrey,
        backgroundColor: AppColors.cardBackground,
        splashColor: AppColors.primary.withOpacity(0.2),
        splashRadius: 30,
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, -2),
        ),
      )),
    );
  }
}

