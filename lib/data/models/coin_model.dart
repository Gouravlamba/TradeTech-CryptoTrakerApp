class CoinModel {
  final String id;
  final String symbol;
  final String name;

  CoinModel({required this.id, required this.symbol, required this.name});

  factory CoinModel.fromJson(Map<String, dynamic> j) => CoinModel(
        id: j['id'] as String,
        symbol: j['symbol'] as String,
        name: j['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'symbol': symbol,
        'name': name,
      };
}
