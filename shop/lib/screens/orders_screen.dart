import 'package:app_name/providers/orders.dart';
import 'package:app_name/widgets/app_drawer.dart';
import 'package:app_name/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrdersScreen extends HookWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = useProvider(ordersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderListItem(order: orders[i]),
        itemCount: orders.length,
      ),
    );
  }
}
