// ignore_for_file: avoid_print

import 'package:baby/pages/bodyPages/handbook/abnormalSigns/abnormal_signs_list.dart';
import 'package:baby/pages/bodyPages/handbook/developmentalStateg/developmental_stages_list.dart';
import 'package:baby/pages/bodyPages/handbook/diseases/diseases_list.dart';
import 'package:baby/pages/bodyPages/handbook/medicineAndVaccination/medicine_vaccination_list.dart';
import 'package:baby/pages/bodyPages/handbook/safe/safety_list.dart';
import 'package:baby/pages/bodyPages/handbook/wonderWeek/wonder_weeks_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widget/feature_handbook.dart';

class HandBookPage extends StatefulWidget {
  const HandBookPage({super.key});

  @override
  State<HandBookPage> createState() => _HandBookPageState();
}

class _HandBookPageState extends State<HandBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cẩm Nang",
            style: GoogleFonts.getFont(
              'Inter',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 244, 244),
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          children: [
            GestureDetector(
              onTap: () {
                print("sự phát triển");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DevelopmentalStagesList()));
              },
              child: const FeatureHandbook(
                  image: "assets/images/phattrien.png",
                  featureName: "Sự phát triển"),
            ),
            GestureDetector(
              onTap: () {
                print("tuần khủng hoảng");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WonderWeeksList()));
              },
              child: const FeatureHandbook(
                  image: "assets/images/tuankhunghoang.png",
                  featureName: "Tuần khủng hoảng"),
            ),
            GestureDetector(
              onTap: () {
                print("thuốc và tiêm phòng");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MedicineAndVaccinationList()));
              },
              child: const FeatureHandbook(
                  image: "assets/images/thuoc_tiemphong.png",
                  featureName: "Thuốc và tiêm phòng"),
            ),
            GestureDetector(
              onTap: () {
                print("Bệnh trẻ em");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DiseasesList()));
              },
              child: const FeatureHandbook(
                  image: "assets/images/benhtreem.png",
                  featureName: "Bệnh trẻ em"),
            ),
            GestureDetector(
              onTap: () {
                print("An toàn cho bé");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SafetyList()));
              },
              child: const FeatureHandbook(
                  image: "assets/images/antoan.png",
                  featureName: "An toàn cho bé"),
            ),
            GestureDetector(
              onTap: () {
                print("Dấu hiệu bất thường");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AbnormalSignsList()));
              },
              child: const FeatureHandbook(
                  image: "assets/images/batthuong.png",
                  featureName: "Dấu hiệu bất thường"),
            ),
          ],
        ));
  }
}
