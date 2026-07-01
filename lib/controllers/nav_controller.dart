import 'package:get/get.dart';

class NavController extends GetxController {
  final selectedIndex = 1.obs; 

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}