import 'package:flutter/material.dart';
import 'package:ui/SizeConfig.dart';
import 'package:ui/palette.dart';

class SearchBar extends StatelessWidget {
  final bool showList;

  // this.showlist could be toggled in the contructor to be false or true.
  // false will make it so that the list of items/tiles aren't displayed
  // true will make it so that the list of items/tiles are displayed with the search bar
  SearchBar(this.showList);

  //Button opens up search bar, will be used for the view Saved Cards, and add card buttons
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RaisedButton(
      child: Text('Add Card'),
      textColor: Colors.white,
      color: Palette.primaryGreen,
      onPressed: () {
        showSearch(context: context, delegate: StudentCardSearch(showList));
      },
    );
  }
}

// SearchDelegate takes in a model of the data
class StudentCardSearch extends SearchDelegate<StudentCardItem> {
  final bool listIsShown; // this is a new change
  StudentCardSearch(this.listIsShown); // contructor

  // Edit the String at the end to change the 'hint text' for the SearchBar
  @override
  String get searchFieldLabel => 'Enter an Email Address';

  // changes the theme of the Search App Bar
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Palette.primaryGreen,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.black),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  // This is the clear button, to clear the query/text
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  // this is the back arrow to get out of Search bar
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // this is what is displayed after the user taps on a name
  // should take them to the card received screen for the selected person
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: TextStyle(fontFamily: 'Montserrat'),
      ),
    );
  }

  // This method displays the list of cards available, and the results of the
  // search
  @override
  Widget buildSuggestions(BuildContext context) {
    // listIsShown = boolean value used to check if you want to see list of
    // items present if the List used.

    //This is where the list is populated and checked before the tiles are created
    List studentList;
    if (listIsShown == true) {
      studentList = query.isEmpty
          ? loadSudentCardItem()
          : loadSudentCardItem()
              .where((p) => p.emailAddress.toLowerCase().contains(query))
              .toList();
    } else if (listIsShown == false) {
      studentList = query.isEmpty
          ? <StudentCardItem>[]
          : loadSudentCardItem()
              .where((p) => p.emailAddress.toLowerCase().contains(query))
              .toList();
    }

    return studentList.isEmpty
        ? Center(
            child: Text(
            'No Results Found',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.safeBlockHorizontal * 4),
          ))
        : ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final StudentCardItem listCard = studentList[index];

              // the 2 text widgets are what is being displayed in the tile in the
              // list
              return ListTile(
                onTap: () {
                  showResults(context);
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      listCard.name + ' - ' + listCard.emailAddress,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.safeBlockHorizontal * 4),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 1.1),
                    Text(
                      listCard.degreeType,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: SizeConfig.safeBlockHorizontal * 3),
                    ),
                    Divider(),
                  ],
                ),
              );
            });
  }
}

// Item/class to hold basic student info for the search.
class StudentCardItem {
  final String name;
  final String degreeType;
  final String emailAddress;

  //Constructor for StudentCardItem
  StudentCardItem(this.name, this.degreeType, this.emailAddress);
}

//Fake Data to test for now
List<StudentCardItem> loadSudentCardItem() {
  var sI = <StudentCardItem>[
    StudentCardItem("Matt Olliver", "Undergraduate", "mOlliver@gatech.edu"),
    StudentCardItem("Noah Le", "Undergraduate", "noah3@gatech.edu"),
    StudentCardItem("Ashvin Warrier", "Undergraduate", "aWarrier@gatech.edu"),
    StudentCardItem(
        "Pratik Nallamotu", "Undergraduate", "pNallamotu@gatech.edu"),
    StudentCardItem("Patrick Ufer", "Undergraduate", "pUfer@gatech.edu"),
    StudentCardItem("Mariana Matias", "Undergraduate", "mMatias@gatech.edu")
  ];
  return sI;
}
