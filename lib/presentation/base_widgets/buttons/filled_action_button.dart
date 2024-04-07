import 'package:flutter/material.dart';

class FilledActionButton extends StatelessWidget {
  const FilledActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isActive,
    this.width = double.infinity,
    this.height = 48,
  });

  final bool isActive;
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(width ?? 0, height ?? 0),
        ),
        maximumSize: MaterialStateProperty.all<Size>(Size.infinite),
        backgroundColor: MaterialStateProperty.all<Color>(
          isActive ? Colors.lightBlueAccent : Colors.grey,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: isActive ? Colors.blue : Colors.grey, width: 2),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      onPressed: isActive ? onPressed : null,
      child: Text(text),
    );
  }
}
