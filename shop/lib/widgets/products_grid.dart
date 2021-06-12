import 'package:app_name/providers/products.dart';
import 'package:app_name/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductGrid extends HookWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = useProvider(filteredProductsProvider);

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (ctx, i) => ProviderScope(
          overrides: [currentProductProvider.overrideWithValue(products[i])],
          child: const ProductItem()),
      itemCount: products.length,
    );
  }
}
