import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/provider/shopping_plan_provider.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:listify/views/screens/detail_screen/detail_shopping_plan_screen.dart';
import 'package:listify/views/screens/home_screen/update_shopping_plan_screen.dart';
import 'package:listify/views/widgets/shopping_item_bought_total_info_widget.dart';
import 'package:provider/provider.dart';

class ShoppingPlanWidget extends StatelessWidget {
  final ShoppingPlanModel plan;

  const ShoppingPlanWidget({
    required this.plan,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingPlanProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          key: Key(plan.id),
          direction: Axis.horizontal,
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              // edit
              SlidableAction(
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateShoppingPlan(
                        plan: plan,
                      ),
                    ),
                  );
                },
                backgroundColor: accentColor,
                foregroundColor: textColor,
                icon: Icons.edit,
              ),
            ],
          ),

          // delete
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  provider.removeShoppingPlan(plan);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Deleted success'),
                      backgroundColor: accentColor,
                    ),
                  );
                },
                backgroundColor: dangerColor,
                foregroundColor: whiteColor,
                icon: Icons.delete,
              ),
            ],
          ),
          child: buildPlan(context),
        ),
      ),
    );
  }

  Widget buildPlan(BuildContext context) {
    final provider = Provider.of<ShoppingPlanProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailShoppingPlan(
              plan: plan,
              // index: index,
            ),
          ),
        );
      },
      child: Container(
        color: secColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  shape: const StadiumBorder(),
                  activeColor: accentColor,
                  checkColor: secColor,
                  value: plan.isDone,
                  onChanged: (_) {
                    plan.isFavorited == true
                        ? _
                        : provider.planToggleStatus(plan);
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 22,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          plan.description ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                plan.isDone == false
                    ? BoughtItemTotalInfoWidget(plan: plan)
                    : IconButton(
                        onPressed: () {
                          provider.planFavoritedStatus(plan);
                        },
                        icon: !plan.isFavorited
                            ? const Icon(
                                Icons.favorite_border,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: dangerColor,
                              ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
