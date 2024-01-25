import 'package:baby/models/hanbook/medicine_vaccination_class.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineAndVaccinationContent extends StatelessWidget {
  final MedicineAndVaccinationDatum medicineAndVaccinationDatum;
  const MedicineAndVaccinationContent(
      {super.key, required this.medicineAndVaccinationDatum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          medicineAndVaccinationDatum.name,
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
          itemCount: medicineAndVaccinationDatum.data.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (medicineAndVaccinationDatum.data[index].contentName != "")
                  Text(
                    medicineAndVaccinationDatum.data[index].contentName,
                    style: GoogleFonts.getFont('Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                if (medicineAndVaccinationDatum.data[index].contentName != "")
                  const SizedBox(height: 8),
                if (medicineAndVaccinationDatum.data[index].content != "")
                  Text(
                    medicineAndVaccinationDatum.data[index].content,
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      //color: Colors.blue),
                    ),
                  ),
                if (medicineAndVaccinationDatum.data[index].content != "")
                  const SizedBox(height: 8),
                if (medicineAndVaccinationDatum.data[index].image != null)
                  Center(
                    child: CachedNetworkImage(
                      imageUrl:
                          medicineAndVaccinationDatum.data[index].image ?? "",
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                if (medicineAndVaccinationDatum.data[index].image != null)
                  const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }
}
