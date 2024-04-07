import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shortway/core/network/network_connection_stream.dart';
import 'package:shortway/injection_container.dart';
import 'package:shortway/router/router.dart';

void main() async {
  // Initialize the dependency injection container.
  await InjectionContainer().init();

  // Run the app with MyApp as the root widget.
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      sl<NetworkConnectionStream>().startListen();
    } else if (state == AppLifecycleState.inactive) {
      sl<NetworkConnectionStream>().stopListen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
