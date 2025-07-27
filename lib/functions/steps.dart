import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';



import 'package:flutter/foundation.dart';


void main() {
  runApp(const StepCounterApp());
}

class StepCounterApp extends StatelessWidget {
  const StepCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StepCounterHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StepCounterHome extends StatefulWidget {
  const StepCounterHome({super.key});

  @override
  State<StepCounterHome> createState() => _StepCounterHomeState();
}

class _StepCounterHomeState extends State<StepCounterHome> {
  String _stepCount = '0';
  String _status = 'Unknown';

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  @override
  void initState() {
    super.initState();
    requestPermission();
    startListening();
  }

  // Ask for activity recognition permission (for Android 10+)
  void requestPermission() async {
    var status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
      await Permission.activityRecognition.request();
    }
  }

  void startListening() {
    _stepCountStream = Pedometer.stepCountStream;
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);
  }

  void onStepCount(StepCount event) {
    setState(() {
      _stepCount = event.steps.toString();
    });
  }

  void onStepCountError(error) {
    setState(() {
      _stepCount = 'Step Count not available';
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Status not available';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Counter'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Steps Taken:', style: TextStyle(fontSize: 24)),
            Text(_stepCount, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text('Status:', style: TextStyle(fontSize: 24)),
            Text(_status, style: TextStyle(fontSize: 32, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}





class StepsNotifier extends ChangeNotifier {
  int _steps =0;

  int get steps => _steps;

  void updateSteps(int newSteps){
    if(newSteps!=_steps){
      _steps=newSteps;
      notifyListeners();
    }

  }
}