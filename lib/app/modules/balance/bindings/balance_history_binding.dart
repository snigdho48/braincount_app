import 'package:get/get.dart';
import '../controllers/balance_history_controller.dart';

class BalanceHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalanceHistoryController>(() => BalanceHistoryController());
  }
}


