import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/balance_history_controller.dart';

class BalanceHistoryView extends GetView<BalanceHistoryController> {
  const BalanceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final baseWidth = 393.0;
    final scale = screenWidth / baseWidth;

    return Scaffold(
      floatingActionButton: _buildRequestButton(scale),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        decoration: const BoxDecoration(
            color: Color(0xFF232323),
          ),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Section with Background
                
                Container(
                  width: screenWidth,
                  height: 350 * scale,
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                       decoration: BoxDecoration(
                    color: const Color(0xFF393838),
                    borderRadius: BorderRadius.circular(25 * scale),
                  ),
                  child: Stack(
                    children: [
                      // Background Container
                 
                      
                      // Content in top section (centered)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10 * scale),
                            // Balance History Title
                            Column(
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
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 16 * scale,
                                    color: const Color(0xFF888787),
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                        
                        SizedBox(height: 9 * scale),
                        
                        // 3D Coin
                        Image.asset(
                          'assets/figma_exports/f95735da83252e978fe0c91533b59558cce94027.png',
                          width: 113 * scale,
                          height: 113 * scale,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.account_balance_wallet,
                            size: 80 * scale,
                            color: Colors.amber,
                          ),
                        ),
                        
                        SizedBox(height: 15 * scale),
                        
                        // Balance Amount
                        Obx(() => RichText(
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
                          ],
                        ),
                      ),
                      
                      // Back Button (positioned absolutely in top section)
                      Positioned(
                        left: 16 * scale,
                        top: 16 * scale,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(8 * scale),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20 * scale,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20 * scale),
                
                // History Label
           ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // History Section (Collapsible)
                    _buildCollapsibleSection(
                      title: 'History:',
                      isExpanded: controller.isHistoryExpanded,
                      onToggle: controller.toggleHistory,
                      scale: scale,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                        child: _buildStatsSection(scale),
                      ),
                    ),

                    SizedBox(height: 30 * scale),

                    // Withdraw History Section (Collapsible)
                    _buildCollapsibleSection(
                      title: 'Withdraw History:',
                      isExpanded: controller.isWithdrawHistoryExpanded,
                      onToggle: controller.toggleWithdrawHistory,
                      scale: scale,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                        child: _buildWithdrawHistoryList(scale),
                      ),
                    ),

                    SizedBox(height: 100 * scale),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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

  Widget _buildCollapsibleSection({
    required String title,
    required RxBool isExpanded,
    required VoidCallback onToggle,
    required double scale,
    required Widget child,
  }) {
    return Obx(() => Column(
      children: [
        // Header with title and expand/collapse icon
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                    fontSize: 13 * scale,
                    color: const Color(0xFF7B7B7B),
                  ),
                ),
                SizedBox(width: 8 * scale),
                AnimatedRotation(
                  turns: isExpanded.value ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: const Color(0xFF7B7B7B),
                    size: 20 * scale,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Collapsible content with animation
        AnimatedCrossFade(
          firstChild: Padding(
            padding: EdgeInsets.only(top: 7 * scale),
            child: child,
          ),
          secondChild: const SizedBox(width: double.infinity, height: 0),
          crossFadeState: isExpanded.value 
              ? CrossFadeState.showFirst 
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
          sizeCurve: Curves.easeInOut,
        ),
      ],
    ));
  }
}
