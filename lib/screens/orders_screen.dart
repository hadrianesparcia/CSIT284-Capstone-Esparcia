import 'package:flutter/material.dart';
import '../models/order.dart';
import '../state/app_state.dart';
import '../widgets/status_chip.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('My Orders')),
        body: state.orders.isEmpty
            ? const Center(child: Text('No orders yet'))
            : ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, i) {
                  final o = state.orders[i];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order #${o.id} • ID ${o.studentId}',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              StatusChip(status: o.status),
                            ],
                          ),
                          const SizedBox(height: 6),
                          for (final l in o.lines)
                            Text('${l.qty}x ${l.item.name}'),
                          const SizedBox(height: 6),
                          Text(
                              'Total: ₱${o.total.toStringAsFixed(0)} (pay on pickup)'),
                          if (o.status == OrderStatus.pending)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => state.markReady(o),
                                child: const Text('Mark as Ready (staff demo)'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}