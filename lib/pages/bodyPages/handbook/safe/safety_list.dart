// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:baby/models/hanbook/safety_class.dart';
import 'package:baby/pages/bodyPages/handbook/safe/safety_content.dart';
import 'package:baby/widget/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SafetyList extends StatefulWidget {
  const SafetyList({super.key});

  @override
  State<SafetyList> createState() => _SafetyListState();
}

class _SafetyListState extends State<SafetyList> {
  Safety safety = Safety(name: "", title: "", safetyData: []);

  @override
  void initState() {
    super.initState();
    loadSafetyData();
  }

  Future<void> loadSafetyData() async {
    final jsonContent = await rootBundle.loadString('assets/jsons/safety.json');
    final parsedData = json.decode(jsonContent);
    setState(() {
      safety = Safety.fromJson(parsedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          safety.name,
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
                safety.title,
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
              itemCount: safety.safetyData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      print("chương ${safety.safetyData[index].id}");
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => SafetyContent(
                            safetyDatum: safety.safetyData[index],
                          ),
                        ),
                      );
                    },
                    child: ItemList(
                      id: safety.safetyData[index].id,
                      name: safety.safetyData[index].name,
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
