import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:app_name/providers/cart.dart';

class OrderItem {
  OrderItem({
    required this.id,
    required this.total,
    required this.items,
    required this.dateTime,
  });

  final String id;
  final double total;
  final List<CartItem> items;
  final DateTime dateTime;

  OrderItem copyWith({
    String? id,
    double? total,
    List<CartItem>? items,
    DateTime? dateTime,
  }) {
    return OrderItem(
      id: id ?? this.id,
      total: total ?? this.total,
      items: items ?? this.items,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}

class Orders extends StateNotifier<List<OrderItem>> {
  Orders(List<OrderItem> state) : super(state);

  void addOrder(List<CartItem> items, double total) {
    state = [
      ...state,
      OrderItem(
        id: DateTime.now().toString(),
        total: total,
        items: items,
        dateTime: DateTime.now(),
      )
    ];
  }

  void clear() {
    state = [];
  }

  void removeOrder(String id) {
    state = state.where((order) => order.id != id).toList();
  }
}

final ordersProvider =
    StateNotifierProvider<Orders, List<OrderItem>>((_) => Orders([]));
