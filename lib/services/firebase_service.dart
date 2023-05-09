import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listify/models/shopping_item_model.dart';
import 'package:listify/models/shopping_plan_model.dart';

class FirebaseService {
  
  /// query read plan
  static CollectionReference<ShoppingPlanModel> readData() {
    
    final collectionRef = FirebaseFirestore.instance.collection('plan');
    final collection = collectionRef.withConverter<ShoppingPlanModel>(
      fromFirestore: (snapshot, _) =>
          ShoppingPlanModel.fromJson(snapshot.data()!),
      toFirestore: (plan, _) => plan.toJson(),
    );

    return collection;
  }

  /// add shopping plan
  static Future createShoppingPlan(ShoppingPlanModel plan) async {
    final docPlan = FirebaseFirestore.instance
        .collection('plan')
        .doc(DateTime.now().toIso8601String());

    plan.id = docPlan.id;
    await docPlan.set(plan.toJson());
  }

  /// update shopping plan
  static Future updateShoppingPlan(ShoppingPlanModel plan) async {
    final docPlan = FirebaseFirestore.instance.collection('plan').doc(plan.id);
    await docPlan.update(plan.toJson());
  }

  /// remove shopping plan
  static Future deleteShoppingPlan(ShoppingPlanModel plan) async {
    final docPlan = FirebaseFirestore.instance.collection('plan').doc(plan.id);
    await docPlan.delete();
  }

  /// read total item in detail page that already or not bought yet
  static Stream<dynamic> readItemBoughtTotal(String id, bool isDoneStatus) =>
      FirebaseFirestore.instance
          .collection('plan')
          .doc(id)
          .collection('item')
          .where('is_done', isEqualTo: isDoneStatus)
          .snapshots();

  /// read total item in detail page
  static Stream<dynamic> readItemTotal(String id) => FirebaseFirestore.instance
      .collection('plan')
      .doc(id)
      .collection('item')
      .snapshots();

  /// read total price in detail page
  static Stream<dynamic> readPriceTotal(String id) => FirebaseFirestore.instance
      .collection('plan')
      .doc(id)
      .collection('item')
      .snapshots();

  /// query read item
  static CollectionReference<ShoppingItemModel> readItemData(String id) {
    final collectionRef = FirebaseFirestore.instance
        .collection('plan')
        .doc(id)
        .collection('item');
    final collection = collectionRef.withConverter<ShoppingItemModel>(
      fromFirestore: (snapshot, _) =>
          ShoppingItemModel.fromJson(snapshot.data()!),
      toFirestore: (item, _) => item.toJson(),
    );

    return collection;
  }

  /// add shopping item
  static Future createShoppingItem(ShoppingItemModel item) async {
    final docPlan = FirebaseFirestore.instance.collection('plan').doc(item.id);
    final itemPlan =
        docPlan.collection('item').doc(DateTime.now().toIso8601String());
    item.id = itemPlan.id;

    await itemPlan.set(item.toJson());
  }

  /// update shopping item
  static Future updateShoppingItem(ShoppingItemModel item, String id) async {
    final docPlan = FirebaseFirestore.instance.collection('plan').doc(id);
    final itemPlan = docPlan.collection('item').doc(item.id);
    await itemPlan.update(item.toJson());
  }

  /// remove shopping item
  static Future deleteShoppingItem(ShoppingItemModel item, String id) async {
    final docPlan = FirebaseFirestore.instance.collection('plan').doc(id);
    final itemPlan = docPlan.collection('item').doc(item.id);
    await itemPlan.delete();
  }
}
