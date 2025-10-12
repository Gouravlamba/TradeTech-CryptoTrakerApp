import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<double> onChanged;

  const QuantityInput({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: const InputDecoration(
        labelText: 'Quantity',
        hintText: 'Enter quantity',
        prefixIcon: Icon(Icons.numbers_outlined),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        final parsed = double.tryParse(value) ?? 0.0;
        onChanged(parsed);
      },
    );
  }
}
