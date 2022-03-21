// import 'dart:html';
//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mediator/ViewEditMeds.dart';
//import 'package:flutter_application_1/main.dart';

class ListOfMeds extends StatefulWidget {
  const ListOfMeds({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListOfMeds();
}

class _ListOfMeds extends State<ListOfMeds> {
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

  void _deleteMed(int idx) async {
    bool? _delMed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Θέλετε σίγουρα να διαγράψετε αυτό το φάρμακο;'),
        actions: <Widget>[
          TextButton(
            child: const Text('Ακύρωση'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text('Ναι'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (_delMed!) {
      _meds.removeAt(idx);
      setState(() {});
    }
  }

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

  void _addNewEntry() async {
    final Entry? _newEntry = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ViewEditMeds()),
    );

    if (_newEntry != null) {
      _meds.add(
        Med(
          name: _newEntry.name,
          description: _newEntry.description,
          alarm: _newEntry.alarm,
        ),
      );
      //Redraw the widget
      setState(() {});
    }
  }

  Widget _buildListMeds() {
    return ListView.separated(
      padding: _padding,
      itemBuilder: (context, index) {
        IconData iconData;
        String toolTip;
        if (_meds[index].taken) {
          iconData = Icons.check_box_outlined;
          toolTip = 'Η υπενθύμιση απενεργοποιήθηκε';
        } else {
          iconData = Icons.check_box_outline_blank_outlined;
          toolTip = 'Απενεργοποίηση Υπενθύμισης';
        }

        return ListTile(
          leading: IconButton(
            icon: Icon(iconData),
            onPressed: () {
              _meds[index].taken = !_meds[index].taken;
              setState(() {});
            },
            tooltip: toolTip,
          ),
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                child: Text(_meds[index].alarm != null
                    ? _meds[index].alarm!.format(context)
                    : ''),
                visible: _meds[index].alarm != null ? true : false,
              ),
              IconButton(
                onPressed: () {
                  _deleteMed(index);
                },
                icon: Icon(Icons.delete),
                tooltip: 'Διαγραφή Φαρμάκου',
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
        title: const Text('Προγραμματισμός Φαρμάκων Ημέρας'),
        automaticallyImplyLeading: false,
      ),

      body: _buildListMeds(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
        onPressed: () {
          _addNewEntry();
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

class Med {
  Image? image;
  String name;
  String? description;
  TimeOfDay? alarm;
  bool taken = false;

  Med({this.image, required this.name, this.description, this.alarm});
}

final _medic = <Med>[
  Med(
    image: Image.asset('assets/images/ponstan.png'),
    name: 'Ponstan',
    alarm: TimeOfDay(hour: 15, minute: 0),
  ),
  Med(
    image: Image.asset('assets/images/augmentin.png'),
    name: 'Augmentin',
    alarm: TimeOfDay(hour: 20, minute: 45),
  ),
  Med(
    image: Image.asset('assets/images/Arnica.png'),
    name: 'Arnica',
    alarm: TimeOfDay(hour: 17, minute: 32),
  ),
  Med(
    image: Image.asset('assets/images/nurofen.png'),
    name: 'Nurofen',
    alarm: TimeOfDay(hour: 22, minute: 50),
  ),
];
