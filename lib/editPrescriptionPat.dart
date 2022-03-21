import 'package:flutter/material.dart';
import 'package:mediator/docProfilForm.dart';

class EditPrescription extends StatefulWidget {
  const EditPrescription({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPrescription();
}

class _EditPrescription extends State<StatefulWidget> {
  final _padding = const EdgeInsets.all(8.0);
  final _colorAppBar = Colors.cyan;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _visibleWidgets = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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
        title: const Text('Φάρμακα'),
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
                  hintText: 'Όνομα Φαρμάκου',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                controller: _nameController,
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
                  hintText: 'Περιγραφή Δοσολογίας',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Το πεδίο περιγραφή δοσολογίας είναι υποχρεωτικό';
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
                          child: Text('Άκυρο',
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
                            final entry = EntryPrescr(
                              name: _nameController.text,
                              description: _descriptionController.text,
                            );
                            Navigator.pop(context, entry);
                          }
                        },
                        child: const Text('Προσθήκη'),
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

class EntryPrescr {
  String name;
  String description;
  TimeOfDay? alarm;

  EntryPrescr({required this.name, required this.description, this.alarm});
}

//EntryPrescr test = EntryPrescr(name: 'Tasos Pap', description: 'omorfos');
