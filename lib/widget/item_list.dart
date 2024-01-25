import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemList extends StatelessWidget {
  final int id;
  final String name;
  final double width;
  final IconData? icon;

  const ItemList(
      {super.key,
      required this.id,
      required this.name,
      required this.width,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 244, 244),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "CHƯƠNG $id",
                style: GoogleFonts.getFont(
                  'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 244, 123, 19),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: GoogleFonts.getFont(
                  'Inter',
                  fontSize: 16,
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
