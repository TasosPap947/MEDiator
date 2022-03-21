import "package:flutter/material.dart";
import 'package:mediator/patBottomNavBar.dart';
import 'package:mediator/patLoginScreen.dart';
import 'package:mediator/patProfilForm.dart';
import 'package:mediator/patientsWidget.dart';
import 'package:mediator/docLoginScreen.dart';
import 'package:camera/camera.dart';

//late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //cameras = await availableCameras();
  runApp(Mediator());
}

class Mediator extends StatelessWidget {
  const Mediator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MEDiator",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: InitialScreenWidget(),
    );
  }
}

class InitialScreenWidget extends StatelessWidget {
  InitialScreenWidget({Key? key}) : super(key: key);

  final TextStyle _buttonTextStyle = TextStyle(
    fontSize: 35,
  );
  final TextStyle _titleTextStyle = TextStyle(
    fontSize: 50,
  );
  final ButtonStyle _elevatedButtonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(300, 80), primary: Colors.cyan);

  final EdgeInsets _padding = EdgeInsets.all(16.0);
  final EdgeInsets _bigPadding = EdgeInsets.all(40.0);
  final EdgeInsets _titlePadding = EdgeInsets.all(20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          children: [
            Padding(
                child: Text("MEDiator", style: _titleTextStyle),
                padding: _titlePadding),
            Padding(
              child: Text(
                "Η πορεία των θεραπειών σου σε ένα μέρος.",
              ),
              padding: _bigPadding,
            ),
            Padding(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DocLoginWidget()),
                  );
                },
                child: Text("Γιατρός", style: _buttonTextStyle),
                style: _elevatedButtonStyle,
              ),
              padding: _padding,
            ),
            Padding(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PatLoginWidget()),
                  );
                },
                child: Text("Ασθενής", style: _buttonTextStyle),
                style: _elevatedButtonStyle,
              ),
              padding: _padding,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
