import 'package:get/get.dart';
import '../../data/models/coin_model.dart';
import '../../data/repositories/portfolio_repository.dart';
import '../../core/helpers/debounce.dart';

class CoinSearchController extends GetxController {
  final _repo = PortfolioRepository();
  final allCoins = <CoinModel>[].obs;
  final results = <CoinModel>[].obs;
  final isLoading = false.obs;
  final Debounce debounce = Debounce(milliseconds: 400);

  @override
  void onInit() {
    super.onInit();
    loadCoins();
  }

  Future<void> loadCoins() async {
    isLoading.value = true;
    try {
      final list = await _repo.getCoinsList(force: true);
      allCoins.value = list;
      results.value = allCoins.take(30).toList();
      print("Loaded ${list.length} coins from CoinGecko");
    } catch (e) {
      print(" Coin list load failed: $e");
    }
    isLoading.value = false;
  }

  void search(String q) {
    debounce.run(() {
      if (q.trim().isEmpty) {
        results.value = allCoins.take(30).toList();
        return;
      }
      final query = q.toLowerCase();
      results.value = allCoins
          .where((c) =>
              c.name.toLowerCase().contains(query) ||
              c.symbol.toLowerCase().contains(query))
          .take(50)
          .toList();
    });
  }
}
