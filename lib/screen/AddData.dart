import 'package:firebaseproject/screen/ViewData.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController _controller = TextEditingController();

  void _addData() {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      FirebaseFirestore.instance.collection('data').add({'text': text});
      _controller.clear();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${text} added to database'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _navigateToListScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewDataScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _navigateToListScreen,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter text",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: _addData,
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
