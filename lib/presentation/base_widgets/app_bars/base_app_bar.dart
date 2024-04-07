import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final bool withBackButton;

  const BaseAppBar({
    super.key,
    required this.titleText,
    this.withBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(titleText),
      leadingWidth: withBackButton ? null : 20,
      leading: Visibility(
        visible: withBackButton,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
