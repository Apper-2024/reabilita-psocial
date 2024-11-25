import 'package:flutter/material.dart';

class CardPaciente extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const CardPaciente({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                SizedBox(width: 16), 
                Center(
                  child: Icon(icon, color: Colors.orange, size: 28),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
