// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:baby/pages/bodyPages/user/child_profile.dart';
import 'package:baby/pages/bodyPages/user/parent_profile.dart';
import 'package:baby/provider/children_provider.dart';
import 'package:baby/provider/parent_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // Truy xuất thông tin từ ParentProvider và ChildrenProvider
    final parentProvider = Provider.of<ParentProvider>(context);
    final parent = parentProvider.parent;
    final childrenProvider = Provider.of<ChildrenProvider>(context);
    final children = childrenProvider.children;

    //lấy thông tin kích thước màn hình
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin người dùng",
          style: GoogleFonts.getFont(
            'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 244, 244),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: parent?.avatar ??
                            "https://firebasestorage.googleapis.com/v0/b/baby-5fa1e.appspot.com/o/avartarBaby%2Fuser.png?alt=media&token=e80c0862-2dae-4fb0-90ba-214544fa2bc4&_gl=1*722hlg*_ga*MTIwOTUzOTU0NS4xNjkzOTI2MTc1*_ga_CW55HF8NVT*MTY5NjAxODU0OC40NS4xLjE2OTYwMTk1NjIuNTIuMC4w",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              //thông tin người dùng
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Giới thiệu",
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ParentProfile(),
                                  ),
                                );
                              },
                              child: Text(
                                "cập nhật",
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: screenSize.width,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 244, 244),
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //tên người dùng
                        Row(
                          children: [
                            Icon(MdiIcons.cardAccountDetailsOutline, size: 16),
                            const SizedBox(width: 16),
                            Text(
                              (parentProvider.parent!.name == null ||
                                      parentProvider.parent!.name == "")
                                  ? "Người dùng"
                                  : parentProvider.parent!.name ?? "Người dùng",
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        //mail
                        Row(
                          children: [
                            Icon(MdiIcons.emailOutline, size: 16),
                            const SizedBox(width: 16),
                            Text(
                              parentProvider.parent!.email,
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        //ghi chú
                        if (parentProvider.parent!.phone != null &&
                            parentProvider.parent!.phone != "")
                          Row(
                            children: [
                              Icon(MdiIcons.cellphone, size: 16),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  parentProvider.parent!.phone!,
                                  style: GoogleFonts.getFont(
                                    'Inter',
                                    fontSize: 14,
                                  ),
                                  softWrap: true,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              //thông tin bé
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Các bé",
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ChildProfile(),
                                  ),
                                );
                              },
                              child: Text(
                                "thêm bé",
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  if (children.isNotEmpty)
                    SizedBox(
                      height: screenSize.height,
                      child: ListView.builder(
                        itemCount: children.length,
                        itemBuilder: (context, index) {
                          final child = children[index];
                          return GestureDetector(
                            onTap: () {
                              // Xử lý khi người dùng nhấn vào một bản ghi cụ thể (nếu cần)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChildProfile(
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: screenSize.width,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 244, 244),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //tên bé
                                  Row(
                                    children: [
                                      Icon(MdiIcons.babyFaceOutline, size: 16),
                                      const SizedBox(width: 16),
                                      Text(
                                        (child.name != "")
                                            ? child.name
                                            : "Bé yêu",
                                        style: GoogleFonts.getFont(
                                          'Inter',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  //mail
                                  Row(
                                    children: [
                                      Icon(MdiIcons.cake, size: 16),
                                      const SizedBox(width: 16),
                                      Text(
                                        child.dob,
                                        style: GoogleFonts.getFont(
                                          'Inter',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  //ghi chú

                                  Row(
                                    children: [
                                      Icon(MdiIcons.genderMaleFemale, size: 16),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          (child.gender) ? "Bé trai" : "Bé gái",
                                          style: GoogleFonts.getFont(
                                            'Inter',
                                            fontSize: 14,
                                          ),
                                          softWrap: true,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
