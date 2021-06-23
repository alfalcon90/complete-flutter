import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      isFavorite: map['isFavorite'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
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

  Future<void> add(Product newProduct) async {
    try {
      Uri url = Uri.parse(
          'https://udemy-shop-ed71b-default-rtdb.firebaseio.com/products.json');
      await post(url, body: newProduct.toJson());
      state = [...state, newProduct];
    } catch (err) {
      print(err);
    }
  }

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

  void update(Product updatedProduct) async {
    try {
      Uri url = Uri.parse(
          'https://udemy-shop-ed71b-default-rtdb.firebaseio.com/products/${updatedProduct.id}.json');
      await patch(url, body: updatedProduct.toJson());
    } catch (err) {
      print(err);
    }
    state = [
      for (final product in state)
        if (product.id == updatedProduct.id)
          product.copyWith(
            title: updatedProduct.title,
            description: updatedProduct.description,
            price: updatedProduct.price,
            imageUrl: updatedProduct.imageUrl,
          )
        else
          product
    ];
  }

  void remove(String id) {
    state = state.where((product) => product.id != id).toList();
  }

  Future<void> fetch() async {
    try {
      Uri url = Uri.parse(
          'https://udemy-shop-ed71b-default-rtdb.firebaseio.com/products.json');
      Response res = await get(url);
      Map<String, dynamic> fetchedProducts = json.decode(res.body);

      state = [...fetchedProducts.values.map((e) => Product.fromMap(e))];
    } catch (err) {
      print(err);
    }
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
