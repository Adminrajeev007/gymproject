// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:gymproject/auth/login_page.dart';
//
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _loading = false;
//
//   void _signup() async {
//     setState(() => _loading = true);
//     try {
//       final res = await Supabase.instance.client.auth.signUp(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Signup successful! Check your email for verification.')),
//       );
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup failed: $e')));
//     } finally {
//       setState(() => _loading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Signup')),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
//             TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _loading ? null : _signup,
//               child: _loading ? const CircularProgressIndicator() : const Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
