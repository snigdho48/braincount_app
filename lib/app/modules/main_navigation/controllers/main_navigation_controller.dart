import 'package:get/get.dart';

class MainNavigationController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }
}





