// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final user = FirebaseAuth.instance.currentUser!;
  String result = '';
  int _currentIndex = 3;

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  TextEditingController urlController = TextEditingController();

  Future<void> fetchData() async {
    try {
      final enteredUrl = urlController.text;
      final response = await http.get(
        Uri.parse(enteredUrl),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result = "hi: {$data}";
        });
      } else {
        setState(() {
          result = "Failed to fetch data. Status Code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }

  Future<void> onPressGet() async {
    try {
      http.Response response = await http.get(
        Uri.parse('http://127.0.0.1:8000/'),
      );
      if (response.statusCode == 200) {
        setState(() {
          result = response.body;
        });
      } else {
        setState(() {
          result = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  onPressClient() async {
    var client = http.Client();

    try {
      http.Response response = await client.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          body: {'title': 'Hello', 'body': 'World', 'userId': '1'});
      if (response.statusCode == 200 || response.statusCode == 201) {
        response = await client
            .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
        setState(() {
          result = response.body;
        });
      } else {
        setState(() {
          result = 'Error: ${response.statusCode}';
        });
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text(
                "Heyyyyyyyyyyyy",
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: IconButton(
                  onPressed: logOut,
                  icon: const Icon(
                    Icons.logout_rounded,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  uploadImage('image', File('assets/images/city_street.jpg'));
                },
                child: const Text("Upload"),
              ),
              const SizedBox(height: 20),
              Text(
                result,
                style: const TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: onPressGet,
                child: const Text(
                  'Make GET Request',
                ),
              ),
              ElevatedButton(
                onPressed: onPressClient,
                child: const Text(
                  'Make Client Request',
                ),
              ),
            ],
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
    );
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

Future<void> uploadImage(String title, File file) async {
  const String urlToInsertImage = "https://127.0.0.1:8000/upload";
  var request = http.MultipartRequest("POST", Uri.parse(urlToInsertImage));

  // Add any necessary fields to the request
  request.fields['title'] = title;

  // Add the image file to the request
  request.files.add(http.MultipartFile.fromBytes(
    'image',
    file.readAsBytesSync(),
    filename: file.path.split('/').last, // Use the filename from the path
  ));

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      // Image uploaded successfully, handle the response here
      print("Image uploaded successfully");
      print(await response.stream.bytesToString());
    } else {
      // Handle the error
      print("Failed to upload image. Status code: ${response.statusCode}");
    }
  } catch (error) {
    // Handle any exceptions that occur during the HTTP request
    print("Error uploading image: $error");
  }
}

Future<void> pickAndUploadImage() async {
  try {
    File imageFile = await getImage();

    await uploadImage('Image from Camera', imageFile);
  } catch (error) {
    print("Error picking and uploading image: $error");
  }
}

Future<File> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    return File(image.path);
  } else {
    throw Exception("Image selection canceled");
  }
}
