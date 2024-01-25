

// ignore_for_file: avoid_print

// hiển thị lịch theo android
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showDatePickerPopupAndroid(BuildContext context,
    DateTime selectedDate, Function(DateTime) onDateSelected) async {
  final DateTime? picked = await showDatePicker(
    initialEntryMode: DatePickerEntryMode.calendar,
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(
        DateTime.now().year - 60, DateTime.now().month, DateTime.now().day),
    lastDate: DateTime.now(),
    //errorFormatText: 'định dạng ngày: dd/mm/yyyy',
    //errorInvalidText: 'Ngày ngoài phạm vi cho phép',
    fieldHintText: "dd/mm/yyyy",
    keyboardType: TextInputType.datetime,
  );

  if (picked != null && picked != selectedDate) {
    onDateSelected(picked);
  }
}



//// hiển thị lịch theo ios
void showDatePickerPopupIos(BuildContext context, DateTime selectedDate,
    Function(DateTime) onDateSelected) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Material(
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),
          height: 300,
          child: Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(
                    DateTime.now().year - 60,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                  onDateTimeChanged: (date) {
                    selectedDate = date;
                    print('selectedate1: $selectedDate');
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  onDateSelected(selectedDate);
                  Navigator.of(context).pop();
                  print('selectedate2: $selectedDate');
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 244, 123, 19),
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Xong',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
