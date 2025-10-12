import 'package:crypto_portfolio/core/helpers/formatters.dart';
import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TotalValueBanner extends StatelessWidget {
  final double total;
  const TotalValueBanner({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.banner,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Portfolio Value',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 6),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: total),
              duration: const Duration(milliseconds: 700),
              builder: (context, val, child) {
                return Text(
                  currencyFormat(val),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
