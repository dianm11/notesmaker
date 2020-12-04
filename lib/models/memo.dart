class Note {
  int _id;
  String _title;
  String _note;

  Note(this._title, this._note);

  Note.forMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._note = map['note'];
  }

  int get id => _id;
  String get title => _title;
  String get note => _note;
  
  set title(String value) {
    _title = value;
  }

  set note(String value) {
    _note = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['title'] = title;
    map['note'] = note;
    return map;
  }
}
