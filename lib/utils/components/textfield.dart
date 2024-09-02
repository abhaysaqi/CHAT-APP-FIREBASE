import 'package:flutter/material.dart';

class MytextField extends StatelessWidget {
  final String hintext;
  final bool ishide;
  TextEditingController controller = TextEditingController();
  final FocusNode? focusNode;
  MytextField(
      {super.key,
      required this.hintext,
      required this.ishide,
      required this.controller, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        obscureText: ishide,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: hintext,
            hintStyle: TextStyle(color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
