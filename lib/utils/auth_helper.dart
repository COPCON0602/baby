// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  // Hàm kiểm tra email đã đăng ký trên Firebase Auth
  static Future<bool> isEmailRegistered(String email) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.updateEmail(email); // Cố gắng cập nhật email
      return true; // Nếu không có lỗi, email đã được đăng ký
    } catch (e) {
      print("kiểm tra đki mail, lỗi: $e");
      // Xử lý lỗi nếu cần
      return false; // Nếu có lỗi, email chưa được đăng ký
    }
  }

  // Hàm kiểm tra xác thực email
  static Future<bool> isEmailVerified(String email) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        return user!.emailVerified;
      }
    } catch (e) {
      print("kiểm tra xác thực mail, lỗi e = $e");
      // Xử lý lỗi nếu cần
    }
    return false; // Mặc định trả về false nếu có lỗi hoặc người dùng không tồn tại
  }
}
