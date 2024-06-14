import 'package:flutter/material.dart';

class UrgencySelector extends StatefulWidget {
  @override
  _UrgencySelectorState createState() => _UrgencySelectorState();
}

class _UrgencySelectorState extends State<UrgencySelector> {
  int selectedUrgency = 1;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedUrgency,
      items: List.generate(3, (index) {
        return DropdownMenuItem<int>(
          value: index + 1,
          child: Text("Level ${index + 1}"),
        );
      }),
      onChanged: (value) {
        setState(() {
          selectedUrgency = value ?? 1;
        });
      },
    );
  }
}
