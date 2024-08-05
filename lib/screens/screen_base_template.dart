import 'package:flutter/material.dart';
import 'package:hero_chum/widgets/navbar/left_drawer.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';

class ScreenBaseTemplate extends StatelessWidget {
  const ScreenBaseTemplate({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [const NavBar(), Expanded(child: child)],
      ),
      drawer: const LeftDrawer(),
    );
  }
}
