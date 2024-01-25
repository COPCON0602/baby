// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:baby/pages/bodyPages/user/user_page.dart';
import 'package:baby/provider/parent_provider.dart';
import 'package:baby/widget/avatar.dart';
import 'package:baby/widget/datepicker.dart';
import 'package:baby/widget/gender.dart';
import 'package:baby/widget/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ParentProfile extends StatefulWidget {
  const ParentProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String avatar = "";
  bool gender = true;

  DateTime selectedDate = DateTime(
    DateTime.now().year - 18,
    DateTime.now().month,
    DateTime.now().day,
  );

  void updateSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
      dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    });
  }
//tạo biến để thực hiện up ảnh lên storage

  @override
  void initState() {
    super.initState();
    _loadCurrentParentData();
  }

//lấy thông tin ban đầu
  void _loadCurrentParentData() {
    final parentProvider = Provider.of<ParentProvider>(context, listen: false);
    final parent = parentProvider.parent;

    if (parent != null) {
      // Lấy thông tin từ parentProvider và cập nhật vào các trường dữ liệu trong màn hình
      nameController.text = parent.name ?? '';
      phoneController.text = parent.phone ?? '';
      dobController.text = parent.dob ?? '';
      mailController.text = parent.email;
      addressController.text = parent.address ?? '';
      gender = parent.gender ?? true;
      avatar = parent.avatar ?? "";
    }
  }

//update thông tin vào parentProvider và cloud firestore
  void _updateParentData() async {
    final parentProvider = Provider.of<ParentProvider>(context, listen: false);
    final parent = parentProvider.parent;

    if (parent != null) {
      final firestore = FirebaseFirestore.instance;
      final email = parent.email;

      // Lấy ID của tài liệu người dùng dựa trên email
      final userQuery =
          firestore.collection('users').where('email', isEqualTo: email);
      final userDocument = await userQuery.get();

      if (userDocument.docs.isNotEmpty) {
        final userId = userDocument.docs.first.id;

        // Cập nhật thông tin của người dùng trên Cloud Firestore
        final userRef = firestore.collection('users').doc(userId);

        parent.name = nameController.text;
        parent.phone = phoneController.text;
        parent.dob = dobController.text;
        parent.address = addressController.text;
        parent.gender = gender;
        parent.avatar = avatar;

        // Cập nhật parentProvider
        parentProvider.setParent(parent);
        try {
          await userRef.update({
            'name': parent.name,
            "phone": parent.phone,
            'dob': parent.dob,
            'email': parent.email,
            'address': parent.address,
            'gender': parent.gender,
            'avatar': parent.avatar,
          });
          // Cập nhật parentProvider
          parentProvider.setParent(parent);
          // Cập nhật thành công, chuyển về màn hình UserPage và thay thế màn hình hiện tại
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const UserPage(),
            ),
          );
        } catch (error) {
          // Xử lý khi có lỗi xảy ra trong quá trình cập nhật
          print('Lỗi khi cập nhật thông tin trên Cloud Firestore: $error');
        }
      } else {
        // Xử lý khi không tìm thấy tài liệu người dùng với email đã cho
        print('Không tìm thấy tài liệu người dùng với email: $email');
      }
    }
  }

  // tải anh
  void _updateProfileImage(File? image) {
    if (image != null) {
      final parentProvider =
          Provider.of<ParentProvider>(context, listen: false);
      final parent = parentProvider.parent;

      if (parent != null) {
        final firestore = FirebaseFirestore.instance;
        final email = parent.email;

        // Lấy ID của tài liệu người dùng dựa trên email
        final userQuery =
            firestore.collection('users').where('email', isEqualTo: email);
        userQuery.get().then((userDocument) {
          if (userDocument.docs.isNotEmpty) {
            final userId = userDocument.docs.first.id;

            // Lưu đường dẫn hình ảnh lên Cloud Firestore
            final imagePath =
                'parents/$userId/avatar.jpg'; // Đường dẫn lưu trữ hình ảnh

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
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin cá nhân",
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Avatar(
                avatar: avatar,
                onImageSelected: _updateProfileImage,
                name: nameController.text,
                isUpload: true,
              ),
            ),
            TextFieldCustomize(
              labelText: 'Họ & tên',
              controller: nameController,
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
                    labelText: 'Ngày sinh',
                    hintText: DateFormat('dd/MM/yyyy').format(
                      DateTime(
                        DateTime.now().year - 18,
                        DateTime.now().month,
                        DateTime.now().day,
                      ),
                    ),
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
                  gender: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextFieldCustomize(
              controller: mailController,
              textInputType: TextInputType.emailAddress,
              labelText: 'Email',
              readOnly: true,
              boxColor: const Color.fromARGB(255, 233, 232, 232),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFieldCustomize(
              controller: phoneController,
              textInputType: TextInputType.number,
              labelText: 'Số điện thoại',
              boxColor: const Color.fromARGB(255, 255, 244, 244),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFieldCustomize(
              controller: addressController,
              textInputType: TextInputType.streetAddress,
              labelText: 'Địa chỉ',
              boxColor: const Color.fromARGB(255, 255, 244, 244),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                _updateParentData(); // Truyền null hoặc một tệp (File) vào đây nếu cần
              },
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
                  style: GoogleFonts.getFont('Inter',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
