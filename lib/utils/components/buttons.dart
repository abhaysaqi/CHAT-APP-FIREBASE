import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
 final String text;
  final VoidCallback? onTap;
  final Color? color;
  MyButton({super.key, required this.text, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
      ),
    );
  }
}
