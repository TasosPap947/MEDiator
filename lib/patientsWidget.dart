import 'package:flutter/material.dart';
import 'package:mediator/docBottomNavBar.dart';
import 'package:mediator/docProfilForm.dart';
import 'package:mediator/editPrescriptionPat.dart';
import 'package:mediator/schedule.dart';
import 'package:mediator/addPats.dart';
//import 'package:flutter_application_1/editPrescriptionPat.dart';
import 'package:mediator/patPrescription.dart';
import "package:mediator/main.dart";

var _patient;
var _patImage;
var _val;
List<String>? _patMeds = ['Depon'];
List<String>? _patDescrMeds = ['-'];

class PatientsWidget extends StatefulWidget {
  const PatientsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PatientsWidget();
}

class _PatientsWidget extends State<PatientsWidget> {
  //int? i;
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

  //void _showPatients(int idx) {}

  void _deletePatients(int idx) async {
    bool? _delPatients = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Θέλετε σίγουρα να διαγράψετε αυτόν τον ασθενή;'),
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

    if (_delPatients!) {
      _pats.removeAt(idx);
      setState(() {});
    }
  }

  void _addNewPatientsEntry() async {
    final PatientsEntry? _newPatientsEntry = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddPats()), //AddPatients()
    );

    if (_newPatientsEntry != null) {
      _pats.add(
        Patients(
            image: AssetImage('assets/images/winney.jpeg'),
            fName: _newPatientsEntry.fName,
            lName: _newPatientsEntry.lName,
            amka: _newPatientsEntry.amka,
            phone: _newPatientsEntry.phone,
            value: 0.05),
      );

      //Redraw the widget
      setState(() {});
    }
  }

  Widget _buildListPatients() {
    return ListView.separated(
      padding: _padding,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            backgroundImage: _pats[index].image,
            radius: 30,
          ),
          //Icon(Icons.check_box_outlined),

          title: Text(_pats[index].lName),
          trailing: IconButton(
            onPressed: () {
              _deletePatients(index);
            },
            icon: Icon(Icons.delete),
            tooltip: 'Διαγραφή Ασθενή',
          ),
          onTap: () {
            _patient = <String>[
              _pats[index].fName,
              _pats[index].lName,
              _pats[index].amka,
              _pats[index].phone
            ];
            _patImage = _pats[index].image;
            _val = _pats[index].value;
            if (_pats[index].descrMeds != null) {
              _patDescrMeds = _pats[index].descrMeds;
            }
            if (_pats[index].meds != null) {
              _patMeds = _pats[index].meds;
            }

            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DocBottomNavBar()),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _pats.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ασθενείς'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DocProfilForm()),
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

      body: _buildListPatients(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
        onPressed: () {
          _addNewPatientsEntry();
          /*Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ViewEditPatientss()),
          );*/
        },
        tooltip: 'Προσθήκη',
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

//fake data

class Patients {
  AssetImage image;
  String fName;
  String lName;
  String amka;
  String phone;
  double value;
  List<String>? meds;
  List<String>? descrMeds;

  Patients(
      {required this.fName,
      required this.lName,
      required this.amka,
      required this.phone,
      required this.image,
      required this.value,
      this.meds,
      this.descrMeds});
}

final _patientInitList = <Patients>[
  Patients(
      amka: '20070898017',
      fName: 'Γεώργιος',
      lName: 'Μήτσουλας',
      phone: '6968909123',
      image: AssetImage('assets/images/dummy.jpg'),
      value: 0.6,
      meds: ['Ponstan', 'Depon'],
      descrMeds: ['1 φορά την ημέρα', '1 το πρωί και 1 το βράδυ']),
  Patients(
      amka: '20090898017',
      fName: 'Δημήτριος',
      lName: 'Καραμπούκουλας',
      phone: '6968909190',
      image: AssetImage('assets/images/twity.jpg'),
      value: 0.2,
      meds: [
        'Ponstan',
        'Panadol',
        'Augmentin'
      ],
      descrMeds: [
        '1 φορά την ημέρα',
        '1 το πρωί και 1 το βράδυ',
        'Πρωί, βράδυ και 10 μέρες'
      ]),
  Patients(
      amka: '20090898908',
      fName: 'Μαρία',
      lName: 'Πενταγιώτισσα',
      phone: '6990090910',
      image: AssetImage('assets/images/maria.jpg'),
      value: 0.7,
      meds: [
        'Voltaren',
        'Depon',
        'Augmentin'
      ],
      descrMeds: [
        '1 φορά την ημέρα',
        '1 το πρωί και 1 το βράδυ',
        'Πρωί, βράδυ και 10 μέρες'
      ]),
  Patients(
      amka: '191304908908',
      fName: 'Περικλής',
      lName: 'Ιπποπόταμος',
      phone: '6976830910',
      image: AssetImage('assets/images/ipo.jpg'),
      value: 0.55,
      meds: [
        'Naprosyn',
        'Arnica',
        'Ponstan'
      ],
      descrMeds: [
        '1 φορά την ημέρα',
        'τοπικά 3 φορές τη μέρα, όσο χρειαστεί',
        'Πρωί, βράδυ και 10 μέρες'
      ]),
  Patients(
      amka: '139090899878',
      fName: 'Ιωάννης',
      lName: 'Τίγρης',
      phone: '6986790954',
      image: AssetImage('assets/images/tiger.jpg'),
      value: 0.9,
      meds: [
        'Panadol',
        'Augmentin'
      ],
      descrMeds: [
        '1 φορά την ημέρα',
        '1 το πρωί και 1 το βράδυ',
      ]),
  Patients(
      amka: '98706589898',
      fName: 'Χριστίνα',
      lName: 'Παρακολουθάκη',
      phone: '6968540917',
      image: AssetImage('assets/images/cris.jpg'),
      value: 0.35,
      meds: [
        'Cosopt',
        'Augmentin',
        'Counterpain'
      ],
      descrMeds: [
        '2 σταγόνες σε κάθε μάτι, 1 φορά την ημέρα',
        '1 το πρωί και 1 το βράδυ',
        'Πρωί, βράδυ και 10 μέρες'
      ]),
  Patients(
      amka: '19590843208',
      fName: 'Μάγια',
      lName: 'Μέλισσα',
      phone: '6987537917',
      image: AssetImage('assets/images/magia.jpg'),
      value: 0.15,
      meds: [
        'Fenistil',
        'Depon',
        'Augmentin'
      ],
      descrMeds: [
        '2 φορες την ημέρα',
        '1 το πρωί και 1 το βράδυ',
        'Πρωί, βράδυ και 10 μέρες'
      ]),
];

//end of fake data

//showPatient
class ShowPatient extends PatientsWidget {
  const ShowPatient({Key? key}) : super(key: key);

  @override
  State<PatientsWidget> createState() => _ShowPatient();
}

class _ShowPatient extends State<ShowPatient> {
  Widget _firstListView() {
    return Container(
      //color: Colors.green,
      child: ListView.separated(
        itemCount: _patient.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => ListTile(
          leading: Text(_fields[index]),
          title: Text(_patient[index]),
        ),
      ),
    );
  }

  final EdgeInsets _padding = EdgeInsets.all(10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Πληροφορίες για τον Aσθενή'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: _padding,
            child: CircleAvatar(
              radius: 70, //radius is 5
              backgroundImage: _patImage, //image url
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
              value: _val,
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

final _fields = <String>['Όνομα:', 'Επίθετο:', 'ΑΜΚΑ:', 'Τηλέφωνο:'];

class DocPrescription extends PatientsWidget {
  const DocPrescription({Key? key}) : super(key: key);

  @override
  State<PatientsWidget> createState() => _DocPrescription();
}

class _DocPrescription extends State<DocPrescription> {
  void _addNewEntryPrescr() async {
    final EntryPrescr? _newEntryPrescr = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditPrescription()),
    );
    if (_newEntryPrescr != null) {
      _patMeds!.add(_newEntryPrescr.name);
      _patDescrMeds!.add(_newEntryPrescr.description);
      setState(() {});
    }
  }

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
      _patMeds!.removeAt(idx);
      _patDescrMeds!.removeAt(idx);
      setState(() {});
    }
  }

  Widget _firstListView() {
    return Container(
      //color: Colors.green,
      child: ListView.separated(
        itemCount: _patMeds!.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => ListTile(
          title: Text(_patMeds![index]),
          subtitle: Text(_patDescrMeds![index]),
          trailing: IconButton(
            onPressed: () {
              _deleteMed(index);
            },
            icon: Icon(Icons.delete),
            tooltip: 'Διαγραφή Φαρμάκου',
          ),
        ),
      ),
    );
  }

  final EdgeInsets _padding = EdgeInsets.all(10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Συνταγογράφηση'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30.0),
            child: _firstListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          _addNewEntryPrescr();
        },
        tooltip: 'Προσθήκη Φαρμάκου',
      ),
    );
  }
}


//EntryPrescr test = EntryPrescr(name: 'Tasos Pap', description: 'omorfos');
