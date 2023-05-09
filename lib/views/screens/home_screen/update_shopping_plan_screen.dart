import 'package:flutter/material.dart';
import 'package:listify/models/shopping_plan_model.dart';
import 'package:listify/provider/shopping_plan_provider.dart';
import 'package:listify/utils/constants/theme.dart';
import 'package:provider/provider.dart';

class UpdateShoppingPlan extends StatefulWidget {
  final ShoppingPlanModel plan;
  const UpdateShoppingPlan({Key? key, required this.plan}) : super(key: key);

  @override
  State<UpdateShoppingPlan> createState() => _UpdateShoppingPlanState();
}

class _UpdateShoppingPlanState extends State<UpdateShoppingPlan> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.plan.title;
    descriptionController.text = widget.plan.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingPlanProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Shopping Plan'),
        backgroundColor: bgColor,
        actions: [
          IconButton(
            onPressed: () {
              provider.removeShoppingPlan(widget.plan);
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),

              //? Form Update title
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
                  hintText: 'Enter new title',
                ),
              ),
              const SizedBox(
                height: 16,
              ),

              //? Form update desc
              TextFormField(
                controller: descriptionController,
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (desc) {
                  if (desc!.isEmpty) {
                    return 'The title can\'t be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Description',
                  hintText: 'Enter new description',
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
                      String newTitle = titleController.text;
                      String newDescription = descriptionController.text;
                      // edit todo
                      provider.updateShoppingPlan(
                          widget.plan, newTitle, newDescription);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('The plan successfully edited'),
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
                    'Save',
                    style: TextStyle(
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
