import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class SelectImageScreen extends StatefulWidget {
  const SelectImageScreen({Key? key}) : super(key: key);

  @override
  State<SelectImageScreen> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  late ObjectDetector _objectDetector;

  @override
  void initState() {
    super.initState();
    _initializeDetector();
  }

  void _initializeDetector() async {
    const path = 'assets/ml/object_labeler.tflite';
    final modelPath = await _getModel(path);
    final options = LocalObjectDetectorOptions(
      mode: DetectionMode.single,
      modelPath: modelPath,
      classifyObjects: true,
      multipleObjects: true,
    );
    _objectDetector = ObjectDetector(options: options);
  }

  Future<String> _getModel(String assetPath) async {
    if (Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final modelPath =
        '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await Directory(path.dirname(modelPath)).create(recursive: true);
    final file = File(modelPath);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  _selectImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _process(image.path);
    }
  }

  Future<void> _process(String path) async {
    List<String> items = [];
    InputImage inputImage = InputImage.fromFilePath(path);

    List<DetectedObject> objects =
        await _objectDetector.processImage(inputImage);
    for (DetectedObject detectedObject in objects) {
      for (Label label in detectedObject.labels) {
        items.add(label.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _selectImage();
              },
              child: const Text('select image'))
        ],
      )),
    );
  }
}
