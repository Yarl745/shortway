import 'package:flutter/material.dart';
import 'package:shortway/presentation/base_widgets/bottom_sheets/bottom_sheet_body.dart';
import 'package:shortway/presentation/base_widgets/buttons/filled_action_button.dart';

class OneActionBottomSheet extends StatelessWidget {
  const OneActionBottomSheet({
    super.key,
    this.iconData,
    required this.titleText,
    required this.subtitleText,
    this.action,
    this.actionButtonText = "Retry",
  });

  final IconData? iconData;
  final String titleText;
  final String subtitleText;
  final Function()? action;
  final String actionButtonText;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (iconData != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Icon(iconData, size: 100, color: Colors.black),
            ),
          Text(
            titleText,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitleText,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: FilledActionButton(
                    text: actionButtonText,
                    isActive: true,
                    width: 150,
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (action != null) action!();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
