

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    
    // ignore: avoid_types_as_parameter_names
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
    

      _items.update(
        productId,
        (existingCarItem) => CartItem(
          id: existingCarItem.id,
          title: existingCarItem.title,
          price: existingCarItem.price,
          quantity: existingCarItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      notifyListeners();
    }
    // ignore: unused_element
    void removeItem(String productId) {
      _items.remove(productId);
      notifyListeners();
    }

    // ignore: unused_element
    void removeSingleItem(String productaId) {
      if (!_items.containsKey(productId)) {
        return;
      }
      if (!_items.containsKey(productId)) {
        return;
      }
      if (_items[productId]!.quantity > 1) {
        _items.remove(productId);
        notifyListeners();
      } else {
        _items.update(
          productId,
          (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price,
          ),
        );
      }
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String id) {}

  void removeItem(String productId) {}
}
