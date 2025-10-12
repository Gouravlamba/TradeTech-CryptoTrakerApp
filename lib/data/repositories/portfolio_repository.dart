import 'dart:convert';
import '../models/coin_model.dart';
import '../models/holding_model.dart';
import '../services/coingecko_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioRepository {
  final _api = CoinGeckoService();

  /// Get all available coins (from API or cache)
  Future<List<CoinModel>> getCoinsList({bool force = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('coins_list');
    if (cached != null && !force) {
      try {
        final list = (json.decode(cached) as List)
            .map((e) => CoinModel.fromJson(e))
            .toList();
        return list;
      } catch (e) {
        print(' Cached coin list parse error: $e');
      }
    }

    final list = await _api.fetchCoinsList();
    await prefs.setString(
        'coins_list', json.encode(list.map((e) => e.toJson()).toList()));
    return list;
  }

  /// Fetch latest prices for given coin IDs
  Future<Map<String, double>> getPrices(List<String> ids) async {
    try {
      final prices = await _api.fetchPricesUsd(ids);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_price_cache', json.encode(prices));
      return prices;
    } catch (e) {
      print(' Price fetch failed: $e');
      return {};
    }
  }

  /// Load user's saved portfolio
  Future<List<HoldingModel>> loadPortfolio() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString('portfolio');
    if (jsonStr == null) return [];

    try {
      final list = (json.decode(jsonStr) as List)
          .map((e) => HoldingModel.fromJson(e))
          .toList();
      return list;
    } catch (e) {
      print(' Portfolio parse error: $e');
      return [];
    }
  }

  /// Save portfolio persistently
  Future<void> savePortfolio(List<HoldingModel> holdings) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = json.encode(holdings.map((h) => h.toJson()).toList());
    await prefs.setString('portfolio', jsonStr);
    print('💾 Portfolio saved: $jsonStr');
  }
}
