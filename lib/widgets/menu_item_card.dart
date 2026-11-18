import 'package:flutter/material.dart';
import '../models/menu_item.dart';

IconData categoryIcon(String category) {
  switch (category) {
    case 'Meals':
      return Icons.rice_bowl;
    case 'Snacks':
      return Icons.fastfood;
    case 'Drinks':
      return Icons.local_drink;
    case 'Dessert':
      return Icons.icecream;
    default:
      return Icons.restaurant;
  }
}

Color categoryColor(String category) {
  switch (category) {
    case 'Meals':
      return Colors.deepOrange;
    case 'Snacks':
      return Colors.amber.shade700;
    case 'Drinks':
      return Colors.blue;
    case 'Dessert':
      return Colors.pink;
    default:
      return Colors.grey;
  }
}

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onAdd;

  const MenuItemCard({super.key, required this.item, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final color = categoryColor(item.category);
    return Card(
      elevation: 1,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(categoryIcon(item.category), color: color, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(item.category,
                      style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₱${item.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange)),
                const SizedBox(height: 4),
                IconButton.filled(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.add),
                  onPressed: onAdd,
                  tooltip: 'Add to cart',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}