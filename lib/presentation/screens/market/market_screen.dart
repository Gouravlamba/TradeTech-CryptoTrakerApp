import 'package:crypto_portfolio/presentation/screens/coin_details/coin_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../../data/services/coingecko_service.dart';
import 'package:get/get.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final _api = CoinGeckoService();
  List<dynamic> _coins = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadMarket();
  }

  Future<void> loadMarket() async {
    setState(() => _loading = true);
    try {
      _coins = await _api.fetchTopMarketCoins();
      print(" Loaded ${_coins.length} coins");
    } catch (e) {
      print(' Market load error: $e');
    }
    setState(() => _loading = false);
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

            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _coins.isEmpty
                ? const Center(
                    child: Text(
                      'No market data available ',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: loadMarket,
                    child: ListView.builder(
                      itemCount: _coins.length,
                      itemBuilder: (context, i) {
                        final c = _coins[i];
                        final price =
                            (c['current_price'] as num?)?.toDouble() ?? 0.0;
                        final priceChange =
                            (c['price_change_24h'] as num?)?.toDouble() ?? 0.0;
                        final priceChangePct =
                            (c['price_change_percentage_24h'] as num?)
                                    ?.toDouble() ??
                                0.0;
                        final bool isNegative = priceChange < 0;

                        return ListTile(
                          onTap: () {
                            Get.to(
                              () => CoinDetailScreen(coinId: c['id']),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(c['image']),
                            backgroundColor: Colors.white,
                          ),
                          title: Text(
                            "${c['market_cap_rank']}. ${c['name']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            c['symbol'].toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹ ${price.toStringAsFixed(4)}',
                                style: const TextStyle(
                                  color: Color(0xff0395eb),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
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
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
