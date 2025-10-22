import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/storage_service.dart';
import '../../../data/models/bank_account_model.dart';
import '../../../data/models/mobile_banking_model.dart';
import '../../../widgets/error_modal.dart';
import '../../../widgets/success_modal.dart';

class WithdrawController extends GetxController {
  final amountController = TextEditingController();
  final accountNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final isLoading = false.obs;
  final selectedMethod = 'bank'.obs;
  final availableBalance = 390.0.obs; // Mock balance
  final amountError = ''.obs; // For real-time validation
  final amountText = ''.obs; // Reactive amount text
  
  // Bank accounts and mobile banking
  final bankAccounts = <BankAccountModel>[].obs;
  final mobileBankingAccounts = <MobileBankingModel>[].obs;
  
  // Selected account for withdrawal
  final selectedBankAccount = Rxn<BankAccountModel>();
  final selectedMobileBanking = Rxn<MobileBankingModel>();
  
  // Form controllers for Add New Bank
  final bankNumberController = TextEditingController();
  final branchNameController = TextEditingController();
  final bankNameController = TextEditingController();
  final routingNumberController = TextEditingController();
  
  // Form controllers for Add Mobile Banking
  final bkashNumberController = TextEditingController();
  final fullNameController = TextEditingController();
  final selectedMfsType = 'Bkash'.obs; // Selected MFS provider

  final methods = ['bank', 'bkash', 'nagad', 'rocket'];
  final mfsTypes = ['Bkash', 'Nagad', 'Rocket'];

  @override
  void onInit() {
    super.onInit();
    loadBalance();
    loadBankAccounts();
    loadMobileBankingAccounts();
  }

  @override
  void onClose() {
    amountController.dispose();
    accountNumberController.dispose();
    bankNumberController.dispose();
    branchNameController.dispose();
    bankNameController.dispose();
    routingNumberController.dispose();
    bkashNumberController.dispose();
    fullNameController.dispose();
    super.onClose();
  }

  void selectMfsType(String type) {
    selectedMfsType.value = type;
  }

  void updateAmount(String value) {
    amountText.value = value;
    amountController.text = value;
    _validateAmount();
  }

  void _validateAmount() {
    final amount = double.tryParse(amountText.value) ?? 0;
    if (amount > availableBalance.value) {
      amountError.value = 'Amount exceeds available balance';
    } else if (amount <= 0 && amountText.value.isNotEmpty) {
      amountError.value = 'Please enter a valid amount';
    } else {
      amountError.value = '';
    }
  }

  bool get isAmountValid => amountError.value.isEmpty && amountText.value.isNotEmpty;

  Future<void> loadBalance() async {
    final user = await StorageService.getUser();
    if (user != null) {
      availableBalance.value = user.balance;
    }
  }

  // Load bank accounts from local storage
  Future<void> loadBankAccounts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('bank_accounts');
      if (data != null) {
        final List<dynamic> jsonList = jsonDecode(data);
        bankAccounts.value = jsonList
            .map((json) => BankAccountModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Error loading bank accounts: $e');
    }
  }

  // Load mobile banking accounts from local storage
  Future<void> loadMobileBankingAccounts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('mobile_banking_accounts');
      if (data != null) {
        final List<dynamic> jsonList = jsonDecode(data);
        mobileBankingAccounts.value = jsonList
            .map((json) => MobileBankingModel.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Error loading mobile banking accounts: $e');
    }
  }

