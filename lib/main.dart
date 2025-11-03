// This imports all the standard Material Design widgets
import 'package:flutter/material.dart';
// 1. Import the Firebase core package
import 'package:firebase_core/firebase_core.dart';
// 2. Import the auto-generated Firebase options file
import 'firebase_options.dart';
// 1. Import the native splash package
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ecommerce_app/screens/auth_wrapper.dart';

void main() async {
  // 1. Make the 'main' function asynchronous

  // 1. Preserve the splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 2. Ensure Flutter is ready before calling native code
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Initialize Firebase
  await Firebase.initializeApp(
    // 4. Use the options from our generated file
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 5. Run the app (this line is already here)
  runApp(MyApp());

  // 4. Remove the splash screen after app is ready
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  // ... (const MyApp)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eCommerce App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // 1. Change this line
      home: const AuthWrapper(), // 2. Set LoginScreen as the home
    );
  }
}
