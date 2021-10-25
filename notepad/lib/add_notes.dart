import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:notepad/database/database_handler.dart';
import 'package:notepad/model/note_model.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  late String title;
  late String body;
  // ignore: non_constant_identifier_names
  late String creation_date;
  late bool starred;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addNote(NoteModel note) {
    DatabaseHandler.db.addNewNote(note);
    print("Note added Successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CupertinoNavigationBar(
            backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: CupertinoColors.inactiveGray,
                child: IconButton(
                  icon: Icon(
                    CupertinoIcons.backward,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.popAndPushNamed((context), "/");
                  },
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CupertinoTextField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: titleController,
                placeholder: "Title",
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              CupertinoTextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: 22.0),
                placeholder: "Body",
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).buttonColor,
          onPressed: () {
            setState(() {
              title = titleController.text;
              body = bodyController.text;
              creation_date = DateTime.now().toString();
            });
            NoteModel note = NoteModel(
              title: title,
              body: body,
              creation_date: creation_date,
            );
            addNote(note);
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          },
          label: Text("Save"),
          icon: Icon(CupertinoIcons.hand_thumbsup),
        ));
  }
}
