import 'package:get/get.dart';
import '../../../data/models/balance_model.dart';
import '../../../data/services/api_service.dart';

class BalanceHistoryController extends GetxController {
  final transactions = <BalanceModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    try {
      isLoading.value = true;
      final history = await ApiService.getBalanceHistory();
      transactions.value = history;
    } catch (e) {
      print('Error loading history: $e');
    } finally {
      isLoading.value = false;
    }
  }
}


