import 'package:notesmaker/models/memo.dart';
import 'package:flutter/material.dart';

class AddMemo extends StatefulWidget {
  final Note note;
  AddMemo(this.note);
  @override
  _AddMemoState createState() => _AddMemoState(this.note);
}

class _AddMemoState extends State<AddMemo> {
  Note _note;
  _AddMemoState(this._note);
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (_note != null) {
      _titleController.text = _note.title;
      _noteController.text = _note.note;
    }
    return Scaffold(
      appBar: AppBar(
        title: _note == null
            ? Text('Add New Note',
                style: TextStyle(
                    color: Colors.purple[100],
                    fontFamily: 'YanoneKaffeesatz',
                    fontSize: 25,
                    fontWeight: FontWeight.bold))
            : Text('Edit Note',
                style: TextStyle(
                    color: Colors.purple[100],
                    fontFamily: 'YanoneKaffeesatz',
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.purple[100],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Simpan',
            icon: Icon(Icons.save),
            onPressed: () {
              if (_note == null) {
                _note = Note(_titleController.text, _noteController.text);
              } else {
                _note.title = _titleController.text;
                _note.note = _noteController.text;
              }
              Navigator.pop(context, _note);
            },
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 40, right: 40),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: TextField(
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                  controller: _titleController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: TextField(
                  controller: _noteController,
                  // keyboardType: TextInputType.multiline,
                  // maxLines: null,
                  // minLines: 15,
                  // decoration: InputDecoration(
                  //   labelText: 'YOUR NOTE HERE',
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  // ),
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                  maxLines: 28,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Type your note..",
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.white38),
                    border: OutlineInputBorder(
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    );
  }

  void deleteNote(noteList) {}
}
