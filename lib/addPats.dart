import 'package:flutter/material.dart';
import 'package:mediator/docProfilForm.dart';

class AddPats extends StatefulWidget {
  const AddPats({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddPats();
}

class _AddPats extends State<StatefulWidget> {
  final _padding = const EdgeInsets.all(8.0);
  final _colorAppBar = Colors.cyan;

  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _amkaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _phoneController.dispose();
    _amkaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _colorAppBar,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DocProfilForm()),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
        title: const Text('Προσθήκη Ασθενή'),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: _padding,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Όνομα',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                controller: _fNameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Το πεδίο όνομα είναι υποχρεωτικό';
                  return null;
                },
              ),
            ),
            Padding(
              padding: _padding,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Επίθετο',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                controller: _lNameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Το πεδίο επίθετο είναι υποχρεωτικό';
                  return null;
                },
              ),
            ),
            Padding(
              padding: _padding,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'AMKA',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                controller: _amkaController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Το πεδίο ΑΜΚΑ είναι υποχρεωτικό';
                  return null;
                },
              ),
            ),
            Padding(
              padding: _padding,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Τηλέφωνο',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                controller: _phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Το πεδίο τηλέφωνο είναι υποχρεωτικό';
                  return null;
                },
              ),
            ),
            Padding(
                padding: _padding,
                child: Row(
                  children: <Widget>[
                    const Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(),
                    ),
                    Padding(
                      padding: _padding,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Ακύρωση',
                              style: TextStyle(color: Colors.cyan)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white))),
                    ),
                    Padding(
                      padding: _padding,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final patEntry = PatientsEntry(
                              fName: _fNameController.text,
                              lName: _lNameController.text,
                              phone: _phoneController.text,
                              amka: _amkaController.text,
                            );
                            Navigator.pop(context, patEntry);
                          }
                        },
                        child: const Text('Αποθήκευση'),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class PatientsEntry {
  String fName;
  String lName;
  String amka;
  String phone;

  PatientsEntry(
      {required this.fName,
      required this.lName,
      required this.amka,
      required this.phone});
}
