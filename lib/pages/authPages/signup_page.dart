// ignore_for_file: avoid_print, unused_import, use_build_context_synchronously

import 'package:baby/pages/authPages/email_verification_page.dart';
import 'package:baby/pages/authPages/forgot_pw_page.dart';
import 'package:baby/pages/home_page.dart';
import 'package:baby/pages/authPages/signin_page.dart';
import 'package:baby/widget/custom_dialog.dart';
import 'package:baby/widget/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isPassword = false;
  bool isConfirmPassword = false;
  bool? loginSuccessful;

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  //kiểm tra định dạng email
  bool isEmailValid(String email) {
    final RegExp regex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }

  // hàm kiểm tra đăng kí
  Future<void> signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Logic kiểm tra
    // Logic kiểm tra định dạng email
    if (!isEmailValid(email)) {
      setState(() {
        emailError = "Vui lòng nhập một email hợp lệ.";
      });
    } else {
      setState(() {
        emailError = null;
      });
    }

    if (password.isEmpty || password.length < 6) {
      setState(() {
        passwordError = "Vui lòng nhập mật khẩu có ít nhất 6 ký tự.";
      });
    } else {
      setState(() {
        passwordError = null;
      });
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPasswordError = "Vui lòng xác nhận mật khẩu.";
      });
    } else if (password != confirmPassword) {
      setState(() {
        confirmPasswordError = "Mật khẩu và xác nhận mật khẩu không khớp.";
      });
    } else {
      setState(() {
        confirmPasswordError = null;
      });
    }

    // Kiểm tra xem có lỗi nào không trước khi tiến hành đăng ký
    if (emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      return; // Không tiếp tục đăng ký nếu có lỗi
    }

    try {
      final auth = FirebaseAuth.instance;

      // Kiểm tra xem email đã tồn tại hay chưa
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        // Tạo một map chứa thông tin người dùng để lưu vào Firestore
        final userData = {
          'email': email,
          'name': 'Người dùng',
          'dob': '',
          'gender': true,
          'phone': '',
          'address': '',
          'avatar':
              'https://firebasestorage.googleapis.com/v0/b/baby-5fa1e.appspot.com/o/avartarBaby%2Fuser.png?alt=media&token=e80c0862-2dae-4fb0-90ba-214544fa2bc4&_gl=1*v0cvkv*_ga*MTIwOTUzOTU0NS4xNjkzOTI2MTc1*_ga_CW55HF8NVT*MTY5NjAxODU0OC40NS4xLjE2OTYwMTg1NTkuNDkuMC4w"',
          'children': [
            {
              'name': 'bé yêu',
              'nicknName': 'baby',
              'dob': "01/01/2020",
              'gender': true,
              'avatar':
                  "https://firebasestorage.googleapis.com/v0/b/baby-5fa1e.appspot.com/o/avartarBaby%2Fbaby.png?alt=media&token=c5c06f79-329c-4e80-b252-3c7fdb556bdd&_gl=1*1vto8yh*_ga*MTIwOTUzOTU0NS4xNjkzOTI2MTc1*_ga_CW55HF8NVT*MTY5NjAxODU0OC40NS4xLjE2OTYwMTg4ODkuNjAuMC4w",
              'records': [
                {
                  'time': DateTime(2022, 01, 01),
                  'weight': 0,
                  'height': 0,
                  'note': ''
                },
              ],
            }
          ]
        };

        // Lưu thông tin người dùng vào Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid) // Sử dụng UID của người dùng làm ID trong Firestore
            .set(userData);

        // Gửi email xác minh
        await user.sendEmailVerification();

        // Hiển thị thông báo cho người dùng
        CustomDialog.show(
          context,
          "Tài khoản đã được đăng ký thành công.\nVui lòng xác thực email!",
          onPressed: () {
            // Đóng dialog
            Navigator.of(context).pop();
            // Chuyển đến màn hình đăng nhập
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const EmailVerificationPage()));
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Email đã tồn tại

        CustomDialog.show(
            context, "Email đã được đăng ký.\nVui lòng chọn \"Quên mật khẩu\"");
      } else {
        // Xử lý lỗi khác ở đây nếu cần
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 244, 244),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenSize.height / 15),
              Image.asset(
                "assets/images/logo.png",
                width: screenSize.height / 4,
                height: screenSize.height / 4,
              ),
              SizedBox(height: screenSize.height / 25),
              const SizedBox(
                height: 8,
              ),
              TextFieldCustomize(
                controller: _emailController,
                borderColor: const Color.fromRGBO(251, 219, 219, 0.612),
                boxColor: Colors.white,
                textInputType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.mail),
                width: screenSize.width - 16,
                height: screenSize.height / 16,
                hintText: "Email",
                errorText: emailError,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldCustomize(
                obscureText: !isPassword,
                controller: _passwordController,
                boxColor: Colors.white,
                borderColor: const Color.fromRGBO(251, 219, 219, 0.612),
                suffixicon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: isPassword ? Colors.blue : Colors.black,
                    )),
                prefixIcon: const Icon(Icons.lock),
                width: screenSize.width - 16,
                height: screenSize.height / 16,
                hintText: "Mật khẩu",
                errorText: passwordError,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldCustomize(
                obscureText: !isConfirmPassword,
                controller: _confirmPasswordController,
                boxColor: Colors.white,
                borderColor: const Color.fromRGBO(251, 219, 219, 0.612),
                suffixicon: IconButton(
                    onPressed: () {
                      setState(() {
                        isConfirmPassword = !isConfirmPassword;
                      });
                    },
                    icon: Icon(
                      isConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: isConfirmPassword ? Colors.blue : Colors.black,
                    )),
                prefixIcon: const Icon(Icons.lock),
                width: screenSize.width - 16,
                height: screenSize.height / 16,
                hintText: "Nhập lại mật khẩu",
                errorText: confirmPasswordError,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage())); // Điều hướng đến màn hình ForgotPasswordPage
                      },
                      child: Text(
                        "Quên mật khẩu",
                        style: GoogleFonts.getFont(
                          'Inter',
                          //fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: signUp,
                child: Container(
                  height: screenSize.height / 16,
                  width: screenSize.width - 144,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 123, 19),
                    borderRadius: BorderRadius.circular(screenSize.height / 16),
                  ),
                  child: Center(
                      child: Text(
                    "Đăng ký",
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
      ),
    );
  }
}
