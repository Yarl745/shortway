import 'package:flutter/material.dart';
import 'package:shortway/injection_container.dart';
import 'package:shortway/presentation/views/home_page/home_page.dart';

void main() async {
  // Initialize the dependency injection container.
  await InjectionContainer().init();

  // Run the app with MyApp as the root widget.
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
