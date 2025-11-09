// This imports all the standard Material Design widgets
import 'package:flutter/material.dart';
// 1. Import the Firebase core package
import 'package:firebase_core/firebase_core.dart';
// 2. Import the auto-generated Firebase options file
import 'firebase_options.dart';
// 1. Import the native splash package
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ecommerce_app/screens/auth_wrapper.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

// 2. --- ADD OUR NEW APP COLOR PALETTE ---
const Color kRichBlack = Color(0xFF1D1F24); // A dark, rich black
const Color kBrown = Color(0xFF8B5E3C); // Our main "coffee" brown
const Color kLightBrown = Color(0xFFD2B48C); // A lighter tan/beige
const Color kOffWhite = Color(0xFFF8F4F0); // A warm, off-white background
// --- END OF COLOR PALETTE ---

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

  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  final cartProvider = CartProvider();
  cartProvider.initializeAuthListener();
  // 7. This is the NEW code for runApp
  runApp(
    // 8. We use ChangeNotifierProvider.value
    ChangeNotifierProvider.value(
      value: cartProvider, // 9. We provide the instance we already created
      child: MyApp(),
    ),
  );

  // 10. Remove splash screen (Unchanged)
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  // ... (const MyApp)
  //const MyApp({super.key});

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
