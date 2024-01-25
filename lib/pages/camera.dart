// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io' show File, Platform;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart' as file_picker;

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  Uint8List? _image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            _image != null
                ? CircleAvatar(
                    radius: 120,
                    backgroundColor: Colors.white,
                    backgroundImage: MemoryImage(
                      _image!,
                    ),
                  )
                : const CircleAvatar(
                    radius: 120,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      "https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0=",
                    ),
                  ),
            Positioned(
              bottom: -0,
              left: 140,
              child: IconButton(
                onPressed: () {
                  showImagePickerOption(context);
                },
                icon: const Icon(
                  Icons.add_a_photo,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 12,
              right: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Search
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/home',
                    );
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: Color(0xFF292929),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '홈',
                        style: TextStyle(
                          color: Color(0xFF292929),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Favorite
                const Column(
                  children: [
                    Icon(
                      Icons.explore_outlined,
                      color: Color(0xFF292929),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '더 보기',
                      style: TextStyle(
                        color: Color(0xFF292929),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                // Airbnb
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/camera',
                    );
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.camera_rounded,
                        color: Color(0xFF292929),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '카메라',
                        style: TextStyle(
                          color: Color(0xFF292929),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Chat
                const Column(
                  children: [
                    Icon(
                      Icons.cases_outlined,
                      color: Color(0xFF292929),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '나의 페이지',
                      style: TextStyle(
                        color: Color(0xFF292929),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                // Profile
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/profile',
                    );
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        color: Color(0xFF292929),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '프로필',
                        style: TextStyle(
                          color: Color(0xFF292929),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.amber.shade100,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Platform.isMacOS
                          ? _pickImageFromWeb()
                          : _pickImageFromGallery();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.black,
                          ),
                          Text(
                            "Gallery",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 60,
                            color: Colors.black,
                          ),
                          Text(
                            "Camera",
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  Future _pickImageFromWeb() async {
    try {
      final result = await file_picker.FilePicker.platform.pickFiles(
        type: file_picker.FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = File(result.files.single.path!);
      setState(() {
        selectedImage = file;
        _image = file.readAsBytesSync();
      });
    } catch (e) {
      print("Error picking image from web: $e");
    }
    Navigator.of(context).pop();
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}
