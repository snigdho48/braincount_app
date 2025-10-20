import 'package:get/get.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class BalanceHistoryController extends GetxController {
  final transactions = <TransactionModel>[].obs;
  final isLoading = false.obs;
  
  // User info
  final userName = 'NAFSIN RAHMAN'.obs;
  final userId = '34874'.obs;
  
  // Stats
  final totalWithdrawn = 2067.0.obs;
  final pendingTasks = 1.obs;
  final rejectedTasks = 1.obs;
  final completedTasks = 34.obs;
  final pendingAmount = 2222.0.obs;
  
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
          title: 'Withdraw ${index.toString().padLeft(2, '0')}',
          amount: balanceModel.amount,
          date: balanceModel.date,
          status: balanceModel.type == 'credit' ? 'completed' : 'pending',
          type: 'withdrawal',
        );
      }).toList();
    } catch (e) {
      print('Error loading history: $e');
      // Mock data for demonstration
      transactions.value = [
        TransactionModel(
          id: 1,
          title: 'Withdraw 01',
          amount: 22.0,
          date: DateTime(2025, 9, 23),
          status: 'completed',
          type: 'withdrawal',
        ),
        TransactionModel(
          id: 2,
          title: 'Withdraw 01',
          amount: 22.0,
          date: DateTime(2025, 9, 23),
          status: 'completed',
          type: 'withdrawal',
        ),
        TransactionModel(
          id: 3,
          title: 'Withdraw 01',
          amount: 22.0,
          date: DateTime(2025, 9, 23),
          status: 'completed',
          type: 'withdrawal',
        ),
      ];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadStats() async {
    try {
      // This would typically come from the API
      // For now using mock data
      totalWithdrawn.value = 2067.0;
      pendingTasks.value = 1;
      rejectedTasks.value = 1;
      completedTasks.value = 34;
      pendingAmount.value = 2222.0;
    } catch (e) {
      print('Error loading stats: $e');
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


