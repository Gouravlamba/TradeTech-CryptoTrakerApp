import 'package:crypto_portfolio/presentation/screens/market/market_screen.dart';
import 'package:crypto_portfolio/presentation/screens/portfolio/portfolio_screen.dart';
import 'package:crypto_portfolio/presentation/screens/profile/profile_screen.dart';
import 'package:crypto_portfolio/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/navigation_controller.dart';

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();
    final pages = [
      const PortfolioScreen(),
      const MarketScreen(),
      const ProfileScreen()
    ];
    return Scaffold(
      body: Obx(() {
        final idx = navCtrl.index.value;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) =>
              FadeTransition(opacity: anim, child: child),
          child: pages[idx],
        );
      }),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
