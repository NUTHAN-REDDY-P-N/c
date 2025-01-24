import 'package:admin/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
  runApp(MaterialApp(
    home: AdminHomePage(),
  ));
}
