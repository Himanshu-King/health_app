import 'package:flutter/material.dart';

class FoodSelectionDialog extends StatelessWidget {
  const FoodSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> foods = ['Apple', 'Banana', 'Tomato', 'Carrot', 'Egg']; // Sample foods

    return AlertDialog(
      title: const Text('Select Food'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(foods[index]),
              onTap: () {
                Navigator.pop(context, foods[index]); // Return the selected food
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog without selection
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
