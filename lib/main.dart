import 'package:flutter/material.dart';
import 'welcomescreen/welcome1.dart';
import 'package:gymproject/HomeScreen/homeScreen.dart';
import 'functions/steps.dart';
import 'package:gymproject/Screens/home.dart';
import 'package:gymproject/auth/main_auth.dart';
import 'package:gymproject/auth/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/perplexity_auth.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://szxoutelzflcujsirgwh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN6eG91dGVsemZsY3Vqc2lyZ3doIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM2Nzc3OTAsImV4cCI6MjA2OTI1Mzc5MH0.5oU_9zRpmgw6PSQZ2bMLwkh1Dsr4iqSkzPPl23dBhTM',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      // home: const GymHomeScreen(),
    );
  }
}



