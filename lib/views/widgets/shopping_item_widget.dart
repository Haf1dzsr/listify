import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:listify/models/shopping_item_model.dart';
import 'package:listify/provider/shopping_item_provider.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:listify/utils/constants/utils.dart';
import 'package:listify/views/screens/detail_screen/update_shopping_item_dialog_widget.dart';
import 'package:provider/provider.dart';

class ShoppingItemWidget extends StatelessWidget {
  final ShoppingItemModel item;
  final String id;

  const ShoppingItemWidget({
    required this.item,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingItemProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          key: Key(item.id),
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
                      builder: (context) => UpdateShoppingItem(
                        item: item,
                        id: id,
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
                  provider.removeShoppingItem(item, id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Deleted success'),
                      backgroundColor: accentColor,
                    ),
                  );
                }, //
                backgroundColor: dangerColor,
                foregroundColor: textColor,
                icon: Icons.delete,
              ),
            ],
          ),
          child: buildItem(context),
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context) {
    final provider = Provider.of<ShoppingItemProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ,
        //   ),
        // );
      },
      child: ListTile(
        tileColor: secColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: Checkbox(
          shape: const StadiumBorder(),
          activeColor: accentColor,
          checkColor: secColor,
          value: item.isDone,
          onChanged: (_) {
            provider.itemToggleStatus(item, id);
          },
        ),
        title: Text(item.name),
        trailing: Text(
            " ${item.qty}  ${item.unit}     |     ${Utils.idrFormat(item.price as num)}"),
      ),
    );
  }
}
