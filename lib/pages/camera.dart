// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io' show File;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:logger/logger.dart';
import 'package:login_auth/components/button.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _CameraPageState();
}

class _CameraPageState extends State<PickImage> {
  Uint8List? _image;
  File? selectedImage;
  List<String> modelSelectionOptions = [
    "YOLO v5s",
    "YOLO v5m",
    "YOLO v5l",
    "YOLO v5x"
  ];
  String selectedModel = "YOLO v5x";
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            padding: const EdgeInsets.all(
                              4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                style: BorderStyle.solid,
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFF292929),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Stack(
                      children: [
                        _image != null
                            ? Container(
                                width: 320,
                                height: 360,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey.shade100,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(_image!),
                                  ),
                                ),
                              )
                            : Container(
                                width: 320,
                                height: 360,
                                color: Colors.grey.shade200,
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 64,
                            ),
                            child: DropdownButtonFormField(
                              value: selectedModel,
                              items: modelSelectionOptions
                                  .map((selection) => DropdownMenuItem(
                                        value: selection,
                                        child: Text(selection),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedModel = value.toString();
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: "Select YOLO Model",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () => showImagePickerOption(context),
                      child: const Button(
                        text: "Import Image",
                        bgColor: Colors.white,
                        textColor: Color(0xFF292929),
                        borderColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () => _uploadImage(),
                      child: const Button(
                        text: "Submit",
                        bgColor: Color(0xFF292929),
                        textColor: Colors.white,
                        borderColor: Color(0xFF292929),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 90,
          child: BottomAppBar(
            color: const Color(0xFF45757B),
            shadowColor: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 12,
                right: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildNavItem(Icons.home_outlined, 'Home', 0),
                  buildNavItem(Icons.explore_outlined, 'Search', 1),
                  buildNavItem(Icons.camera_rounded, 'Camera', 2),
                  buildNavItem(Icons.cases_outlined, 'My Page', 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
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
                      _pickImageFromWeb();
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

  // Future _pickImageFromGallery() async {
  //   final returnImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (returnImage == null) return;
  //   setState(() {
  //     selectedImage = File(returnImage.path);
  //     _image = File(returnImage.path).readAsBytesSync();
  //   });
  //   Navigator.of(context).pop();
  // }

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

  Future<void> _uploadImage() async {
    if (selectedImage == null) return;

    String uploadUrl = "http://172.30.1.67:8000/images";
    Dio dio = Dio();

    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          selectedImage!.path,
          filename: selectedImage!.path.split('/').last,
        ),
        "model_name": selectedModel,
      });

      Response response = await dio.post(
        uploadUrl,
        data: formData,
      );
      Logger().e(response);
      print("Server Response: ${response.data}");
    } catch (e) {
      Logger().e(e);
      print("Error uploading image: $e");
    }
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        switch (_currentIndex) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/search');
            break;
          case 2:
            Navigator.pushNamed(context, '/camera');
            break;
          case 3:
            Navigator.pushNamed(context, '/mypage');
            break;
        }
      },
      child: Column(
        children: [
          Icon(
            icon,
            color:
                _currentIndex == index ? Colors.white : const Color(0xFF292929),
            size: 28,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index
                  ? Colors.white
                  : const Color(0xFF292929),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
