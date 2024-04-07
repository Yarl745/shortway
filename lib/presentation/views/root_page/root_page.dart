import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shortway/core/error/failure_controller.dart';
import 'package:shortway/injection_container.dart';

/// The root page of the application, serving as an entry point for the routing system.
///
/// This class defines the root widget for the application's route hierarchy. It is designed
/// to interact with the AutoRoute package to manage navigation and route definitions.
@RoutePage()
class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  bool isProcessing = false;

  /// Provides a way to access the RootPageState from the widget tree.
  static RootPageState of(BuildContext context) {
    return context.findAncestorStateOfType<RootPageState>()!;
  }

  /// Shows a bottom sheet with customizable behavior and appearance.
  void showBottomSheet({
    required BuildContext context,
    required Widget bottomSheet,
    bool resetFailureOnDismiss = false,
    VoidCallback? onDismiss,
    bool isDismissible = false,
    bool enableDrag = false,
    bool useRootNavigator = true,
  }) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: enableDrag,
      constraints: BoxConstraints(
        maxWidth: size.width > 650 && orientation == Orientation.landscape
            ? 650
            : size.width,
      ),
      builder: (context) {
        return PopScope(
          canPop: isDismissible,
          child: bottomSheet,
          onPopInvoked: (didPop) {
            if (didPop) {
              if (onDismiss != null) onDismiss();
              if (resetFailureOnDismiss) {
                sl<FailureController>().resetFailure();
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
