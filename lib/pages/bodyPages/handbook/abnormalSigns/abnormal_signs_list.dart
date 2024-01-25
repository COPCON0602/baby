// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:baby/models/hanbook/abnormal_signs_class.dart';
import 'package:baby/pages/bodyPages/handbook/abnormalSigns/abnormal_signs_content.dart';
import 'package:baby/widget/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AbnormalSignsList extends StatefulWidget {
  const AbnormalSignsList({super.key});

  @override
  State<AbnormalSignsList> createState() => _AbnormalSignsListState();
}

class _AbnormalSignsListState extends State<AbnormalSignsList> {
  AbnormalSigns abnormalSigns =
      AbnormalSigns(name: "", title: "", abnormalSignsData: []);

  @override
  void initState() {
    super.initState();
    loadAbnormalSignsData();
  }

  Future<void> loadAbnormalSignsData() async {
    final jsonContent =
        await rootBundle.loadString('assets/jsons/abnormalSigns.json');
    final parsedData = json.decode(jsonContent);
    setState(() {
      abnormalSigns = AbnormalSigns.fromJson(parsedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          abnormalSigns.name,
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
                abnormalSigns.title,
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
              itemCount: abnormalSigns.abnormalSignsData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      print(
                          "chương ${abnormalSigns.abnormalSignsData[index].id}");
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              AbnormalSignsContent(
                            abnormalSignsDatum:
                                abnormalSigns.abnormalSignsData[index],
                          ),
                        ),
                      );
                    },
                    child: ItemList(
                      id: abnormalSigns.abnormalSignsData[index].id,
                      name: abnormalSigns.abnormalSignsData[index].name,
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
