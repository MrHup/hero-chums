import 'package:flutter/material.dart';
import 'package:hero_chum/static/constants.dart';

class TaskDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const TaskDescriptionField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Short description of task", style: hintTextStyle),
        TextField(
          controller: controller,
          maxLines: 6,
          decoration: InputDecoration(
            // hintText: "Short description of task",
            filled: true,
            fillColor: const Color(0xfff7f7fd),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
