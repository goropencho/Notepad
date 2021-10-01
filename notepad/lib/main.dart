import 'package:flutter/material.dart';
import 'package:notepad/add_notes.dart';
import 'package:notepad/database/database_handler.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/AddNotes": (context) => AddNotes(),
      },
      home: HomeScreen(),
    ));

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyListShows();
  }
}

class BodyListShows extends StatefulWidget {
  const BodyListShows({Key? key}) : super(key: key);

  @override._BodyListShowsState
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            titleSpacing: 0,
            elevation: 0.5,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            title: Text(
              "MyNotes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  wordSpacing: 0.2),
            ),
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
                              int id = noteData.data[index]['id'];
                              bool isEnabled = false;
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  elevation: 0.5,
                                  child: ListTile(
                                    trailing: IconButton(
                                        onPressed: () {
                                          isEnabled = true;
                                        },
                                        icon: isEnabled
                                            ? Icon(Icons.star)
                                            : Icon(Icons.star,
                                                color: Colors.yellow[900])),
                                    title: Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.blueGrey[900],
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.01),
                                    ),
                                    subtitle: Text(
                                      body,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black54),
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
            onPressed: () {
              Navigator.pushNamed((context), "/AddNotes");
            },
            child: Icon(
              Icons.add,
            )));
  }
}
