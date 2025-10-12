import 'package:crypto_portfolio/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controllers/portfolio_controller.dart';
import '../../../data/services/coingecko_service.dart';
import '../../widgets/total_value_banner.dart';
import '../../widgets/loading_indicator.dart';
import '../add_asset/add_asset_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ctrl = Get.find<PortfolioController>();
  final _api = CoinGeckoService();

  final Map<String, Map<String, dynamic>> _coinDetails = {};

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    for (final h in ctrl.holdings) {
      if (!_coinDetails.containsKey(h.coinId)) {
        try {
          final detail = await _api.fetchCoinDetail(h.coinId);
          _coinDetails[h.coinId] = detail;
        } catch (e) {
          print(' Detail fetch failed for ${h.coinId}: $e');
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 17, 32),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Image.asset(
              "assets/logo22.png",
              height: 180,
              width: 180,
              fit: BoxFit.contain,
            ),

            // Profile Icon
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
              onPressed: () {
                Get.to(
                  () => ProfileScreen(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 300),
                );
              },
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) return const LoadingIndicator();

        if (ctrl.holdings.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_balance_wallet_outlined,
                    size: 72, color: Colors.grey),
                const SizedBox(height: 12),
                const Text(
                  'No assets yet',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => showAddSheet(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add your first asset'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ctrl.refreshPrices();
            await loadDetails();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: ctrl.holdings.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return TotalValueBanner(total: ctrl.totalValue);
              }

              final h = ctrl.holdings[index - 1];
              final coinId = h.coinId;
              final coinName = ctrl.getCoinName(coinId);
              final price = ctrl.prices[coinId] ?? 0.0;
              final totalValue = price * h.quantity;

              final detail = _coinDetails[coinId];
              final imageUrl = detail?['image'] ??
                  'https://assets.coingecko.com/coins/images/1/large/bitcoin.png';
              final priceChange =
                  (detail?['price_change_24h'] as num?)?.toDouble() ?? 0.0;
              final priceChangePct =
                  (detail?['price_change_percentage_24h'] as num?)
                          ?.toDouble() ??
                      0.0;
              final isNegative = priceChange < 0;

              return Dismissible(
                key: ValueKey(coinId),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  ctrl.removeHolding(coinId);
                  setState(() {
                    _coinDetails.remove(coinId);
                  });
                  Get.snackbar(
                    'Removed',
                    '$coinName removed',
                    backgroundColor: Colors.red.withOpacity(0.8),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      backgroundColor: Colors.white,
                      radius: 24,
                    ),
                    title: Text(
                      coinName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${coinId.toUpperCase()} • Qty: ${h.quantity}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹ ${price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Color(0xff0395eb),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${isNegative ? '' : '+'}${priceChangePct.toStringAsFixed(2)}% "
                          "(${isNegative ? '' : '+'}${priceChange.toStringAsFixed(4)})",
                          style: TextStyle(
                            color: isNegative ? Colors.red : Colors.green,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Remove asset?'),
                          content: Text('Remove $coinName from portfolio?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                ctrl.removeHolding(coinId);
                                setState(() {
                                  _coinDetails.remove(coinId);
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Remove'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddSheet(context),
        backgroundColor: Color.fromARGB(255, 0, 17, 32),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  void showAddSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.grey[50],
      builder: (_) => const AddAssetScreen(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
    );
  }
}
