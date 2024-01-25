// ignore_for_file: use_build_context_synchronously

import 'package:baby/pages/authPages/signin_page.dart';
import 'package:baby/widget/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    // Kiểm tra lại xem email đã được xác minh chưa
                    final user = FirebaseAuth.instance.currentUser;
                    await user?.reload();
                    if (user != null && user.emailVerified) {
                      // Email đã được xác minh, điều hướng đến màn hình chính
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SigninPage()),
                      );
                    } else {
                      // Hiển thị thông báo nếu email chưa được xác minh
                      CustomDialog.show(
                          context, "Email chưa được xác minh thành công!");
                    }
                  },
                  child: Container(
                    height: screenSize.height / 16,
                    width: screenSize.width - 144,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 123, 19),
                      borderRadius:
                          BorderRadius.circular(screenSize.height / 16),
                    ),
                    child: Center(
                        child: Text(
                      'Kiểm tra xác minh Email',
                      style: GoogleFonts.getFont('Inter',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
