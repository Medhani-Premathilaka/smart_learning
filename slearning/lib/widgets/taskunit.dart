import 'package:flutter/material.dart';

class TaskUnit extends StatelessWidget {
  final String title; // Task name
  final String startDate; // Start date
  final String endDate; // Optional end date
  final bool isInProgress; // To indicate "IN PROGRESS" or "DONE"
  final Color circleColor; // Background color for the circle

  const TaskUnit({
    Key? key,
    required this.title,
    required this.startDate,
    this.endDate = '',
    this.isInProgress = false,
    this.circleColor = Colors.green, // Default green color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circle with title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19,vertical: 10),
          child: Column(
            
            children: [
              Container(
                width: 93,
                height: 93,
                decoration: BoxDecoration(
          color: circleColor,
          borderRadius: BorderRadius.circular(30), 
                ),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                     // textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16), // Space between circle and task details

        // Task details (dates and status)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 0),
          child: Expanded(
            child: Container(
              width: 200,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[300], // Light grey background
                borderRadius: BorderRadius.circular(8),
                //textAlign:TextAlign.center,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Started: $startDate',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (endDate.isNotEmpty)
                    Text(
                      'Ended: $endDate',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      
                    ),
                  Text(
                    isInProgress ? 'IN PROGRESS' :'DONE' ,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isInProgress ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildSkillBox(String skill) {
    return Container(
      width: 93, // Adjusted size
      height: 93, // Adjusted size
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(30), // Rounded corners
      ),
      child: Center(
        child: Text(
          skill,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    
  }
}
