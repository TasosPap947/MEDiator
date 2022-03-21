//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mediator/docBottomNavBar.dart';
import 'package:mediator/patientsWidget.dart';
// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const appTitle = 'Φτιάξε το προφίλ σου';
//     return MaterialApp(
//       title: appTitle,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(appTitle),
//         ),
//         body: PatProfilForm(),
//       ),
//     );
//   }
// }

class PatDoctor extends StatefulWidget {
  const PatDoctor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PatDoctor();
}

class _PatDoctor extends State<PatDoctor> {
  final _fNameController = TextEditingController();
  /* late CameraController controller;
  @override
  void initState() {
    super.initState();

  } */

/*  Widget _doctorInf() {
    return ListView.separated(
      padding: _padding,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_doctor[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _doctor.length,
    );
  }
*/

  Widget _firstListView() {
    return Container(
      //color: Colors.green,
      child: ListView.separated(
        itemCount: _doctor.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => ListTile(
          leading: Text(_fields[index]),
          title: Text(_doctor[index]),
        ),
      ),
    );
  }

  final EdgeInsets _padding = EdgeInsets.all(10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Πληροφορίες για τον γιατρό'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: _padding,
            child: CircleAvatar(
              radius: 70, //radius is 5
              backgroundImage: AssetImage('assets/images/cat.jpg'), //image url
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: const Text(
              'Πρόοδος Θεραπείας:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: _padding,
            child: LinearProgressIndicator(
              value: 0.8,
              minHeight: 12,
              color: Colors.green,
              backgroundColor: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: _firstListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.call),
        onPressed: () {},
        tooltip: 'Κλήση',
      ),
    );
  }
}

final _doctor = <String>[
  'Ιπποκράτης',
  'Γρίπουλας',
  '20078501867',
  '6987651211'
];

final _fields = <String>['Όνομα:', 'Επίθετο:', 'ΑΜΚΑ:', 'Τηλέφωνο:'];
