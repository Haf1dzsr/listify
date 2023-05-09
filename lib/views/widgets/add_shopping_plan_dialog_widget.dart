import 'package:flutter/material.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/provider/shopping_plan_provider.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:provider/provider.dart';

class AddShoppingPlanDialog extends StatefulWidget {
  const AddShoppingPlanDialog({super.key});

  @override
  State<AddShoppingPlanDialog> createState() => _AddShoppingPlanDialogState();
}

class _AddShoppingPlanDialogState extends State<AddShoppingPlanDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingPlanProvider>(context, listen: false);
    return AlertDialog(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Add Plan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 32,
            ),

            //? Form Add title
            TextFormField(
              controller: titleController,
              maxLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (title) {
                if (title!.isEmpty) {
                  return 'The title cannot be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Title',
                hintText: 'Enter the title',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //? Form Add desc
            TextFormField(
              controller: descriptionController,
              maxLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (desc) {
                if (desc!.isEmpty) {
                  return 'The Description can\'t be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Description',
                hintText: 'Enter the description',
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // create todo
                    final plan = ShoppingPlanModel(
                        createdTime: DateTime.now(),
                        id: DateTime.now().toString(),
                        title: titleController.text,
                        description: descriptionController.text);

                    provider.addShoppingPlan(plan);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('New plan added'),
                        backgroundColor: accentColor,
                      ),
                    );
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.of(context).pop(context);
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(accentColor),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: bgColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
