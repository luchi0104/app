import 'package:flutter/material.dart';

class personal_information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('個人資料'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('User'),
            accountEmail: Text('123-456-7890'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.healing),
            title: Text('傷口歷史紀錄'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.analytics),
            title: Text('進行中的分析'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('通知設置'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text('聯絡支援'),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SupportPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('支援服務'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text('歡迎來到支援服務頁面！', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
