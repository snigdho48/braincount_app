import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/balance_history_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/brain_loader.dart';
import '../../../data/models/balance_model.dart';

class BalanceHistoryView extends GetView<BalanceHistoryController> {
  const BalanceHistoryView({super.key});

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
              // Transaction List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const BrainLoader(
                        message: 'Loading transaction history...');
                  }

                  if (controller.transactions.isEmpty) {
                    return const Center(
                      child: Text(
                        'No transactions found',
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: controller.loadHistory,
                    color: AppColors.primary,
                    backgroundColor: AppColors.cardBackground,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: controller.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = controller.transactions[index];
                        return _buildTransactionCard(transaction);
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.textWhite,
            ),
          ),
          const Expanded(
            child: Text(
              'Balance History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(BalanceModel transaction) {
    final isEarning = transaction.isEarning;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (isEarning ? AppColors.success : AppColors.error)
              .withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (isEarning ? AppColors.success : AppColors.error)
                  .withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isEarning ? Icons.add_circle : Icons.remove_circle,
              color: isEarning ? AppColors.success : AppColors.error,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textWhite,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('dd MMM yyyy, HH:mm').format(transaction.date),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isEarning ? '+' : '-'}৳${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isEarning ? AppColors.success : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}

