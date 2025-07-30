// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'providers/auth_provider.dart';
// import 'screens/auth/login_screen.dart';
// import 'screens/discover/discover_screen.dart';
// import 'screens/chat/chat_list_screen.dart';
// import 'screens/profile/profile_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//       ],
//       child: MaterialApp(
//         title: 'FitConnect',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             elevation: 0,
//           ),
//         ),
//         home: const AuthWrapper(),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }
//
// class AuthWrapper extends StatefulWidget {
//   const AuthWrapper({Key? key}) : super(key: key);
//
//   @override
//   State<AuthWrapper> createState() => _AuthWrapperState();
// }
//
// class _AuthWrapperState extends State<AuthWrapper> {
//   @override
//   void initState() {
//     super.initState();
//     _checkAuthStatus();
//   }
//
//   Future<void> _checkAuthStatus() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     await authProvider.checkAuthStatus();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthProvider>(
//       builder: (context, authProvider, child) {
//         if (authProvider.isLoading) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//
//         if (authProvider.user == null) {
//           return const LoginScreen();
//         }
//
//         return const MainScreen();
//       },
//     );
//   }
// }
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;
//
//   final List<Widget> _screens = [
//     const DiscoverScreen(),
//     const ChatListScreen(),
//     const ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore),
//             label: 'Discover',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'Chats',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }