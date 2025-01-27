import 'package:flutter/material.dart';

class VitalsPage extends StatelessWidget {
  const VitalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive design
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vitals'),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text('569', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('kcal', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: const [
                    Text('2048', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('steps', style: TextStyle(fontSize: 16)),
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

            // Circular Progress Indicator
            Center(
              child: Container(
                width: width * 0.25, // Adjust based on screen size
                height: width * 0.25,
                child: CircularProgressIndicator(
                  value: 0.7, // Example value for heart health
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Vital Signs Cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildVitalCard('Blood Pressure', '__/__ mmHg'),
                  _buildVitalCard('Heart Rate', '__ bpm'),
                  _buildVitalCard('SpO2', '__%'),
                  _buildVitalCard('Stress Level', 'Relaxed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
