import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controllers/coin_search_controller.dart';

typedef OnCoinSelect = void Function(String coinId);

class SearchBox extends StatefulWidget {
  final CoinSearchController controller;
  final OnCoinSelect onSelect;
  const SearchBox(
      {super.key, required this.controller, required this.onSelect});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _t = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.controller.allCoins.isEmpty) widget.controller.loadCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: _t,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search coin by name or symbol',
        ),
        onChanged: widget.controller.search,
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 220,
        child: Obx(() {
          final results = widget.controller.results;
          if (widget.controller.isLoading.value)
            return const Center(child: CircularProgressIndicator());
          if (results.isEmpty) return const Center(child: Text('No results'));
          return ListView.separated(
            itemCount: results.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (c, i) {
              final coin = results[i];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(coin.symbol
                      .substring(0, coin.symbol.length > 1 ? 1 : 1)
                      .toUpperCase()),
                ),
                title: Text(coin.name),
                subtitle: Text(coin.symbol.toUpperCase()),
                onTap: () {
                  widget.onSelect(coin.id);

                  _t.text = '${coin.name} (${coin.symbol.toUpperCase()})';
                  FocusScope.of(context).unfocus();
                },
              );
            },
          );
        }),
      ),
    ]);
  }
}
