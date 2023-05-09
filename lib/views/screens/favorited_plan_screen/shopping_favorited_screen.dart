import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/services/firebase_service.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:listify/views/widgets/shopping_plan_widget.dart';

class ShoppingFavoritedScreen extends StatefulWidget {
  const ShoppingFavoritedScreen({
    super.key,
  });

  @override
  State<ShoppingFavoritedScreen> createState() =>
      _ShoppingFavoritedScreenState();
}

class _ShoppingFavoritedScreenState extends State<ShoppingFavoritedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Favorited Shopping Plans'),
        backgroundColor: bgColor,
        foregroundColor: textColor,
      ),
      body: FirestoreListView<ShoppingPlanModel>(
        padding: const EdgeInsets.all(16),
        emptyBuilder: (context) => const Center(
          child: Text('No favorited plan yet'),
        ),
        loadingBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorBuilder: (context, error, stackTrace) => const Text('Error'),
        scrollDirection: Axis.vertical,
        query:
            FirebaseService.readData().where('is_favorited', isEqualTo: true),
        itemBuilder: (context, snapshot) {
          final plan = snapshot.data();
          return ShoppingPlanWidget(plan: plan);
        },
      ),
    );
  }
}
