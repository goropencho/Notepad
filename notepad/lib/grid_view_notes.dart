import 'package:flutter/material.dart';

class GridViewNotes extends StatefulWidget {
  const GridViewNotes({Key? key}) : super(key: key);

  @override
  _GridViewNotesState createState() => _GridViewNotesState();
}

class _GridViewNotesState extends State<GridViewNotes> {
  List<String> notes = [
    "Today I do",
    "Do That",
    "Then THis",
    "Ofc THis",
    "THen tHat"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.596,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: notes.length,
            itemBuilder: (BuildContext context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0)),
                elevation: 6,
                child: Center(child: Text(notes[index])),
              );
            }));
  }
}
