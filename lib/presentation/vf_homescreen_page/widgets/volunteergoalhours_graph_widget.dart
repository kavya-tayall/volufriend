import 'package:flutter/material.dart';

class GoalProgressWidget extends StatelessWidget {
  final int completedHours;
  final int goalHours;

  const GoalProgressWidget({
    Key? key,
    required this.completedHours,
    required this.goalHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = (completedHours / goalHours).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0), // Consistent horizontal padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Goal',
            style: TextStyle(
              fontSize: 18, // Slightly larger for emphasis
              fontWeight: FontWeight.bold,
              color: Theme.of(context)
                  .colorScheme
                  .onBackground, // Theme-based color
            ),
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * progress,
                height: 20,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Theme color for progress
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '$completedHours of $goalHours hours completed',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
