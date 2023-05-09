import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/provider/shopping_plan_provider.dart';
import 'package:listify/services/firebase_service.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:listify/views/widgets/shopping_plan_widget.dart';
import 'package:provider/provider.dart';

class ShoppingPlanCompleted extends StatefulWidget {
  const ShoppingPlanCompleted({
    super.key,
  });

  @override
  State<ShoppingPlanCompleted> createState() => _ShoppingPlanCompletedState();
}

class _ShoppingPlanCompletedState extends State<ShoppingPlanCompleted> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingPlanProvider>(
      builder: (context, provider, _) => Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          // title: const Text('Completed Shopping Plans'),
          title: Container(
            color: bgColor,
            child: TextField(
              onChanged: (value) {
                provider.updateItemTitle(value);
                debugPrint(provider.inputPlansTitle);
              },
              decoration: const InputDecoration(
                  fillColor: bgColor,
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search . . .',
                  border: InputBorder.none),
            ),
          ),
          backgroundColor: bgColor,
          foregroundColor: textColor,
        ),
        body: FirestoreListView<ShoppingPlanModel>(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          emptyBuilder: (context) => const Center(
            child: Text('No plans.'),
          ),
          loadingBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorBuilder: (context, error, stackTrace) => const Text('Error'),
          query: FirebaseService.readData().where('is_done', isEqualTo: true),
          itemBuilder: (context, snapshot) {
            final plan = snapshot.data();

            if (provider.inputPlansTitle.isEmpty) {
              return ShoppingPlanWidget(plan: plan);
            }
            if (plan.title
                .toString()
                .toLowerCase()
                .contains(provider.inputPlansTitle.toLowerCase())) {
              return ShoppingPlanWidget(plan: plan);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
