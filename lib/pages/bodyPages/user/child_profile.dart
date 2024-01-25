// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'dart:io';
import 'package:baby/models/child.dart';
import 'package:baby/models/growth/growth_info.dart';
import 'package:baby/provider/children_provider.dart';
import 'package:baby/provider/parent_provider.dart';
import 'package:baby/widget/avatar.dart';
import 'package:baby/widget/datepicker.dart';
import 'package:baby/widget/gender.dart';
import 'package:baby/widget/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ChildProfile extends StatefulWidget {
  final double? width;
  final double? height;
  final int? index; // Thêm index để biết là đang sửa record nào hoặc thêm mới
  const ChildProfile({super.key, this.width, this.height, this.index});

  @override
  State<ChildProfile> createState() => _ChildProfileState();
}

class _ChildProfileState extends State<ChildProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  List<GrowthInforRecord> records = [];

  String avatar = "";

  bool gender = true;

  DateTime selectedDate = DateTime.now();

  void updateSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
      dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    });
  }

  @override
  void initState() {
    if (widget.index != null) {
      // Nếu đang sửa thì điền thông tin cũ vào các controller
      final provider = Provider.of<ChildrenProvider>(context, listen: false);
      final child = provider.children[widget.index!];
      selectedDate = DateFormat('dd/MM/yyyy').parse(child.dob);

      dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      nameController.text = child.name.toString();
      nickNameController.text = child.nicknName.toString();
      avatar = child.avatar ?? "";
      gender = child.gender;
      records = child.records ?? [];
    } else {
      // Nếu thêm mới thì khởi tạo giá trị ban đầu
      nameController.text = "";
      nickNameController.text = "";
      dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      avatar = "";
      gender = true;
      records = [];
    }
    super.initState();
  }

  // hàm để lưu thông tin bé lên ChildrenProvider và  Firestore
  void saveChild() async {
    final Child child = Child(
        name: nameController.text,
        dob: dobController.text,
        gender: gender,
        avatar: avatar,
        nicknName: nickNameController.text,
        records: records);

    final parentProvider = Provider.of<ParentProvider>(context, listen: false);
    final parent = parentProvider.parent;

    if (parent != null) {
      final firestore = FirebaseFirestore.instance;
      final email = parent.email;

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

          if (widget.index != null) {
            // Nếu đang sửa, cập nhật thông tin bé
            updatedChildren[widget.index!] = {
              'name': child.name,
              'dob': child.dob,
              'gender': child.gender,
              'avatar': child.avatar,
              'nickName': child.nicknName,
              'records': child.records,
            };
          } else {
            // Nếu thêm mới, thêm thông tin bé vào danh sách

            updatedChildren.add({
              'name': child.name,
              'dob': child.dob,
              'gender': child.gender,
              'avatar': child.avatar,
              'nickName': child.nicknName,
              "records": child.records,
            });
          }

          // Cập nhật trường "children" trong document của người dùng
          await userRef.update({'children': updatedChildren});

          // Cập nhật thông tin vào ChildrenProvider
          final provider =
              Provider.of<ChildrenProvider>(context, listen: false);
          if (widget.index != null) {
            // Nếu đang sửa, cập nhật thông tin bé trong provider
            provider.editChild(widget.index!, child);
            print("Chỉnh sửa thông tin bé thành công");
          } else {
            // Nếu thêm mới, thêm thông tin bé vào provider
            provider.addChild(child);
            print("Thêm bé thành công");
          }

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

  // Thêm hàm để xoá thông tin bé từ Firestore
  void deleteChild() async {
    final provider = Provider.of<ChildrenProvider>(context, listen: false);

    final parentProvider = Provider.of<ParentProvider>(context, listen: false);
    final parent = parentProvider.parent;

    if (parent != null) {
      final firestore = FirebaseFirestore.instance;
      final email = parent.email;

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

          if (currentChildren != null) {
            // Xóa child khỏi danh sách dựa trên index
            currentChildren.removeAt(widget.index!);

            // Cập nhật trường "children" trong document của người dùng
            await userRef.update({'children': currentChildren});

            // Xoá thông tin bé từ ChildrenProvider
            provider.removeChild(widget.index!);

            Navigator.pop(context);
          } else {
            print(
                "Không tìm thấy danh sách children cho người dùng với email: $email");
          }
        } else {
          print("Không tìm thấy người dùng với email: $email");
        }
      } catch (error) {
        // Xử lý lỗi nếu có
        print('Lỗi khi xoá thông tin bé: $error');
      }
    }
  }

