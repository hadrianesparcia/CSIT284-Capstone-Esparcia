import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onAdd;

  const MenuItemCard({super.key, required this.item, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.restaurant)),
        title: Text(item.name),
        subtitle: Text('${item.category} • ₱${item.price.toStringAsFixed(0)}'),
        trailing: IconButton.filled(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: onAdd,
          tooltip: 'Add to cart',
        ),
      ),
    );
  }
}