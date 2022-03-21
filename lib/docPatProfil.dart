// import 'dart:html';
//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mediator/patientsWidget.dart';
import 'package:mediator/addPats.dart';

//import 'package:flutter_application_1/main.dart';

class DocPatProfil extends StatefulWidget {
  const DocPatProfil({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DocPatProfil();
}

class _DocPatProfil extends State<DocPatProfil> {
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

  final _pats = _patientInitList;

  Image? _im;

  Widget _buildListMeds() {
    return ListView.separated(
      padding: _padding,
      itemBuilder: (context, i) {
        return ListTile(
          leading: IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {},
            tooltip: 'test',
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

          // title: Text(patient[i]),
          /* trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                child: Text(_pats[i].amka),
                visible: true,
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
          ),*/
        );
      },
      separatorBuilder: (context, i) => const Divider(),
      itemCount: _pats.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
      ),

      body: _buildListMeds(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
        onPressed: () {
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

final _patientInitList = <Patients>[
  Patients(
      amka: '1111111111111',
      fName: 'Tasos',
      lName: 'Pap',
      phone: '6968000000',
      image: AssetImage('assets/images/cat.jpg'),
      value: 0.6),
  Patients(
      image: AssetImage('assets/images/cat.jpg'),
      amka: '1111111111111',
      fName: 'Tasos',
      lName: 'Papazafeiropoulos',
      phone: '6968000000',
      value: 0.2),
];
