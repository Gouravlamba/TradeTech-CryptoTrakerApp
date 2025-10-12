import 'package:get/get.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/main_app/main_app_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const mainApp = '/main';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: mainApp, page: () => const MainAppScreen()),
  ];
}
