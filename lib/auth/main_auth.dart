// import 'package:flutter/material.dart';
// import 'package:gymproject/auth/login_page.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// void main() async {
//   /// TODO: update Supabase credentials with your own
//   await Supabase.initialize(
//     url: 'https://szxoutelzflcujsirgwh.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN6eG91dGVsemZsY3Vqc2lyZ3doIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM2Nzc3OTAsImV4cCI6MjA2OTI1Mzc5MH0.5oU_9zRpmgw6PSQZ2bMLwkh1Dsr4iqSkzPPl23dBhTM',
//   );
//   runApp(const MyApp());
// }
//
// final supabase = Supabase.instance.client;
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Auth',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }
