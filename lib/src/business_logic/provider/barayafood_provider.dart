import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:barayafood/src/data/model/barayafood.dart';
import 'package:barayafood/src/data/repository/repository.dart';
import 'package:barayafood/src/business_logic/provider/barayafood_state.dart';

class BarayaFoodProvider with ChangeNotifier {
  BarayaFoodState _state;
  late List<BarayaFood> _allItems;

  final Repository repository;

  BarayaFoodProvider({required this.repository})
      : _state = BarayaFoodState.initial(repository.getBarayaFoodList) {
    _allItems = List.from(_state.mainItems); // Inisialisasi _allItems di sini
  }
  BarayaFoodState get state => _state;

  void filterBarayaFood(String query) {
    List<BarayaFood> filteredItems;

    if (query.isEmpty) {
      filteredItems = List.from(_allItems);
    } else {
      filteredItems = _allItems
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    _state = _state.copyWith(mainItems: filteredItems);
    notifyListeners();
  }

  increaseQuantity(BarayaFood barayafood) {
    final List<BarayaFood> mainItems = _state.mainItems.map((element) {
      if (element.id == barayafood.id) {
        return element.copyWith(quantity: barayafood.quantity + 1);
      }
      return element;
    }).toList();
    _state = _state.copyWith(mainItems: mainItems);
    calculateTotalPrice();
    notifyListeners();
  }

  decreaseQuantity(BarayaFood barayafood) {
    if (barayafood.quantity > 1) {
      final List<BarayaFood> mainItems = _state.mainItems.map((element) {
        if (element.id == barayafood.id) {
          return element.copyWith(quantity: barayafood.quantity - 1);
        }
        return element;
      }).toList();

      _state = _state.copyWith(mainItems: mainItems);
    } else {
      deleteFromCart(barayafood);
    }
    calculateTotalPrice();
    notifyListeners();
  }

  addToCart(BarayaFood barayafood) {
    final List<BarayaFood> cartItems = _state.mainItems.map((element) {
      if (element.id == barayafood.id) {
        return element.copyWith(cart: true);
      }
      return element;
    }).toList();
    _state = _state.copyWith(mainItems: cartItems);
    calculateTotalPrice();
  }

  deleteFromCart(BarayaFood barayafood) {
    final List<BarayaFood> cartItems = _state.mainItems.map((element) {
      if (element.id == barayafood.id) {
        return element.copyWith(cart: false);
      }
      return element;
    }).toList();

    _state = _state.copyWith(mainItems: cartItems);
    notifyListeners();
  }

  clearCart() {
    List<BarayaFood> mainItems = _state.mainItems
        .map((element) => element.copyWith(cart: false))
        .toList();

    _state = _state.copyWith(mainItems: mainItems);
    calculateTotalPrice();
    notifyListeners();
  }

  calculateTotalPrice() {
    double totalPrice = 0.0;

    for (var element in _state.mainItems) {
      if (element.cart) {
        totalPrice += element.quantity * element.price;
      }
    }
    _state =
        _state.copyWith(mainItems: _state.mainItems, totalPrice: totalPrice);
  }

  get getCartList => _state.mainItems.where((element) => element.cart).toList();
}
