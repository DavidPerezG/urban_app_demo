import 'package:flutter/material.dart';
import 'package:urban_app/src/screens/intake_screen.dart';
import 'package:urban_app/src/screens/moodboard.dart';
import 'package:urban_app/src/screens/questionnaire_screen.dart';
// Import other screens as needed

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Define a mapping of task names to corresponding screens
  final Map<String, Widget> taskScreens = {
    'Intake': IntakeScreen(),
    'Questionnaire': QuestionnaireScreen(),
    'Moodboard': MoodboardScreen(),
    // Add other screens as needed
  };

  List<Map<String, dynamic>> locations = [
    {'name': 'Foyer', 'progress': 9.0},
    {'name': 'Study room', 'progress': 1.0},
    {'name': 'Piano room/ Sitting area', 'progress': 0.6},
    {'name': 'Dining room', 'progress': 0.4},
    {'name': 'Living room', 'progress': 0.1},
  ];

  List<Map<String, String>> tasks = [
    {'task': 'Intake', 'status': 'Finished'},
    {'task': 'Questionnaire', 'status': 'Finished'},
    {'task': 'Moodboard', 'status': 'Finished'},
    {'task': 'Rendering', 'status': 'Awaiting'},
  ];

  @override
  void initState() {
    super.initState();
  }

  Color getColor(double progress) {
    if (progress >= 0.80) {
      return Colors.green;
    } else if (progress >= 0.6) {
      return Colors.yellow;
    } else if (progress >= 0.3) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // signOut method when the user presses the logout button
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: locations.map((location) {
              return ExpansionTile(
                shape: CircleBorder(eccentricity: 0.1),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${location['name']}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    LinearProgressIndicator(
                      value: location['progress'],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        getColor(location['progress']),
                      ),
                    ),
                  ],
                ),
                initiallyExpanded: false,
                children: tasks.map((task) {
                  return InkWell(
                    onTap: () {
                      // Check if the task name is in the mapping
                      if (taskScreens.containsKey(task['task'])) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => taskScreens[task['task']]!,
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task['task'] ?? '',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            task['status'] ?? '',
                            style: TextStyle(
                              color: task['status'] == 'Finished'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
