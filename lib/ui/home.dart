import 'package:notesmaker/models/memo.dart';
import 'package:notesmaker/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'add_memo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper _dbHelper = DbHelper();
  int _count = 0;
  List<Note> _noteList;
  @override
  Widget build(BuildContext context) {
    if (_noteList == null) {
      _noteList = List<Note>();
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        elevation: 0,
        title: Text(
          'NotesMaker',
          style: TextStyle(
              color: Colors.purple[100], fontFamily: 'Satisfy', fontSize: 25),
        ),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[100],
        child: const Icon(
          Icons.add,
          color: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        onPressed: () async {
          var note = await navigateToEntryForm(context, null);
          if (note != null) addNote(note);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home_filled),
              color: Color.fromRGBO(64, 76, 94, 1.0),
              onPressed: () {},
            ), 
          ],
        ),
        color: Color.fromRGBO(64, 76, 94, 1.0),
      ),
    );
  }

  Future<Note> navigateToEntryForm(BuildContext context, Note note) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AddMemo(note);
        },
      ),
    );
    return result;
  }


  ListView createListView() {
    return ListView.builder(
      padding: EdgeInsets.only(left: 10, right: 10),
      itemCount: _count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 3,
          color: Color.fromRGBO(64, 75, 96, .9),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () async {
                  var note =
                      await navigateToEntryForm(context, this._noteList[index]);
                  if (note != null) editNote(note);
                },
              ),
            ),
            contentPadding: EdgeInsets.all(10),
            title: Text(this._noteList[index].title,
                style: TextStyle(
                  color: Colors.purple[100],
                  fontFamily: 'PatrickHand',
                  fontSize: 25,
                )),
            subtitle: Text(
              this._noteList[index].note,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11, color: Colors.white60),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete_outline_sharp,
                color: Colors.purple[100],
                size: 20,
              ),
              onTap: () {
                deleteNote(_noteList[index]);
              },
            ),
             onTap: () async {
              var note =
                  await navigateToEntryForm(context, this._noteList[index]);
              if (note != null) editNote(note);
            },
          ),
        );
      },
    );
  }

  void addNote(Note object) async {
    int result = await _dbHelper.insert(object);
    if (result > 0) {
      updateListView();
    }
  }

  void editNote(Note object) async {
    int result = await _dbHelper.update(object);
    if (result > 0) {
      updateListView();
    }
  }

  void deleteNote(Note object) async {
    int result = await _dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = _dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = _dbHelper.getNotesList();
      noteListFuture.then((noteList) {
        setState(() {
          this._noteList = noteList;
          this._count = noteList.length;
        });
      });
    });
  }
}