// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:gymproject/auth/main_auth.dart';
// import 'package:gymproject/auth/profile_screen.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _setupAuthListener();
//
//   }
//
//   void _setupAuthListener() {
//     supabase.auth.onAuthStateChange.listen((data) {
//       final event = data.event;
//       if (event == AuthChangeEvent.signedIn) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => const ProfileScreen(),
//           ),
//         );
//       }
//     });
//   }
//
//   Future<AuthResponse> _googleSignIn() async {
//     /// TODO: update the Web client ID with your own.
//     ///
//     /// Web Client ID that you registered with Google Cloud.
//     const webClientId = '1059141546121-usjagn0oettdrtan1taq7mpsfqdmgnbo.apps.googleusercontent.com';
//
//     /// TODO: update the iOS client ID with your own.
//     ///
//     /// iOS Client ID that you registered with Google Cloud.
//     const iosClientId = 'my-ios.apps.googleusercontent.com';
//
//     // Google sign in on Android will work without providing the Android
//     // Client ID registered on Google Cloud.
//
//     // final GoogleSignIn googleSignIn = GoogleSignIn(
//     //   clientId: iosClientId,
//     //   serverClientId: webClientId,
//     // );
//     // final googleUser = await googleSignIn.signIn();
//     // final googleAuth = await googleUser!.authentication;
//     // final accessToken = googleAuth.accessToken;
//     // final idToken = googleAuth.idToken;
//     final signIn = GoogleSignIn.instance;
//     await signIn.initialize(
//       clientId: "<YOUR_IOS_CLIENT_ID>",
//       serverClientId: "<YOUR_WEB_CLIENT_ID>",
//     );
//
//     final GoogleSignInAccount? user = await signIn.authenticate();
//     if (user == null) {
//       // User cancelled
//       return null;
//     }
//
//     final GoogleSignInAuthentication auth = await user.authentication;
//     final idToken = auth.idToken;
//     final accessToken = auth.accessToken;
// // Use idToken & accessToken for Supabase etc.
//
//
//     if (accessToken == null) {
//       throw 'No Access Token found.';
//     }
//     if (idToken == null) {
//       throw 'No ID Token found.';
//     }
//
//     return supabase.auth.signInWithIdToken(
//       provider: OAuthProvider.google,
//       idToken: idToken,
//       accessToken: accessToken,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _googleSignIn,
//           child: const Text('Google login'),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});
// //
// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }
// //
// // class _LoginScreenState extends State<LoginScreen> {
// //   @override
// //   void initState() {
// //     _setupAuthListener();
// //     super.initState();
// //   }
// //
// //   void _setupAuthListener() {
// //     supabase.auth.onAuthStateChange.listen((data) {
// //       final event = data.event;
// //       if (event == AuthChangeEvent.signedIn) {
// //         Navigator.of(context).pushReplacement(
// //           MaterialPageRoute(
// //             builder: (context) => const ProfileScreen(),
// //           ),
// //         );
// //       }
// //     });
// //   }
// //
// //   Future<AuthResponse> _googleSignIn() async {
// //     /// TODO: update the Web client ID with your own.
// //     ///
// //     /// Web Client ID that you registered with Google Cloud.
// //     const webClientId = '1059141546121-usjagn0oettdrtan1taq7mpsfqdmgnbo.apps.googleusercontent.com ';
// //
// //     /// TODO: update the iOS client ID with your own.
// //     ///
// //     /// iOS Client ID that you registered with Google Cloud.
// //     const iosClientId = 'my-ios.apps.googleusercontent.com';
// //
// //     // Google sign in on Android will work without providing the Android
// //     // Client ID registered on Google Cloud.
// //
// //     final GoogleSignIn googleSignIn = GoogleSignIn(
// //       clientId: iosClientId,
// //       serverClientId: webClientId,
// //     );
// //     final googleUser = await googleSignIn.signIn();
// //     final googleAuth = await googleUser!.authentication;
// //     final accessToken = googleAuth.accessToken;
// //     final idToken = googleAuth.idToken;
// //
// //     if (accessToken == null) {
// //       throw 'No Access Token found.';
// //     }
// //     if (idToken == null) {
// //       throw 'No ID Token found.';
// //     }
// //
// //     return supabase.auth.signInWithIdToken(
// //       provider: OAuthProvider.google,
// //       idToken: idToken,
// //       accessToken: accessToken,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Login'),
// //       ),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: _googleSignIn,
// //           child: const Text('Google login'),
// //         ),
// //       ),
// //     );
// //   }
// // }
