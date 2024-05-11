import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barayafood/core/app_style.dart';
import 'package:barayafood/src/data/model/barayafood.dart';
import 'package:barayafood/src/presentation/widget/barayafood_list_view.dart';
import 'package:barayafood/src/business_logic/provider/barayafood_provider.dart';
import 'package:barayafood/src/presentation/screen/barayafood_detail_screen.dart';

class BarayaFoodListScreen extends StatelessWidget {
  const BarayaFoodListScreen({super.key});

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Baraya Food", style: h2Style),
                ],
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        onChanged: (value) {
          context.read<BarayaFoodProvider>().filterBarayaFood(value);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: const Icon(Icons.menu, color: Colors.grey),
          contentPadding: const EdgeInsets.all(20),
          border: textFieldStyle,
          focusedBorder: textFieldStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<BarayaFood> items =
        context.watch<BarayaFoodProvider>().state.mainItems;

    Future<Widget?> navigate(BarayaFood barayafood, int index) {
      return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) => ChangeNotifierProvider.value(
            value: context.read<BarayaFoodProvider>(),
            child: BarayaFoodDetailScreen(barayafood: barayafood, index: index),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            _searchBar(context),
            BarayaFoodListView(barayafoodList: items, onTap: navigate),
            const Text("Popular", style: h2Style),
            BarayaFoodListView(
              barayafoodList: items,
              isHorizontal: false,
              onTap: navigate,
            ),
          ],
        ),
      ),
    );
  }
}
