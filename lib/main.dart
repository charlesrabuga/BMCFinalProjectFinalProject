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

// Lighting & Lamps Shop Theme
const Color kCharcoalBlack = Color(
  0xFF1C1C1E,
); // Deep charcoal for background or text contrast
const Color kWarmAmber = Color(0xFFFFB300); // Main accent — warm lamp glow
const Color kSoftGold = Color(
  0xFFE0B060,
); // Elegant gold for highlights or icons
const Color kLightBeige = Color(0xFFF5E6CA); // Soft neutral background tone
const Color kIvoryWhite = Color(
  0xFFFFFBF5,
); // Clean, subtle off-white for balance
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

      // 1. --- THIS IS THE NEW, COMPLETE THEME ---
      theme: ThemeData(
        // 2. Set the main color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: kWarmAmber, // Main accent color
          brightness: Brightness.light,
          primary: kWarmAmber, // Buttons, icons, main highlights
          onPrimary: Colors.white, // Text on primary buttons
          secondary: kSoftGold, // Subtle gold for accents
          background: kIvoryWhite, // Overall app background
        ),
        useMaterial3: true,

        // 3. Set the background color for all screens
        scaffoldBackgroundColor: kIvoryWhite,

        // 4. --- (FIX) APPLY THE GOOGLE FONT ---
        // This applies "Lato" to all text in the app
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),

        // 5. --- GLOBAL BUTTON STYLE ---
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kWarmAmber, // Lamp glow color
            foregroundColor: Colors.white, // Button text
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // 6. --- (FIX) GLOBAL TEXT FIELD STYLE ---
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: kSoftGold.withOpacity(0.6)),
          ),
          labelStyle: TextStyle(color: kCharcoalBlack.withOpacity(0.7)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kWarmAmber, width: 2.0),
          ),
        ),

        // 7. --- (FIX) GLOBAL CARD STYLE ---
        cardTheme: CardThemeData(
          elevation: 2,
          color: kLightBeige, // Warm neutral card background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          // 8. This ensures the images inside the card are rounded
          clipBehavior: Clip.antiAlias,
        ),

        /// 9. --- (NEW) GLOBAL APPBAR STYLE ---
        appBarTheme: const AppBarTheme(
          backgroundColor: kLightBeige, // Soft beige AppBar
          foregroundColor: kCharcoalBlack, // Icons and text
          elevation: 0,
          centerTitle: true,
        ),
      ),

      // --- END OF THEME ---
      home: const AuthWrapper(),
    );
  }
}
