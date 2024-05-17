import 'package:flutter/material.dart';
import 'pages/AI_Wound_analysis.dart';
import 'pages/Historical_data_analysis.dart';
import 'pages/personal_information.dart';
import 'pages/Login_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // 設置登入頁面為首頁
    );
  }
}


class BottomNavigationController extends StatefulWidget {
  BottomNavigationController({Key? key}) : super(key: key);

  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  int _currentIndex = 0;
  final pages = [Historical_data(), AI_Wound_analysis(),personal_information()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('褥瘡分析系統'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.history), label: '歷史資料分析'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'AI 傷口分析'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '個人資料',),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed, // 固定底部導航欄項目
        showSelectedLabels: true, // 顯示被選中時的標籤
        showUnselectedLabels: true, // 顯示未被選中時的標籤
        unselectedLabelStyle: TextStyle(color: Colors.black),
        onTap: _onItemClick,
      ),
    );
  }

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


