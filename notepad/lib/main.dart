import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/add_notes.dart';
import 'package:notepad/database/database_handler.dart';
import 'package:notepad/model/note_model.dart';
import 'package:notepad/show_notes.dart';

themeDecision(x) {
  if (x == 0) {
    return CupertinoThemeData(
      barBackgroundColor: CupertinoColors.black,
      primaryColor: CupertinoColors.white,
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.white,
      ),
      scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
    );
  } else if (x == 1) {
    return CupertinoThemeData(
        barBackgroundColor: CupertinoColors.white,
        primaryColor: CupertinoColors.black,
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          primaryColor: CupertinoColors.black,
        ),
        scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray);
  }
}

int x = 0;
void main() {
  runApp(CupertinoApp(
    theme: x == 0 ? themeDecision(0) : themeDecision(1),
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/AddNotes": (context) => AddNotes(),
      "/ShowNotes": (context) => ShowNotes(),
    },
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyListShows();
  }
}

class BodyListShows extends StatefulWidget {
  const BodyListShows({Key? key}) : super(key: key);

  createState() => _BodyListShowsState();
}

class _BodyListShowsState extends State<BodyListShows> {
  getNotes() async {
    final notes = await DatabaseHandler.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            onPressed: () {
              if (x == 0) {}
            },
            child: Icon(CupertinoIcons.lightbulb),
          ),
          backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
          middle: Text(
            "Notes",
            style: TextStyle(
                color: CupertinoTheme.of(context).primaryColor,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                wordSpacing: 0.2),
          ),
        ),
        body: FutureBuilder(
            future: getNotes(),
            builder: (context, AsyncSnapshot noteData) {
              switch (noteData.connectionState) {
                case ConnectionState.none:
                  return Text("Nothing");
                  break;
                case ConnectionState.waiting:
                  // TODO: Handle this case.
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  break;
                case ConnectionState.active:
                  // TODO: Handle this case.
                  return Text("Hello");
                  break;
                case ConnectionState.done:
                  {
                    if (noteData.data == Null) {
                      return Center(child: Text("Add Notes Here"));
                    } else {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: noteData.data!.length,
                            itemBuilder: (context, index) {
                              String title = noteData.data[index]['title'];
                              String body = noteData.data[index]['body'];
                              String creationDate =
                                  noteData.data[index]['creation_date'];
                              int id = noteData.data[index]['id'];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/ShowNotes",
                                      arguments: NoteModel(
                                          title: title,
                                          body: body,
                                          creation_date:
                                              creationDate.toString()));
                                },
                                child: Card(
                                  elevation: 1,
                                  child: ListTile(
                                    title: Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: CupertinoTheme.of(context)
                                              .primaryColor,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.01),
                                    ),
                                    subtitle: Text(
                                      body,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: CupertinoTheme.of(context)
                                              .primaryColor),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  }
              }
            }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: CupertinoColors.inactiveGray,
            onPressed: () {
              Navigator.pushNamed(context, "/AddNotes");
            },
            child: Icon(CupertinoIcons.add, color: CupertinoColors.black)));
  }
}
