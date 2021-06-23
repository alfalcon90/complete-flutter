import 'package:app_name/providers/cart.dart';
import 'package:app_name/providers/products.dart';
import 'package:app_name/screens/cart_screen.dart';
import 'package:app_name/widgets/app_drawer.dart';
import 'package:app_name/widgets/badge.dart';
import 'package:app_name/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverviewScreen extends HookWidget {
  OverviewScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final filter = useProvider(productListFilterProvider);
    final cartQuantity = useProvider(cartQuantityProvider);

    useEffect(() {
      context.read(productsProvider.notifier).fetch();
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              filter.state = selectedValue;
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              )
            ],
            icon: Icon(Icons.more_vert),
          ),
          Badge(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
            value: cartQuantity,
            color: Colors.black,
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(),
    );
  }
}
