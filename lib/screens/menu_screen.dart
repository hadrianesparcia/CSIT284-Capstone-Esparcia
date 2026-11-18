import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';
import '../widgets/menu_item_card.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
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
            IconButton(
              icon: Badge(
                isLabelVisible: state.cartCount > 0,
                label: Text('${state.cartCount}'),
                child: const Icon(Icons.shopping_cart),
              ),
              tooltip: 'Cart',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CartScreen())),
            ),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: dummyMenu.length,
          itemBuilder: (context, i) => MenuItemCard(
            item: dummyMenu[i],
            onAdd: () {
              state.addToCart(dummyMenu[i]);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${dummyMenu[i].name} added'),
                duration: const Duration(milliseconds: 800),
              ));
            },
          ),
        ),
      ),
    );
  }
}