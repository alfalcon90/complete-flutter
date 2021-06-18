import 'package:app_name/providers/products.dart';
import 'package:app_name/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManagedProductItem extends StatelessWidget {
  const ManagedProductItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(product.title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.imageUrl),
          ),
          trailing: Container(
            width: 120,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditProductScreen.routeName,
                        arguments: product);
                  },
                  icon: Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 16,
                ),
                IconButton(
                    onPressed: () {
                      context
                          .read(productsProvider.notifier)
                          .remove(product.id);
                    },
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor),
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
