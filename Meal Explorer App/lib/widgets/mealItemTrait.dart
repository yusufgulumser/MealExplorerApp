import 'package:flutter/material.dart';

class MealItemTr extends StatelessWidget {
  MealItemTr({super.key, required this.icon, required this.textt});
  IconData icon;
  String textt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: Colors.white,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          textt,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
