import 'package:baby/models/hanbook/abnormal_signs_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AbnormalSignsContent extends StatelessWidget {
  final AbnormalSignsDatum abnormalSignsDatum;
  const AbnormalSignsContent({super.key, required this.abnormalSignsDatum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          abnormalSignsDatum.name,
          style: GoogleFonts.getFont(
            'Inter',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(100, 255, 245, 210),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: abnormalSignsDatum.data.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (abnormalSignsDatum.data[index].contentName != "")
                  Text(
                    abnormalSignsDatum.data[index].contentName,
                    style: GoogleFonts.getFont('Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                if (abnormalSignsDatum.data[index].contentName != "")
                  const SizedBox(height: 8),
                if (abnormalSignsDatum.data[index].content != "")
                  Text(
                    abnormalSignsDatum.data[index].content,
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      //color: Colors.blue),
                    ),
                  ),
                if (abnormalSignsDatum.data[index].content != "")
                  const SizedBox(height: 8),
                if (abnormalSignsDatum.data[index].image != null)
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: abnormalSignsDatum.data[index].image ?? "",
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                if (abnormalSignsDatum.data[index].image != null)
                  const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }
}
