import 'package:flutter/material.dart';
import 'package:todo/configs/colors.dart';

class Subheader extends StatelessWidget {
  const Subheader({required this.label, Key? key}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              letterSpacing: 1.1,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 50,
            height: 4,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
