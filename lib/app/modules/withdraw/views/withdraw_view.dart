import 'package:braincount/app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/withdraw_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/user_header.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/services/theme_service.dart';

class WithdrawView extends GetView<WithdrawController> {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = Responsive.scaleWidth(393.0);

    return Scaffold(
      floatingActionButton: Obx(() => controller.hasSelectedAccount
          ? _buildWithdrawButton(scale, context)
          : const SizedBox.shrink()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              const SizedBox.shrink(),
             // UserHeader(scale: scale),
              
              SizedBox(height: 16 * scale),
              
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
                        'Select Method',
                        style: TextStyle(
                          fontFamily: 'Oddlini',
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 36 * scale), // Balance back button width
                  ],
                ),
              ),
              
              SizedBox(height: 24 * scale),
              
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bank Section
                        // Text(
                        //   'Bank:',
                        //   style: TextStyle(
                        //     fontFamily: 'Satoshi',
                        //     fontSize: 13 * scale,
                        //     fontWeight: FontWeight.w500,
                        //     color: const Color(0xFF7B7B7B),
                        //   ),
                        // ),
                        
                        // SizedBox(height: 14 * scale),
                        
                        // // Dynamic Bank Cards
                        // Obx(() => Column(
                        //   children: controller.bankAccounts.map((account) {
                        //     final isSelected = controller.selectedBankAccount.value?.id == account.id;
                        //     return Padding(
                        //       padding: EdgeInsets.only(bottom: 8 * scale),
                        //       child: _buildBankCard(
                        //         bankName: account.bankName,
                        //         accountNumber: account.maskedNumber,
                        //         iconPath: 'assets/figma_exports/342b1751ba1e7c7b04bc21f79d69a779d258f449.png',
                        //         scale: scale,
                        //         isSelected: isSelected,
                        //         onTap: () => controller.selectBankAccount(account),
                        //         onDelete: () => controller.removeBankAccount(account.id),
                        //       ),
                        //     );
                        //   }).toList(),
                        // )),
                        
                        // // Add New Bank Button
                        // _buildAddButton(
                        //   title: 'Add new bank',
                        //   subtitle: 'Your information is secured with advanced encryption technology.',
                        //   iconPath: 'assets/figma_exports/7ea6ec867a81175fb3ce624afc494eef23e79f63.svg',
                        //   scale: scale,
                        //   routeName: AppRoutes.addNewBank, // Navigate to bank form
                        // ),
                        
                        // SizedBox(height: 30 * scale),
                        
                        // Mobile Banking Section
                        Text(
                          'Mobile Banking',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 13 * scale,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryText,
                          ),
                        ),
                        
                        SizedBox(height: 14 * scale),
                        
                        // Dynamic Mobile Banking Cards
                        Obx(() => Column(
                          children: controller.mobileBankingAccounts.map((account) {
                            final isSelected = controller.selectedMobileBanking.value?.id == account.id;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8 * scale),
                              child: _buildBankCard(
                                bankName: account.provider,
                                accountNumber: account.maskedNumber,
                                iconPath: account.logoPath,
                                scale: scale,
                                isSelected: isSelected,
                                onTap: () => controller.selectMobileBanking(account),
                                onDelete: () => controller.removeMobileBanking(account.id),
                              ),
                            );
                          }).toList(),
                        )),
                        
                        // Add Mobile Banking Button
                        _buildAddButton(
                          title: 'Add Mobile Banking',
                          subtitle: 'Your information is secured with advanced encryption technology.',
                          iconPath: 'assets/figma_exports/e977960102b436ee5a735069067af54ab2328cd3.svg',
                          scale: scale,
                          mobileIcon: true,
                          routeName: AppRoutes.addBank, // Navigate to mobile banking form
                        ),
                        
                        SizedBox(height: 100 * scale), // Bottom spacing
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  

  Widget _buildBankCard({
    required String bankName,
    required String accountNumber,
    required String iconPath,
    required double scale,
    bool isSelected = false,
    VoidCallback? onTap,
    VoidCallback? onDelete,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 360 * scale,
        padding: EdgeInsets.all(12 * scale),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(11 * scale),
          border: isSelected
              ? Border.all(color: AppColors.info, width: 2)
              : Border.all(color: AppColors.border.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
        children: [
          // Bank Icon
          SizedBox(
            width: 40 * scale,
            height: 40 * scale,
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.account_balance,
                size: 24 * scale,
                color: AppColors.primaryText,
              ),
            ),
          ),
          SizedBox(width: 16 * scale),
          // Bank Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bankName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                ),
                SizedBox(height: 2 * scale),
                Text(
                  accountNumber,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          // Remove Button
          if (onDelete != null)
            GestureDetector(
              onTap: onDelete,
              child: Text(
                'Remove',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.w500,
                  color: AppColors.info,
                  letterSpacing: 0.14 * scale,
                ),
              ),
            ),
        ],
      ),
      ),
    );
  }

  Widget _buildWithdrawButton(double scale, BuildContext context) {
    return Container(
      width: 216 * scale,
      height: 45 * scale,
      margin: EdgeInsets.only(bottom: 20 * scale),
      child: ElevatedButton(
        onPressed: () => _showWithdrawModal(context, scale),
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
              'Withdraw',
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
    );
  }

  void _showWithdrawModal(BuildContext context, double scale) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildWithdrawModalContent(scale),
    );
  }

  Widget _buildWithdrawModalContent(double scale) {
    final screenHeight = Get.height;
    final modalHeight = screenHeight * 0.75;
    
    return Container(
      height: modalHeight,
      padding: EdgeInsets.only(
        bottom: Get.mediaQuery.viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25 * scale),
          topRight: Radius.circular(25 * scale),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24 * scale),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Close Button
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    'Withdraw Money',
                    style: TextStyle(
                      fontFamily: 'Oddlini',
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(4 * scale),
                      child: Icon(
                        Icons.close,
                        size: 24 * scale,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 24 * scale),
            
            // Selected Method Card
            Obx(() => Container(
              width: double.infinity,
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(11 * scale),
                border: Border.all(
                  color: AppColors.info,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  // Logo/Icon
                  SizedBox(
                    width: 40 * scale,
                    height: 40 * scale,
                    child: controller.selectedAccountLogo.isNotEmpty
                        ? Image.asset(
                            controller.selectedAccountLogo,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.account_balance,
                              size: 32 * scale,
                              color: AppColors.info,
                            ),
                          )
                        : Icon(
                            Icons.account_balance,
                            size: 32 * scale,
                            color: AppColors.info,
                          ),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.selectedAccountName,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryText,
                          ),
                        ),
                        SizedBox(height: 4 * scale),
                        Text(
                          controller.selectedAccountNumber,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            
            SizedBox(height: 24 * scale),
            
            // Amount Label
            Text(
              'Amount',
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryText,
              ),
            ),
            
            SizedBox(height: 8 * scale),
            
            // Amount Input
            Obx(() {
              final hasError = controller.amountError.value.isNotEmpty;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(8 * scale),
                      border: Border.all(
                        color: hasError ? AppColors.error : AppColors.border.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: controller.amountController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => controller.updateAmount(value),
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryText,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        hintStyle: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryText,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        suffixText: 'BDT',
                        suffixStyle: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                  ),
                  if (hasError)
                    Padding(
                      padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
                      child: Text(
                        controller.amountError.value,
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.w400,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                ],
              );
            }),
            
            SizedBox(height: 12 * scale),
            
            // Available Balance
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Balance:',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w400,
                    color: AppColors.success,
                  ),
                ),
                Text(
                  '${controller.availableBalance.value.toStringAsFixed(0)} BDT',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 13 * scale,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            )),
            
            SizedBox(height: 32 * scale),
            
            // Withdraw Now Button
            Expanded(
              child: Center(
                child: Obx(() => SizedBox(
                  width: 216 * scale,
                  height: 45 * scale,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.submitWithdrawal(),
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
                        child: controller.isLoading.value
                            ? SizedBox(
                                width: 20 * scale,
                                height: 20 * scale,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Withdraw Now',
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
                )),
              ),
            ),
            
            SizedBox(height: 16 * scale),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton({
    required String title,
    required String subtitle,
    required String iconPath,
    required double scale,
    bool mobileIcon = false,
    String? routeName,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to appropriate add page
        if (routeName != null) {
          Get.toNamed(routeName);
        }
      },
      child: Container(
        width: 360 * scale,
        height: 92 * scale,
        padding: EdgeInsets.symmetric(horizontal: 13 * scale),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(11 * scale),
          border: Border.all(
            color: AppColors.border.withOpacity(0.4),
            width: 1,
          ),
        ),
        child: Row(
        children: [
          // Icon
          SizedBox(
            width: 42 * scale,
            height: 42 * scale,
            child: mobileIcon
                ? Stack(
                    children: [
                      // Circle background
                      Image.asset(
                        iconPath,
                        width: 42 * scale,
                        height: 42 * scale,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 42 * scale,
                          height: 42 * scale,
                          decoration: const BoxDecoration(
                            color: Color(0xFF393838),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.phone_android,
                            size: 24 * scale,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                      // Mobile icon overlay
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
                  )
                : Image.asset(
                    iconPath,
                    width: 42 * scale,
                    height: 42 * scale,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.add_circle_outline,
                      size: 42 * scale,
                      color: AppColors.primaryText,
                    ),
                  ),
          ),
          SizedBox(width: 14 * scale),
          // Text
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Oddlini',
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                  ),
                ),
                SizedBox(height: 2 * scale),
                Text(
                  subtitle,
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
    );
  }
}
