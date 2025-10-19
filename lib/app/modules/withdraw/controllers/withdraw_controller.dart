import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/api_service.dart';
import '../../../data/services/storage_service.dart';
import '../../../widgets/error_modal.dart';
import '../../../widgets/success_modal.dart';

class WithdrawController extends GetxController {
  final amountController = TextEditingController();
  final accountNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final isLoading = false.obs;
  final selectedMethod = 'bank'.obs;
  final availableBalance = 0.0.obs;

  final methods = ['bank', 'bkash', 'nagad', 'rocket'];

  @override
  void onInit() {
    super.onInit();
    loadBalance();
  }

  @override
  void onClose() {
    amountController.dispose();
    accountNumberController.dispose();
    super.onClose();
  }

  Future<void> loadBalance() async {
    final user = await StorageService.getUser();
    if (user != null) {
      availableBalance.value = user.balance;
    }
  }

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  Future<void> submitWithdrawal() async {
    if (!formKey.currentState!.validate()) return;

    final amount = double.tryParse(amountController.text) ?? 0;
    
    if (amount <= 0) {
      ErrorModal.show(
        Get.context!,
        title: 'Invalid Amount',
        message: 'Please enter a valid amount',
      );
      return;
    }

    if (amount > availableBalance.value) {
      ErrorModal.show(
        Get.context!,
        title: 'Insufficient Balance',
        message: 'You do not have sufficient balance',
      );
      return;
    }

    try {
      isLoading.value = true;
      
      final response = await ApiService.withdrawRequest(
        amount,
        selectedMethod.value,
        {
          'account_number': accountNumberController.text,
        },
      );

      if (response['success'] == true) {
        SuccessModal.show(
          Get.context!,
          title: 'Success!',
          message: 'Withdrawal request submitted successfully',
          onPressed: () {
            Get.back();
            Get.back();
          },
        );
      } else {
        ErrorModal.show(
          Get.context!,
          title: 'Failed',
          message: response['message'] ?? 'Failed to submit withdrawal',
        );
      }
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'An error occurred. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}


