import 'package:flutter/material.dart';
import 'Register_page.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登入'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '用戶名',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '密碼',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 登入驗證邏輯
                if (_usernameController.text == 'user' && _passwordController.text == 'password') {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationController()));
                } else {
                  // 处理错误
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('用戶名或密碼錯誤')),
                  );
                }
              },
              child: Text('登入'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text('註冊帳號'),
            ),
          ],
        ),
      ),
    );
  }
}
