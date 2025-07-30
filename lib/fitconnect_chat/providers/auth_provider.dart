// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/user.dart';
// import '../services/api_service.dart';
//
// class AuthProvider with ChangeNotifier {
//   User? _user;
//   bool _isLoading = false;
//
//   User? get user => _user;
//   bool get isLoading => _isLoading;
//   bool get isLoggedIn => _user != null;
//
//   Future<void> checkAuthStatus() async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userJson = prefs.getString('user');
//
//       if (userJson != null) {
//         // Parse stored user data
//         final userData = json.decode(userJson);
//         _user = User.fromJson(userData);
//       }
//     } catch (e) {
//       print('Error checking auth status: $e');
//     }
//
//     _isLoading = false;
//     notifyListeners();
//   }
//
//   Future<bool> login(String username, String password) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await ApiService.login(username, password);
//       final userData = response['user'];
//
//       _user = User.fromJson(userData);
//
//       // Store user data locally
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('user', json.encode(userData));
//
//       _isLoading = false;
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       throw e;
//     }
//   }
//
//   Future<bool> register(String username, String password, String name, String bio, String location) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await ApiService.register(username, password, name, bio, location);
//       final userData = response['user'];
//
//       _user = User.fromJson(userData);
//
//       // Store user data locally
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('user', json.encode(userData));
//
//       _isLoading = false;
//       notifyListeners();
//       return true;
//     } catch (e) {
//       _isLoading = false;
//       notifyListeners();
//       throw e;
//     }
//   }
//
//   Future<void> logout() async {
//     _user = null;
//
//     // Clear stored data
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('user');
//
//     notifyListeners();
//   }
// }