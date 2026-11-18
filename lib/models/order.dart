import 'menu_item.dart';

enum OrderStatus { pending, ready }

class CartLine {
  final MenuItem item;
  int qty;
  CartLine(this.item, this.qty);
  double get subtotal => item.price * qty;
}

class Order {
  final int id;
  final String studentId;
  final List<CartLine> lines;
  final DateTime placedAt;
  OrderStatus status;

  Order({
    required this.id,
    required this.studentId,
    required this.lines,
    required this.placedAt,
    this.status = OrderStatus.pending,
  });

  double get total => lines.fold(0, (sum, l) => sum + l.subtotal);
}