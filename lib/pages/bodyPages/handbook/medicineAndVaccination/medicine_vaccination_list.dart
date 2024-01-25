// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:baby/models/hanbook/medicine_vaccination_class.dart';
import 'package:baby/pages/bodyPages/handbook/medicineAndVaccination/medicine_vaccination_content.dart';
import 'package:baby/widget/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineAndVaccinationList extends StatefulWidget {
  const MedicineAndVaccinationList({super.key});

  @override
  State<MedicineAndVaccinationList> createState() =>
      _MedicineAndVaccinationListState();
}

class _MedicineAndVaccinationListState
    extends State<MedicineAndVaccinationList> {
  MedicineAndVaccination medicineAndVaccination = MedicineAndVaccination(
      name: "", title: "", medicineAndVaccinationData: []);

  @override
  void initState() {
    super.initState();
    loadMedicineAndVaccinationData();
  }

  Future<void> loadMedicineAndVaccinationData() async {
    final jsonContent =
        await rootBundle.loadString('assets/jsons/medicine_vaccination.json');
    final parsedData = json.decode(jsonContent);
    setState(() {
      medicineAndVaccination = MedicineAndVaccination.fromJson(parsedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          medicineAndVaccination.name,
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                medicineAndVaccination.title,
                style: GoogleFonts.getFont(
                  'Inter',
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              height: 8,
              color: Colors.grey,
            ),
            Expanded(
                child: ListView.builder(
              itemCount:
                  medicineAndVaccination.medicineAndVaccinationData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      print(
                          "chương ${medicineAndVaccination.medicineAndVaccinationData[index].id}");
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              MedicineAndVaccinationContent(
                            medicineAndVaccinationDatum: medicineAndVaccination
                                .medicineAndVaccinationData[index],
                          ),
                        ),
                      );
                    },
                    child: ItemList(
                      id: medicineAndVaccination
                          .medicineAndVaccinationData[index].id,
                      name: medicineAndVaccination
                          .medicineAndVaccinationData[index].name,
                      width: screenWidth - 8,
                    ));
              },
            ))
          ],
        ),
      ),
    );
  }
}