// tải anh
  void _uploadImage(File? image) async {
    if (image != null) {
      final parentProvider =
          Provider.of<ParentProvider>(context, listen: false);
      final parent = parentProvider.parent;

      if (parent != null) {
        final firestore = FirebaseFirestore.instance;
        final email = parent.email;

        try {
          // Tìm document người dùng dựa trên email
          final userQuery =
              firestore.collection('users').where('email', isEqualTo: email);
          final userDocuments = await userQuery.get();

          if (userDocuments.docs.isNotEmpty) {
            // Lấy ID của document người dùng
            final userId = userDocuments.docs.first.id;

            // Lưu đường dẫn hình ảnh lên Cloud Firestore
            String imagePath;
            if (widget.index == null) {
              imagePath = 'parents/$userId/children/addChild/avatar.jpg';
            } else {
              imagePath =
                  'parents/$userId/children/childrenIndex_${widget.index}/avatar.jpg';
            }

            // Lưu hình ảnh lên storage
            final storageRef = FirebaseStorage.instance.ref(imagePath);
            final uploadTask = storageRef.putFile(image);

            // Lắng nghe sự kiện hoàn thành tải lên
            uploadTask.whenComplete(() async {
              try {
                final imageUrl = await storageRef.getDownloadURL();

                setState(() {
                  avatar = imageUrl;
                });
              } catch (error) {
                print('Lỗi khi lấy URL hình ảnh: $error');
              }
            });
          }
        } catch (error) {
          // Xử lý lỗi nếu có
          print('Lỗi khi lưu thông tin bé: $error');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.index != null ? "Chỉnh sửa thông tin bé" : "Thêm thông tin bé",
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Avatar(
              avatar: avatar,
              onImageSelected: _uploadImage,
              name: nameController.text,
              isUpload: true,
            ),
          ),
          if (widget.index != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                                    color: Colors.blue, // Màu nền của nút "Huỷ"
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
                                    width: 16), // Khoảng cách giữa hai nút
                                ClipOval(
                                  child: Material(
                                    color: Colors.red, // Màu nền của nút "Xoá"
                                    child: InkWell(
                                      onTap: () {
                                        deleteChild();

                                        Navigator.pop(context);
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
          TextFieldCustomize(
            labelText: 'Tên của bé',
            controller: nameController,
            textInputType: TextInputType.name,
            boxColor: const Color.fromARGB(255, 255, 244, 244),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldCustomize(
            labelText: 'Tên ở nhà',
            controller: nickNameController,
            textInputType: TextInputType.name,
            boxColor: const Color.fromARGB(255, 255, 244, 244),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: TextFieldCustomize(
                  boxColor: const Color.fromARGB(255, 255, 244, 244),
                  controller: dobController,
                  textInputType: TextInputType.none,
                  labelText: 'Ngày sinh (bắt buộc)',
                  suffixicon: const Icon(Icons.calendar_month),
                  onEditingComplete: () {
                    setState(() {
                      selectedDate =
                          DateFormat('dd/MM/yyyy').parse(dobController.text);
                    });
                  },
                  readOnly: true,
                  onTap: () {
                    showDatePickerPopupIos(
                        context, selectedDate, updateSelectedDate);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Gender(
                femaleName: "Bé gái",
                maleName: "Bé trai",
                gender: gender,
                onChanged: (value) {
                  gender = value;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: saveChild,
            child: Container(
              height: screenSize.height / 16,
              width: screenSize.width - 144,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 244, 123, 19),
                borderRadius: BorderRadius.circular(screenSize.height / 16),
              ),
              child: Center(
                child: Text(
                  "Lưu thông tin",
                  style: GoogleFonts.getFont(
                    'Inter',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
