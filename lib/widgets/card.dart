
import 'package:flutter/material.dart';

/// A container widget that scrolls.
class Card extends StatelessWidget {
  final Widget child;

  const Card({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: child
    );
  }
}