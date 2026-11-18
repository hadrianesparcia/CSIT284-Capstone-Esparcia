import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';
import '../models/order.dart';

/// Simple in-memory app state (no accounts, no backend).
class AppState extends ChangeNotifier {
  AppState._();
  static final AppState instance = AppState._();

  final List<CartLine> cart = [];
  final List<Order> orders = [];
  int _nextOrderId = 1;

  int get cartCount => cart.fold(0, (s, l) => s + l.qty);
  double get cartTotal => cart.fold(0, (s, l) => s + l.subtotal);

  void addToCart(MenuItem item) {
    final i = cart.indexWhere((l) => l.item.id == item.id);
    if (i >= 0) {
      cart[i].qty++;
    } else {
      cart.add(CartLine(item, 1));
    }
    notifyListeners();
  }

  void decrease(CartLine line) {
    line.qty--;
    if (line.qty <= 0) cart.remove(line);
    notifyListeners();
  }

  void increase(CartLine line) {
    line.qty++;
    notifyListeners();
  }

  void placeOrder(String studentId) {
    if (cart.isEmpty) return;
    orders.insert(
      0,
      Order(
        id: _nextOrderId++,
        studentId: studentId,
        lines: cart.map((l) => CartLine(l.item, l.qty)).toList(),
        placedAt: DateTime.now(),
      ),
    );
    cart.clear();
    notifyListeners();
  }

  /// Simulates the canteen staff marking an order as ready.
  void markReady(Order order) {
    order.status = OrderStatus.ready;
    notifyListeners();
  }
}