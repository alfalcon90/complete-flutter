import 'package:app_name/providers/cart.dart';
import 'package:app_name/providers/products.dart';
import 'package:app_name/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductItem extends HookWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = useProvider(currentProductProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: product.id);
          },
          child: Hero(
            tag: product.title,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
              onPressed: () {
                context
                    .read(productsProvider.notifier)
                    .toggleFavorite(product.id);
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border)),
          trailing: IconButton(
              onPressed: () {
                context
                    .read(cartProvider.notifier)
                    .addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} was added to your cart'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () => context
                          .read(cartProvider.notifier)
                          .removeQuantity(product.id, 1),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart)),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
