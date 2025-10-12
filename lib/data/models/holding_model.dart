class HoldingModel {
  final String coinId;
  double quantity;

  HoldingModel({required this.coinId, required this.quantity});

  factory HoldingModel.fromJson(Map<String, dynamic> j) => HoldingModel(
        coinId: j['coinId'] as String,
        quantity: (j['quantity'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'coinId': coinId,
        'quantity': quantity,
      };
}
