import 'package:flutter/material.dart';

//import './Basic_Info_Form.dart';
import '../components/Cards/SummaryCard.dart';

class ViewSavedCards extends StatelessWidget {
  final _createAccountFormKey = GlobalKey<FormState>();
  var savedCardsList = [
    {
      'fullname': 'Matt Oliver',
      'school': 'Georgia Institute of Technology',
      'degreeType': 'B.S.',
      'major': 'Computer Science',
      'skills': ['C#', 'Front End', 'iOS Development', 'XCode'],
      'interests': ['Golf', 'Computers', 'Tennis'],
      'isFavorite': true
    },
    {
      'fullname': 'Diana Rodrigues',
      'school': 'Georgia Institute of Technology',
      'degreeType': 'M.S.',
      'major': 'Civil Engineering',
      'skills': ['AutoCAD', 'MatLab'],
      'interests': ['Equestrian', 'Spanish', 'Traveling', 'Diving'],
      'isFavorite': true
    },
    {
      'fullname': 'Chad White',
      'school': 'University of Georgia',
      'degreeType': 'B.S.',
      'major': 'Business Administration',
      'skills': ['Accounting', 'Excel', 'Data Analysis'],
      'interests': ['Lacrosse', 'Dogs', 'Football'],
      'isFavorite': false
    },
    {
      'fullname': 'Matt Oliver2',
      'school': 'Georgia Tech2',
      'degreeType': 'bachelors2',
      'major': 'CS2',
      'skills': ['golf2', 'computers2', 'tennis2', 'wonderwhat'],
      'interests': ['yes', 'matt', 'hocky'],
      'isFavorite': false
    },
    {
      'fullname': 'Matt Oliver2',
      'school': 'Georgia Tech2',
      'degreeType': 'bachelors2',
      'major': 'CS2',
      'skills': ['golf2', 'computers2', 'tennis2', 'wonderwhat'],
      'interests': ['yes', 'matt', 'hocky'],
      'isFavorite': false
    },
    {
      'fullname': 'Matt Oliver2',
      'school': 'Georgia Tech2',
      'degreeType': 'bachelors2',
      'major': 'CS2',
      'skills': ['golf2', 'computers2', 'tennis2', 'wonderwhat'],
      'interests': ['yes', 'matt', 'hocky'],
      'isFavorite': false
    },
    {
      'fullname': 'Matt Oliver2',
      'school': 'Georgia Tech2',
      'degreeType': 'bachelors2',
      'major': 'CS2',
      'skills': ['golf2', 'computers2', 'tennis2', 'wonderwhat'],
      'interests': ['yes', 'matt', 'hocky'],
      'isFavorite': false
    },
    {
      'fullname': 'Matt Oliver2',
      'school': 'Georgia Tech2',
      'degreeType': 'bachelors2',
      'major': 'CS2',
      'skills': ['golf2', 'computers2', 'tennis2', 'wonderwhat'],
      'interests': ['yes', 'matt', 'hocky'],
      'isFavorite': false
    },
    {
      'fullname': 'Matt Oliver2',
      'school': 'Georgia Tech2',
      'degreeType': 'bachelors2',
      'major': 'CS2',
      'skills': ['golf2', 'computers2', 'tennis2', 'wonderwhat'],
      'interests': ['yes', 'matt', 'hocky'],
      'isFavorite': false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Cards',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: savedCardsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: new SummaryCard(
                savedCardsList[index]['fullname'],
                savedCardsList[index]['school'],
                savedCardsList[index]['degreeType'],
                savedCardsList[index]['major'],
                savedCardsList[index]['skills'],
                savedCardsList[index]['interests'],
                savedCardsList[index]['isFavorite']),
          );
        },
        padding: EdgeInsets.only(top: 10, bottom: 10),
      ),
    );
  }
}
