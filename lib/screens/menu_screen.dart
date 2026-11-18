import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';
import '../widgets/menu_item_card.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _selected = 'All';

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    final categories = ['All', ...dummyMenu.map((m) => m.category).toSet()];
    final items = _selected == 'All'
        ? dummyMenu
        : dummyMenu.where((m) => m.category == _selected).toList();

    return ListenableBuilder(
      listenable: state,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Canteen Menu'),
          actions: [
            IconButton(
              icon: const Icon(Icons.receipt_long),
              tooltip: 'My orders',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const OrdersScreen())),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 56,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) => ChoiceChip(
                  label: Text(categories[i]),
                  selected: _selected == categories[i],
                  onSelected: (_) => setState(() => _selected = categories[i]),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                itemCount: items.length,
                itemBuilder: (context, i) => MenuItemCard(
                  item: items[i],
                  onAdd: () {
                    state.addToCart(items[i]);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${items[i].name} added'),
                      duration: const Duration(milliseconds: 800),
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: state.cartCount == 0
            ? null
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    icon: const Icon(Icons.shopping_cart),
                    label: Text(
                      'View cart • ${state.cartCount} items • ₱${state.cartTotal.toStringAsFixed(0)}',
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CartScreen())),
                  ),
                ),
              ),
      ),
    );
  }
}