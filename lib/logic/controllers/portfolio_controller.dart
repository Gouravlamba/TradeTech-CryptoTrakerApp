import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../../data/models/holding_model.dart';
import '../../data/models/coin_model.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../core/helpers/formatters.dart';

class PortfolioController extends GetxController {
  final _repo = PortfolioRepository();
  Timer? _autoRefreshTimer;

  final coinsList = <CoinModel>[].obs;
  final holdings = <HoldingModel>[].obs;
  final prices = <String, double>{}.obs;
  final isLoading = false.obs;
  final lastError = RxnString();

  double get totalValue {
    double total = 0;
    for (final h in holdings) {
      final p = prices[h.coinId] ?? 0.0;
      total += p * h.quantity;
    }
    return total;
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    startAutoRefresh();
  }

  void startAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      if (holdings.isNotEmpty) {
        print("Auto refresh prices...");
        refreshPrices();
      }
    });
  }

  @override
  void onClose() {
    _autoRefreshTimer?.cancel();
    super.onClose();
  }

  Future<void> loadInitial() async {
    isLoading.value = true;
    lastError.value = null;
    try {
      coinsList.value = await _repo.getCoinsList();
      holdings.value = await _repo.loadPortfolio();
      await refreshPrices();
    } catch (e) {
      lastError.value = e.toString();
      print(" loadInitial error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPrices() async {
    try {
      final ids = holdings.map((h) => h.coinId).toSet().toList();
      if (ids.isEmpty) return;
      print(" Fetching latest prices for: $ids");
      final res = await _repo.getPrices(ids);
      prices.assignAll(res);
      print(" Prices updated: ${jsonEncode(res)}");
      update();
    } catch (e) {
      lastError.value = 'Price fetch failed: $e';
      print(" Price fetch failed: $e");
    }
  }

  Future<void> addOrUpdateHolding(String coinId, double quantity) async {
    final idx = holdings.indexWhere((h) => h.coinId == coinId);
    if (idx >= 0) {
      holdings[idx] = HoldingModel(coinId: coinId, quantity: quantity);
    } else {
      holdings.add(HoldingModel(coinId: coinId, quantity: quantity));
    }

    holdings.refresh();
    await _repo.savePortfolio(holdings);
    await refreshPrices();
    update();
  }

  Future<void> removeHolding(String coinId) async {
    holdings.removeWhere((h) => h.coinId == coinId);
    holdings.refresh();
    await _repo.savePortfolio(holdings);
    await refreshPrices();
    update();
  }

  String getCoinName(String coinId) {
    final c = coinsList.firstWhereOrNull((c) => c.id == coinId);
    return c?.name ?? coinId;
  }

  String formatHoldingValue(String coinId, double quantity) {
    final p = prices[coinId] ?? 0.0;
    return currencyFormat(p * quantity);
  }
}
