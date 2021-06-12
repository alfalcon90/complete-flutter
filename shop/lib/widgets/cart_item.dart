import 'package:app_name/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Dismissible(
        key: ValueKey(cartItem.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          context.read(cartProvider.notifier).remove(cartItem.id);
        },
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 24,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 24),
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FittedBox(child: Text('\$${cartItem.price}')),
                ),
              ),
              title: Text(cartItem.title),
              subtitle: Text('Total: \$${cartItem.price * cartItem.quantity}'),
              trailing: Text('${cartItem.quantity} X'),
            ),
          ),
        ),
      ),
    );
  }
}
