import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/services/storage_service.dart';
import '../data/services/theme_service.dart';
import '../core/theme/app_colors.dart';

/// Reusable User Header Widget
/// Displays user avatar, name, ID, and theme toggle
/// Used across multiple screens (Dashboard, Withdraw, Balance History, etc.)
class UserHeader extends StatelessWidget {
  final double scale;
  final bool showThemeToggle;

  const UserHeader({
    super.key,
    required this.scale,
    this.showThemeToggle = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.getUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final userName = user?.name ?? 'NAFSIN RAHMAN';
        final userId = user?.id.toString() ?? '34874';

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 12 * scale,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User Info
              Expanded(
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 40 * scale,
                      height: 40 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0B8FF),
                        borderRadius: BorderRadius.circular(20 * scale),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13 * scale),
                        child: Padding(
                          padding: EdgeInsets.all(3 * scale),
                          child: Image.asset(
                            'assets/figma_exports/52ec367639c91dd0186e7c21dba64d8ed1375a47.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person,
                              size: 24 * scale,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(width: 7 * scale),
                    
                    // User Details
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Oddlini',
                              fontSize: 13 * scale,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryText,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'User ID: $userId',
                            style: TextStyle(
                              fontFamily: 'Satoshi',
                              fontSize: 10 * scale,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Theme Toggle Switch
              if (showThemeToggle)
                Obx(() {
                  final themeService = Get.find<ThemeService>();
                  final isDark = themeService.isDarkMode.value;
                  
                  return GestureDetector(
                    onTap: () => themeService.toggleTheme(),
                    child: SizedBox(
                      width: 60 * scale,
                      height: 32 * scale,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Track (recessed background)
                          Container(
                            width: 56 * scale,
                            height: 24 * scale,
                            decoration: BoxDecoration(
                              color: isDark 
                                  ? const Color(0xFF2A2D3E)
                                  : const Color(0xFFE4E7EC),
                              borderRadius: BorderRadius.circular(12 * scale),
                                   border: Border.all(
                                color: isDark
                                    ? const Color(0xFF5B7CE6)
                                    : const Color(0xFFFF9500),
                                width: 1,
                              ),
                              boxShadow: [
                                // Inner shadow effect (top-left)
                                BoxShadow(
                                  color: isDark
                                      ? const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3)
                                      : Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(-2, -0),
                                  spreadRadius: -1,
                                ),
                                // Inner shadow effect (bottom-right)
                                BoxShadow(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.white.withOpacity(0.7),
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                  spreadRadius: -2,
                                ),
                           
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6 * scale),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Sun icon (shown when dark mode is active)
                                  Icon(
                                    Icons.light_mode_outlined,
                                    size: 12 * scale,
                                    color: isDark
                                        ? Colors.grey.shade600
                                        : Colors.transparent,
                                  ),
                                  // Moon icon (shown when light mode is active)
                                  Icon(
                                    Icons.dark_mode_outlined,
                                    size: 12 * scale,
                                    color: !isDark
                                        ? Colors.grey.shade500
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          // Animated Thumb (larger button)
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            left: isDark ? 32 * scale : 0,
                            child: Container(
                              width: 28 * scale,
                              height: 28 * scale,
                              decoration: BoxDecoration(
                                color: isDark 
                                    ? const Color(0xFF5B7CE6)
                                    : const Color(0xFFFF9500),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                  BoxShadow(
                                    color: isDark
                                        ? const Color(0xFF5B7CE6).withOpacity(0.3)
                                        : const Color(0xFFFF9500).withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                                    key: ValueKey<bool>(isDark),
                                    size: 16 * scale,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ],
          ),
        );
      },
    );
  }
}

