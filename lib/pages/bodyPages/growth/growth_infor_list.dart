// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, use_build_context_synchronously, unnecessary_import

import 'package:baby/models/child.dart';
import 'package:baby/models/growth/growth_info.dart';
import 'package:baby/pages/bodyPages/growth/record_detail.dart';
import 'package:baby/pages/bodyPages/user/child_profile.dart';
import 'package:baby/provider/children_provider.dart';
import 'package:baby/provider/growth_infor_provider.dart';
import 'package:baby/widget/custom_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class GrowthInforListPage extends StatefulWidget {
  const GrowthInforListPage({Key? key});

  @override
  _GrowthInforListPageState createState() => _GrowthInforListPageState();
}

class _GrowthInforListPageState extends State<GrowthInforListPage> {
  Child? selectedChild; // chọn child nào
  bool isSelected = false;

  Widget buildGrowthInfoList() {
    final growthInforProvider = Provider.of<GrowthInforProvider>(context);
    final childRecords = growthInforProvider.childRecords;
    final screenSize = MediaQuery.of(context).size;

    // Sử dụng child được chọn để truy xuất thông tin tăng trưởng
    final List<GrowthInforRecord> records =
        selectedChild != null && childRecords.containsKey(selectedChild!)
            ? childRecords[selectedChild!]!
            : [];

    return Expanded(
      child: (records.isEmpty)
          ? Center(
              child: Text(
                "Chưa có thông tin.\nVui lòng thêm thông tin",
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final growthInfo = records[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoRecordDetail(
                          child: selectedChild,
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //thời gian
                      Row(
                        children: [
                          const SizedBox(width: 16),
                          Text(
                            DateFormat("dd/MM/yyyy").format(growthInfo.time),
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: screenSize.width,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 244, 244),
                          borderRadius: BorderRadius.all(
                            Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),

                            //cân nặng
                            Row(
                              children: [
                                Icon(MdiIcons.scale, size: 16),
                                const SizedBox(width: 16),
                                Text(
                                  "Cân nặng: ${growthInfo.weight} kg",
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            //chiều cao
                            Row(
                              children: [
                                Icon(MdiIcons.humanMaleHeight, size: 16),
                                const SizedBox(width: 16),
                                Text(
                                  "Chiều cao: ${growthInfo.height} cm",
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            //ghi chú
                            if (growthInfo.note != null)
                              Row(
                                children: [
                                  Icon(MdiIcons.notebookEditOutline, size: 16),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      "Ghi chú: ${growthInfo.note}",
                                      style: GoogleFonts.getFont(
                                        'Inter',
                                        fontSize: 14,
                                      ),
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final childrenProvider = Provider.of<ChildrenProvider>(context);
    final children = childrenProvider.children;
    print("Số lượng bé: ${children.length}");
    final screenSize = MediaQuery.of(context).size;

// nếu selectedChild là null và danh sách children không rỗng, chọn child đầu tiên
    if (selectedChild == null && children.isNotEmpty) {
      selectedChild = children.first;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nhật ký phát triển",
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: (children.isEmpty)
                ? Column(
                    children: [
                      Text(
                        "Vui lòng thêm thông tin bé",
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChildProfile(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline_outlined),
                        color: const Color.fromARGB(255, 244, 123, 19),
                        iconSize: 30,
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenSize.height / 10,
                        child: ListView.builder(
                          scrollDirection:
                              Axis.horizontal, // Đặt hướng cuộn ngang
                          itemCount: children.length,
                          itemBuilder: (context, index) {
                            final child = children[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected = true;
                                  selectedChild = child;

                                  print("Đã chọn bé: ${selectedChild!.name}");
                                });
                              },
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: (child.avatar == null ||
                                                    child.avatar == "")
                                                ? "https://firebasestorage.googleapis.com/v0/b/baby-5fa1e.appspot.com/o/avartarBaby%2Fbaby.png?alt=media&token=c5c06f79-329c-4e80-b252-3c7fdb556bdd&_gl=1*1vz6p61*_ga*MTIwOTUzOTU0NS4xNjkzOTI2MTc1*_ga_CW55HF8NVT*MTY5NTkxMzU5OS4zMi4xLjE2OTU5MTQ3NzguNDkuMC4w"
                                                : child.avatar!,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        (child.nicknName == null ||
                                                child.nicknName == "")
                                            ? "Bé yêu"
                                            : child.nicknName!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          buildGrowthInfoList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Thêm mới",
        backgroundColor: const Color.fromARGB(255, 244, 123, 19),
        onPressed: () {
          (children.isEmpty)
              ? CustomDialog.show(
                  context, "Vui lòng thêm bé trước khi thực hiện")
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoRecordDetail(
                      child: selectedChild,
                    ),
                  ),
                );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
