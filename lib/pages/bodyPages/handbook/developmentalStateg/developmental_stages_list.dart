// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:baby/models/hanbook/developmental_stages_class.dart';
import 'package:baby/pages/bodyPages/handbook/developmentalStateg/developmental_stages_content.dart';
import 'package:baby/widget/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DevelopmentalStagesList extends StatefulWidget {
  const DevelopmentalStagesList({super.key});

  @override
  State<DevelopmentalStagesList> createState() =>
      _DevelopmentalStagesListState();
}

class _DevelopmentalStagesListState extends State<DevelopmentalStagesList> {
  DevelopmentalStages developmentalStages =
      DevelopmentalStages(name: "", title: "", developmentalStagesData: []);

  @override
  void initState() {
    super.initState();
    loadDevelopmentalStagesData();
  }

  Future<void> loadDevelopmentalStagesData() async {
    final jsonContent =
        await rootBundle.loadString('assets/jsons/developmentalStages.json');
    final parsedData = json.decode(jsonContent);
    setState(() {
      developmentalStages = DevelopmentalStages.fromJson(parsedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          developmentalStages.name,
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
                developmentalStages.title,
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w500,
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
              itemCount: developmentalStages.developmentalStagesData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      print(
                          "chương ${developmentalStages.developmentalStagesData[index].id}");
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              DevelopmentalStagesContent(
                            developmentalStagesDatum: developmentalStages
                                .developmentalStagesData[index],
                          ),
                        ),
                      );
                    },
                    child: ItemList(
                      id: developmentalStages.developmentalStagesData[index].id,
                      name: developmentalStages
                          .developmentalStagesData[index].name,
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
