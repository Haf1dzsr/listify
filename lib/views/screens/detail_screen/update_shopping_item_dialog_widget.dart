import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:listify/models/shopping_item_model.dart';
import 'package:listify/provider/shopping_item_provider.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:provider/provider.dart';

class UpdateShoppingItem extends StatefulWidget {
  final ShoppingItemModel item;
  final String id;
  const UpdateShoppingItem({
    super.key,
    required this.item,
    required this.id,
  });

  @override
  State<UpdateShoppingItem> createState() => _UpdateShoppingItemState();
}

class _UpdateShoppingItemState extends State<UpdateShoppingItem> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  SingleValueDropDownController unitController =
      SingleValueDropDownController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.item.name;
    qtyController.text = widget.item.qty.toString();
    unitController = SingleValueDropDownController(
        data: DropDownValueModel(
            name: widget.item.unit!, value: widget.item.unit));
    // widget.item.unit ?? '';
    priceController.text = widget.item.price.toString();
  }

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
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.item.name),
        backgroundColor: bgColor,
        actions: [
          IconButton(
            onPressed: () {
              provider.removeShoppingItem(widget.item, widget.item.id);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Deleted success'),
                  backgroundColor: accentColor,
                ),
              );

              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              // ? Form update item name
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
                  hintText: 'Enter the new item name',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // ?  Form qty n unit
              Row(
                children: [
                  // ? form update qty
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
                        hintText: 'Enter the new quantity',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),

                  // ? form update unit
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
                height: 16,
              ),

              // ? Form update price
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
                  hintText: 'Enter the new price',
                ),
              ),
              const SizedBox(
                height: 32,
              ),

              // ? Update Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider.updateShoppingItem(
                        widget.item,
                        widget.id,
                        nameController.text,
                        int.parse(qtyController.text),
                        unitController.dropDownValue!.value,
                        int.parse(priceController.text),
                      );
                      nameController.clear();
                      qtyController.clear();
                      unitController.clearDropDown();
                      priceController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Item edited'),
                          backgroundColor: accentColor,
                        ),
                      );
                      Navigator.of(context).pop();
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
                        fontWeight: FontWeight.bold, color: textColor),
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
