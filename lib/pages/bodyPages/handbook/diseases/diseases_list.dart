// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:baby/models/hanbook/diseases_class.dart';
import 'package:baby/pages/bodyPages/handbook/diseases/diseases_content.dart';
import 'package:baby/widget/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseasesList extends StatefulWidget {
  const DiseasesList({super.key});

  @override
  State<DiseasesList> createState() => _DiseasesListState();
}

class _DiseasesListState extends State<DiseasesList> {
  Diseases diseases = Diseases(name: "", title: "", diseasesData: []);

  @override
  void initState() {
    super.initState();
    loadDiseasesData();
  }

  Future<void> loadDiseasesData() async {
    final jsonContent =
        await rootBundle.loadString('assets/jsons/diseases.json');
    final parsedData = json.decode(jsonContent);
    setState(() {
      diseases = Diseases.fromJson(parsedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          diseases.name,
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
                diseases.title,
                style: GoogleFonts.getFont(
                  'Inter',
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(
              height: 8,
              color: Colors.grey,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: diseases.diseasesData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      print("chương ${diseases.diseasesData[index].id}");
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => DiseasesContent(
                            diseasesDatum: diseases.diseasesData[index],
                          ),
                        ),
                      );
                    },
                    child: ItemList(
                      id: diseases.diseasesData[index].id,
                      name: diseases.diseasesData[index].name,
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
