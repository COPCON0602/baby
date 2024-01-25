// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatefulWidget {
  final String name;
  final String? avatar;
  final String? phone;
  final bool isUpload;
  final double size;
  final Function(File?)? onImageSelected;

  const Avatar({
    super.key,
    required this.name,
    this.avatar,
    this.phone,
    this.isUpload = false,
    this.size = 120,
    this.onImageSelected,
  });

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  File? _selectedImage;

  Future<void> _selectImage() async {
    final image = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Chụp ảnh'),
              onTap: () async {
                final image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                Navigator.pop(context, image);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Chọn ảnh từ thư viện'),
              onTap: () async {
                final image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                Navigator.pop(context, image);
              },
            ),
          ],
        );
      },
    );

    if (image != null) {
      widget.onImageSelected?.call(File(image.path));
      setState(() {
        _selectedImage = File(image.path);
        print("selectedImage: $_selectedImage ");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("selectedImage: $_selectedImage ");
    return GestureDetector(
      onTap: () {
        _selectImage();
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: widget.size - 20,
                height: widget.size - 20,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 248, 25, 9),
                  shape: BoxShape.circle,
                ),
                child: _selectedImage != null
                    ? ClipOval(
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : (widget.avatar != null
                        ? ClipOval(
                            child: Image.network(
                              widget.avatar!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    (widget.name != "")
                                        ? widget.name
                                            .substring(0, 1)
                                            .toUpperCase()
                                        : "A",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              widget.name.substring(0, 1).toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                          )),
              ),
              if (widget.isUpload)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.file_upload_outlined,
                      color: Color.fromARGB(255, 248, 25, 9),
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          if (widget.phone != null)
            SizedBox(
              width: widget.size,
              child: Text(
                widget.phone!,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
