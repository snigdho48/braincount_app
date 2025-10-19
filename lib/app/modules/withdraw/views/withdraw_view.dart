import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/withdraw_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class WithdrawView extends GetView<WithdrawController> {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(Responsive.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title
                      Text(
                        'Select Method',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(16),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Responsive.lgVertical),
                      // Bank Section
                      _buildBankSection(),
                      SizedBox(height: Responsive.lgVertical),
                      // Mobile Banking Section
                      _buildMobileBankingSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.md,
        vertical: Responsive.smVertical,
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: Responsive.sp(40),
                height: Responsive.sp(40),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(Responsive.radiusSm),
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: Responsive.iconSize,
                ),
              ),
              SizedBox(width: Responsive.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NAFSIN RAHMAN',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(14),
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                  Text(
                    'User ID: 34874',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(12),
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: AppColors.textWhite,
              size: Responsive.iconSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank:',
          style: TextStyle(
            fontSize: Responsive.fontSize(14),
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
        SizedBox(height: Responsive.mdVertical),
        _buildBankCard('Bank Name', 'Account: **** 1234', true),
        SizedBox(height: Responsive.smVertical),
        _buildBankCard('Bank Name 2', 'Account: **** 5678', false),
        SizedBox(height: Responsive.mdVertical),
        _buildAddNewCard('Add new bank', FontAwesomeIcons.building),
      ],
    );
  }

  Widget _buildBankCard(String bankName, String account, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(Responsive.md),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(Responsive.radiusMd),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.borderColor,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.sp(40),
            height: Responsive.sp(32),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(Responsive.radiusSm),
            ),
            child: FaIcon(
              FontAwesomeIcons.building,
              color: AppColors.primary,
              size: Responsive.iconSizeSm,
            ),
          ),
          SizedBox(width: Responsive.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bankName,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(14),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textWhite,
                  ),
                ),
                Text(
                  account,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(12),
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            FaIcon(
              FontAwesomeIcons.circleCheck,
              color: AppColors.success,
              size: Responsive.iconSizeSm,
            ),
        ],
      ),
    );
  }

  Widget _buildMobileBankingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile Banking',
          style: TextStyle(
            fontSize: Responsive.fontSize(14),
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
        SizedBox(height: Responsive.mdVertical),
        _buildAddNewCard('Add Mobile Banking', FontAwesomeIcons.mobileScreen),
      ],
    );
  }

  Widget _buildAddNewCard(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.all(Responsive.lg),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(Responsive.radiusMd),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.sp(42),
            height: Responsive.sp(42),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              icon,
              color: AppColors.primary,
              size: Responsive.iconSizeSm,
            ),
          ),
          SizedBox(width: Responsive.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(14),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textWhite,
                  ),
                ),
                Text(
                  'Your information is secured with advanced encryption technology.',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(11),
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
