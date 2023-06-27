import 'package:flutter/material.dart';
import 'package:listify/models/shopping_item_model.dart';

import 'package:listify/services/firebase_service.dart';

class ShoppingItemProvider with ChangeNotifier {
  /// add shopping item
  Future<void> addShoppingItem(ShoppingItemModel item) async {
    await FirebaseService.createShoppingItem(item);
  }

  /// remove shopping item
  Future<void> removeShoppingItem(ShoppingItemModel item, String id) async {
    await FirebaseService.deleteShoppingItem(item, id);
  }

  /// update shopping item
  Future<void> updateShoppingItem(
    ShoppingItemModel item,
    String id,
    String newName,
    int newQty,
    String newUnit,
    int newPrice,
  ) async {
    item.name = newName;
    item.qty = newQty;
    item.unit = newUnit;
    item.price = newPrice;
    await FirebaseService.updateShoppingItem(item, id);
  }

  /// isDone widget plan method
  bool itemToggleStatus(ShoppingItemModel item, String id) {
    item.isDone = !item.isDone;
    FirebaseService.updateShoppingItem(item, id);
    return item.isDone;
  }
}
