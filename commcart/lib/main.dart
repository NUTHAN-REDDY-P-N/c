import 'package:commcart/firestore/provider.dart';
import 'package:commcart/screens/homeScreen.dart';
import 'package:commcart/screens/items.dart';
import 'package:commcart/screens/sign_in.dart';
import 'package:commcart/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://judwbcxsuiziyumshahq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp1ZHdiY3hzdWl6aXl1bXNoYWhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzczNTA1NTMsImV4cCI6MjA1MjkyNjU1M30.kGZL8gbE7LPSxPHZCzxGKc88rdwCstNDMfh3rYOsiGs',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: commCart(),
    ),
  );
}

class commCart extends StatefulWidget {
  const commCart({super.key});

  @override
  State<commCart> createState() => _commCartState();
}

class _commCartState extends State<commCart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signUp',
      routes: {
        '/signUp': (context) => SignUp(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => loginIn(),
        '/items': (context) => items()
      },
    );
  }
}