  // Save bank accounts to local storage
  Future<void> saveBankAccounts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = bankAccounts.map((account) => account.toJson()).toList();
      await prefs.setString('bank_accounts', jsonEncode(jsonList));
    } catch (e) {
      print('Error saving bank accounts: $e');
    }
  }

  // Save mobile banking accounts to local storage
  Future<void> saveMobileBankingAccounts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = mobileBankingAccounts.map((account) => account.toJson()).toList();
      await prefs.setString('mobile_banking_accounts', jsonEncode(jsonList));
    } catch (e) {
      print('Error saving mobile banking accounts: $e');
    }
  }

  // Add new bank account
  Future<void> addBankAccount() async {
    if (bankNumberController.text.isEmpty ||
        branchNameController.text.isEmpty ||
        bankNameController.text.isEmpty ||
        routingNumberController.text.isEmpty) {
      ErrorModal.show(
        Get.context!,
        title: 'Missing Information',
        message: 'Please fill in all fields',
      );
      return;
    }

    try {
      final newAccount = BankAccountModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        bankName: bankNameController.text,
        bankNumber: bankNumberController.text,
        branchName: branchNameController.text,
        routingNumber: routingNumberController.text,
        createdAt: DateTime.now(),
      );

      bankAccounts.add(newAccount);
      await saveBankAccounts();

      // Clear form
      bankNumberController.clear();
      branchNameController.clear();
      bankNameController.clear();
      routingNumberController.clear();

      SuccessModal.show(
        Get.context!,
        title: 'Success!',
        message: 'Bank account added successfully',
        onPressed: () {
          Get.back(); // Close modal
          Get.back(); // Go back to select method page
        },
      );
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Failed to add bank account',
      );
    }
  }

  // Add new mobile banking account
  Future<void> addMobileBanking() async {
    if (bkashNumberController.text.isEmpty ||
        fullNameController.text.isEmpty) {
      ErrorModal.show(
        Get.context!,
        title: 'Missing Information',
        message: 'Please fill in all required fields',
      );
      return;
    }

    try {
      final newAccount = MobileBankingModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        provider: selectedMfsType.value,
        phoneNumber: bkashNumberController.text,
        fullName: fullNameController.text,
        createdAt: DateTime.now(),
      );

      mobileBankingAccounts.add(newAccount);
      await saveMobileBankingAccounts();

      // Clear form
      bkashNumberController.clear();
      fullNameController.clear();
      selectedMfsType.value = 'Bkash'; // Reset to default

      SuccessModal.show(
        Get.context!,
        title: 'Success!',
        message: 'Mobile banking account added successfully',
        onPressed: () {
          Get.back(); // Close modal
          Get.back(); // Go back to select method page
        },
      );
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Failed to add mobile banking account',
      );
    }
  }

  // Remove bank account
  Future<void> removeBankAccount(String id) async {
    try {
      bankAccounts.removeWhere((account) => account.id == id);
      await saveBankAccounts();
      
      SuccessModal.show(
        Get.context!,
        title: 'Removed',
        message: 'Bank account removed successfully',
        onPressed: () => Get.back(),
      );
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Failed to remove bank account',
      );
    }
  }

  // Remove mobile banking account
  Future<void> removeMobileBanking(String id) async {
    try {
      mobileBankingAccounts.removeWhere((account) => account.id == id);
      await saveMobileBankingAccounts();
      
      SuccessModal.show(
        Get.context!,
        title: 'Removed',
        message: 'Mobile banking account removed successfully',
        onPressed: () => Get.back(),
      );
    } catch (e) {
      ErrorModal.show(
        Get.context!,
        title: 'Error',
        message: 'Failed to remove mobile banking account',
      );
    }
  }

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  // Select bank account for withdrawal
  void selectBankAccount(BankAccountModel account) {
    selectedBankAccount.value = account;
    selectedMobileBanking.value = null;
  }

  // Select mobile banking for withdrawal
  void selectMobileBanking(MobileBankingModel account) {
    selectedMobileBanking.value = account;
    selectedBankAccount.value = null;
  }

  // Check if any account is selected
  bool get hasSelectedAccount => 
      selectedBankAccount.value != null || selectedMobileBanking.value != null;

  // Get selected account display name
  String get selectedAccountName {
    if (selectedBankAccount.value != null) {
      return selectedBankAccount.value!.bankName;
    }
    if (selectedMobileBanking.value != null) {
      return selectedMobileBanking.value!.provider;
    }
    return '';
  }

  // Get selected account number
  String get selectedAccountNumber {
    if (selectedBankAccount.value != null) {
      return selectedBankAccount.value!.maskedNumber;
    }
    if (selectedMobileBanking.value != null) {
      return selectedMobileBanking.value!.maskedNumber;
    }
    return '';
  }

  // Get selected account logo path
  String get selectedAccountLogo {
    if (selectedBankAccount.value != null) {
      return 'assets/figma_exports/342b1751ba1e7c7b04bc21f79d69a779d258f449.png'; // Bank logo
    }
    if (selectedMobileBanking.value != null) {
      return selectedMobileBanking.value!.logoPath;
    }
    return '';
  }

  // Check if selected account is mobile banking
  bool get isMobileBankingSelected => selectedMobileBanking.value != null;

  Future<void> submitWithdrawal() async {
    if (!hasSelectedAccount) {
      ErrorModal.show(
        Get.context!,
        title: 'No Account Selected',
        message: 'Please select an account first',
      );
      return;
    }

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
      
      // For now, just show success (API integration later)
      await Future.delayed(const Duration(seconds: 1));
      
      // Update balance
      availableBalance.value -= amount;
      
      // Clear form
      amountController.clear();
      selectedBankAccount.value = null;
      selectedMobileBanking.value = null;

      SuccessModal.show(
        Get.context!,
        title: 'Success!',
        message: 'Withdrawal request submitted successfully',
        onPressed: () {
          Get.back(); // Close modal
          Get.back(); // Close bottom sheet
          Get.back(); // Go back to previous page
        },
      );
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


