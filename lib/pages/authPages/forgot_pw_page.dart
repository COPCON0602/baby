// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:baby/pages/authPages/signin_page.dart';
import 'package:baby/utils/auth_helper.dart';
import 'package:baby/widget/custom_dialog.dart';
import 'package:baby/widget/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // text controller
  final _emailController = TextEditingController();

  //thông báo lỗi
  String? emailError;

  //kiểm tra định dạng email
  bool isEmailValid(String email) {
    final RegExp regex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

// Hàm đổi mật khẩu
  Future<void> passwordReset() async {
    final email = _emailController.text.trim();

    if (!isEmailValid(email)) {
      setState(() {
        emailError = "Vui lòng nhập một email hợp lệ.";
      });
      return; // Dừng hàm nếu email không hợp lệ
    } else {
      setState(() {
        emailError = null;
      });
    }

    final isRegistered = await AuthHelper.isEmailRegistered(email);

    if (isRegistered) {
      final isVerified = await AuthHelper.isEmailVerified(email);

      if (isVerified) {
        // Email đã được đăng ký và xác thực
        // Gửi email đổi mật khẩu
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          CustomDialog.show(
            context,
            "Email đổi mật khẩu đã được gửi thành công.",
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SigninPage(),
                ),
              );
            },
          );
        } catch (e) {
          print("Lỗi đổi mật khẩu: $e");
          // Xử lý lỗi nếu cần
        }
      } else {
        // Email đã được đăng ký nhưng chưa được xác thực
        CustomDialog.show(context, "Email chưa được xác thực.");
      }
    } else {
      CustomDialog.show(context, "Email chưa được đăng ký.");
    }
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height / 10),
              Image.asset(
                "assets/images/logo.png",
                width: screenSize.height / 4,
                height: screenSize.height / 4,
              ),
              SizedBox(height: screenSize.height / 20),
              Text(
                "Vui lòng nhập email.\nChúng tôi sẽ gửi cho bạn một email đổi mật khẩu",
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Inter',
                    color: const Color.fromARGB(255, 244, 123, 19),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
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
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  print('Đổi mật khẩu');
                  passwordReset();
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
                      "Đổi mật khẩu",
                      style: GoogleFonts.getFont('Inter',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
