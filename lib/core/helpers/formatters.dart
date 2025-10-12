import 'package:intl/intl.dart';

String currencyFormat(double value) {
  final f = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  return f.format(value);
}

String quantityFormat(double q) {
  if (q == q.roundToDouble()) return q.toStringAsFixed(0);
  if (q < 1) return q.toStringAsFixed(6);
  return q.toStringAsFixed(4);
}
