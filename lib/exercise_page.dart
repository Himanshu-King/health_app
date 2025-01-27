import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int selectedCalories = 330;
  int selectedTime = 30;

  final List<int> timeOptions = [10, 20, 30, 40, 50, 60];

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive design
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04), // Responsive padding
        child: Column(
          children: [
            // Steps and Calories at the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepCalorieInfo('3,524', 'Steps'),
                _buildStepCalorieInfo('952', 'Calories'),
              ],
            ),
            const SizedBox(height: 20),

            // Exercise cards
            Expanded(
              child: ListView(
                children: [
                  _buildExerciseCard('Skipping', 20),
                  _buildExerciseCard('Cycling', 330),
                  _buildExerciseCard('Running', 330),
                  _buildExerciseCard('Meditation', 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCalorieInfo(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 18, color: Colors.grey)),
      ],
    );
  }

  Widget _buildExerciseCard(String exerciseName, int calories) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Text('$calories Calories'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Show exercise details and calorie tracking when tapped
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return _buildExerciseDetailsBottomSheet(exerciseName);
            },
          );
        },
      ),
    );
  }

  Widget _buildExerciseDetailsBottomSheet(String exerciseName) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select how many calories you can burn', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),

          // Calorie selector
          Text('$selectedCalories Calories', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // Time options
          Wrap(
            spacing: 10,
            children: timeOptions.map((time) {
              return ChoiceChip(
                label: Text('$time min'),
                selected: selectedTime == time,
                onSelected: (selected) {
                  setState(() {
                    selectedTime = time;
                    selectedCalories = time * 11; // Sample calculation
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the modal when user presses 'Save'
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
