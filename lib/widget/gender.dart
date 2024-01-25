import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gender extends StatefulWidget {
  final String? femaleName;
  final String? maleName;
  final bool gender;
  final Function(bool) onChanged;
  const Gender(
      {super.key,
      required this.gender,
      required this.onChanged,
      this.femaleName,
      this.maleName});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  var gender = true;
  @override
  void initState() {
    gender = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Giới tính',
            style: GoogleFonts.getFont(
              'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              width: 120,
              height: 44,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        gender = true;
                        widget.onChanged(true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: gender
                                ? const Color.fromARGB(255, 244, 123, 19)
                                : Colors.white,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                          color: gender
                              ? const Color.fromARGB(255, 244, 123, 19)
                              : Colors.white,
                        ),
                        child: Text(
                          widget.maleName ?? "Nam",
                          style: GoogleFonts.getFont(
                            'Inter',
                            color: gender ? Colors.white : Colors.black,
                            fontWeight:
                                gender ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          gender = false;
                        });
                        widget.onChanged(false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: !gender
                                ? const Color.fromARGB(255, 244, 123, 19)
                                : Colors.white,
                          ),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                          color: !gender
                              ? const Color.fromARGB(255, 244, 123, 19)
                              : Colors.white,
                        ),
                        child: Text(
                          widget.femaleName ?? "Nữ",
                          style: GoogleFonts.getFont(
                            'Inter',
                            color: !gender ? Colors.white : Colors.black,
                            fontWeight:
                                !gender ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
