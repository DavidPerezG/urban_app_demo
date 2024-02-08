import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> locations = [
    {'name': 'Location 1', 'progress': 1.0},
    {'name': 'Location 2', 'progress': 0.8},
    {'name': 'Location 3', 'progress': 0.6},
    {'name': 'Location 4', 'progress': 0.4},
    {'name': 'Location 5', 'progress': 0.2},
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
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // signOut method when the user presses the logout button
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: locations.map((location) {
              return ExpansionTile(
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        task['task'] ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        task['status'] ?? '',
                        style: TextStyle(
                          color: task['status'] == 'Finished'
                              ? Colors.green
                              : Colors.orange,
                        ),
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
