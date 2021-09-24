import 'package:flutter/material.dart';
import 'package:notepad/categorySelector.dart';
import 'package:notepad/grid_view_notes.dart';
import 'theme.dart';

void main() {
  runApp(MaterialApp(
    theme: myTheme,
    home: Homepage(),
  ));
}

class Homepage extends StatelessWidget {
  List<String> elements = ["Notes", "To Do", "Blogs"];
  Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttoncolor = Colors.black87;
    return Scaffold(
        backgroundColor: Colors.deepOrange[900],
        appBar: AppBar(
          backgroundColor: Colors.deepOrange[900],
          elevation: 0,
          leading: Builder(
              builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(
                    Icons.bookmark,
                    color: buttoncolor,
                  ))),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/kick.jpg'),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: buttoncolor,
                )),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "My Notes",
                    style: TextStyle(
                        fontSize: 45,
                        color: buttoncolor,
                        wordSpacing: 6.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                width: 340,
                height: MediaQuery.of(context).size.height * 0.0890,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: buttoncolor,
                    ),
                  ),
                ),
              ),
            ),
            CategorySelector(),
            GridViewNotes()
          ],
        ));
  }
}
