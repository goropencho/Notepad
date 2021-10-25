class NoteModel {
  String title;
  String body;
  String creation_date;
  NoteModel({
    required this.title,
    required this.body,
    required this.creation_date,
  });

  isNotEmpty() {
    if (title.isEmpty && body.isEmpty && creation_date.isEmpty) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toMap() {
    return ({
      "title": title,
      "body": body,
      "creation_date": creation_date.toString()
    });
  }
}
