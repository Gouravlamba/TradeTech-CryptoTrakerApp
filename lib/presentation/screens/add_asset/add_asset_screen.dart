import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/coingecko_service.dart';
import '../../../logic/controllers/coin_search_controller.dart';
import '../../../logic/controllers/portfolio_controller.dart';
import '../../widgets/quantity_input.dart';

class AddAssetScreen extends StatefulWidget {
  const AddAssetScreen({super.key});

  @override
  State<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final searchCtrl = Get.find<CoinSearchController>();
  final portCtrl = Get.find<PortfolioController>();
  final _api = CoinGeckoService();

  String? selectedCoinId;
  Map<String, dynamic>? selectedDetail;
  bool loadingDetail = false;
  bool searching = false;
  List<Map<String, dynamic>> _marketList = [];

  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  double quantity = 0.0;

  @override
  void initState() {
    super.initState();
    loadMarketCoins();
  }

  @override
  void dispose() {
    _qtyController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadMarketCoins() async {
    setState(() => searching = true);
    try {
      _marketList = await _api.fetchTopMarketCoins();
      print("Loaded ${_marketList.length} market coins");
    } catch (e) {
      print(' Failed to load market list: $e');
    }
    setState(() => searching = false);
  }

  Future<void> _onSelectCoin(String id) async {
    selectedCoinId = id;
    selectedDetail = null;
    loadingDetail = true;
    setState(() {});
    try {
      final detail = await _api.fetchCoinDetail(id);
      selectedDetail = detail;

      await Future.delayed(const Duration(milliseconds: 200));
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load coin details.');
    } finally {
      loadingDetail = false;
      setState(() {});
    }
  }

  Future<void> _onAddPressed() async {
    final q = double.tryParse(_qtyController.text) ?? 0.0;
    if (selectedCoinId == null) {
      Get.snackbar('Validation', 'Please select a coin',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (q <= 0) {
      Get.snackbar('Validation', 'Please enter a valid quantity',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    await portCtrl.addOrUpdateHolding(selectedCoinId!, q);
    await portCtrl.refreshPrices();
    Get.back();
    Get.snackbar('Added', '${selectedDetail?['name'] ?? selectedCoinId} added',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.of(context).size.height * 0.9;

    return SafeArea(
      child: SizedBox(
        height: sheetHeight,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 12,
          ),
          child: Column(
            children: [
              // handle bar
              Container(
                height: 6,
                width: 48,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const Text(
                'Add Asset',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              //content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (loadingDetail)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (selectedDetail != null)
                      Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(selectedDetail!['image'] ?? ''),
                            backgroundColor: Colors.white,
                          ),
                          title: Text(selectedDetail!['name'] ?? ''),
                          subtitle: Text(
                            selectedDetail!['symbol'].toString().toUpperCase(),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${(selectedDetail!['current_price'] as num?)?.toDouble().toStringAsFixed(2) ?? '0.00'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff0395eb),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${(selectedDetail!['price_change_percentage_24h'] as num?)?.toDouble().toStringAsFixed(2) ?? 0.0}% '
                                '(${(selectedDetail!['price_change_24h'] as num?)?.toDouble().toStringAsFixed(2) ?? 0.0})',
                                style: TextStyle(
                                  color: ((selectedDetail!['price_change_24h']
                                                      as num?)
                                                  ?.toDouble() ??
                                              0.0) <
                                          0
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Search input
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search coin name or symbol...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (v) => setState(() {}),
                    ),
                    const SizedBox(height: 8),

                    // Live suggestions list
                    searching
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: _filteredCoins().length,
                              itemBuilder: (context, i) {
                                final c = _filteredCoins()[i];
                                final isNegative =
                                    (c['price_change_percentage_24h'] ?? 0) < 0;
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(c['image'] ?? ''),
                                      backgroundColor: Colors.white,
                                    ),
                                    title: Text(
                                      "${c['market_cap_rank']}. ${c['name']}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    subtitle: Text(
                                      c['symbol'].toString().toUpperCase(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '\$${(c['current_price'] as num).toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: Color(0xff0395eb),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "${isNegative ? '' : '+'}${(c['price_change_percentage_24h'] ?? 0).toStringAsFixed(2)}%",
                                          style: TextStyle(
                                            color: isNegative
                                                ? Colors.red
                                                : Colors.green,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () => _onSelectCoin(c['id']),
                                  ),
                                );
                              },
                            ),
                          ),

                    const SizedBox(height: 10),

                    // Quantity input
                    QuantityInput(
                      controller: _qtyController,
                      onChanged: (v) => quantity = v,
                    ),
                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: (selectedCoinId != null &&
                              _qtyController.text.trim().isNotEmpty &&
                              (double.tryParse(_qtyController.text) ?? 0) > 0)
                          ? _onAddPressed
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Add to Portfolio',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),

                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _filteredCoins() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _marketList;
    return _marketList
        .where((c) =>
            c['name'].toString().toLowerCase().contains(query) ||
            c['symbol'].toString().toLowerCase().contains(query))
        .toList();
  }
}
