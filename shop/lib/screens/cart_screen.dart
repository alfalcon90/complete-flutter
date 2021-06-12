import 'package:app_name/providers/cart.dart';
import 'package:app_name/providers/orders.dart';
import 'package:app_name/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartScreen extends HookWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = useProvider(cartProvider);
    final total = context.read(cartProvider.notifier).total;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Chip(
                    label: Text(
                      '\$$total',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      context
                          .read(ordersProvider.notifier)
                          .addOrder(cart, total);
                      context.read(cartProvider.notifier).clear();
                    },
                    child: Text('Order Now'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CartListItem(cartItem: cart[i]),
            itemCount: cart.length,
          ))
        ],
      ),
    );
  }
}
