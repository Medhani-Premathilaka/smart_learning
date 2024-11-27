import 'package:flutter/material.dart';
import 'package:slearning/screens/home.dart';
import 'package:slearning/screens/notice.dart';
import 'package:slearning/screens/profile.dart';
import 'package:slearning/widgets/taskunit.dart';

class Fav extends StatelessWidget {
  const Fav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: 1100,
              child: Stack(
                children: [
                  // Circle 1 (Top-left)
                  Positioned(
                    top: -71,
                    left: -56,
                    child: Container(
                      width: 170,
                      height: 162,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.3),
                      ),
                    ),
                  ),
                  // Circle 2 (Top-left)
                  Positioned(
                    top: 35,
                    left: 25,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.withOpacity(0.4),
                      ),
                    ),
                  ),
                  // Title
                  const Positioned(
                    top: 50,
                    left: 26,
                    child: Text(
                      "Your Choices",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // "New" Button
                  Positioned(
                    top: 109,
                    left: 256,
                    child: InkWell(
                      onTap: () {
                        // Add your button click functionality here
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      borderRadius: BorderRadius.circular(
                          30), // For ripple effect within rounded corners
                      child: Container(
                        width: 104,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 24,
                            ),
                            Text(
                              "New",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 50px Gap Below the "New" Button
                  const Positioned(
                    top: 145, // Adjusted for 50px gap
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  // Task Units
                  Positioned(
                    top: 195, // Adjusted to place task units after the gap
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        const TaskUnit(
                          title: "MySQL",
                          startDate: "2024.05.06",
                          isInProgress: true, // In progress task
                          circleColor: Colors.green,
                        ),
                        
                        const SizedBox(height: 20),
                        const TaskUnit(
                          title: "React.JS",
                          startDate: "2024.05.06",
                          //endDate: "2024.05.08", // Completed task
                          isInProgress: true,
                          circleColor: Colors.green,
                        ),
                      
                        
                        const SizedBox(height: 20),
                        const TaskUnit(
                          title: "Python",
                          startDate: "2024.05.06",
                          isInProgress: true, // In progress task
                          circleColor: Colors.green,
                        ),
                        SizedBox(height: 20),
                        TaskUnit(
                          title: "HTML",
                          startDate: "2024.05.06",
                          isInProgress: false, 
                          endDate: "2024.05.06",// In progress task
                          circleColor: Colors.green.withOpacity(0.75),
                        ),
                        //SizedBox(height: 20),
                        
                        
                        SizedBox(height: 20),
                        TaskUnit(
                          title: "Python",
                          startDate: "2024.05.06",
                          isInProgress: false, // In progress task
                          circleColor: Colors.green.withOpacity(0.75
                          ),
                        ),
                        SizedBox(height: 20),
                        TaskUnit(
                          title: "CSS",
                          startDate: "2024.05.06",
                          endDate: "2024.05.06",
                          isInProgress: false, // In progress task
                          circleColor: Colors.green.withOpacity(0.75),
                        ),
                      ],
                    ),
                  ),
                  // Pagination Dots
                  
                ],
              ),
            ),
          ),
          // Floating Footer Section
          Positioned(
            bottom: 5,
            left: MediaQuery.of(context).size.width / 2 - 190, // Center horizontally
            child: Container(
              width: 380, // Set width to 380
              height: 45, // Set height to 45
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Color(0xFFB6EFA4), // Light green background color
                borderRadius: BorderRadius.circular(30), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5), // Shadow position
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle Home action
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    icon: Icon(Icons.home, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle Star action
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Fav()));
                    },
                    icon: Icon(Icons.star, color: Colors.green),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle Notification action
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Notice()));
                    },
                    icon: Icon(Icons.notifications, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle Profile action
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    icon: Icon(Icons.person, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
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

  Widget _completedSkillBox(String skill) {
    return Container(
      width: 93, // Adjusted size
      height: 93, // Adjusted size
      decoration: BoxDecoration(
        color: Color(0xFF54D149).withOpacity(0.68), // Updated color with opacity
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
