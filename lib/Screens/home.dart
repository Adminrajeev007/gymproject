import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gymproject/menu/profile.dart';
import 'package:gymproject/menu/notification.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// You might want a package for more advanced carousels,
// but PageView works well for this.
// Example: carousel_slider package (flutter pub add carousel_slider)

class GymHomeScreen extends StatefulWidget {
  final User? user;
  const GymHomeScreen({super.key,this.user});

  @override
  State<GymHomeScreen> createState() => _GymHomeScreenState();
}

class _GymHomeScreenState extends State<GymHomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Replace with your actual image paths from assets
  final List<String> _imagePaths = [
    'assets/images/home_scroll_1.jpg', // Make sure to add these to your pubspec.yaml
    'assets/images/home_scroll_2.jpg',
    'assets/images/home_scroll_3.jpg',
  ];
  String _userName = "Guest";
  String _userEmail = "";

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _loadUserData();
  }


  void _loadUserData() {
    final currentUser = widget.user ?? Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      setState(() {
        // User metadata might contain name, check common fields
        // Google often provides name in user_metadata.full_name or .name
        // Email is usually directly available
        _userName = currentUser.userMetadata?['full_name'] ??
            currentUser.userMetadata?['name'] ??
            currentUser.email?.split('@')[0] ?? // Fallback to part of email
            "User";
        _userEmail = currentUser.email ?? "No email provided";
      });
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(

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
                  Text(
                    'Welcome , $_userName',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined),
                    onPressed: _onNotificationTap,
                  ),
                ],
              ),
            ),
            // Top 30% - Image Carousel
            SizedBox(
              height: screenHeight * 0.3, // 30% of screen height
              child: PageView.builder(
                controller: _pageController,
                itemCount: _imagePaths.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    _imagePaths[index],
                    fit: BoxFit.cover, // Crop to fill the container
                  );
                },
              ),
            ),
            // Optional: Page indicators for the carousel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_imagePaths.length, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor // Or your preferred active color
                        : Colors.grey,
                  ),
                );
              }),
            ),
        
            // Bottom 70% - Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Workout of the Day',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Squats: 3 sets of 10 reps\nBench Press: 3 sets of 8 reps\n...',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
        
                    const Text(
                      'Set up your',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    // You could use a horizontal ListView.builder here for classes
                    SizedBox(
                      height: 120, // Adjust as needed
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          //make it clickable
                          _buildClassCard('Nutrition', '6:00 PM', Colors.blue[100]!),
                          _buildClassCard('Exercise', '7:00 PM', Colors.green[100]!),
                          _buildClassCard('Diet plan', '8:00 PM', Colors.purple[100]!),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
        
                    const Text(
                      'Quick Actions',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: () {}, child: const Text('Check-in')),
                        ElevatedButton(onPressed: () {}, child: const Text('Book Class')),
                      ],
                    ),
                    const SizedBox(height: 20),
        
                    // Example of more content
                    const Text(
                      'Gym News & Updates',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.campaign),
                        title: Text('New equipment arriving next week!'),
                        subtitle: Text('Get ready for an upgraded experience.'),
                      ),
                    ),
                    const SizedBox(height: 200), // To ensure scrolling
                    const Text('End of content'),
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
      )
    );
  }

  Widget _buildClassCard(String title, String time, Color color) {
    return Card(
      color: color,
      margin: const EdgeInsets.only(right: 10),
      child: Container(
        width: 150, // Adjust as needed
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(time),
          ],
        ),
      ),
    );
  }
  int _selectedIndex = 0;
  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
    // Add navigation logic for tabs if needed
  }
}



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return notificationScreen();


    // return FitPassProfileApp();
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
    return notificationScreen();
  }
}



