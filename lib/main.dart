import 'package:auth_with_supabase/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://zbeamakyrprbiqpflcwm.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpiZWFtYWt5cnByYmlxcGZsY3dtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1MTQyNTksImV4cCI6MjA0NzA5MDI1OX0.vgfqv6rM4TcbEyVaONpDlfDbIrM8sBiUcFn6ySXgX4c",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}
