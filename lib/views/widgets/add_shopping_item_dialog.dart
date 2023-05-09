import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:listify/models/shopping_item_model.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/provider/shopping_item_provider.dart';

import 'package:listify/utils/constants/theme.dart';
import 'package:provider/provider.dart';

class AddShoppingItemDialog extends StatefulWidget {
  final ShoppingPlanModel plan;
  const AddShoppingItemDialog({
    super.key,
    required this.plan,
  });

  @override
  State<AddShoppingItemDialog> createState() => _AddShoppingItemDialogState();
}

class _AddShoppingItemDialogState extends State<AddShoppingItemDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final SingleValueDropDownController unitController =
      SingleValueDropDownController();
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    qtyController.dispose();
    unitController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingItemProvider>(context, listen: false);
    return AlertDialog(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      content: SizedBox(
        width: 280,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Add Item',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              // ? Form add item name
              TextFormField(
                controller: nameController,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (name) {
                  if (name!.isEmpty) {
                    return 'The name cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'name',
                  hintText: 'Enter the item name',
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              // ? Form qty n unit
              Row(
                children: [
                  // ? form add qty
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: qtyController,
                      maxLines: 1,
                      validator: (qty) {
                        if (qty!.isEmpty) {
                          return 'The quantity cannot be empty';
                        } else if (!qty.contains(RegExp(r'[0-9]'))) {
                          return 'The quantity must be a number';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelText: 'quantity',
                        hintText: 'Enter the quantity',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),

                  //? form add unit
                  Expanded(
                    flex: 2,
                    child: DropDownTextField(
                      controller: unitController,
                      validator: (unit) {
                        if (unit!.isEmpty) {
                          return 'The unit cannot be empty';
                        } else if (!unit
                            .contains(RegExp(r'^(pcs|kg|liter)$'))) {
                          return 'The unit has to be either pcs, kg or l';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (_) {},
                      dropDownItemCount: 3,
                      dropDownList: const [
                        DropDownValueModel(name: 'pcs', value: 'pcs'),
                        DropDownValueModel(name: 'kg', value: 'kg'),
                        DropDownValueModel(name: 'liter', value: 'liter'),
                      ],
                      dropdownColor: secColor,
                      textFieldDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        label: const Text('Unit'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),

              // ? Form add price
              TextFormField(
                controller: priceController,
                maxLines: 1,
                validator: (price) {
                  if (price!.isEmpty) {
                    return 'The price cannot be empty';
                  }
                  if (!price.contains(RegExp(r'[0-9]'))) {
                    return 'The price must be a number';
                  } else {
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'price',
                  hintText: 'Enter the price',
                ),
              ),
              const SizedBox(
                height: 32,
              ),

              // ? Add Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // create todo
                      final item = ShoppingItemModel(
                        createdTime: DateTime.now(),
                        id: widget.plan.id,
                        name: nameController.text,
                        qty: int.parse(qtyController.text),
                        unit: unitController.dropDownValue!.value,
                        price: int.parse(priceController.text) *
                            int.parse(qtyController.text),
                      );

                      provider.addShoppingItem(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('New item added'),
                          backgroundColor: accentColor,
                        ),
                      );

                      nameController.clear();
                      qtyController.clear();
                      unitController.clearDropDown();
                      priceController.clear();
                      Navigator.of(context).pop(context);
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll(accentColor),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
