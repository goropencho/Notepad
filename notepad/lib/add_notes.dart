import 'package:flutter/material.dart';
import 'package:notepad/database/database_handler.dart';
import 'package:notepad/model/note_model.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  late String title;
  late String body;
  late DateTime creation_date;
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
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
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: 20.0),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write here..........."),
              )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              title = titleController.text;
              body = bodyController.text;
              creation_date = DateTime.now();
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
          icon: Icon(Icons.save),
        ));
  }
}
