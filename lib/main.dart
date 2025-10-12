import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'logic/controllers/navigation_controller.dart';
import 'logic/controllers/portfolio_controller.dart';
import 'logic/controllers/coin_search_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NavigationController());
  Get.put(PortfolioController());
  Get.put(CoinSearchController());
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Trade Tech',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
