import 'package:flutter/material.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/services/firebase_service.dart';

class ShoppingPlanProvider with ChangeNotifier {
  // a variable that contain the onchanged value in the textfield for search query
  String inputPlansTitle = '';

  /// add shopping plan
  void addShoppingPlan(ShoppingPlanModel plan) {
    FirebaseService.createShoppingPlan(plan);
  }

  /// update shopping plan
  Future<void> updateShoppingPlan(
      ShoppingPlanModel plan, String newTitle, String? newDescription) async {
    plan.title = newTitle;
    plan.description = newDescription;
    await FirebaseService.updateShoppingPlan(plan);
  }

  /// remove shopping plan
  Future<void> removeShoppingPlan(ShoppingPlanModel plan) async {
    await FirebaseService.deleteShoppingPlan(plan);
  }

  /// done status whether the plan is done or not
  Future<bool> planToggleStatus(ShoppingPlanModel plan) async {
    plan.isDone = !plan.isDone;
    await FirebaseService.updateShoppingPlan(plan);
    return plan.isDone;
  }

  /// favorited status whether the plan is favorited or not
  Future<bool> planFavoritedStatus(ShoppingPlanModel plan) async {
    plan.isFavorited = !plan.isFavorited;
    await FirebaseService.updateShoppingPlan(plan);
    return plan.isFavorited;
  }

  /// search query
  String updateItemTitle(String inputtedText) {
    inputPlansTitle = inputtedText;
    notifyListeners();
    return inputPlansTitle;
  }
}
