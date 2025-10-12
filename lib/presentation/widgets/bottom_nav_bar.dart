import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../../logic/controllers/navigation_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<NavigationController>();
    return Obx(() {
      final idx = nav.index.value;
      return BottomNavigationBar(
        currentIndex: idx,
        onTap: nav.changeIndex,
        backgroundColor: AppColors.surface,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart), label: 'Portfolio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: 'Market'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      );
    });
  }
}
