import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int index = 0;
  int selectedIndex = 0;
  final List<String> elements = ["Notes", "To Do", "Blogs"];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: elements.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: Text(elements[index],
                      style: TextStyle(
                          color: index == selectedIndex
                              ? Colors.black87
                              : Colors.black26,
                          fontSize: 35,
                          letterSpacing: 0.5,
                          wordSpacing: 0)),
                ),
              );
            }));
  }
}
