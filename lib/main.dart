import 'package:flutter/material.dart';
import 'vitals_page.dart'; // Importing the new pages
import 'diet_page.dart';
import 'exercise_page.dart';
import 'womens_health_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Health Features'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildCard(context, 'Vitals', const VitalsPage(), 'assets/vitals.png'),
          _buildCard(context, 'Diet', const DietPage(), 'assets/diet.png'),
          _buildCard(context, 'Exercise', const ExercisePage(), 'assets/exercise.png'),
          _buildCard(context, 'Women\'s Health', const WomensHealthPage(), 'assets/womens_health.png'),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Widget page, String imageUrl) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Column(
          children: [
            Image.asset(imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
