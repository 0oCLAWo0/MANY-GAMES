import 'package:flutter/material.dart';

class Reusable {

 static Row createPlayers(String label, IconData icon, Color iconColor) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }

 static Widget buildButtons({
    required VoidCallback onTap,
    required String label,
    required IconData symbol,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            symbol,
            color: const Color.fromARGB(255, 2, 12, 66),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 2, 10, 51),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  

}

 