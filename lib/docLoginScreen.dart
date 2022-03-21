import 'package:flutter/material.dart';
import 'package:mediator/patientsWidget.dart';

class DocLoginWidget extends StatelessWidget {
  DocLoginWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextStyle _buttonTextStyle = TextStyle(
    fontSize: 35,
  );
  final TextStyle _titleTextStyle = TextStyle(
    fontSize: 50,
  );
  final EdgeInsets _padding = EdgeInsets.all(16.0);
  final EdgeInsets _titlePadding = EdgeInsets.all(20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Συνδέσου στο προφίλ σου'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                child: Text("MEDiator", style: _titleTextStyle),
                padding: _titlePadding),
            Padding(
              padding: _padding,
              /*child: CircleAvatar(
                radius: 100.0,
                backgroundImage: NetworkImage(
                    'https://www.pngitem.com/middle/miiJii_professional-clipart-female-avatar-circle-hd-png-download/'),
                backgroundColor: Colors.green,
              ), */
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment
                        .topCenter, //aligns CircleAvatar to Top Center.
                    child: /*Image(
                        image: //AssetImage('assets/images/notification.png'),
                      ) */ /*Container(
                      height: 170.0,
                      width: 170.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                          image: AssetImage('assets/images/camera.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle, */
                        Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/MEDiator.png'),
                          // fit: BoxFit.fill,
                        ),
                        //shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  //),
                ],
              ),
            ),
            /*Padding(
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
            ), */
            Padding(
              padding: _padding,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'AMKA',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.cyan),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
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
                decoration: InputDecoration(
                  hintText: 'Κωδικός',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.cyan),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Το πεδίο κωδικός είναι υποχρεωτικό';
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
                alignment:
                    Alignment.bottomCenter, //aligns CircleAvatar to Top Center.
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PatientsWidget()),
                      );
                    }
                  },
                  child: const Text('Σύνδεση'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
