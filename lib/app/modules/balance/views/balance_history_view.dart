import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/balance_history_controller.dart';
import '../../../core/theme/app_colors.dart';

class BalanceHistoryView extends GetView<BalanceHistoryController> {
  const BalanceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Base design width from Figma (393px)
    final baseWidth = 393.0;
    
    // Scale factor for responsive design
    final scale = screenWidth / baseWidth;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF232323), // Exact Figma background color
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              child: Stack(
                children: [
                  // Top Background Container (at top: 0)
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 393 * scale,
                      height: 382 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFF393838),
                        borderRadius: BorderRadius.circular(25 * scale),
                      ),
                    ),
                  ),
              
              // User Header (top: 49px, left: 28px)
              Positioned(
                left: 28 * scale,
                top: 49 * scale,
                child: _buildUserHeader(scale),
              ),
              
              // Back Button (left: 36px, top: 123px)
              Positioned(
                left: 36 * scale,
                top: 123 * scale,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Transform.rotate(
                    angle: 271.416 * 3.14159 / 180,
                    child: Transform.scale(
                      scaleY: -1,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 15.8 * scale,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              
              // "Withdraw" Title (left: calc(50%-50.5px), top: 124px)
              Positioned(
                left: (screenWidth / 2) - (50.5 * scale),
                top: 124 * scale,
                child: SizedBox(
                  width: 100 * scale,
                  child: Text(
                    'Withdraw',
                    style: TextStyle(
                      fontFamily: 'Oddlini',
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              // Balance Title (left: 110px, top: 109px)
              Positioned(
                left: 110 * scale,
                top: 109 * scale,
                child: SizedBox(
                  width: 172 * scale,
                  child: Column(
                    children: [
                      Text(
                        'Balance History',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Oddlini',
                          fontSize: 20 * scale,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Total withdrawal amount',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 16 * scale,
                          color: const Color(0xFF888787),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // 3D Coin (left: 144px, top: 173px)
              Positioned(
                left: 144 * scale,
                top: 173 * scale,
                child: Image.asset(
                  'assets/figma_exports/f95735da83252e978fe0c91533b59558cce94027.png',
                  width: 113 * scale,
                  height: 113 * scale,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.account_balance_wallet,
                    size: 80 * scale,
                    color: Colors.amber,
                  ),
                ),
              ),
              
              // Balance Amount (left: 61px, top: 301px)
              Positioned(
                left: 61 * scale,
                top: 301 * scale,
                child: Obx(() => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${controller.totalWithdrawn.value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: TextStyle(
                          fontFamily: 'Oddlini',
                          fontSize: 48 * scale,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFBB27),
                        ),
                      ),
                      TextSpan(
                        text: ' BDT',
                        style: TextStyle(
                          fontFamily: 'Oddlini',
                          fontSize: 48 * scale,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )),
              ),
              
              // History Title (left: 67px, top: 402px with translate-x-[-50%])
              Positioned(
                left: 67 * scale,
                top: 402 * scale,
                child: Transform.translate(
                  offset: Offset(-67 * scale * 0.5, 0),
                  child: Text(
                    'History:',
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                      fontSize: 13 * scale,
                      color: const Color(0xFF7B7B7B),
                    ),
                  ),
                ),
              ),
              
              // Stats Section (left: 16px, top: 429px)
              Positioned(
                left: 16 * scale,
                top: 429 * scale,
                child: _buildStatsSection(scale),
              ),
              
              // Withdraw History Title (left: 97px, top: 752px with translate-x-[-50%])
              Positioned(
                left: 97 * scale,
                top: 752 * scale,
                child: Transform.translate(
                  offset: Offset(-97 * scale * 0.5, 0),
                  child: Text(
                    'Withdraw History:',
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                      fontSize: 13 * scale,
                      color: const Color(0xFF7B7B7B),
                    ),
                  ),
                ),
              ),
              
              // Withdraw History List (left: calc(50%-0.5px), top: 786px)
              Positioned(
                left: (screenWidth / 2) - (0.5 * scale),
                top: 786 * scale,
                child: Transform.translate(
                  offset: Offset(-180 * scale, 0), // Center 360px width
                  child: _buildWithdrawHistoryList(scale),
                ),
              ),
              
                  // Request Withdraw Button (left: calc(50%-0.5px), top: 722px)
                  Positioned(
                    left: (screenWidth / 2) - (0.5 * scale),
                    top: 722 * scale,
                    child: Transform.translate(
                      offset: Offset(-108 * scale, 0), // Center 216px width
                      child: _buildRequestButton(scale),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader(double scale) {
    return Row(
      children: [
        // Profile Image with Badge
        SizedBox(
          width: 60 * scale,
          height: 55 * scale,
          child: Stack(
            children: [
              // Background circle
              Positioned(
                left: 9 * scale,
                top: 7 * scale,
                child: Container(
                  width: 40 * scale,
                  height: 40 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0B8FF),
                    borderRadius: BorderRadius.circular(20 * scale),
                  ),
                ),
              ),
              // User Image
              Positioned(
                left: 12 * scale,
                top: 11 * scale,
                child: Container(
                  width: 34 * scale,
                  height: 31 * scale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13 * scale),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13 * scale),
                    child: Image.asset(
                      'assets/figma_exports/52ec367639c91dd0186e7c21dba64d8ed1375a47.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.person,
                        size: 24 * scale,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // Badge
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 24 * scale,
                  height: 24 * scale,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 11 * scale,
                      color: const Color(0xFFF5F5F4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10 * scale),
        // User Info (Positioned at left: 146px, top: 60px for name)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
              controller.userName.value.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Oddlini',
                fontWeight: FontWeight.w700,
                fontSize: 13 * scale,
                color: Colors.white,
                height: 20 / 13, // line-height: 20px
              ),
            )),
            Obx(() => Text(
              'User ID: ${controller.userId.value}',
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
                fontSize: 11 * scale,
                color: Colors.grey,
                height: 20 / 11, // line-height: 20px
              ),
            )),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsSection(double scale) {
    return SizedBox(
      width: 360 * scale,
      child: Column(
        children: [
          _buildStatCard(
            'Pending Task:',
            controller.pendingTasks.value.toString().padLeft(2, '0'),
            'assets/figma_exports/aef459389e4d924042d590b4feb4814a7e12b0dc.png',
            scale,
            isFirst: true,
          ),
          SizedBox(height: 3 * scale),
          _buildStatCard(
            'Rejected Task:',
            controller.rejectedTasks.value.toString().padLeft(2, '0'),
            'assets/figma_exports/1675285846cd7b5e8d301751b7fad513321145d8.png',
            scale,
          ),
          SizedBox(height: 3 * scale),
          _buildStatCard(
            'Task Completed:',
            controller.completedTasks.value.toString().padLeft(2, '0'),
            'assets/figma_exports/a29cb327491524ea2c54f667bc26f5de70644a1e.png',
            scale,
          ),
          SizedBox(height: 3 * scale),
          _buildStatCard(
            'Pending Amount:',
            '${controller.pendingAmount.value.toStringAsFixed(0)} BDT',
            'assets/figma_exports/ced8213fa5d46c747c4716e117d8a33b5e7cb0a3.png',
            scale,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String iconPath, double scale, {bool isFirst = false, bool isLast = false}) {
    return Container(
      height: 67 * scale,
      padding: EdgeInsets.symmetric(horizontal: 21 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2929),
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? Radius.circular(11 * scale) : Radius.zero,
          topRight: isFirst ? Radius.circular(11 * scale) : Radius.zero,
          bottomLeft: isLast ? Radius.circular(11 * scale) : Radius.zero,
          bottomRight: isLast ? Radius.circular(11 * scale) : Radius.zero,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Image.asset(
            iconPath,
            width: label == 'Pending Task:' ? 22 * scale : 24 * scale,
            height: label == 'Pending Task:' ? 22 * scale : 24 * scale,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.info_outline,
              size: 20 * scale,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 18 * scale),
          // Label
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 16 * scale,
              color: Colors.white,
              letterSpacing: 0.32 * scale,
              height: 1.25,
            ),
          ),
          const Spacer(),
          // Value
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 16 * scale,
              color: const Color(0xFF888787),
              letterSpacing: 0.32 * scale,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawHistoryList(double scale) {
    return Obx(() {
      if (controller.transactions.isEmpty) {
        return SizedBox(
          width: 360 * scale,
          height: 186 * scale,
          child: Center(
            child: Text(
              'No withdrawal history found.',
              style: TextStyle(
                fontSize: 14 * scale,
                color: Colors.grey,
              ),
            ),
          ),
        );
      }
      
      return SizedBox(
        width: 360 * scale,
        child: Column(
          children: List.generate(
            controller.transactions.length > 3 ? 3 : controller.transactions.length,
            (index) {
              final transaction = controller.transactions[index];
              final isFirst = index == 0;
              final isLast = index == (controller.transactions.length > 3 ? 2 : controller.transactions.length - 1);
              
              return Column(
                children: [
                  if (index > 0) SizedBox(height: 3 * scale),
                  _buildTransactionCard(transaction, index, scale, isFirst: isFirst, isLast: isLast),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildTransactionCard(dynamic transaction, int index, double scale, {bool isFirst = false, bool isLast = false}) {
    return Container(
      height: 62 * scale,
      width: 360 * scale,
      padding: EdgeInsets.symmetric(horizontal: 17 * scale, vertical: 9 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2929),
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? Radius.circular(11 * scale) : Radius.zero,
          topRight: isFirst ? Radius.circular(11 * scale) : Radius.zero,
          bottomLeft: isLast ? Radius.circular(11 * scale) : Radius.zero,
          bottomRight: isLast ? Radius.circular(11 * scale) : Radius.zero,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 306 * scale,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${index + 1}. ${transaction.title}',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 16 * scale,
                    color: Colors.white,
                    letterSpacing: 0.32 * scale,
                    height: 1.25,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: transaction.amount.toStringAsFixed(0),
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700,
                          fontSize: 16 * scale,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: ' BDT',
                        style: TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 16 * scale,
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
          SizedBox(height: 3 * scale),
          Text(
            'Date: ${transaction.date.day.toString().padLeft(2, '0')}/${transaction.date.month.toString().padLeft(2, '0')}/${transaction.date.year.toString().substring(2, 4)}',
            style: TextStyle(
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.w300,
              fontSize: 8 * scale,
              color: const Color(0xFF8B8B8B),
              letterSpacing: 0.16 * scale,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestButton(double scale) {
    return GestureDetector(
      onTap: controller.goToWithdrawRequest,
      child: Container(
        width: 216 * scale,
        height: 45 * scale,
        padding: EdgeInsets.symmetric(horizontal: 21 * scale, vertical: 8 * scale),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22 * scale),
          gradient: const RadialGradient(
            center: Alignment(-0.126, -2.234),
            radius: 1.5,
            colors: [
              Color(0xEB58A3D8), // rgba(88,163,216,0.92)
              Color(0xE78C98EC), // rgba(140,152,236,0.905)
              Color(0xE3C08EFF), // rgba(192,142,255,0.89)
            ],
            stops: [0.242, 0.545, 0.849],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Request Withdraw',
              style: TextStyle(
                fontFamily: 'Oddlini',
                fontSize: 16 * scale,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.32 * scale,
                height: 1.25,
              ),
            ),
            SizedBox(width: 10 * scale),
            Transform.rotate(
              angle: 268.584 * 3.14159 / 180,
              child: Icon(
                Icons.arrow_forward,
                size: 11 * scale,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
