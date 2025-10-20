import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/profile_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: Get.height - Get.mediaQuery.padding.top - Get.mediaQuery.padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.all(Responsive.md),
                  child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                _buildHeader(),
                SizedBox(height: Responsive.lgVertical),
                // Title
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(16),
                    fontWeight: FontWeight.w600,
                    color: AppColors.textWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Responsive.lgVertical),
                // Profile Info Card
                _buildProfileCard(),
                SizedBox(height: Responsive.lgVertical),
                // Information Section
                _buildInformationSection(),
                SizedBox(height: Responsive.lgVertical),
                // Preferences Section
                _buildPreferencesSection(),
              ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Obx(() => Text(
                      controller.user.value?.name ?? 'User',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                      ),
                    )),
                Obx(() => Text(
                      'User ID: ${controller.user.value?.userId ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(12),
                        color: AppColors.textGrey,
                      ),
                    )),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            color: AppColors.textWhite,
            size: Responsive.iconSize,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.all(Responsive.lg),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(Responsive.radiusLg),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.sp(97),
            height: Responsive.sp(97),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(Responsive.radiusMd),
            ),
            child: Icon(
              Icons.person,
              size: Responsive.sp(50),
              color: Colors.white,
            ),
          ),
          SizedBox(width: Responsive.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.wallet,
                      color: AppColors.warning,
                      size: Responsive.iconSizeSm,
                    ),
                    SizedBox(width: Responsive.sm),
                    Obx(() => Text(
                          controller.user.value?.balance.toStringAsFixed(0) ?? '0',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(16),
                            fontWeight: FontWeight.bold,
                            color: AppColors.textWhite,
                          ),
                        )),
                  ],
                ),
                Text(
                  'Balance',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(12),
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: Responsive.mdVertical),
                Obx(() => Text(
                      controller.user.value?.name ?? 'User Name',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                      ),
                    )),
                Obx(() => Text(
                      'User ID: ${controller.user.value?.userId ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(12),
                        color: AppColors.textGrey,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations:',
          style: TextStyle(
            fontSize: Responsive.fontSize(14),
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
        SizedBox(height: Responsive.mdVertical),
        _buildInfoItem(FontAwesomeIcons.envelope, 'Email:', controller.user.value?.email ?? 'N/A'),
        _buildInfoItem(FontAwesomeIcons.phone, 'Phone:', '0131976411'),
        _buildInfoItem(FontAwesomeIcons.moneyBillTransfer, 'Total Withdraw:', '23,322 BDT'),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Responsive.mdVertical),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          FaIcon(
            icon,
            color: AppColors.primary,
            size: Responsive.iconSizeSm,
          ),
          SizedBox(width: Responsive.md),
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.fontSize(14),
              color: AppColors.textGrey,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.fontSize(14),
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preference:',
          style: TextStyle(
            fontSize: Responsive.fontSize(14),
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
        ),
        SizedBox(height: Responsive.mdVertical),
        _buildPreferenceItem(FontAwesomeIcons.globe, 'Language:', 'EN'),
        _buildPreferenceItem(FontAwesomeIcons.palette, 'Theme:', 'Default'),
      ],
    );
  }

  Widget _buildPreferenceItem(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Responsive.mdVertical),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          FaIcon(
            icon,
            color: AppColors.primary,
            size: Responsive.iconSizeSm,
          ),
          SizedBox(width: Responsive.md),
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.fontSize(14),
              color: AppColors.textGrey,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.fontSize(14),
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }
}
