import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:ui/SizeConfig.dart';

/* For anyone in this current file. I have the other search working, but I need
the view card widget from the home screen. So I could reuse it in my code for
search and add by email function. I have the search working on another branch.
I decided to try a different way that gives us more styling options, and it might
be a little easier to read.

This is just a test so far, will be further figuring out how to use this version
of search bar that someone has made.
*/
class SearchBarComponent extends StatelessWidget {
  // Returns a list of items you want. In our case the students with the
  // relevant name or relevant email. Working it out.

  // currently it's using hardcoded data for testing puporses.
  Future<List<BasicStudentItem>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return BasicStudentItem(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SearchBar<BasicStudentItem>(
            hintText: "Enter an email address",
            hintStyle: TextStyle(
              color: Colors.grey[100],
            ),
            textStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            onSearch: search,
            searchBarStyle: SearchBarStyle(
              padding: EdgeInsets.all(2),
              borderRadius: BorderRadius.circular(10),
            ),
            onItemFound: (BasicStudentItem card, int index) {
              return ListTile(
                title: Text(
                  card.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: SizeConfig.safeBlockHorizontal * 4),
                ),
                subtitle: Text(card.description,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: SizeConfig.safeBlockHorizontal * 4)),
              );
            }),
      )),
    );
  }
}

// Hardcoded Data for testing purposes
class BasicStudentItem {
  final String title;
  final String description;

  BasicStudentItem(this.title, this.description); // Constructor
}
