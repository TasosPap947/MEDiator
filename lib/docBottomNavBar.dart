import 'package:flutter/material.dart';
import 'package:mediator/docPatProfil.dart';
import 'package:mediator/keepAlivePage.dart';
import 'package:mediator/schedule.dart';
import 'package:mediator/listOfMeds.dart';
import 'package:mediator/patientsWidget.dart';

class DocBottomNavBar extends StatefulWidget {
  const DocBottomNavBar({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _DocBottomNavBar();
}

class _DocBottomNavBar extends State<StatefulWidget> {
  /*void setIdx(int x) {
    this.j = x;
  }

*/

  int _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.person, color: Colors.white70),
      label: 'Προφίλ Ασθενή',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.medical_services, color: Colors.white70),
      label: 'Συνταγογράφηση',
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
          KeepAlivePage(child: ShowPatient()),
          KeepAlivePage(child: DocPrescription()),
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
