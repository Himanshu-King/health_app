import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';

class WomensHealthPage extends StatefulWidget {
  const WomensHealthPage({super.key});

  @override
  State<WomensHealthPage> createState() => _WomensHealthPageState();
}

class _WomensHealthPageState extends State<WomensHealthPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime? _lastPeriodDate;
  int _cycleLength = 28; // Default cycle length
  final Map<String, dynamic> _logForToday = {
    "flow": "No Flow",
    "mood": "Happy",
    "symptoms": [],
  };

  @override
  Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  return Scaffold(
    appBar: AppBar(
      title: const Text("Women's Health"),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCalendar(),
          const SizedBox(height: 16),
          _buildLastPeriodInput(),
          const SizedBox(height: 16),
          _buildCycleLengthInput(width), // Pass width here
          const SizedBox(height: 16),
          _buildNextPeriodInfo(),
          const SizedBox(height: 24),
          _buildLogForToday(),
        ],
      ),
    ),
  );
}


  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDate,
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      calendarFormat: CalendarFormat.month,
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
        });
      },
      selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
    );
  }

  Widget _buildLastPeriodInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Last Period Date:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              setState(() {
                _lastPeriodDate = pickedDate;
              });
            }
          },
          child: Text(
            _lastPeriodDate != null
                ? "${_lastPeriodDate!.toLocal()}".split(' ')[0]
                : "Select Date",
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _buildCycleLengthInput(double width) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Cycle Length (days):",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: width * 0.2, // Responsive width for input
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "28",
          ),
          onChanged: (value) {
            setState(() {
              _cycleLength = int.tryParse(value) ?? 28;
            });
          },
        ),
      ),
    ],
  );
}


  Widget _buildNextPeriodInfo() {
    if (_lastPeriodDate == null) {
      return const Text(
        "Please input your last period date.",
        style: TextStyle(fontSize: 16, color: Colors.red),
      );
    }

    DateTime nextPeriodDate = _lastPeriodDate!.add(Duration(days: _cycleLength));
    int daysLeft = nextPeriodDate.difference(DateTime.now()).inDays;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Next Period Date: ${nextPeriodDate.toLocal()}".split(' ')[0],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          daysLeft >= 0
              ? "Days Left: $daysLeft"
              : "Your period is overdue by ${-daysLeft} days.",
          style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
        ),
      ],
    );
  }

  Widget _buildLogForToday() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Log for Today:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildDropdown(
          title: "Flow",
          value: _logForToday["flow"],
          items: ["No Flow", "Light Flow", "Medium Flow", "Heavy Flow"],
          onChanged: (value) {
            setState(() {
              _logForToday["flow"] = value!;
            });
          },
        ),
        const SizedBox(height: 8),
        _buildDropdown(
          title: "Mood",
          value: _logForToday["mood"],
          items: ["Happy", "Stressed", "Sensitive", "Angry", "Relaxed"],
          onChanged: (value) {
            setState(() {
              _logForToday["mood"] = value!;
            });
          },
        ),
        const SizedBox(height: 8),
        _buildSymptomsSelector(),
      ],
    );
  }

  Widget _buildDropdown({
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSymptomsSelector() {
    const symptoms = [
      "Cramps",
      "Bloating",
      "Headache",
      "Nausea",
      "Back Pain",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Symptoms:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8.0,
          children: symptoms.map((symptom) {
            final isSelected = _logForToday["symptoms"].contains(symptom);
            return ChoiceChip(
              label: Text(symptom),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _logForToday["symptoms"].add(symptom);
                  } else {
                    _logForToday["symptoms"].remove(symptom);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
