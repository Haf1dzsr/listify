import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listify/utils/constants/utils.dart';

class ShoppingPlanModel {
  DateTime createdTime;
  String id;
  String title;
  String? description;
  bool isDone;
  bool isFavorited;

  ShoppingPlanModel({
    required this.createdTime,
    this.id = '',
    required this.title,
    this.description,
    this.isDone = false,
    this.isFavorited = false,
  });

  ShoppingPlanModel.fromJson(Map<String, Object?> json)
      : this(
          createdTime: Utils.toDateTime(json['created_time']! as Timestamp),
          id: json['id']! as String,
          title: json['title']! as String,
          description: json['description']! as String,
          isDone: json['is_done']! as bool,
          isFavorited: json['is_favorited']! as bool,
        );

  Map<String, dynamic> toJson() => {
        'created_time': createdTime,
        'id': id,
        'title': title,
        'description': description,
        'is_done': isDone,
        'is_favorited': isFavorited,
      };
}
