import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import for making HTTP requests
import 'dart:convert'; // Import for JSON encoding/decoding

// Define data models for the structured response from the LLM
class MealPlan {
  final String planTitle;
  final List<DailyPlan> dailyPlans;

  MealPlan({required this.planTitle, required this.dailyPlans});

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    var list = json['dailyPlans'] as List;
    List<DailyPlan> dailyPlansList = list.map((i) => DailyPlan.fromJson(i)).toList();
    return MealPlan(
      planTitle: json['planTitle'],
      dailyPlans: dailyPlansList,
    );
  }
}

class DailyPlan {
  final String day;
  final List<Meal> meals;

  DailyPlan({required this.day, required this.meals});

  factory DailyPlan.fromJson(Map<String, dynamic> json) {
    var list = json['meals'] as List;
    List<Meal> mealsList = list.map((i) => Meal.fromJson(i)).toList();
    return DailyPlan(
      day: json['day'],
      meals: mealsList,
    );
  }
}

class Meal {
  final String mealType;
  final String dishName;
  final List<String> ingredients;
  final String instructions;

  Meal({
    required this.mealType,
    required this.dishName,
    required this.ingredients,
    required this.instructions,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mealType: json['mealType'],
      dishName: json['dishName'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: json['instructions'],
    );
  }
}


class MealPlanningScreen extends StatefulWidget {
  const MealPlanningScreen({super.key});

  @override
  State<MealPlanningScreen> createState() => _MealPlanningScreenState();
}

class _MealPlanningScreenState extends State<MealPlanningScreen> {
  String? _selectedGoal;
  final List<String> _selectedDietaryFocus = [];
  bool _isLoading = false;
  MealPlan? _generatedMealPlan;
  String? _errorMessage;

  final List<String> _goals = ['Weight Loss', 'Weight Gain', 'Maintenance'];
  final List<String> _dietaryOptions = [
    'Low Calorie',
    'High Protein',
    'Low Carb',
    'Vegetarian',
    'Vegan',
    'Gluten-Free',
    'Keto',
  ];

  Future<void> _generateMealPlan() async {
    if (_selectedGoal == null && _selectedDietaryFocus.isEmpty) {
      _showSnackbar('Please select at least one goal or dietary focus.');
      return;
    }

    setState(() {
      _isLoading = true;
      _generatedMealPlan = null;
      _errorMessage = null;
    });

    String prompt = "Generate a 7-day meal plan for an adult.";
    if (_selectedGoal != null) {
      prompt += " The primary goal is $_selectedGoal.";
    }
    if (_selectedDietaryFocus.isNotEmpty) {
      prompt += " The dietary focus should include: ${_selectedDietaryFocus.join(', ')}.";
    }
    prompt += " Provide the plan in a structured JSON format with a 'planTitle' (e.g., '7-Day Weight Loss Plan'), and a 'dailyPlans' array. Each daily plan should have a 'day' (e.g., 'Day 1'), and a 'meals' array. Each meal should have 'mealType' (e.g., 'Breakfast', 'Lunch', 'Dinner', 'Snack'), 'dishName', 'ingredients' (as a list of strings), and 'instructions'. Make sure the plan is realistic and healthy.";

    try {
      // THIS IS WHERE THE LLM API CALL HAPPENS
      const String apiKey = ''; // Leave empty, Canvas will inject it
      const String apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

      final Map<String, dynamic> payload = {
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'responseMimeType': 'application/json',
          'responseSchema': {
            'type': 'OBJECT',
            'properties': {
              'planTitle': {'type': 'STRING'},
              'dailyPlans': {
                'type': 'ARRAY',
                'items': {
                  'type': 'OBJECT',
                  'properties': {
                    'day': {'type': 'STRING'},
                    'meals': {
                      'type': 'ARRAY',
                      'items': {
                        'type': 'OBJECT',
                        'properties': {
                          'mealType': {'type': 'STRING'},
                          'dishName': {'type': 'STRING'},
                          'ingredients': {
                            'type': 'ARRAY',
                            'items': {'type': 'STRING'}
                          },
                          'instructions': {'type': 'STRING'}
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['candidates'] != null && responseData['candidates'].isNotEmpty) {
          final String jsonString = responseData['candidates'][0]['content']['parts'][0]['text'];
          // The LLM sometimes wraps the JSON in markdown code block, so we need to clean it
          final String cleanedJsonString = jsonString.replaceAll('```json\n', '').replaceAll('\n```', '');
          final Map<String, dynamic> parsedJson = jsonDecode(cleanedJsonString);
          setState(() {
            _generatedMealPlan = MealPlan.fromJson(parsedJson);
          });
        } else {
          setState(() {
            _errorMessage = 'No meal plan generated. Please try again.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to generate meal plan: ${response.statusCode} ${response.reasonPhrase}';
          print('API Error: ${response.body}');
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        print('Exception during API call: $e');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planning'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Your Goal:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: _goals.map((goal) {
                return ChoiceChip(
                  label: Text(goal),
                  selected: _selectedGoal == goal,
                  onSelected: (selected) {
                    setState(() {
                      _selectedGoal = selected ? goal : null;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Dietary Focus (Optional):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: _dietaryOptions.map((option) {
                return ChoiceChip(
                  label: Text(option),
                  selected: _selectedDietaryFocus.contains(option),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedDietaryFocus.add(option);
                      } else {
                        _selectedDietaryFocus.remove(option);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _generateMealPlan,
                icon: _isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Icon(Icons.auto_awesome),
                label: Text(_isLoading ? 'Generating...' : 'Generate Meal Plan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (_generatedMealPlan != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _generatedMealPlan!.planTitle,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const SizedBox(height: 15),
                      ..._generatedMealPlan!.dailyPlans.map((dailyPlan) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 15),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dailyPlan.day,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                                ),
                                const Divider(),
                                ...dailyPlan.meals.map((meal) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${meal.mealType}: ${meal.dishName}',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Ingredients: ${meal.ingredients.join(', ')}',
                                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Instructions: ${meal.instructions}',
                                          style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}