import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../data/services/coingecko_service.dart';
import '../../../core/helpers/formatters.dart';

class CoinDetailScreen extends StatefulWidget {
  final String coinId;
  const CoinDetailScreen({super.key, required this.coinId});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  final _api = CoinGeckoService();
  Map<String, dynamic>? coin;
  List<double> chartPrices = [];
  bool loading = true;
  bool chartLoading = true;

  @override
  void initState() {
    super.initState();
    loadCoin();
  }

  Future<void> loadCoin() async {
    setState(() {
      loading = true;
      chartLoading = true;
    });

    try {
      coin = await _api.fetchCoinDetail(widget.coinId);
      chartPrices = await _api.fetchCoinChart7d(widget.coinId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load coin details');
    }

    setState(() {
      loading = false;
      chartLoading = false;
    });
  }

  Widget titleAndValue(String title, String value,
      {CrossAxisAlignment align = CrossAxisAlignment.start,
      Color valueColor = Colors.black}) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget buildChart() {
    if (chartLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (chartPrices.isEmpty) {
      return const Text('No chart data available',
          style: TextStyle(color: Colors.grey));
    }

    bool isPositive = chartPrices.last >= chartPrices.first;

    final minY = chartPrices.reduce((a, b) => a < b ? a : b);
    final maxY = chartPrices.reduce((a, b) => a > b ? a : b);

    final lineColor = isPositive ? Colors.greenAccent : Colors.redAccent;

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 231, 231),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: LineChart(
        LineChartData(
          backgroundColor: const Color.fromARGB(255, 235, 231, 231),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: List.generate(
                chartPrices.length,
                (i) => FlSpot(i.toDouble(), chartPrices[i]),
              ),
              color: lineColor,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    lineColor.withOpacity(0.4),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: const FlDotData(show: false),
            ),
          ],
          minY: minY * 0.98,
          maxY: maxY * 1.02,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 17, 32),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Color.fromARGB(255, 0, 17, 32),
                            backgroundImage: NetworkImage(coin?['image'] ?? ''),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${coin!['name']} (${coin!['symbol'].toString().toUpperCase()})",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\₹${(coin!['current_price'] ?? 0).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0395eb),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // --- Price Change
                      Builder(builder: (_) {
                        double change =
                            (coin?['price_change_24h'] ?? 0).toDouble();
                        double pct = (coin?['price_change_percentage_24h'] ?? 0)
                            .toDouble();
                        final isNeg = change < 0;
                        return Text(
                          "24h: ${isNeg ? '' : '+'}${pct.toStringAsFixed(2)}% (${isNeg ? '' : '+'}${change.toStringAsFixed(4)})",
                          style: TextStyle(
                            color:
                                isNeg ? Colors.redAccent : Colors.greenAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),

                      const SizedBox(height: 16),

                      // Chart
                      Expanded(
                        child: Card(
                          color: const Color.fromARGB(255, 235, 231, 231),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Last 7 Days",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                const SizedBox(height: 8),
                                Expanded(child: buildChart()),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      //  Market Stats
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: theme.cardColor.withOpacity(0.95),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleAndValue("Market Cap",
                                    currencyFormat(coin?['market_cap'] ?? 0)),
                                titleAndValue("Rank",
                                    "#${coin?['market_cap_rank'] ?? '-'}",
                                    align: CrossAxisAlignment.end),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleAndValue(
                                  "24h Low",
                                  "\₹${(coin?['low_24h'] ?? 0).toStringAsFixed(2)}",
                                  valueColor: Colors.red,
                                ),
                                titleAndValue(
                                  "24h High",
                                  "\₹${(coin?['high_24h'] ?? 0).toStringAsFixed(2)}",
                                  valueColor: Colors.green,
                                  align: CrossAxisAlignment.end,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleAndValue("Circulating",
                                    "${coin?['circulating_supply'] ?? '-'}"),
                                titleAndValue("Max Supply",
                                    "${coin?['max_supply'] ?? '-'}",
                                    align: CrossAxisAlignment.end),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Back Button
                Positioned(
                  top: MediaQuery.of(context).padding.top + 6,
                  left: 10,
                  child: InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.cardColor.withOpacity(0.8),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 20),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
