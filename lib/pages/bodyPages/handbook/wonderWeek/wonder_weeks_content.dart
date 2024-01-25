import 'package:baby/models/hanbook/wonder_weeks_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WonderWeeksContent extends StatelessWidget {
  final WonderWeeksDatum wonderWeeksDatum;
  const WonderWeeksContent({super.key, required this.wonderWeeksDatum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          wonderWeeksDatum.name,
          style: GoogleFonts.getFont(
            'Inter',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: wonderWeeksDatum.data.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wonderWeeksDatum.data[index].contentName,
                  style: GoogleFonts.getFont('Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(height: 8),
                Text(
                  wonderWeeksDatum.data[index].content,
                  style: GoogleFonts.getFont(
                    'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    //color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 8),
                if (wonderWeeksDatum.data[index].image != null)
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: wonderWeeksDatum.data[index].image ?? "",
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                if (wonderWeeksDatum.data[index].image != null)
                  const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }
}
