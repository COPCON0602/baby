// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:baby/models/child.dart';
import 'package:baby/models/growth/growth_info.dart';
import 'package:baby/provider/growth_infor_provider.dart';
import 'package:baby/widget/datepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class InfoRecordDetail extends StatefulWidget {
  final double? width;
  final double? height;
  final Child? child;
  final int? index; // index cho biết sửa record nào
  const InfoRecordDetail({
    super.key,
    this.width,
    this.height,
    this.index,
    this.child,
  });

  @override
  State<InfoRecordDetail> createState() => _InfoRecordDetailState();
}

class _InfoRecordDetailState extends State<InfoRecordDetail> {
  //textcontroller
  TextEditingController timeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  //chọn ngày
  DateTime selectedDate = DateTime.now();

  //update timeController
  void updateSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
      timeController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    });
  }

  @override
  void initState() {
    if (widget.index != null) {
      // Nếu đang sửa thì điền thông tin cũ vào các controller
      final growthInforProvider =
          Provider.of<GrowthInforProvider>(context, listen: false);
      final childRecords = growthInforProvider.childRecords;
      final records = childRecords[widget.child] ?? [];
      if (widget.index! < records.length) {
        final record = records[widget.index!];
        selectedDate = record.time;
        timeController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
        weightController.text = record.weight.toString();
        heightController.text = record.height.toString();
        noteController.text = record.note ?? '';
      }
    } else {
      // Nếu thêm mới thì khởi tạo giá trị ban đầu
      weightController.text = "0";
      heightController.text = "0";
      timeController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    }
    super.initState();
  }

  void saveRecord() async {
    if (widget.child != null) {
      final growthInforProvider =
          Provider.of<GrowthInforProvider>(context, listen: false);
      final childRecords = growthInforProvider.childRecords;
      final records = childRecords[widget.child!] ?? [];

      final newRecord = GrowthInforRecord(
        time: selectedDate,
        weight: double.tryParse(weightController.text) ?? 0.0,
        height: double.tryParse(heightController.text) ?? 0.0,
        note: noteController.text.isNotEmpty ? noteController.text : null,
      );

      if (widget.index != null && widget.index! < records.length) {
        // Nếu đang chỉnh sửa thông tin tăng trưởng
        growthInforProvider.editChildRecord(
            widget.child!, widget.index!, newRecord);
      } else {
        // Nếu thêm mới thông tin tăng trưởng
        growthInforProvider.addChildRecord(widget.child!, newRecord);
      }

      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final email = user.email;

        try {
          // Tìm document người dùng dựa trên email
          final userQuery =
              firestore.collection('users').where('email', isEqualTo: email);
          final userDocuments = await userQuery.get();

          if (userDocuments.docs.isNotEmpty) {
            // Lấy ID của document người dùng
            final userId = userDocuments.docs.first.id;

            // Tạo một reference đến collection "users" và document của người dùng
            final userRef = firestore.collection('users').doc(userId);

            // Lấy document người dùng
            final userDoc = await userRef.get();

            // Lấy trường "children" hiện có (nếu có)
            final List<dynamic>? currentChildren = userDoc.data()?['children'];

            // Tạo danh sách mới chứa thông tin bé mới
            final List<Map<String, dynamic>> updatedChildren =
                currentChildren != null ? List.from(currentChildren) : [];

            // Tạo danh sách mới để cập nhật lên Cloud Firestore
            final List<Map<String, dynamic>> updatedRecords = [];

            for (final record in records) {
              updatedRecords.add({
                'time': record.time,
                'weight': record.weight,
                'height': record.height,
                'note': record.note,
              });
            }

            // Cập nhật trường "records" trong danh sách children tương ứng
            if (widget.index != null &&
                widget.index! < updatedChildren.length) {
              updatedChildren[widget.index!]['records'] = updatedRecords;
            }

            // Cập nhật trường "children" trong document của người dùng
            await userRef.update({'children': updatedChildren});

            Navigator.pop(context);
          } else {
            print("Không tìm thấy người dùng với email: $email");
          }
        } catch (error) {
          // Xử lý lỗi nếu có
          print('Lỗi khi lưu thông tin bé: $error');
        }
      }
    }
  }

  void deleteRecord() {
    if (widget.child != null && widget.index != null) {
      final growthInforProvider =
          Provider.of<GrowthInforProvider>(context, listen: false);
      growthInforProvider.removeChildRecord(widget.child!, widget.index!);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.index != null ? "Chỉnh sửa thông tin" : "Thêm thông tin",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height / 10,
            ),
            Row(
              children: [
                Text(
                  "Tăng trưởng",
                  style: GoogleFonts.getFont("Inter",
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (widget.index != null)
                        IconButton(
                          onPressed: () {
                            // Hiển thị hộp thoại cảnh báo khi người dùng nhấn vào nút
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Xác nhận xoá"),
                                  content: const Text(
                                      "Bạn có chắc chắn muốn xoá thông tin này?"),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ClipOval(
                                          child: Material(
                                            color: Colors
                                                .blue, // Màu nền của nút "Huỷ"
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pop(); // Đóng hộp thoại
                                              },
                                              child: const SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                16), // Khoảng cách giữa hai nút
                                        ClipOval(
                                          child: Material(
                                            color: Colors
                                                .red, // Màu nền của nút "Xoá"
                                            child: InkWell(
                                              onTap: () {
                                                // Gọi hàm để xoá thông tin
                                                deleteRecord();
                                                Navigator.of(context)
                                                    .pop(); // Đóng hộp thoại
                                              },
                                              child: const SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(MdiIcons.delete),
                        )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              width: widget.width,
              height: widget.height,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 244, 244),
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  //thời gian
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(MdiIcons.calendarClock),
                      const SizedBox(width: 16),
                      Text(
                        "Thời gian",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 100),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            showDatePickerPopupIos(
                                context, selectedDate, updateSelectedDate);
                          },
                          controller: timeController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),

                  // cân nặng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(MdiIcons.scale),
                      const SizedBox(width: 16),
                      Text(
                        "Cân nặng",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 100),
                      SizedBox(
                        width: 70,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9.]')), // Chấp nhận số và dấu chấm (cho trường hợp nhập số thập phân)
                          ],
                          onChanged: (value) {
                            // Xử lý giá trị nhập vào
                            if (value.startsWith('0')) {
                              // Nếu giá trị bắt đầu bằng 0, loại bỏ 0 và cập nhật giá trị vào TextField
                              weightController.text =
                                  int.parse(value).toString();
                            }
                          },
                          controller: weightController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "kg",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),

                  //chiều cao
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(MdiIcons.humanMaleHeight),
                      const SizedBox(width: 16),
                      Text(
                        "Chiều cao",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 100),
                      SizedBox(
                        width: 70,
                        child: TextField(
                          keyboardType:
                              TextInputType.number, // Chọn kiểu bàn phím số
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[0-9.]')), // Chấp nhận số và dấu chấm (cho trường hợp nhập số thập phân)
                          ],
                          onChanged: (value) {
                            // Xử lý giá trị nhập vào
                            if (value.startsWith('0')) {
                              // Nếu giá trị bắt đầu bằng 0, loại bỏ 0 và cập nhật giá trị vào TextField
                              heightController.text =
                                  int.parse(value).toString();
                            }
                          },
                          controller: heightController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "cm",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  // ghi chú
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(MdiIcons.notebookEditOutline),
                      const SizedBox(width: 16),
                      Text(
                        "Ghi chú:",
                        style: GoogleFonts.getFont(
                          "Inter",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          controller: noteController,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height / 10,
            ),
            GestureDetector(
              onTap: saveRecord,
              child: Container(
                height: screenSize.height / 16,
                width: screenSize.width - 144,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 123, 19),
                  borderRadius: BorderRadius.circular(screenSize.height / 16),
                ),
                child: Center(
                  child: Text(
                    widget.index != null
                        ? "Chỉnh sửa thông tin"
                        : "Thêm thông tin",
                    style: GoogleFonts.getFont("Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
