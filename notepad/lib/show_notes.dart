import 'package:flutter/material.dart';
import 'package:notepad/database/database_handler.dart';
import 'package:notepad/model/note_model.dart';
import 'package:flutter/cupertino.dart';

class ShowNotes extends StatefulWidget {
  ShowNotes({Key? key}) : super(key: key);

  @override
  _ShowNotesState createState() => _ShowNotesState();
}

class _ShowNotesState extends State<ShowNotes> {
  late String title;
  late String body;
  // ignore: non_constant_identifier_names
  late String creation_date;
  late bool starred;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  deleteNode(String title) {
    DatabaseHandler.db.deleteNote(title);
    print("Successfully Deleted");
  }

  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)!.settings.arguments as NoteModel;
    if (note.isNotEmpty()) {
      titleController.text = note.title;
      bodyController.text = note.body;
    }
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CupertinoNavigationBar(
            previousPageTitle: "Notes",
            leading: Padding(
              padding: const EdgeInsets.only(right: 64),
              child: IconButton(
                iconSize: 30,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CupertinoTextField(
                textCapitalization: TextCapitalization.sentences,
                readOnly: true,
                controller: titleController,
                placeholder: note.title,
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: CupertinoTextField(
                readOnly: true,
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: 20.0),
                placeholder: note.body,
              )),
            ],
          ),
        ));
  }
}
