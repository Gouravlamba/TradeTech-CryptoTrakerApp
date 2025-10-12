import 'package:crypto_portfolio/core/helpers/formatters.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/holding_model.dart';
import '../../../logic/controllers/portfolio_controller.dart';
import '../../../data/services/coin_image_service.dart';

class PortfolioCard extends StatelessWidget {
  final HoldingModel holding;
  const PortfolioCard({super.key, required this.holding});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PortfolioController>();
    final name = ctrl.getCoinName(holding.coinId);
    final price = ctrl.prices[holding.coinId] ?? 0.0;
    final total = price * holding.quantity;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: FutureBuilder<String?>(
          future: CoinImageService().getCoinImage(holding.coinId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data!),
                backgroundColor: Colors.white,
              );
            } else {
              return const CircleAvatar(
                child: Icon(Icons.currency_bitcoin),
              );
            }
          },
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "${holding.coinId.toUpperCase()} • Qty: ${quantityFormat(holding.quantity)}",
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currencyFormat(price),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(currencyFormat(total)),
          ],
        ),
        onLongPress: () => _showRemoveDialog(context, ctrl),
      ),
    );
  }

  void _showRemoveDialog(BuildContext ctx, PortfolioController ctrl) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Remove asset?'),
        content: Text('Remove ${holding.coinId} from portfolio?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ctrl.removeHolding(holding.coinId);
              Navigator.pop(ctx);
              Get.snackbar('Removed', '${holding.coinId} removed',
                  snackPosition: SnackPosition.BOTTOM);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
