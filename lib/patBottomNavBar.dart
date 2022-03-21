import 'package:flutter/material.dart';
import 'package:mediator/docProfilForm.dart';
import 'package:mediator/listOfMeds.dart';
import 'package:mediator/patDoctor.dart';
import 'package:mediator/patPrescription.dart';
import 'package:mediator/schedule.dart';
import 'package:mediator/keepAlivePage.dart';

class PatBottomNavBar extends StatefulWidget {
  const PatBottomNavBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PatBottomNavBar();
}

class _PatBottomNavBar extends State<StatefulWidget> {
  int _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.medical_services, color: Colors.white70),
      label: 'Συνταγές',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.schedule, color: Colors.white70),
      label: 'Πρόγραμμα',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.contacts, color: Colors.white70),
      label: 'Γιατρός',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: [
          KeepAlivePage(child: PatPrescription()),
          KeepAlivePage(child: ListOfMeds()),
          KeepAlivePage(child: PatDoctor()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.cyan,
        currentIndex: _currentIndex,
        items: _bottomNavigationBarItems,
        onTap: (index) {
          setState(() {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        },
      ),
    );
  }
}
