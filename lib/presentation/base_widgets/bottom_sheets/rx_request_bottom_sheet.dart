import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shortway/core/error/failure.dart';
import 'package:shortway/core/error/failure_controller.dart';
import 'package:shortway/core/network/network_connection_stream.dart';
import 'package:shortway/injection_container.dart';
import 'package:shortway/presentation/base_widgets/bottom_sheets/one_action_bottom_sheet.dart';
import 'package:shortway/presentation/views/root_page/root_page.dart';

class RxRequestBottomSheet extends StatefulWidget {
  const RxRequestBottomSheet({
    super.key,
    required this.child,
    this.isDismissible = true,
    this.requestOnInit = false,
    this.primaryActionText = "Retry",
    this.retryRequest,
  });

  final bool requestOnInit;
  final bool isDismissible;
  final Widget child;
  final VoidCallback? retryRequest;
  final String primaryActionText;

  @override
  State<RxRequestBottomSheet> createState() => _RxRequestBottomSheetState();
}

class _RxRequestBottomSheetState extends State<RxRequestBottomSheet> {
  late final NetworkConnectionStream _connectionStream;
  late final ReactionDisposer _failureListenerDisposer;
  late bool _canRequest;
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    _canRequest = widget.requestOnInit;
    if (_canRequest == false) sl<FailureController>().resetFailure();

    _connectionStream = sl<NetworkConnectionStream>();
    _connectionStream.addListener(
      (isConnected) async {
        if (mounted && ModalRoute.of(context)!.isCurrent == false) return;

        if (isActive) return;
        isActive = true;

        await Future.delayed(const Duration(milliseconds: 200));
        if (isConnected == false && mounted) {
          RootPageState.of(context).showBottomSheet(
            context: context,
            isDismissible: widget.isDismissible,
            onDismiss: dismissPopup,
            enableDrag: widget.isDismissible,
            bottomSheet: OneActionBottomSheet(
              action: dismissPopup,
              actionButtonText: widget.primaryActionText,
              iconData: Icons.wifi_off,
              titleText: "No Internet",
              subtitleText: "Oops, your connection seems off... "
                  "Keep calm, lite a fire and try again",
            ),
          );
        }
      },
    );
    _failureListenerDisposer = reaction(
      (_) => sl<FailureController>().currentFailure,
      (failure) async {
        if (mounted && ModalRoute.of(context)!.isCurrent == false) return;

        if (isActive || failure == null) return;
        isActive = true;

        await Future.delayed(const Duration(milliseconds: 200));

        if (failure != null && mounted) {
          if (failure is ServerFailure) {
            RootPageState.of(context).showBottomSheet(
              context: context,
              isDismissible: widget.isDismissible,
              onDismiss: dismissPopup,
              enableDrag: widget.isDismissible,
              bottomSheet: OneActionBottomSheet(
                action: dismissPopup,
                actionButtonText: widget.primaryActionText,
                iconData: Icons.error_outline,
                titleText: "Server Error",
                subtitleText: "Server Error",
              ),
            );
          } //
          else if (failure is PathSearchFailure) {
            RootPageState.of(context).showBottomSheet(
              context: context,
              isDismissible: widget.isDismissible,
              onDismiss: dismissPopup,
              enableDrag: widget.isDismissible,
              bottomSheet: OneActionBottomSheet(
                action: dismissPopup,
                actionButtonText: widget.primaryActionText,
                iconData: Icons.error_outline,
                titleText: "Path search failure",
                subtitleText: "An error occurred while searching "
                    "for the shortest path.",
              ),
            );
          } //
          else if (failure is NotCorrectUrlFailure) {
            RootPageState.of(context).showBottomSheet(
              context: context,
              isDismissible: widget.isDismissible,
              onDismiss: dismissPopup,
              enableDrag: widget.isDismissible,
              bottomSheet: OneActionBottomSheet(
                action: dismissPopup,
                actionButtonText: widget.primaryActionText,
                iconData: Icons.error_outline,
                titleText: "Not a valid URL",
                subtitleText: "The URL you're trying to reach isn't "
                    "responding. Make sure you have the right address",
              ),
            );
          } //
          else if (failure is TooManyRequestsFailure) {
            RootPageState.of(context).showBottomSheet(
              context: context,
              isDismissible: widget.isDismissible,
              onDismiss: dismissPopup,
              enableDrag: widget.isDismissible,
              bottomSheet: OneActionBottomSheet(
                action: dismissPopup,
                actionButtonText: widget.primaryActionText,
                iconData: Icons.error_outline,
                titleText: "Too many requests",
                subtitleText: "You've hit the speed limit for requests. "
                    "Take a breather, then try again in a moment.",
              ),
            );
          }
        }
      },
    );

    _canRequest = true;
  }

  @override
  void dispose() {
    _failureListenerDisposer();
    super.dispose();
  }

  void dismissPopup() {
    isActive = false;
    sl<FailureController>().resetFailure();
    if (widget.retryRequest != null) widget.retryRequest!();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
