//import 'package:baby/widget/custom_datepicker_popup.dart';
import 'package:baby/widget/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';

//  nhập thông tin chi tiết
class RecordDetail extends StatefulWidget {
  final double? width;
  final double? height;
  const RecordDetail({super.key, this.width, this.height});

  @override
  State<RecordDetail> createState() => _RecordDetailState();
}

class _RecordDetailState extends State<RecordDetail> {
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

  // khởi tạo giá trị ban đầu
  @override
  void initState() {
    weightController.text = "0";
    heightController.text = "0";
    timeController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
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
            //crossAxisAlignment: CrossAxisAlignment.center,
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
            //crossAxisAlignment: CrossAxisAlignment.center,
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
                      weightController.text = int.parse(value).toString();
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
                  keyboardType: TextInputType.number, // Chọn kiểu bàn phím số
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(
                        r'[0-9.]')), // Chấp nhận số và dấu chấm (cho trường hợp nhập số thập phân)
                  ],
                  onChanged: (value) {
                    // Xử lý giá trị nhập vào
                    if (value.startsWith('0')) {
                      // Nếu giá trị bắt đầu bằng 0, loại bỏ 0 và cập nhật giá trị vào TextField
                      heightController.text = int.parse(value).toString();
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
    );
  }
}
