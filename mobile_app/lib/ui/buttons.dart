import 'package:flutter/material.dart';

class GloryTinyTextButton extends StatelessWidget {
  const GloryTinyTextButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Feedback.forTap(context);
        onPressed();
      },
      child: Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
    );
  }
}
