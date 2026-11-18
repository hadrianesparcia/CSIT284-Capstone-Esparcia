import 'package:flutter/material.dart';
import '../models/order.dart';

class StatusChip extends StatelessWidget {
  final OrderStatus status;
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final ready = status == OrderStatus.ready;
    return Chip(
      label: Text(ready ? 'Ready' : 'Pending'),
      backgroundColor: ready ? Colors.green.shade100 : Colors.orange.shade100,
      avatar: Icon(ready ? Icons.check_circle : Icons.hourglass_top, size: 18),
    );
  }
}