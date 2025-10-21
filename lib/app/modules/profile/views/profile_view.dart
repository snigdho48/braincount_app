import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/theme/app_colors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = Responsive.scale;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Header
                
                SizedBox(height: 6 * scale),
                
                // Back Button & Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  child: Row(
                    children: [
                      // GestureDetector(
                      //   onTap: () => Get.back(),
                      //   child: Container(
                      //     padding: EdgeInsets.all(8 * scale),
                      //     child: Icon(
                      //       Icons.arrow_back_ios,
                      //       size: 18 * scale,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontFamily: 'Oddlini',
                            fontSize: 20 * scale,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // SizedBox(width: 34 * scale), // Balance back button
                    ],
                  ),
                ),
                
                SizedBox(height: 48 * scale),
                
                // Main Content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Card
                      _buildProfileCard(scale),
                      
                      SizedBox(height: 20 * scale),
                      
                      // Information Section
                      _buildInformationSection(scale),
                      
                      SizedBox(height: 20 * scale),
                      
                      // Preferences Section
                      _buildPreferencesSection(scale),
                      
                      SizedBox(height: 30 * scale),
                      
                      // Logout Button
                      _buildLogoutButton(scale),
                      
                      SizedBox(height: 100 * scale), // Bottom padding for nav
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildLogoutButton(double scale) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: GestureDetector(
        onTap: controller.navigateToLogin,
        child: Container(
          width: double.infinity,
          height: 50 * scale,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF4B4B),
                Color(0xFFE63946),
              ],
            ),
            borderRadius: BorderRadius.circular(11 * scale),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE63946).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                size: 20 * scale,
                color: Colors.white,
              ),
              SizedBox(width: 10 * scale),
              Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Oddlini',
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(double scale) {
    final isDark = controller.isDarkMode;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 361 * scale,
      height: 149 * scale,
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 26 * scale),
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 127, 80, 163),
                  Color(0xFF7B1BAB),
                  Color.fromARGB(255, 157, 43, 245),
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  AppColors.primary.withOpacity(0.08),
                  AppColors.primary.withOpacity(0.12),
                ],
              ),
        borderRadius: BorderRadius.circular(20 * scale),
        border: isDark
            ? null
            : Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 1.5,
              ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Avatar
          Container(
            width: 106 * scale,
            height: 97 * scale,
            padding: EdgeInsets.all(5 * scale),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFFE0B8FF)
                  : AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(13 * scale),
              border: isDark
                  ? null
                  : Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 2,
                    ),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13 * scale),
                  child: Image.asset(
                    'assets/figma_exports/52ec367639c91dd0186e7c21dba64d8ed1375a47.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: isDark
                          ? const Color(0xFFE0B8FF)
                          : AppColors.primary.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: 50 * scale,
                        color: isDark ? Colors.white : AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5 * scale,
                  right: 5 * scale,
                  child: Container(
                    width: 22 * scale,
                    height: 22 * scale,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : AppColors.primary,
                      shape: BoxShape.circle,
                      border: isDark
                          ? null
                          : Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                      boxShadow: isDark
                          ? null
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 14 * scale,
                      color: isDark ? const Color(0xFF5B099B) : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // User Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Balance
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/figma_exports/52a872e8cda9ffb4d0024f72bc025103b71aefd9.png',
                    width: 27 * scale,
                    height: 27 * scale,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.currency_bitcoin,
                      size: 27 * scale,
                      color: const Color(0xFFFFBB27),
                    ),
                  ),
                  SizedBox(width: 4 * scale),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                        controller.user.value?.balance.toStringAsFixed(0) ?? '2,387',
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                      )),
                      Text(
                        'Balance',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10 * scale,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? const Color(0xFFDEA5FF)
                              : AppColors.primary.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Name and ID
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() => Text(
                    (controller.user.value?.name ?? 'NAFSIN RAHMAN').toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Oddlini',
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(height: 2 * scale),
                  Obx(() => Text(
                    'User ID: ${controller.user.value?.userId ?? '34874'}',
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 11 * scale,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                    textAlign: TextAlign.right,
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection(double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations:',
          style: TextStyle(
            fontFamily: 'Satoshi',
            fontSize: 13 * scale,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF7B7B7B),
          ),
        ),
        SizedBox(height: 5 * scale),
        
        // All three rows grouped together as one container
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(11 * scale),
          ),
          child: Column(
            children: [
              // Email Row
              Container(
                padding: EdgeInsets.symmetric(horizontal: 39 * scale, vertical: 23 * scale),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.divider,
                      width: Responsive.sp(3.05),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/figma_exports/388e9002c3b03627b8d59a100889100bb11d532e.png',
                      width: 20 * scale,
                      height: 20 * scale,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.email,
                        size: 20 * scale,
                        color: AppColors.primaryText,
                      ),
                    ),
                    SizedBox(width: 18 * scale),
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText,
                        letterSpacing: 0.32 * scale,
                      ),
                    ),
                    SizedBox(width: 42 * scale),
                    Expanded(
                      child: Obx(() => Text(
                        textAlign: TextAlign.end,
                        controller.user.value?.email ?? '3rfwehe@gmail.com',
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryText,
                          letterSpacing: 0.32 * scale,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )),
                    ),
                  ],
                ),
              ),
              
              // Phone Row
              Container(
                padding: EdgeInsets.symmetric(horizontal: 37 * scale, vertical: 21 * scale),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.divider,
                      width: Responsive.sp(3),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/figma_exports/5ebda7c46aa25670e261fe423176ad470bfc21fc.png',
                      width: 24 * scale,
                      height: 24 * scale,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.phone,
                        size: 24 * scale,
                        color: AppColors.primaryText,
                      ),
                    ),
                    SizedBox(width: 16 * scale),
                    Text(
                      'Phone:',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText,
                        letterSpacing: 0.32 * scale,
                      ),
                    ),
                    SizedBox(width: 97 * scale),
                    Text(
                      '0131976411',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryText,
                        letterSpacing: 0.32 * scale,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Total Withdraw Row
            //   Container(
            //     height: 67 * scale,
            //     padding: EdgeInsets.symmetric(horizontal: 35 * scale, vertical: 19 * scale),
            //     child: Row(
            //       children: [
            //         Image.asset(
            //           'assets/figma_exports/c33c2922af6e3138ba83c64c20e4f805a0c07d4a.png',
            //           width: 26 * scale,
            //           height: 26 * scale,
            //           errorBuilder: (context, error, stackTrace) => Icon(
            //             Icons.account_balance_wallet,
            //             size: 26 * scale,
            //             color: Colors.white,
            //           ),
            //         ),
            //         SizedBox(width: 16 * scale),
            //         Text(
            //           'Total Withdraw:',
            //           style: TextStyle(
            //             fontFamily: 'Helvetica',
            //             fontSize: 16 * scale,
            //             fontWeight: FontWeight.w400,
            //             color: Colors.white,
            //             letterSpacing: 0.32 * scale,
            //           ),
            //         ),
            //         SizedBox(width: 39 * scale),
            //         Text(
            //           '23,322 BDT',
            //           style: TextStyle(
            //             fontFamily: 'Helvetica',
            //             fontSize: 16 * scale,
            //             fontWeight: FontWeight.w400,
            //             color: const Color(0xFF888787),
            //             letterSpacing: 0.32 * scale,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // 
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesSection(double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preference:',
          style: TextStyle(
            fontFamily: 'Satoshi',
            fontSize: 13 * scale,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF7B7B7B),
          ),
        ),
        SizedBox(height: 6 * scale),
        
        // Both rows grouped together as one container
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(11 * scale),
          ),
          child: Column(
            children: [
              // Language Row
              Container(
             
                padding: EdgeInsets.symmetric(horizontal: 39 * scale, vertical: 22 * scale),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.divider,
                      width: Responsive.sp(3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/figma_exports/e625ba0757712e63f8dea7328c4031b13cb43b91.png',
                          width: 22 * scale,
                          height: 22 * scale,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.language,
                            size: 22 * scale,
                            color: AppColors.primaryText,
                          ),
                        ),
                        SizedBox(width: 16 * scale),
                        Text(
                          'Language:',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryText,
                            letterSpacing: 0.32 * scale,
                          ),
                        ),
                      ],
                    ),
              GestureDetector(
                onTap: () => _showLanguageSelector(scale),
                child: Container(
                
                  padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                  decoration: BoxDecoration(
                    color: controller.isDarkMode ? AppColors.tertiaryBackground : AppColors.shadowColor,
                    borderRadius: BorderRadius.circular(24 * scale),
                    border: Border.all(
                      color: controller.isDarkMode ? AppColors.divider : AppColors.divider,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => Text(
                        controller.selectedLanguage.value,
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryText,
                          letterSpacing: 0.24 * scale,
                        ),
                      )),
                      SizedBox(width: 5 * scale),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 16 * scale,
                        color: AppColors.secondaryText,
                      ),
                    ],
                  ),
                ),
              ),
                  ],
                ),
              ),
              
              // Theme Row
              GestureDetector(
                onTap: () => _showThemeSelector(scale),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 39 * scale, vertical: 20 * scale),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/figma_exports/37e5b09f05424b21df5d9d6c983e73dff12561ea.png',
                            width: 26 * scale,
                            height: 26 * scale,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.palette,
                              size: 26 * scale,
                              color: AppColors.primaryText,
                            ),
                          ),
                          SizedBox(width: 12 * scale),
                          Text(
                            'Theme:',
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryText,
                              letterSpacing: 0.32 * scale,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                        decoration: BoxDecoration(
                          color: controller.isDarkMode
                              ? AppColors.tertiaryBackground
                              : AppColors.shadowColor,
                          borderRadius: BorderRadius.circular(24 * scale),
                          border: Border.all(
                            color: controller.isDarkMode ? AppColors.divider : AppColors.divider,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() => Text(
                              controller.isDarkMode ? 'Dark' : 'Light',
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryText,
                                letterSpacing: 0.32 * scale,
                              ),
                            )),
                            SizedBox(width: 5 * scale),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 16 * scale,
                              color: AppColors.secondaryText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLanguageSelector(double scale) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20 * scale),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12 * scale),
              width: 40 * scale,
              height: 4 * scale,
              decoration: BoxDecoration(
                color: AppColors.secondaryText,
                borderRadius: BorderRadius.circular(2 * scale),
              ),
            ),
            
            // Title
            Padding(
              padding: EdgeInsets.all(20 * scale),
              child: Text(
                'Select Language',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
            ),
            
            // Language options
            ...controller.availableLanguages.map((language) {
              return Obx(() {
                final isSelected = controller.selectedLanguage.value == language;
                return InkWell(
                  onTap: () {
                    controller.changeLanguage(language);
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * scale,
                      vertical: 16 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.divider,
                          width: Responsive.sp(3),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          language == 'EN' ? 'English' : 'বাংলা',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w400,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.secondaryText,
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: 20 * scale,
                          ),
                      ],
                    ),
                  ),
                );
              });
            }).toList(),
            
            SizedBox(height: 20 * scale),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  void _showThemeSelector(double scale) {
    final themes = [
      {'name': 'Dark', 'value': true, 'icon': Icons.dark_mode},
      {'name': 'Light', 'value': false, 'icon': Icons.light_mode},
    ];

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20 * scale),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12 * scale),
              width: 40 * scale,
              height: 4 * scale,
              decoration: BoxDecoration(
                color: AppColors.secondaryText,
                borderRadius: BorderRadius.circular(2 * scale),
              ),
            ),
            
            // Title
            Padding(
              padding: EdgeInsets.all(20 * scale),
              child: Text(
                'Select Theme',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
            ),
            
            // Theme options
            ...themes.map((theme) {
              return Obx(() {
                final isSelected = controller.isDarkMode == theme['value'];
                return InkWell(
                  onTap: () {
                    controller.toggleTheme();
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * scale,
                      vertical: 16 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.divider,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              theme['icon'] as IconData,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.secondaryText,
                              size: 24 * scale,
                            ),
                            SizedBox(width: 16 * scale),
                            Text(
                              theme['name'] as String,
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.w400,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: 20 * scale,
                          ),
                      ],
                    ),
                  ),
                );
              });
            }).toList(),
            
            SizedBox(height: 20 * scale),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }
}
