import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';
import 'package:shortway/domain/repositories/path_finder_repository.dart';
import 'package:shortway/injection_container.dart';

/// A widget that wraps its child with providers for dependency injection.
///
/// This class uses the AutoRoute package to define a route that is also a provider wrapper.
/// It injects dependencies into the widget tree, making them available to child widgets.
/// This approach centralizes the dependency injection setup for specific routes, enhancing
/// modularity and separation of concerns.
@RoutePage()
class ProviderWrapperPage extends StatefulWidget implements AutoRouteWrapper {
  /// Constructs a ProviderWrapperPage.
  const ProviderWrapperPage({super.key});

  @override
  State<ProviderWrapperPage> createState() => ProviderWrapperPageState();

  /// Wraps the route with providers to inject dependencies.
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FieldBrainRepository>(
          create: (_) => sl<FieldBrainRepository>(),
        ),
        Provider<PathFinderRepository>(
          create: (_) => sl<PathFinderRepository>(),
        ),
      ],
      child: this,
    );
  }
}

/// The state class for ProviderWrapperPage.
class ProviderWrapperPageState extends State<ProviderWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
