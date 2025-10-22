import 'package:braincount/app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/withdraw_controller.dart';
import '../../../core/theme/app_colors.dart';

class AddNewBankView extends GetView<WithdrawController> {
  const AddNewBankView({super.key});

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
             // UserHeader(scale: scale),
              
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
              
              // Icon Section (Bank icon)
              Container(
                width: 361 * scale,
                height: 92 * scale,
                padding: EdgeInsets.symmetric(horizontal: 13 * scale),
                child: Row(
                  children: [
                    // Icon
                    Image.asset(
                      'assets/figma_exports/7ea6ec867a81175fb3ce624afc494eef23e79f63.svg',
                      width: 42 * scale,
                      height: 42 * scale,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.account_balance,
                        size: 42 * scale,
                        color: AppColors.primaryText,
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
                            'Add new bank',
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
                    padding: EdgeInsets.symmetric(horizontal: 21.5 * scale),
                    child: Column(
                      children: [
                        // Bank Number Field (inactive - grey)
                        _buildTextField(
                          label: 'Bank Number',
                          hintText: '4966 0000 0000 0000',
                          iconPath: 'assets/figma_exports/5ea78f81295f9cfb7b495d73ce705ea28a3f99ee.svg',
                          keyboardType: TextInputType.number,
                          scale: scale,
                          isActive: false, // Grey label
                          controller: controller.bankNumberController,
                        ),
                        
                        SizedBox(height: 17 * scale),
                        
                        // Branch Name Field (active - purple gradient)
                        _buildTextField(
                          label: 'Branch Name',
                          hintText: 'Niketan',
                          iconPath: 'assets/figma_exports/631490767225ef2b75ec5e3b6d56b3bc83701ba0.svg',
                          keyboardType: TextInputType.text,
                          scale: scale,
                          isActive: true, // Purple gradient label
                          controller: controller.branchNameController,
                        ),
                        
                        SizedBox(height: 17 * scale),
                        
                        // Bank's Name Field (inactive - grey)
                        _buildTextField(
                          label: "Bank' Name",
                          hintText: 'Enter full name',
                          iconPath: 'assets/figma_exports/8b04a3f5e1e164e6388f8a8bea63f4f2f8189c6e.svg',
                          keyboardType: TextInputType.name,
                          scale: scale,
                          isActive: false, // Grey label
                          controller: controller.bankNameController,
                        ),
                        
                        SizedBox(height: 17 * scale),
                        
                        // Routing Number Field (inactive - grey)
                        _buildTextField(
                          label: 'Routing Number',
                          hintText: 'Enter Routing number',
                          iconPath: 'assets/figma_exports/8b04a3f5e1e164e6388f8a8bea63f4f2f8189c6e.svg',
                          keyboardType: TextInputType.number,
                          scale: scale,
                          isActive: false, // Grey label
                          controller: controller.routingNumberController,
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
            controller.addBankAccount();
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
    required bool isActive, // true = purple gradient, false = grey
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label (purple gradient or grey)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13 * scale, vertical: 2 * scale),
          child: isActive
              ? ShaderMask(
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
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 10 * scale,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText.withOpacity(0.7),
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
            border: isActive
                ? Border.all(color: AppColors.border.withOpacity(0.5), width: 1)
                : Border.all(color: AppColors.border.withOpacity(0.2), width: 1),
          ),
          child: Row(
            children: [
              SizedBox(width: 29 * scale),
              Expanded(
                child: TextField(
                  keyboardType: keyboardType,
                  controller: controller,
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
    if (iconPath.contains('5ea78f81295f9cfb7b495d73ce705ea28a3f99ee')) {
      return Icons.credit_card; // Card icon for Bank Number
    } else if (iconPath.contains('631490767225ef2b75ec5e3b6d56b3bc83701ba0')) {
      return Icons.account_balance; // Bank icon for Branch Name
    } else if (iconPath.contains('8b04a3f5e1e164e6388f8a8bea63f4f2f8189c6e')) {
      return Icons.person_outline; // Person icon for Bank Name and Routing Number
    }
    return Icons.edit; // Fallback
  }
}

