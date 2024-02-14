// ignore_for_file: unused_field, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_auth/components/button.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TraslatePage extends StatefulWidget {
  const TraslatePage({super.key, required this.title});
  final String title;

  @override
  State<TraslatePage> createState() => _TraslatePageState();
}

class _TraslatePageState extends State<TraslatePage> {
  late final CameraController _cameraController;
  final _controller = TextEditingController();
  TranslateLanguage _sourceLanguage = TranslateLanguage.english;
  TranslateLanguage _targetLanguage = TranslateLanguage.korean;
  late final OnDeviceTranslator _onDeviceTranslator = OnDeviceTranslator(
    sourceLanguage: _sourceLanguage,
    targetLanguage: _targetLanguage,
  );
  final _translationController = StreamController<String>();
  final bool _cameraIsBusy = false;
  bool _recognitionIsBusy = false;
  late final stt.SpeechToText _speechToText;

  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);
  final bool _canProcess = true;
  final bool _isBusy = false;
  String? _text;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _translationController.close();
    _onDeviceTranslator.close();
    _textRecognizer.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeSpeechToText();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<void> captureAndRecognizeText() async {
    if (_recognitionIsBusy) return;
    _recognitionIsBusy = true;

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _recognizeText(InputImage.fromFilePath(image.path));
    }

    _recognitionIsBusy = false;
    Navigator.of(context).pop();
  }

  Future<void> _recognizeText(InputImage inputImage) async {
    _recognitionIsBusy = true;

    final recognizedText = await _textRecognizer.processImage(inputImage);
    _controller.text = recognizedText.text;

    _recognitionIsBusy = false;
  }

  Future<void> _initializeSpeechToText() async {
    _speechToText = stt.SpeechToText();
    await _speechToText.initialize();
  }

  void startListening() {
    _speechToText.listen(
      onResult: (result) {
        setState(() {
          _controller.text = result.recognizedWords;
        });
      },
    );
  }

  void stopListening() {
    _speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.clear_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop(0);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: DropdownButtonFormField<TranslateLanguage>(
                      value: _sourceLanguage,
                      dropdownColor: Colors.white,
                      style: const TextStyle(
                        color: Color(0xFF292929),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _sourceLanguage = value!;
                          print(_sourceLanguage);
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: TranslateLanguage.english,
                          child: Text('영어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.korean,
                          child: Text('한국어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.japanese,
                          child: Text('일본어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.chinese,
                          child: Text('중국어'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: '아는 말',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: DropdownButtonFormField<TranslateLanguage>(
                      value: _targetLanguage,
                      dropdownColor: Colors.white,
                      style: const TextStyle(
                        color: Color(0xFF292929),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _targetLanguage = value!;
                          print(_targetLanguage);
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: TranslateLanguage.english,
                          child: Text('영어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.korean,
                          child: Text('한국어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.japanese,
                          child: Text('일본어'),
                        ),
                        DropdownMenuItem(
                          value: TranslateLanguage.chinese,
                          child: Text('중국어'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: '알고싶은 말',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '번역할 내용을 작성해 주세요',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) async {
                final translation =
                    await _onDeviceTranslator.translateText(text);
                _translationController.add(translation);
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<String>(
              stream: _translationController.stream,
              builder: (context, snapshot) {
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () => captureAndRecognizeText(),
                child: const Button(
                  text: "캡쳐하기",
                  bgColor: Colors.white,
                  textColor: Color(0xFF292929),
                  borderColor: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  if (_speechToText.isListening) {
                    stopListening();
                  } else {
                    startListening();
                  }
                },
                child: const Button(
                  text: "물어보기",
                  bgColor: Color(0xFF292929),
                  textColor: Colors.white,
                  borderColor: Color(0xFF292929),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
