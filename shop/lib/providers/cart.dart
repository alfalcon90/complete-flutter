import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartItem {
  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });

  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem copyWith({
    String? id,
    String? productId,
    String? title,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}

class Cart extends StateNotifier<List<CartItem>> {
  Cart(List<CartItem> state) : super(state);

  double get total {
    return state.fold(
        0,
        (double previousValue, item) =>
            previousValue + (item.quantity * item.price));
  }

  void addItem(String productId, double price, String title) {
    if (state.any((item) => item.productId == productId)) {
      // Add to existing item
      state = [
        for (final item in state)
          if (item.productId == productId)
            item.copyWith(quantity: item.quantity + 1)
          else
            item
      ];
    } else {
      // Create new item
      state = [
        ...state,
        CartItem(
          id: DateTime.now().toString(),
          productId: productId,
          title: title,
          quantity: 1,
          price: price,
        )
      ];
    }
  }

  void remove(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void clear() {
    state = [];
  }

  void removeQuantity(String productId, int quantity) {
    int index = state.indexWhere((item) => item.productId == productId);

    if (index.isNegative) {
      return;
    }

    if (state[index].quantity <= 1) {
      this.remove(state[index].id);
    } else {
      state = [
        for (final item in state)
          if (item.productId == productId)
            item.copyWith(quantity: item.quantity - quantity)
          else
            item
      ];
    }
  }
}

final cartProvider =
    StateNotifierProvider<Cart, List<CartItem>>((_) => Cart([]));

final cartQuantityProvider = Provider<String>((ref) {
  return ref
      .watch(cartProvider)
      .fold(0, (int previousValue, item) => previousValue + item.quantity)
      .toString();
});
