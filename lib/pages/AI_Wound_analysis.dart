import 'package:flutter/material.dart';

class AI_Wound_analysis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI傷口分析"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text("相機預覽區域", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
        ),
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
          onPressed: () => print('Take Picture'),
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
