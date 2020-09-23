import 'package:flutter/material.dart';

import './Basic_Info_Form.dart';
import '../components/Cards/SummaryCard.dart';


class ViewSavedCards extends StatelessWidget {
  final _createAccountFormKey = GlobalKey<FormState>();
  var savedCardsList = [{'fullname':'Matt Oliver', 'school':'Georgia Tech', 'degreeType':'bachelors', 'major':'CS', 'skills':['golf','computers','tennis'], 'interests':['golf2','computers2','2tennis'], 'isFavorite':false},{'fullname':'Matt Oliver2', 'school':'Georgia Tech2', 'degreeType':'bachelors2', 'major':'CS2', 'skills':['golf2','computers2','tennis2','wonderwhat'], 'interests':['yes','matt','hocky'], 'isFavorite':false},{'fullname':'Matt Oliver2', 'school':'Georgia Tech2', 'degreeType':'bachelors2', 'major':'CS2', 'skills':['golf2','computers2','tennis2','wonderwhat'], 'interests':['yes','matt','hocky'], 'isFavorite':false},{'fullname':'Matt Oliver2', 'school':'Georgia Tech2', 'degreeType':'bachelors2', 'major':'CS2', 'skills':['golf2','computers2','tennis2','wonderwhat'], 'interests':['yes','matt','hocky'], 'isFavorite':false},{'fullname':'Matt Oliver2', 'school':'Georgia Tech2', 'degreeType':'bachelors2', 'major':'CS2', 'skills':['golf2','computers2','tennis2','wonderwhat'], 'interests':['yes','matt','hocky'], 'isFavorite':false},{'fullname':'Matt Oliver2', 'school':'Georgia Tech2', 'degreeType':'bachelors2', 'major':'CS2', 'skills':['golf2','computers2','tennis2','wonderwhat'], 'interests':['yes','matt','hocky'], 'isFavorite':false},{'fullname':'Matt Oliver2', 'school':'Georgia Tech2', 'degreeType':'bachelors2', 'major':'CS2', 'skills':['golf2','computers2','tennis2','wonderwhat'], 'interests':['yes','matt','hocky'], 'isFavorite':false},{'fullname':'Matt Oliver2', 'school':'Georgia Tech2', 'degreeType':'bachelors2', 'major':'CS2', 'skills':['golf2','computers2','tennis2','wonderwhat'], 'interests':['yes','matt','hocky'], 'isFavorite':false},{'fullname':'Matt Oliver2', 'school':'Georgia Tech2', 'degreeType':'bachelors2', 'major':'CS2', 'skills':['golf2','computers2','tennis2','wonderwhat'], 'interests':['yes','matt','hocky'], 'isFavorite':false}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: savedCardsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: new SummaryCard(savedCardsList[index]['fullname'], savedCardsList[index]['school'], savedCardsList[index]['degreeType'], savedCardsList[index]['major'], savedCardsList[index]['skills'], savedCardsList[index]['interests'], savedCardsList[index]['isFavorite']),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
