import 'package:flutter/material.dart';

class Historical_data extends StatefulWidget {
  @override
  _HistoricalDataState createState() => _HistoricalDataState();
}

class _HistoricalDataState extends State<Historical_data> {
  List<Map<String, String>> data = [
    {"date": "2024-05-19", "title": "褥瘡1", "note": "注意事項1"},
    {"date": "2024-05-20", "title": "褥瘡2", "note": "注意事項2"}
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _newTitleController = TextEditingController();
  final TextEditingController _newNoteController = TextEditingController();

  void _addNewData() {
    setState(() {
      data.add({
        "date": DateTime.now().toString().split(' ')[0],
        "title": _newTitleController.text,
        "note": _newNoteController.text
      });
    });
    _newTitleController.clear();
    _newNoteController.clear();
  }

  void _editTitle(int index) {
    showDialog(
      context: context,
      builder: (context) {
        _titleController.text = data[index]["title"]!;
        _noteController.text = data[index]["note"]!;
        return AlertDialog(
          title: Text('編輯標題與備註'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: '標題'),
              ),
              TextField(
                controller: _noteController,
                decoration: InputDecoration(labelText: '備註'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  data[index]["title"] = _titleController.text;
                  data[index]["note"] = _noteController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('確定'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("歷史資料分析"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]["title"]!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data[index]["note"]!),
                      Text(data[index]["date"]!),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editTitle(index),
                  ),
                );
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     children: [
          //       TextField(
          //         controller: _newTitleController,
          //         decoration: InputDecoration(labelText: '新增標題'),
          //       ),
          //       TextField(
          //         controller: _newNoteController,
          //         decoration: InputDecoration(labelText: '新增備註'),
          //       ),
          //       SizedBox(height: 10),
          //       ElevatedButton(
          //         onPressed: _addNewData,
          //         child: Text('新增資料'),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Historical_data(),
  ));
}