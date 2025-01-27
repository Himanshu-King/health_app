import 'package:flutter/material.dart';
import 'food_selection_page.dart'; // Importing the food selection page

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  _DietPageState createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  final Map<String, List<String>> meals = {
    'Breakfast': [],
    'Morning Snack': [],
    'Lunch': [],
    'Evening Snack': [],
    'Dinner': [],
  };

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive design
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet'),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04), // Responsive padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Weight and Caloric Intake
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: const [
                      Text('Current Weight', style: TextStyle(fontSize: 16)),
                      Text('59 Kgs', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: const [
                      Text('1024', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('kcal', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Daily Meals Section
              const Text('Daily Meals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildMealItem(context, 'Breakfast', 'Recommended 447 kcal'),
              _buildMealItem(context, 'Morning Snack', 'Recommended 547 kcal'),
              _buildMealItem(context, 'Lunch', 'Recommended 547 kcal'),
              _buildMealItem(context, 'Evening Snack', 'Recommended 547 kcal'),
              _buildMealItem(context, 'Dinner', 'Recommended 547 kcal'),
              const SizedBox(height: 20),

              // Search Bar
              const Text('What did you eat?', style: TextStyle(fontSize: 16)),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search for foods...',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealItem(BuildContext context, String meal, String recommendation) {
    return ListTile(
      title: Text(meal),
      subtitle: Text(recommendation),
      trailing: const Icon(Icons.add),
      onTap: () async {
        // Open a dialog for food selection instead of navigating to a new page
        final selectedFood = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return const FoodSelectionDialog(); // Custom dialog for food selection
          },
        );

        if (selectedFood != null) {
          setState(() {
            meals[meal]?.add(selectedFood); // Add the selected food to the meal
          });
          // Optionally, show a message or update the UI to reflect the added food
          print('Selected food for $meal: $selectedFood');
        }
      },
    );
  }
}
