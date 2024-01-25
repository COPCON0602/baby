import 'package:baby/models/hanbook/developmental_stages_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DevelopmentalStagesContent extends StatelessWidget {
  final DevelopmentalStagesDatum developmentalStagesDatum;
  const DevelopmentalStagesContent(
      {super.key, required this.developmentalStagesDatum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          developmentalStagesDatum.name,
          style: GoogleFonts.getFont(
            'Inter',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: developmentalStagesDatum.data.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (developmentalStagesDatum.data[index].contentName != "")
                  Text(
                    developmentalStagesDatum.data[index].contentName,
                    style: GoogleFonts.getFont('Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                if (developmentalStagesDatum.data[index].contentName != "")
                  const SizedBox(height: 8),
                if (developmentalStagesDatum.data[index].content != "")
                  Text(
                    developmentalStagesDatum.data[index].content,
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      //color: Colors.blue),
                    ),
                  ),
                if (developmentalStagesDatum.data[index].content != "")
                  const SizedBox(height: 8),
                if (developmentalStagesDatum.data[index].image != null)
                  Center(
                    child: CachedNetworkImage(
                      imageUrl:
                          developmentalStagesDatum.data[index].image ?? "",
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                if (developmentalStagesDatum.data[index].image != null)
                  const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }
}
