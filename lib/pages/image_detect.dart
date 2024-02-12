// ignore_for_file: avoid_print, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:io' show File;
import 'dart:typed_data';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:logger/logger.dart';
import 'package:login_auth/components/button.dart';

class ImageDetect extends StatefulWidget {
  const ImageDetect({super.key});

  @override
  State<ImageDetect> createState() => _ImageDetectPageState();
}

class _ImageDetectPageState extends State<ImageDetect> {
  Uint8List? _image;
  File? selectedImage;
  String selectedModel = "yolov5x";
  List<dynamic> classNames = [];
  List<dynamic> boundingBox = [];
  int _currentIndex = 2;
  int imageHeight = 1;
  int imageWidth = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
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
                          for (var box in boundingBox)
                            Positioned(
                              left: box[0].toDouble() * imageWidth,
                              top: box[1].toDouble() * imageHeight,
                              child: Container(
                                width: (box[2].toDouble() - box[0].toDouble()) *
                                    imageWidth,
                                height:
                                    (box[3].toDouble() - box[1].toDouble()) *
                                        imageHeight,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: () => showImagePickerOption(context),
                            child: const Button(
                              text: "사진 가져오기",
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
                              text: "보내기",
                              bgColor: Color(0xFF292929),
                              textColor: Colors.white,
                              borderColor: Color(0xFF292929),
                            ),
                          ),
                        ],
                      ),
                      if (classNames != null && classNames.isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 320,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "결과는?",
                                    style: TextStyle(
                                      color: Color(0xFF292929),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    classNames.join('\n'),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            )
                          ],
                        )
                      else
                        Container(),
                    ],
                  ),
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
                  buildNavItem(Icons.question_answer_rounded, 'Chat', 1),
                  buildNavItem(Icons.camera_rounded, 'Camera', 2),
                  buildNavItem(Icons.person_outline_rounded, 'My Page', 3),
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
                      _pickImageFromGallery();
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

    final image = File(returnImage.path);

    final decodedImage = await decodeImageFromList(image.readAsBytesSync());
    final int imageHeight = decodedImage.height;
    final int imageWidth = decodedImage.width;

    print('Image width: $imageHeight, height: $imageWidth');
    Navigator.of(context).pop();
  }

  // Future _pickImageFromWeb() async {
  //   try {
  //     final result = await file_picker.FilePicker.platform.pickFiles(
  //       type: file_picker.FileType.custom,
  //       allowedExtensions: ['jpg', 'jpeg', 'png'],
  //     );

  //     if (result == null || result.files.isEmpty) {
  //       return;
  //     }

  //     final file = File(result.files.single.path!);

  //     setState(() {
  //       selectedImage = file;
  //       _image = file.readAsBytesSync();
  //     });
  //   } catch (e) {
  //     print("Error picking image from web: $e");
  //   }
  //   Navigator.of(context).pop();
  // }

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

    String uploadUrl = "http://172.30.1.29:8000/image";
    Dio dio = Dio();

    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          selectedImage!.path,
          filename: selectedImage!.path.split('/').last,
        ),
        "model_name": selectedModel,
      });

      Response uploadResponse = await dio.post(
        uploadUrl,
        data: formData,
      );

      Logger().e(uploadResponse);
      print("Server Response: ${uploadResponse.data}");

      // if (uploadResponse.statusCode == 200) {
      //   setState(() {
      //     // Extract class_name values and store them in classNames list
      //     classNames = List<dynamic>.from(uploadResponse.data[0]
      //         .map((item) => item["class_name"].toString()));
      //     print(classNames);
      //   });
      // }

      if (uploadResponse.statusCode == 200) {
        setState(
          () {
            classNames = List<dynamic>.from(
              Set<String>.from(
                uploadResponse.data[0]
                    .map((item) => item["class_name"].toString()),
              ),
            );

            boundingBox = List<dynamic>.from(
              uploadResponse.data[0].map((item) => item["bbox"]),
            );

            print(boundingBox);
          },
        );
      }
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
