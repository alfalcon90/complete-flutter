import 'package:app_name/providers/products.dart';
import 'package:app_name/screens/edit_product_screen.dart';
import 'package:app_name/widgets/app_drawer.dart';
import 'package:app_name/widgets/managed_products_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsScreen extends HookWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    final products = useProvider(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Products',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemBuilder: (ctx, i) => ManagedProductItem(product: products[i]),
          itemCount: products.length,
        ),
      ),
    );
  }
}
