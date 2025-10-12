import '../../core/constants/api_urls.dart';
import 'network_service.dart';
import '../models/coin_model.dart';

class CoinGeckoService {
  final _net = NetworkService();

  /// Fetch all available coins (id, symbol, name)
  Future<List<CoinModel>> fetchCoinsList() async {
    final res = await _net.get(ApiUrls.coinsList);
    if (res is List) {
      return res.map((e) => CoinModel.fromJson(e)).cast<CoinModel>().toList();
    }
    throw Exception('Unexpected coin list response');
  }

  /// Fetch current prices
  Future<Map<String, double>> fetchPricesUsd(List<String> ids) async {
    if (ids.isEmpty) return {};
    final idsParam = ids.join(',');
    final url = '${ApiUrls.simplePrice}?ids=$idsParam&vs_currencies=usd';
    final res = await _net.get(url);
    if (res is Map<String, dynamic>) {
      final Map<String, double> map = {};
      res.forEach((k, v) {
        try {
          final val = (v['usd'] as num).toDouble();
          map[k] = val;
        } catch (_) {}
      });
      return map;
    }
    throw Exception('Unexpected price response');
  }

  //Compatibility alias used by repositories
  Future<Map<String, double>> fetchPrices(List<String> ids) async {
    return await fetchPricesUsd(ids);
  }

  //Fetch top 20 market coins by market cap
  Future<List<Map<String, dynamic>>> fetchTopMarketCoins() async {
    final url =
        '${ApiUrls.base}/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false';

    final res = await _net.get(url);
    if (res is List) {
      return res.cast<Map<String, dynamic>>();
    }
    return [];
  }

  // Fetch full detail for a single coin
  Future<Map<String, dynamic>> fetchCoinDetail(String id) async {
    final url = '${ApiUrls.base}/coins/$id'
        '?localization=false'
        '&tickers=false'
        '&market_data=true'
        '&community_data=false'
        '&developer_data=false'
        '&sparkline=false';

    final res = await _net.get(url);

    if (res is Map<String, dynamic>) {
      final image = res['image'] is Map
          ? res['image']['large'] ?? res['image']['small']
          : null;
      final market = res['market_data'] ?? {};

      return {
        'id': id,
        'name': res['name'] ?? id,
        'symbol': res['symbol'] ?? '',
        'image': image,

        // Current Prices
        'current_price':
            (market['current_price']?['usd'] as num?)?.toDouble() ?? 0.0,
        'price_change_24h':
            (market['price_change_24h'] as num?)?.toDouble() ?? 0.0,
        'price_change_percentage_24h':
            (market['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,

        // Market data
        'market_cap': (market['market_cap']?['usd'] as num?)?.toDouble() ?? 0.0,
        'market_cap_rank': res['market_cap_rank'] ?? 0,
        'total_volume':
            (market['total_volume']?['usd'] as num?)?.toDouble() ?? 0.0,
        'circulating_supply':
            (market['circulating_supply'] as num?)?.toDouble() ?? 0.0,
        'max_supply': (market['max_supply'] as num?)?.toDouble() ?? 0.0,

        // High/Low
        'high_24h': (market['high_24h']?['usd'] as num?)?.toDouble() ?? 0.0,
        'low_24h': (market['low_24h']?['usd'] as num?)?.toDouble() ?? 0.0,

        //  All-time records
        'ath': (market['ath']?['usd'] as num?)?.toDouble() ?? 0.0,
        'atl': (market['atl']?['usd'] as num?)?.toDouble() ?? 0.0,

        // Dates
        'ath_date': market['ath_date']?['usd'],
        'atl_date': market['atl_date']?['usd'],
      };
    }

    throw Exception('Coin detail fetch failed');
  }

  /// Fetch 7-day market chart
  Future<List<double>> fetchCoinChart7d(String id) async {
    final url = '${ApiUrls.base}/coins/$id/market_chart?vs_currency=usd&days=7';
    final res = await _net.get(url);

    if (res is Map<String, dynamic> && res['prices'] is List) {
      final List prices = res['prices'];
      return prices.map((e) => (e[1] as num).toDouble()).toList();
    }

    return [];
  }
}
