import 'package:braincount/app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/withdraw_controller.dart';
import '../../../core/theme/app_colors.dart';

class AddBankView extends GetView<WithdrawController> {
  const AddBankView({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = Responsive.scaleWidth(393.0);

    return Scaffold(
      body: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // User Header
              //UserHeader(scale: scale),
              
              SizedBox(height: 6 * scale),
              
              // Back Button & Title Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(8 * scale),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20 * scale,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontFamily: 'Oddlini',
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 36 * scale),
                  ],
                ),
              ),
              
              SizedBox(height: 19 * scale),
              
              // Icon Section (Mobile Banking icon for now)
              Container(
                width: 361 * scale,
                height: 92 * scale,
                padding: EdgeInsets.symmetric(horizontal: 13 * scale),
                child: Row(
                  children: [
                    // Icon
                    SizedBox(
                      width: 42 * scale,
                      height: 42 * scale,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/figma_exports/e977960102b436ee5a735069067af54ab2328cd3.svg',
                            width: 42 * scale,
                            height: 42 * scale,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 42 * scale,
                              height: 42 * scale,
                              decoration: const BoxDecoration(
                                color: Color(0xFF393838),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              'assets/figma_exports/97b8a17d2721a42db0189b619ed83a991d2db005.svg',
                              width: 23 * scale,
                              height: 23 * scale,
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.phone_android,
                                size: 20 * scale,
                                color: AppColors.primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 19 * scale),
                    // Text
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Mobile Banking',
                            style: TextStyle(
                              fontFamily: 'Oddlini',
                              fontSize: 20 * scale,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryText,
                            ),
                          ),
                          SizedBox(height: 2 * scale),
                          Text(
                            'Your information is secured with advanced encryption technology.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11 * scale,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryText,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 17 * scale),
              
              // Form Fields
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.5 * scale),
                    child: Column(
                      children: [
                        // MFS Type Selector
                        _buildMfsTypeSelector(scale),
                        
                        SizedBox(height: 17 * scale),
                        
                        // Mobile Number Field
                        _buildTextField(
                          label: 'Mobile Number',
                          hintText: '4966 34567 765',
                          iconPath: 'assets/figma_exports/e7adfe8da9134c438a4300fef8ba51fb28c9c6e7.svg',
                          keyboardType: TextInputType.phone,
                          scale: scale,
                          controller: controller.bkashNumberController,
                        ),
                        
                        SizedBox(height: 17 * scale),
                        
                        // Full Name Field
                        _buildTextField(
                          label: 'Full name',
                          hintText: 'Nafsin Rahman',
                          iconPath: 'assets/figma_exports/1020d6133de744c75ccb941e05831d23a26710cb.svg',
                          keyboardType: TextInputType.name,
                          scale: scale,
                          controller: controller.fullNameController,
                        ),
                        
                        SizedBox(height: 100 * scale),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
      // Add Button (floating at bottom)
      floatingActionButton: Container(
        width: 216 * scale,
        height: 45 * scale,
        margin: EdgeInsets.only(bottom: 20 * scale),
        child: ElevatedButton(
          onPressed: () {
            // Handle add action
            controller.addMobileBanking();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22 * scale),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22 * scale),
              gradient: const RadialGradient(
                center: Alignment(-0.126, -2.234),
                radius: 1.5,
                colors: [
                  Color(0xEB58A3D8),
                  Color(0xE78C98EC),
                  Color(0xE3C08EFF),
                ],
                stops: [0.242, 0.545, 0.849],
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Add',
                style: TextStyle(
                  fontFamily: 'Oddlini',
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.32 * scale,
                  height: 1.25,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  

  Widget _buildTextField({
    required String label,
    required String hintText,
    required String iconPath,
    required TextInputType keyboardType,
    required double scale,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with gradient (purple)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13 * scale, vertical: 2 * scale),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xFF5B099B),
                Color(0xFF5B099B),
              ],
            ).createShader(bounds),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 10 * scale,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        SizedBox(height: 1 * scale),
        
        // Text Field
        Container(
          height: 41 * scale,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(8 * scale),
            border: Border.all(
              color: AppColors.border.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 29 * scale),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryText,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 15 * scale,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12 * scale),
                child: Icon(
                  _getIconForPath(iconPath),
                  size: 19 * scale,
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getIconForPath(String iconPath) {
    if (iconPath.contains('e7adfe8da9134c438a4300fef8ba51fb28c9c6e7')) {
      return Icons.credit_card; // Card icon for Bkash Number
    } else if (iconPath.contains('1020d6133de744c75ccb941e05831d23a26710cb')) {
      return Icons.person_outline; // Person icon for Full Name and Amount
    }
    return Icons.edit; // Fallback
  }

  Widget _buildMfsTypeSelector(double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13 * scale, vertical: 2 * scale),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF5B099B), Color(0xFF5B099B)],
            ).createShader(bounds),
            child: Text(
              'MFS Type',
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 10 * scale,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        SizedBox(height: 1 * scale),
        
        // Dropdown
        Container(
          height: 41 * scale,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(8 * scale),
            border: Border.all(
              color: AppColors.border.withOpacity(0.2),
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          child: Obx(() => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: controller.selectedMfsType.value,
              isExpanded: true,
              dropdownColor: AppColors.cardBackground,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primaryText,
                size: 24 * scale,
              ),
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 15 * scale,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryText,
              ),
              items: controller.mfsTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectMfsType(newValue);
                }
              },
            ),
          )),
        ),
      ],
    );
  }
}

