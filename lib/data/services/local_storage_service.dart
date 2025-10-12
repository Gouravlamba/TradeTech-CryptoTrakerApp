import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class LocalStorageService {
  Future<void> saveString(String key, String value) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  Future<void> savePortfolioJson(String json) =>
      saveString(AppConstants.portfolioStorageKey, json);

  Future<String?> loadPortfolioJson() =>
      getString(AppConstants.portfolioStorageKey);

  Future<void> saveCoinListJson(String json) =>
      saveString(AppConstants.coinListCacheKey, json);

  Future<String?> loadCoinListJson() =>
      getString(AppConstants.coinListCacheKey);

  Future<void> savePriceCacheJson(String json) =>
      saveString(AppConstants.lastPriceCacheKey, json);

  Future<String?> loadPriceCacheJson() =>
      getString(AppConstants.lastPriceCacheKey);
}
