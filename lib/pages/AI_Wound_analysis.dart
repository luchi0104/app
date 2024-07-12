import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' show join;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class AI_Wound_analysis extends StatefulWidget {
  @override
  _AI_Wound_analysisState createState() => _AI_Wound_analysisState();
}

class _AI_Wound_analysisState extends State<AI_Wound_analysis> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _initializeCamera();
  }

  Future<void> _requestPermissions() async {
    await Permission.photos.request();
    await Permission.storage.request();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[_selectedCameraIndex], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  void _switchCamera() {
    setState(() {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      _initializeCamera();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI傷口分析"),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Container(
                width: 300,
                height: 500, // 相機與覽大小
                child: CameraPreview(_controller),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();

              // 獲取圖片
              final directory = await getApplicationDocumentsDirectory();
              final imagePath = join(directory.path, '${DateTime.now()}.png');
              final imageFile = File(image.path);

              // 圖片保存路徑
              await imageFile.copy(imagePath);

              // 把圖片放置相簿
              await GallerySaver.saveImage(imagePath);

              print('拍攝的照片路進: ${image.path}');
              print('已保存到相簿的路境: $imagePath');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('已保存到相簿')),
              );
            } catch (e) {
              print(e);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('出错')),
              );
            }
          },
          heroTag: 'btn1',
          child: Icon(Icons.camera_alt),
        ),
        FloatingActionButton(
          onPressed: _switchCamera,
          heroTag: 'btn2',
          child: Icon(Icons.album),
        ),
      ],
    );
  }
}
