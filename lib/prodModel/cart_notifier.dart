import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:mollet/prodModel/cart.dart';

class CartNotifier with ChangeNotifier {
  List<Cart> _cartList = [];
  Cart _cart;

  UnmodifiableListView<Cart> get cartList => UnmodifiableListView(_cartList);

  Cart get cart => _cart;

  set cartList(List<Cart> cartList) {
    _cartList = cartList;
    notifyListeners();
  }

  set cart(Cart cart) {
    _cart = cart;
    notifyListeners();
  }
}
