import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/services/firebase_service.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:listify/views/screens/completed_plan_screen/shopping_completed_screen.dart';
import 'package:listify/views/screens/favorited_plan_screen/shopping_favorited_screen.dart';
import 'package:listify/views/widgets/add_shopping_plan_dialog_widget.dart';
import 'package:listify/views/widgets/shopping_plan_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Shopping Plans'),
        backgroundColor: bgColor,
        foregroundColor: textColor,
      ),
      drawer: Drawer(
        backgroundColor: bgColor,
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingPlanCompleted(),
                  ),
                ),
                title: const Text(
                  'Completed Shopping Plans',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),

              // ! isFavorited navigation
              ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingFavoritedScreen(),
                  ),
                ),
                title: const Text(
                  'Favorited Shopping Plans',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
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
        query: FirebaseService.readData().where('is_done', isEqualTo: false),
        itemBuilder: (context, snapshot) {
          final plan = snapshot.data();
          return ShoppingPlanWidget(plan: plan);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: accentColor,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AddShoppingPlanDialog();
          },
        ),
        icon: const Icon(
          Icons.add,
          color: bgColor,
          weight: 100,
        ),
        label: const Text(
          'New Plan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: bgColor,
          ),
        ),
      ),
    );
  }
}
