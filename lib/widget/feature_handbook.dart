import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureHandbook extends StatelessWidget {
  final String image;
  final String featureName;
  const FeatureHandbook(
      {super.key, required this.image, required this.featureName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 50,
          child: Image.asset(image),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          featureName,
          style: GoogleFonts.getFont("Roboto"),
        )
      ],
    );
  }
}
