import 'package:flutter/material.dart';
import 'package:ui/components/NavigationBar.dart';
import 'package:ui/screens/AddEvents.dart';
import 'package:ui/screens/Profile.dart';
import 'package:ui/screens/ViewAttendees.dart';
import 'package:ui/screens/ViewEvents.dart';
import 'package:ui/screens/WelcomeScreen.dart';
import 'package:ui/screens/CreateAccount.dart';
import 'package:ui/screens/Home.dart';
import 'package:ui/screens/CreateCard1.dart';
import 'package:ui/screens/ViewSavedCards.dart';
import 'package:ui/screens/PreviewCard.dart';
import 'package:ui/screens/AddCard.dart';
import 'package:ui/screens/AddCardByEmail.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => NavigationBar());
      case '/createAccount':
        return MaterialPageRoute(builder: (_) => CreateAccount());
      default:
        // If there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> generateNavigationBarRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/createCard1':
        return MaterialPageRoute(
            builder: (context) => CreateCard1(
                  context: context,
                ));
      case '/savedCards':
        return MaterialPageRoute(builder: (_) => ViewSavedCards());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/previewCard':
        return MaterialPageRoute(
            builder: (_) => PreviewCard(settings.arguments));
      case '/addCard':
        return MaterialPageRoute(builder: (_) => AddCard());
      case '/viewEvents':
        return MaterialPageRoute(builder: (_) => ViewEvents());
      case '/addCardByEmail':
        return MaterialPageRoute(builder: (_) => AddCardByEmail());
      case '/AddEvents':
        return MaterialPageRoute(
            builder: (_) => AddEvents()); // argument might be wrong right now
      // case '/viewAttendees':
      // return MaterialPageRoute(builder: (_) => ViewAttendees());
      default:
        // If there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR NAVIGATING TO ROUTE'),
        ),
      );
    });
  }
}
