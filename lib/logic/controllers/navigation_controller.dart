import 'package:get/get.dart';

class NavigationController extends GetxController {
  final index = 0.obs;

  void changeIndex(int i) => index.value = i;
}
