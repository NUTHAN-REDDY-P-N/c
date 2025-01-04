import 'package:commcart/firestore/provider.dart';
import 'package:commcart/screens/homeScreen.dart';
import 'package:commcart/screens/sign_in.dart';
import 'package:commcart/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      initialRoute: '/login',
      routes: {
        '/signUp': (context) => SignUp(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => loginIn(),
      },
    );
  }
}
