import 'package:hooks_riverpod/hooks_riverpod.dart';

class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite;

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}

class Products extends StateNotifier<List<Product>> {
  Products()
      : super([
          Product(
            id: 'p1',
            title: 'Red Shirt',
            description: 'A red shirt - it is pretty red!',
            price: 29.99,
            imageUrl:
                'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          ),
          Product(
            id: 'p2',
            title: 'Trousers',
            description: 'A nice pair of trousers.',
            price: 59.99,
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
          ),
          Product(
            id: 'p3',
            title: 'Yellow Scarf',
            description:
                'Warm and cozy - exactly what you need for the winter.',
            price: 19.99,
            imageUrl:
                'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
          ),
          Product(
            id: 'p4',
            title: 'A Pan',
            description: 'Prepare any meal you want.',
            price: 49.99,
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
          ),
        ]);

  void addProduct() {}

  Product findById(String id) {
    return state.firstWhere((product) => product.id == id);
  }

  void toggleFavorite(String id) {
    state = [
      for (final product in state)
        if (product.id == id)
          product.copyWith(isFavorite: !product.isFavorite)
        else
          product
    ];
  }
}

enum FilterOptions { Favorites, All }

final productsProvider =
    StateNotifierProvider<Products, List<Product>>((_) => Products());

final currentProductProvider = ScopedProvider<Product>(null);

final productListFilterProvider = StateProvider((_) => FilterOptions.All);

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final filter = ref.watch(productListFilterProvider);
  final products = ref.watch(productsProvider);

  switch (filter.state) {
    case FilterOptions.Favorites:
      return products.where((product) => product.isFavorite).toList();
    default:
      return products;
  }
});
