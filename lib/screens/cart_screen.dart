import 'package:flutter/material.dart';
import '../state/app_state.dart';
import 'orders_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _idController = TextEditingController();
  final state = AppState.instance;

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  void _place() {
    final id = _idController.text.trim();
    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your student ID')),
      );
      return;
    }
    state.placeOrder(id);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const OrdersScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('Your Cart')),
        body: state.cart.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        for (final line in state.cart)
                          ListTile(
                            title: Text(line.item.name),
                            subtitle:
                                Text('₱${line.subtotal.toStringAsFixed(0)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => state.decrease(line),
                                ),
                                Text('${line.qty}'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => state.increase(line),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField(
                          controller: _idController,
                          decoration: const InputDecoration(
                            labelText: 'Student ID',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Total: ₱${state.cartTotal.toStringAsFixed(0)}  (Cash on pickup)',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _place,
                            child: const Text('Place Order'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}