// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:baby/models/hanbook/wonder_weeks_class.dart';
import 'package:baby/pages/bodyPages/handbook/wonderWeek/wonder_weeks_content.dart';
import 'package:baby/widget/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WonderWeeksList extends StatefulWidget {
  const WonderWeeksList({super.key});

  @override
  State<WonderWeeksList> createState() => _WonderWeeksListState();
}

class _WonderWeeksListState extends State<WonderWeeksList> {
  WonderWeeks wonderWeeks =
      WonderWeeks(name: "", title: "", wonderWeeksData: []);

  @override
  void initState() {
    super.initState();
    loadWonderWeeksData();
  }

  Future<void> loadWonderWeeksData() async {
    final jsonContent =
        await rootBundle.loadString('assets/jsons/wonderWeeks.json');
    final parsedData = json.decode(jsonContent);
    setState(() {
      wonderWeeks = WonderWeeks.fromJson(parsedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          wonderWeeks.name,
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
                wonderWeeks.title,
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
              itemCount: wonderWeeks.wonderWeeksData.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      print("chương ${wonderWeeks.wonderWeeksData[index].id}");
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => WonderWeeksContent(
                            wonderWeeksDatum:
                                wonderWeeks.wonderWeeksData[index],
                          ),
                        ),
                      );
                    },
                    child: ItemList(
                      id: wonderWeeks.wonderWeeksData[index].id,
                      name: wonderWeeks.wonderWeeksData[index].name,
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
