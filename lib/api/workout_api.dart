import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Workout Planner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WorkoutHomePage(),
    );
  }
}

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  bool isLoading = false;
  dynamic workoutResult;

  final headers = {
    'content-type': 'application/json',
    'X-RapidAPI-Key': '4f1bdc0242mshbc73ad954ee2b21p1f6fbejsn74f88fab2915',
    'X-RapidAPI-Host':
    'ai-workout-planner-exercise-fitness-nutrition-guide.p.rapidapi.com'
  };

  Future<void> fetchWorkoutPlan() async {
    setState(() {
      isLoading = true;
      workoutResult = null;
    });

    final url = Uri.parse(
        'https://ai-workout-planner-exercise-fitness-nutrition-guide.p.rapidapi.com/generateWorkoutPlan?noqueue=true');

    final body = jsonEncode({
      "goal": "Build muscle",
      "fitness_level": "Intermediate",
      "preferences": ["Weight training", "Cardio"],
      "health_conditions": ["None"],
      "schedule": {
        "days_per_week": 4,
        "session_duration": 60,
        "plan_duration_weeks": 4
      },
      "lang": "en"
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        setState(() {
          workoutResult = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          workoutResult = {
            'error': 'Error ${response.statusCode}: ${response.body}'
          };
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        workoutResult = {'error': 'Failed to fetch workout plan: $e'};
        isLoading = false;
      });
    }
  }

  Widget _buildWorkoutPlan(Map<String, dynamic> plan) {
    // Check if the response has a 'weeks' field (common structure)
    if (plan.containsKey('weeks')) {
      return ListView.builder(
        itemCount: plan['weeks'].length,
        itemBuilder: (context, weekIndex) {
          final week = plan['weeks'][weekIndex];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Week ${weekIndex + 1}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...week['days'].map<Widget>((day) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            day['day'] ?? 'Day',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          ...(day['exercises'] as List).map<Widget>((ex) {
                            final exercise = ex as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exercise['name'] ?? 'Exercise',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                      'Sets: ${exercise['sets'] ?? '-'}, Reps: ${exercise['repetitions'] ?? '-'}, Duration: ${exercise['duration'] ?? '-'}'),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      );
    }
    // If the structure is different, display the raw JSON
    return SingleChildScrollView(
      child: Text(
        const JsonEncoder.withIndent('  ').convert(plan),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Workout Planner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: isLoading ? null : fetchWorkoutPlan,
              child: const Text('Generate Workout Plan'),
            ),
            const SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Expanded(
              child: workoutResult == null
                  ? const Center(child: Text('Press the button to fetch your plan.'))
                  : workoutResult['error'] != null
                  ? Center(child: Text(workoutResult['error']))
                  : _buildWorkoutPlan(workoutResult),
            ),
          ],
        ),
      ),
    );
  }
}