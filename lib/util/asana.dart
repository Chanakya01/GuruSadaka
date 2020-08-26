class AsanaModel {
  static String _name;
  static String _doc;
  static int _time;
  static String _picurl;

  // User(this.email, this.uid, this.displayName, this.photoUrl);

  void setAsana(Map<String, dynamic> map) {
    _name = map['Name'];
    _doc = map['DocUrl'];
    _time = map['Time'];
    _picurl = map['PicUrl'];
  }

  String get doc => _doc;

  String get name => _name;

  int get time => _time;

  String get picurl => _picurl;

  Map<String, dynamic> get getAsana {
    return {
      'name': _name,
      'time': _time,
      'doc': _doc,
      'picurl': _picurl,
    };
  }
}
