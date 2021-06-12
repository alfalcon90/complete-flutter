import 'package:app_name/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderListItem extends HookWidget {
  const OrderListItem({Key? key, required this.order}) : super(key: key);

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    return Card(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.total}'),
            subtitle:
                Text(DateFormat('dd MM yyyy hh:mm').format(order.dateTime)),
            trailing: IconButton(
              icon: Icon(
                  isExpanded.value ? Icons.expand_less : Icons.expand_more),
              onPressed: () => isExpanded.value = !isExpanded.value,
            ),
          ),
          if (isExpanded.value)
            Container(
              height: min(order.items.length * 24.0 + 16, 240.0),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                itemBuilder: (ctx, i) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.items[i].title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${order.items[i].quantity}x \$${order.items[i].price}',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                ),
                itemCount: order.items.length,
              ),
            )
        ],
      ),
    );
  }
}
