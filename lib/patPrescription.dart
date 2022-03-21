// import 'dart:html';
//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mediator/editPrescriptionPat.dart';
import 'package:mediator/patProfilForm.dart';
import "package:flutter_tts/flutter_tts.dart";
import "package:mediator/main.dart";

//import 'package:flutter_application_1/main.dart';

class PatPrescription extends StatefulWidget {
  const PatPrescription({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PatPrescription();
}

class _PatPrescription extends State<PatPrescription> {
  /* late CameraController controller;
  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  } 

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  } 
*/
  final _padding = const EdgeInsets.all(8.0);

  final _meds = _medic;

  Image? _im;

  void _showImage(int idx) async {
    if (_meds[idx].image != null) {
      _im = _meds[idx].image;
    } else {
      _im = null;
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: _im,
        actions: <Widget>[
          TextButton(
            child: const Text('Πίσω'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _addNewEntryPrescr() async {
    final EntryPrescr? _newEntryPrescr = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditPrescription()),
    );

    if (_newEntryPrescr != null) {
      _meds.add(
        Medd(
          name: _newEntryPrescr.name,
          description: _newEntryPrescr.description,
        ),
      );
      //Redraw the widget
      setState(() {});
    }
  }

  final FlutterTts flutterTts = FlutterTts();

  Future _speak(String text) async {
    await flutterTts.speak(text);
  }

  Widget _buildListMedds() {
    return ListView.separated(
      padding: _padding,
      itemBuilder: (context, index) {
        return ListTile(
          /*Container(
  height: 200,
  width: double.infinity,
  decoration: const BoxDecoration(
    image: DecorationImage(
        image: _showImage(index),
        fit: BoxFit.cover),
  //),
//)*/
          /*  IconButton(
                icon: Icon(Icons.picture_in_picture),
                onPressed: () {
                  //     _showImage(index);
                },
                tooltip: toolTip,
              ), */

          title: Text(_meds[index].name),
          subtitle: Text(_meds[index].description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  _speak(_meds[index].name);
                },
                icon: Image.asset('assets/images/speaker.png'),
                tooltip: 'Ηχητική Ονομασία',
              ),
              IconButton(
                icon: Icon(Icons.photo_album),
                tooltip: 'Εμφάνιση Φωτογραφίας',
                onPressed: () {
                  _showImage(index);
                },
              ),
              IconButton(
                onPressed: () {
                  /* Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CameraPreview(controller))); */
                },
                icon: Icon(Icons.camera_enhance),
                tooltip: 'Φωτογράφιση',
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _meds.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Φάρμακα'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PatProfilForm()),
              );
            },
            icon: Icon(Icons.person),
            tooltip: 'Επεξεργασία Προφίλ',
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InitialScreenWidget()),
              );
            },
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Αποσύνδεση Χρήστη',
          ),
        ],
      ),

      body: _buildListMedds(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
        onPressed: () {
          _addNewEntryPrescr();
          /*Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ViewEditMeds()),
          );*/
        },
        tooltip: 'Προσθήκη',
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class Medd {
  Image? image;
  String name;
  String description;
  TimeOfDay? alarm;
  bool taken = false;

  Medd({this.image, required this.name, required this.description, this.alarm});
}

final _medic = <Medd>[
  Medd(
    image: Image.asset('assets/images/ponstan.png'),
    name: 'Ponstan',
    // alarm: TimeOfDay(hour: 15, minute: 0),
    description: '1 φορά την ημέρα για μία εβδομάδα',
  ),
  Medd(
    image: Image.asset('assets/images/augmentin.png'),
    name: 'Augmentin',
    description: 'Πρωί και βράδυ για 10 μέρες',
  ),
  Medd(
    image: Image.asset('assets/images/Arnica.png'),
    name: 'Arnica',
    description: '3 φορές την ημέρα, τοπικά, μετά από πάγο',
  ),
  Medd(
    image: Image.asset('assets/images/nurofen.png'),
    name: 'Nurofen',
    description: '1 κάθε βράδυ πριν τον ύπνο',
  ),
];
