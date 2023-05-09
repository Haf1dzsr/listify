import 'package:flutter/material.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/services/firebase_service.dart';
import 'package:listify/utils/constants/theme.dart';

class BoughtItemTotalInfoWidget extends StatelessWidget {
  final ShoppingPlanModel plan;
  const BoughtItemTotalInfoWidget({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ? checked Bought item total info
        StreamBuilder<dynamic>(
          stream: FirebaseService.readItemBoughtTotal(plan.id, true),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            int boughtTotalItems = snapshot.data.docs.length;

            return Text(
              boughtTotalItems.toString(),
              style: const TextStyle(
                color: accentColor,
              ),
            );
          },
        ),
        const Text(
          ' / ',
          style: TextStyle(
            color: accentColor,
          ),
        ),

        // ? Total the whole items in plan
        StreamBuilder<dynamic>(
          stream: FirebaseService.readItemTotal(plan.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              // int totalItems = snapshot.data.docs.length;
              // int itemBoughtCount = snapshot.data!.count;
              return const CircularProgressIndicator();
            }
            int totalItems = snapshot.data.docs.length;
            return Text(
              totalItems.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            );
          },
        ),

        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.checklist_rounded,
          color: accentColor,
        ),
      ],
    );
  }
}
