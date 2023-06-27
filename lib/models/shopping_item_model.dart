import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listify/utils/constants/utils.dart';

class ShoppingItemModel {
  DateTime createdTime;
  String id;
  String name;
  int qty;
  String? unit; // pcs, kg, l
  int? price;
  bool isDone;

  ShoppingItemModel({
    required this.createdTime,
    this.id = '',
    required this.name,
    required this.qty,
    this.unit = 'pcs',
    this.price,
    this.isDone = false,
  });

  ShoppingItemModel.fromJson(Map<String, Object?> json)
      : this(
          createdTime: Utils.toDateTime(json['created_time']! as Timestamp),
          id: json['id']! as String,
          name: json['name']! as String,
          qty: json['qty']! as int,
          unit: json['unit']! as String,
          price: json['price']! as int,
          isDone: json['is_done']! as bool,
        );

  Map<String, dynamic> toJson() => {
        'created_time': createdTime,
        'id': id,
        'name': name,
        'qty': qty,
        'unit': unit,
        'price': price,
        'is_done': isDone,
      };
}
