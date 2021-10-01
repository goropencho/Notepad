class NoteModel {
  String title;
  String body;
  DateTime creation_date;

  NoteModel(
      {required this.title, required this.body, required this.creation_date});

  Map<String, dynamic> toMap() {
    return ({
      "title": title,
      "body": body,
      "creation_date": creation_date.toString()
    });
  }
}
