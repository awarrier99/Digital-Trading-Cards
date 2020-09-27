import 'package:flutter/material.dart';
import 'package:ui/RouteGenerator.dart';
import 'package:ui/components/SearchBar.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 0;

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          title: Text("Saved Cards"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.plus_one),
          title: Text("Add Card"),
        ),
      ],
      onTap: _onTap,
      currentIndex: _currentIndex,
    );
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        _navigatorKey.currentState.pushReplacementNamed("/savedCards");
        break;
      case 1:
        _navigatorKey.currentState.pushReplacementNamed("/home");
        break;
      case 2:
        showSearch(context: context, delegate: StudentCardSearch(false));
        break;
    }
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
          key: _navigatorKey,
          initialRoute: '/home',
          onGenerateRoute: RouteGenerator.generateRoute),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
