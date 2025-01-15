import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  String _result = 'No result';  // Default result message

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    await _cameraController?.initialize();
    setState(() {});
  }

  Future<void> captureAndSendImage() async {
    final XFile? image = await _cameraController?.takePicture();


    if (image != null) {
      print('Image captured at path: ${image.path}');
      sendImageToServer(image.path);
    } else {
      print('Failed to capture image.');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void sendImageToServer(String imagePath) async {
    final url = Uri.parse('youripaddress:5001/detect');
    final request = http.MultipartRequest('POST', url);


    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    try {
      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('Response data: $responseData');

        // Assuming the response data is a JSON string
        Map<String, dynamic> data = jsonDecode(responseData);

        setState(() {
          // Process detections if available
          _result = (data.containsKey("detections") && data["detections"] != null)
              ? _processDetections(data["detections"])
              : 'No result';
        });
      } else {
        setState(() {
          _result = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
      print('Error: $e');
    }
  }

  // Function to clean and process the detections string
  String _processDetections(String detections) {
    // Clean the string by removing unwanted characters like [' and ']
    String cleaned = detections.replaceAll(RegExp(r"[^\w\s,]"), '');

    // Split the string by commas and trim each item
    List<String> detectionList = cleaned.split(',').map((e) => e.trim()).toList();

    // Join the items into a string, separated by commas
    return detectionList.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera")),
      body: Column(
        children: [
          Expanded(
            child: _cameraController != null && _cameraController!.value.isInitialized
                ? Center(
              child: Container(
                width: 500,
                height: 500,
                child: Transform.rotate(
                  angle: 3.14 / 2,
                  child: CameraPreview(_cameraController!),
                ),
              ),
            )
                : Center(child: CircularProgressIndicator()),
          ),
          if (_result != null)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Result: $_result',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: captureAndSendImage,
        child: Icon(Icons.camera),
      ),
    );
  }
}
