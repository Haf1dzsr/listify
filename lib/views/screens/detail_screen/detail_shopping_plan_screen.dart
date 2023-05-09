// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listify/models/shopping_item_model.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/services/firebase_service.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:listify/utils/constants/utils.dart';
import 'package:listify/views/widgets/add_shopping_item_dialog.dart';
import 'package:listify/views/widgets/shopping_item_widget.dart';

class DetailShoppingPlan extends StatefulWidget {
  final ShoppingPlanModel plan;

  const DetailShoppingPlan({
    super.key,
    required this.plan,
  });

  @override
  State<DetailShoppingPlan> createState() => _DetailShoppingPlanState();
}

class _DetailShoppingPlanState extends State<DetailShoppingPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        // judul = nama plan
        title: Text(widget.plan.title),
        backgroundColor: bgColor,
        foregroundColor: textColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 2),

          // ? Unchecked item list
          Expanded(
            child: SizedBox(
              height: 50,
              child: FirestoreListView<ShoppingItemModel>(
                shrinkWrap: true,
                pageSize: 5,
                scrollDirection: Axis.vertical,
                emptyBuilder: (context) => const Center(
                  child: Text('What are you going to buy ?'),
                ),
                loadingBuilder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorBuilder: (context, error, stackTrace) =>
                    const Text('Error'),
                query: FirebaseService.readItemData(widget.plan.id)
                    .where('is_done', isEqualTo: false),
                itemBuilder: (context, snapshot) {
                  final item = snapshot.data();

                  return ShoppingItemWidget(
                    item: item,
                    id: widget.plan.id,
                  );
                },
              ),
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //? Item to buy total info
              SizedBox(
                child: Column(
                  children: [
                    const Text(
                      'Item to Buy',
                      style: TextStyle(color: textColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<dynamic>(
                      stream: FirebaseService.readItemBoughtTotal(
                          widget.plan.id, false),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        int totalItems = snapshot.data.docs.length;
                        return Text(
                          totalItems.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        );
                        // const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),

              //? Price Total info
              SizedBox(
                child: Column(
                  children: [
                    const Text(
                      'Price Total',
                      style: TextStyle(color: textColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: FirebaseService.readPriceTotal(widget.plan.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        num priceTotal = 0;
                        for (final doc in snapshot.data.docs) {
                          priceTotal += doc.data()!["price"];
                        }
                        return Text(
                          Utils.idrFormat(priceTotal),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        );
                        // const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),

              //? Item Bought total info
              SizedBox(
                child: Column(
                  children: [
                    const Text(
                      'Item Bought',
                      style: TextStyle(color: textColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<dynamic>(
                      stream: FirebaseService.readItemBoughtTotal(
                          widget.plan.id, true),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // int totalItems = snapshot.data.docs.length;
                          // int itemBoughtCount = snapshot.data!.count;
                          return const CircularProgressIndicator();
                        }
                        int totalItems = snapshot.data.docs.length;
                        return Text(
                          totalItems.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        );
                        // const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
          ),

          // ? Checked item list
          Expanded(
            child: FirestoreListView<ShoppingItemModel>(
              shrinkWrap: true,
              pageSize: 5,
              scrollDirection: Axis.vertical,
              emptyBuilder: (context) => const Center(
                child: Text('No completed items yet'),
              ),
              loadingBuilder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorBuilder: (context, error, stackTrace) => const Text('Error'),
              query: FirebaseService.readItemData(widget.plan.id)
                  .where('is_done', isEqualTo: true),
              itemBuilder: (context, snapshot) {
                final item = snapshot.data();
                return ShoppingItemWidget(
                  item: item,
                  id: widget.plan.id,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: accentColor,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddShoppingItemDialog(
              plan: widget.plan,
            ); // add ShoppingItem
          },
        ),
        icon: const Icon(
          Icons.add,
          color: bgColor,
          weight: 100,
        ),
        label: const Text(
          'Add Item',
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
