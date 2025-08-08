import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gymproject/Screens/home.dart';
import 'package:gymproject/api/workout_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://szxoutelzflcujsirgwh.supabase.co', // <<--- REPLACE ME
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN6eG91dGVsemZsY3Vqc2lyZ3doIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM2Nzc3OTAsImV4cCI6MjA2OTI1Mzc5MH0.5oU_9zRpmgw6PSQZ2bMLwkh1Dsr4iqSkzPPl23dBhTM', // <<--- REPLACE ME
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  // TODO: Replace with your actual Google OAuth client IDs.
  static const String webClientId =
      '1059141546121-usjagn0oettdrtan1taq7mpsfqdmgnbo.apps.googleusercontent.com'; // <<--- REPLACE ME
  static const String iosClientId =
      'YOUR_GOOGLE_IOS_CLIENT_ID'; // <<--- REPLACE ME

  Future<void> _googleSignIn() async {
    setState(() => _isLoading = true);
    try {
      // Use singleton instance
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      // Initialize with client IDs
      await googleSignIn.initialize(
        clientId: iosClientId,
        serverClientId: webClientId,
      );

      // Trigger the sign-in flow
      final GoogleSignInAccount? user = await googleSignIn.authenticate();

      if (user == null) {
        // User cancelled the sign-in
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login cancelled.')),
        );
        return; // Exit early
      }

      // Get the ID token
      final GoogleSignInAuthentication auth = await user.authentication;
      final idToken = auth.idToken;

      if (idToken == null) {
        throw Exception('Failed to get ID token from Google Sign-In');
      }

      // Sign in with Supabase using the Google ID token
      final AuthResponse response =
          await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        // accessToken can be omitted as it's often not available in google_sign_in v7+
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const GymHomeScreen()));
        // TODO: Navigate to home/profile screen after login
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Login failed: ${response.error?.message ?? 'Unknown error'}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Column(
        children: [
          SizedBox(),
          Center(
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _googleSignIn,
              icon: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.login),
              label: const Text('Sign in with Google'),
            ),
          ),
          Row(
            children: [
              ElevatedButton(

                onPressed:(){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const WorkoutHomePage()),
                  );
                },
                child: Text("Get Workout Plan"))],
          )
        ],
      ),
    );
  }
}

extension on AuthResponse {
  get error => null;
}
