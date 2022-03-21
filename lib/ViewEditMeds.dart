import 'package:flutter/material.dart';
import 'package:mediator/docProfilForm.dart';

class ViewEditMeds extends StatefulWidget {
  const ViewEditMeds({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewEditMeds();
}

class _ViewEditMeds extends State<StatefulWidget> {
  final _padding = const EdgeInsets.all(8.0);
  final _colorAppBar = Colors.cyan;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  TimeOfDay? _alarmTime;
  bool _visibleWidgets = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _showTime() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (result != null) {
      setState(() {
        _alarmTime = result;
        _visibleWidgets = true;
      });
    }
  }

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
                  hintText: 'Όνομα',
                  border: OutlineInputBorder(borderSide: BorderSide()),
                ),
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Ο τίτλος είναι υποχρεωτικός';
                  return null;
                },
              ),
            ),
            Padding(
              padding: _padding,
              child: TextField(
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: 'Περιγραφή',
                    border: OutlineInputBorder(borderSide: BorderSide())),
                controller: _descriptionController,
              ),
            ),
            Padding(
                padding: _padding,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('assets/images/notification.png'),
                      onPressed: _showTime,
                      tooltip: 'Ορισμός Υπενθύμισης',
                    ),
                    Visibility(
                      child: Text(_alarmTime != null
                          ? _alarmTime!.format(context)
                          : ''),
                      visible: true,
                    ),
                    Visibility(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _alarmTime = null;
                            _visibleWidgets = false;
                          });
                        },
                        icon: const Icon(Icons.cancel),
                      ),
                      visible: true,
                    ),
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
                            final entry = Entry(
                              alarm: _alarmTime,
                              name: _nameController.text,
                              description: _descriptionController.text,
                            );
                            Navigator.pop(context, entry);
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

class Entry {
  String name;
  String? description;
  TimeOfDay? alarm;

  Entry({required this.name, this.description, this.alarm});
}

//Entry test = Entry(name: 'Tasos Pap', description: 'omorfos');
