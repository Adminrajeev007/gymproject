// //232
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:gymproject/functions/steps.dart';
import 'package:gymproject/menu/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StepsNotifier _stepsNotifier = StepsNotifier();
  late Stream<StepCount> _stepCountStream;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen((event) {
      _stepsNotifier.updateSteps(event.steps);
    }).onError((error) {
      debugPrint('Pedometer error: $error');
    });
  }

  void _onProfileTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  void _onNotificationTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationPage()),
    );
  }

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    // Add navigation logic for tabs if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _onProfileTap,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                  const Text(
                    "Gym Home",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined),
                    onPressed: _onNotificationTap,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to Your Gym App!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(12)),
                            height: 120,
                            child: AnimatedBuilder(
                              animation: _stepsNotifier,
                              builder: (context, _) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.directions_walk,
                                      size: 40, color: Colors.orange),
                                  const SizedBox(height: 10),
                                  const Text('Steps',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${_stepsNotifier.steps}',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                                color: Colors.red[100],
                                borderRadius: BorderRadius.circular(12)),
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.local_fire_department,
                                    size: 40, color: Colors.red),
                                SizedBox(height: 10),
                                Text('Calories',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text('523 kcal',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 120,
                      color: Colors.blue[50],
                      alignment: Alignment.center,
                      child: const Text('Your Workout Summary',
                          style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 120,
                      color: Colors.green[50],
                      alignment: Alignment.center,
                      child: const Text('Upcoming Classes',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 8,
          borderRadius: BorderRadius.circular(30),
          shadowColor: Colors.black45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: _selectedIndex,
              onTap: _onTabSelected,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
                BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Dummy Profile Page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return FitPassProfileApp();
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Profile')),
    //   body: const Center(child: Text('Profile Page')),
    // );
  }
}

// Dummy Notification Page
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const Center(child: Text('Notification Page')),
    );
  }
}


//
//
// //
// //
// //
// // import 'package:flutter/material.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   int _selectedIndex = 0;
// //
// //   void _onProfileTap() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => const ProfilePage()),
// //     );
// //   }
// //
// //   void _onNotificationTap() {
// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(builder: (context) => const NotificationPage()),
// //     );
// //   }
// //
// //   void _onTabSelected(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //     // Add navigation logic for other tabs if needed.
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             // Top bar
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   // Profile icon
// //                   GestureDetector(
// //                     onTap: _onProfileTap,
// //                     child: CircleAvatar(
// //                       backgroundColor: Colors.black,
// //                       child: const Icon(Icons.person, color: Colors.white),
// //                     ),
// //                   ),
// //                   // Title (optional)
// //                   const Text(
// //                     "Gym Home",
// //                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
// //                   ),
// //                   // Notification icon
// //                   IconButton(
// //                     icon: const Icon(Icons.notifications_none_outlined),
// //                     onPressed: _onNotificationTap,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             // Scrollable Content
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         'Welcome to Your Gym App!',
// //                         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //                       ),
// //                       const SizedBox(height: 20),
// //
// //                       Container(child:
// //                         Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             Expanded(
// //                               child: Container(
// //                                 padding: const EdgeInsets.all(16),
// //                                 margin: const EdgeInsets.only(right: 8), // spacing between containers
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.orange[100],
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 height: 120,
// //                                 child: Column(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: const [
// //                                     Icon(Icons.directions_walk, size: 40, color: Colors.orange),
// //                                     SizedBox(height: 10),
// //                                     Text(
// //                                       'Steps',
// //                                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                                     ),
// //                                     SizedBox(height: 5),
// //                                     Text(
// //                                       '8,432',
// //                                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                             Expanded(
// //                               child: Container(
// //                                 padding: const EdgeInsets.all(16),
// //                                 margin: const EdgeInsets.only(left: 8), // spacing between containers
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.red[100],
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 height: 120,
// //                                 child: Column(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: const [
// //                                     Icon(Icons.local_fire_department, size: 40, color: Colors.red),
// //                                     SizedBox(height: 10),
// //                                     Text(
// //                                       'Calories',
// //                                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                                     ),
// //                                     SizedBox(height: 5),
// //                                     Text(
// //                                       '523 kcal',
// //                                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //
// //
// //                         ),)
// //                       // Container(
// //                       //   height: 120,
// //                       //   color: Colors.blue[50],
// //                       //   alignment: Alignment.center,
// //                       //   child: const Text('Your Workout Summary',
// //                       //       style: TextStyle(fontSize: 18)),
// //                       // ),
// //                       // const SizedBox(height: 20),
// //                       // Container(
// //                       //   height: 120,
// //                       //   color: Colors.green[50],
// //                       //   alignment: Alignment.center,
// //                       //   child: const Text('Upcoming Classes',
// //                       //       style: TextStyle(fontSize: 18)),
// //                       // ),
// //                       // Add more widgets as per requirements
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             // Bottom Navigation Bar
// //             BottomNavigationBar(
// //               backgroundColor: Colors.white,
// //               currentIndex: _selectedIndex,
// //               onTap: _onTabSelected,
// //               type: BottomNavigationBarType.fixed,
// //               items: const [
// //                 BottomNavigationBarItem(
// //                   icon: Icon(Icons.home), label: 'Home',
// //                 ),
// //                 BottomNavigationBarItem(
// //                   icon: Icon(Icons.fitness_center), label: 'Workouts',
// //                 ),
// //                 BottomNavigationBarItem(
// //                   icon: Icon(Icons.calendar_today), label: 'Schedule',
// //                 ),
// //                 BottomNavigationBarItem(
// //                   icon: Icon(Icons.bar_chart), label: 'Progress',
// //                 ),
// //                 BottomNavigationBarItem(
// //                   icon: Icon(Icons.settings), label: 'Settings',
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // Dummy Profile Page
// // class ProfilePage extends StatelessWidget {
// //   const ProfilePage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Profile')),
// //       body: const Center(child: Text('Profile Page')),
// //     );
// //   }
// // }
// //
// // // Dummy Notification Page
// // class NotificationPage extends StatelessWidget {
// //   const NotificationPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Notifications')),
// //       body: const Center(child: Text('Notification Page')),
// //     );
// //   }
// // }
// //
