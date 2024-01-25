import 'package:baby/models/hanbook/diseases_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseasesContent extends StatelessWidget {
  final DiseasesDatum diseasesDatum;
  const DiseasesContent({super.key, required this.diseasesDatum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          diseasesDatum.name,
          style: GoogleFonts.getFont(
            'Inter',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: diseasesDatum.data.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (diseasesDatum.data[index].contentName != "")
                  Text(
                    diseasesDatum.data[index].contentName,
                    style: GoogleFonts.getFont('Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                if (diseasesDatum.data[index].contentName != "")
                  const SizedBox(height: 8),
                if (diseasesDatum.data[index].content != "")
                  Text(
                    diseasesDatum.data[index].content,
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      //color: Colors.blue),
                    ),
                  ),
                if (diseasesDatum.data[index].content != "")
                  const SizedBox(height: 8),
                if (diseasesDatum.data[index].image != null)
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: diseasesDatum.data[index].image ?? "",
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                if (diseasesDatum.data[index].image != null)
                  const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }
}
