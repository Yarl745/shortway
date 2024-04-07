import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class RxLoadingOverlay extends StatefulWidget {
  const RxLoadingOverlay(
      {super.key, required this.child, required this.observableFuture});

  final Widget child;
  final ObservableFuture Function() observableFuture;

  @override
  State<RxLoadingOverlay> createState() => _RxLoadingOverlayState();
}

class _RxLoadingOverlayState extends State<RxLoadingOverlay> {
  late final ReactionDisposer _reactionDisposer;
  late BuildContext dialogContext;
  bool isActiveLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _reactionDisposer = reaction(
      (_) => widget.observableFuture().status,
      (status) {
        if (status == FutureStatus.pending && isActiveLoading == false) {
          isActiveLoading = true;
          _startLoading(context);
        } //
        else if (isActiveLoading) {
          isActiveLoading = false;
          Navigator.pop(dialogContext);
        }
      },
      delay: 50,
    );
  }

  @override
  void dispose() {
    _reactionDisposer();
    super.dispose();
  }

  void _startLoading(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        dialogContext = context;
        return PopScope(
          canPop: false,
          child: Container(
            alignment: Alignment.center,
            color: Colors.black26,
            child: const _LoaderWidget(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _LoaderWidget extends StatelessWidget {
  const _LoaderWidget({
    super.key,
    this.valueColor,
    this.backgroundColor,
    this.size = 80,
  });

  final Color? valueColor;
  final Color? backgroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(
          valueColor ?? Colors.blue,
        ),
        strokeWidth: 7,
      ),
    );
  }
}
