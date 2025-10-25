import 'package:expensetracker/utils/constants.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final double iconSize;
  final double messageFontSize;
  const MessageWidget({
    super.key,
    required this.icon,
    required this.message,
    this.iconSize = defaultIconSize,
    this.messageFontSize = defaultFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(icon, size: iconSize, color: Colors.grey),
          SizedBox(height: defaultSpacing),
          Text(message, style: TextStyle(fontSize: messageFontSize)),
        ],
      ),
    );
  }
}
