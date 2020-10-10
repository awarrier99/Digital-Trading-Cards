import 'package:flutter/material.dart';
import 'package:ui/components/NavigationBar.dart';
import 'package:ui/screens/WelcomeScreen.dart';
import 'package:ui/screens/CreateAccount.dart';
import 'package:ui/screens/Home.dart';
import 'package:ui/screens/CreateCard1.dart';
import 'package:ui/screens/ViewSavedCards.dart';
import 'package:ui/screens/PreviewCard.dart';
import 'package:ui/screens/AddCard.dart';
import 'package:ui/screens/AddCard2.dart';

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
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/createCard1':
        return MaterialPageRoute(
            builder: (context) => CreateCard1(
                  context: context,
                ));
      case '/savedCards':
        return MaterialPageRoute(builder: (_) => ViewSavedCards());
      case '/previewCard':
        return MaterialPageRoute(builder: (_) => PreviewCard(args));
      case '/addCard':
        return MaterialPageRoute(builder: (_) => AddCard());
      case '/addCard2':
        return MaterialPageRoute(builder: (_) => AddCard2());
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
