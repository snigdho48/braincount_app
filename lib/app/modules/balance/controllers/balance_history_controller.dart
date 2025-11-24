import 'package:get/get.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class BalanceHistoryController extends GetxController {
  final transactions = <TransactionModel>[].obs;
  final isLoading = false.obs;
  
  // User info
  final userName = ''.obs;
  final userId = ''.obs;
  
  // Stats
  final totalWithdrawn = 0.0.obs;
  final pendingTasks = 0.obs;
  final rejectedTasks = 0.obs;
  final completedTasks = 0.obs;
  final pendingAmount = 0.0.obs;
  
  // Collapsible sections
  final isHistoryExpanded = true.obs;
  final isWithdrawHistoryExpanded = true.obs;
  
  void toggleHistory() {
    isHistoryExpanded.value = !isHistoryExpanded.value;
  }
  
  void toggleWithdrawHistory() {
    isWithdrawHistoryExpanded.value = !isWithdrawHistoryExpanded.value;
  }

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadHistory();
    loadStats();
  }

  Future<void> loadUserData() async {
    final user = await StorageService.getUser();
    if (user != null) {
      userName.value = user.name;
      userId.value = user.id.toString();
    }
  }

  Future<void> loadHistory() async {
    try {
      isLoading.value = true;
      final history = await ApiService.getBalanceHistory();
      // Convert BalanceModel to TransactionModel
      transactions.value = history.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final balanceModel = entry.value;
        return TransactionModel(
          id: index,
          title: balanceModel.type == 'earning' 
              ? balanceModel.description.isNotEmpty 
                  ? balanceModel.description
                  : 'Task Completed'
              : balanceModel.description.isNotEmpty
                  ? balanceModel.description
                  : 'Withdrawal Request',
          amount: balanceModel.amount,
          date: balanceModel.date,
          status: balanceModel.status,
          type: balanceModel.type,
        );
      }).toList();
      
      // Calculate total withdrawn from transactions
      final withdrawals = transactions.where((t) => t.type == 'withdrawal').toList();
      totalWithdrawn.value = withdrawals.fold(0.0, (sum, t) => sum + t.amount);
    } catch (e) {
      // Show error but don't crash
      transactions.value = [];
      Get.snackbar(
        'Error',
        'Failed to load transaction history',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadStats() async {
    try {
      // Get stats from dashboard API
      final stats = await ApiService.getDashboardStats();
      completedTasks.value = stats.taskCompleted;
      pendingTasks.value = stats.taskPending;
      rejectedTasks.value = stats.taskRejected;
      
      // Calculate total withdrawn from transactions
      final withdrawals = transactions.where((t) => t.type == 'withdrawal').toList();
      totalWithdrawn.value = withdrawals.fold(0.0, (sum, t) => sum + t.amount);
      
      // Calculate pending amount (balance - withdrawn)
      final user = await StorageService.getUser();
      if (user != null) {
        pendingAmount.value = user.balance;
      }
    } catch (e) {
      // Error handled silently - keep existing values
    }
  }

  Future<void> refreshTransactions() async {
    await loadHistory();
    await loadStats();
  }

  void goToWithdrawRequest() {
    Get.toNamed(AppRoutes.withdraw);
  }
}


