import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic/feature/select_image/bloc/select_image_bloc.dart';
import 'package:geopic/feature/select_image/bloc/select_image_event.dart';
import 'package:geopic/feature/select_image/bloc/select_image_state.dart';
import 'package:get_it/get_it.dart';
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
  final SelectImageBloc _selectImageBloc =
      GetIt.instance.get<SelectImageBloc>();
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

    String prompt =
        'I will give a list of items which is near to me. Give me a list of locations which can i be at there. Items: ${items.toString()}. Return output like [place1, place2]';
    _selectImageBloc.add(SendDetectPlaceRequest(prompt: prompt));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _selectImageBloc,
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<SelectImageBloc, SelectImageState>(
            builder: (context, state) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _selectImage();
                  },
                  child: const Text('select image')),
              // if(state is SelectImageSuccessState){
              //   return
              // }
            ],
          );
        })),
      ),
    );
  }
}
