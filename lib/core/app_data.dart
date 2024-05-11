import 'package:barayafood/src/data/model/bottom_navigation_item.dart';
import 'package:flutter/material.dart';

class AppData {
  const AppData._();

  static const List<BottomNavigationItem> bottomNavigationItems = [
    BottomNavigationItem(Icon(Icons.home), 'Home'),
    BottomNavigationItem(
        Icon(Icons.add_shopping_cart_rounded), 'Shopping cart'),
    BottomNavigationItem(
        Icon(Icons.account_balance_wallet), 'Transaction history'),
  ];
}
