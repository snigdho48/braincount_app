import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../core/utils/responsive.dart';
import '../../../widgets/user_header.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = Responsive.scale;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF232323),
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
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 34 * scale), // Balance back button
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
                      
                      SizedBox(height: 100 * scale), // Bottom padding for nav
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(double scale) {
    return Container(
      width: 361 * scale,
      height: 149 * scale,
      padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 26 * scale),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 127, 80, 163),
                  Color(0xFF7B1BAB),
            Color.fromARGB(255, 157, 43, 245),
      
            
          ],
        ),
      
        borderRadius: BorderRadius.circular(20 * scale),
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
              color: const Color(0xFFE0B8FF),
              borderRadius: BorderRadius.circular(13 * scale),
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
                      color: const Color(0xFFE0B8FF),
                      child: Icon(
                        Icons.person,
                        size: 50 * scale,
                        color: Colors.white,
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
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 14 * scale,
                      color: const Color(0xFF5B099B),
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
                          color: Colors.white,
                        ),
                      )),
                      Text(
                        'Balance',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10 * scale,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFDEA5FF),
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
                      color: Colors.white,
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
                      color: Colors.white,
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
            color: const Color(0xFF393838),
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
                      color: const Color(0xFF232323),
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
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 18 * scale),
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
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
                          color: const Color(0xFF888787),
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
                      color: const Color(0xFF232323),
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
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16 * scale),
                    Text(
                      'Phone:',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
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
                        color: const Color(0xFF888787),
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
            color: const Color(0xFF393838),
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
                      color: const Color(0xFF232323),
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
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 16 * scale),
                        Text(
                          'Language:',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
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
                    color: const Color(0xFF212121),
                    borderRadius: BorderRadius.circular(24 * scale),
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
                          color: const Color(0xFF888787),
                          letterSpacing: 0.24 * scale,
                        ),
                      )),
                      SizedBox(width: 5 * scale),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 16 * scale,
                        color: const Color(0xFF888787),
                      ),
                    ],
                  ),
                ),
              ),
                  ],
                ),
              ),
              
              // Theme Row
              Container(
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
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 12 * scale),
                        Text(
                          'Theme:',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            letterSpacing: 0.32 * scale,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Default',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF888787),
                        letterSpacing: 0.32 * scale,
                      ),
                    ),
                  ],
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
          color: const Color(0xFF393838),
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
                color: const Color(0xFF888787),
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
                  color: Colors.white,
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
                          ? const Color(0xFF85428C).withOpacity(0.2)
                          : Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                          color: const Color(0xFF232323),
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
                                ? const Color(0xFF85428C)
                                : const Color(0xFF888787),
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF85428C),
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
