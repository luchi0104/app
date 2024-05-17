import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class AI_Wound_analysis extends StatefulWidget {
  @override
  _AI_Wound_analysisState createState() => _AI_Wound_analysisState();
}

class _AI_Wound_analysisState extends State<AI_Wound_analysis> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {});
    }
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
      body: _initializeControllerFuture == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Container(
                      width: 400,
                      height: 550, // 设置相机预览画面的大小
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
          onPressed: () => print('Turn on flashlight'),
          child: Icon(Icons.flash_on),
        ),
        FloatingActionButton(
          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final image = await _controller.takePicture();
              print('Picture taken: ${image.path}');
            } catch (e) {
              print(e);
            }
          },
          heroTag: 'btn1',
          child: Icon(Icons.camera_alt),
        ),
        FloatingActionButton(
          onPressed: () => print('Change Camera'),
          heroTag: 'btn2',
          child: Icon(Icons.flip_camera_android),
        ),
      ],
    );
  }
}
