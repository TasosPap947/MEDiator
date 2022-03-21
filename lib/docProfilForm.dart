//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mediator/docBottomNavBar.dart';
import 'package:mediator/patientsWidget.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

String imagePath = "assets/images/cat.jpg";

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

class DocProfilForm extends StatefulWidget {
  const DocProfilForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DocProfilForm();
}

class _DocProfilForm extends State<DocProfilForm> {
  final _fNameController = TextEditingController();
  /* late CameraController controller;
  @override
  void initState() {
    super.initState();

  } */

  final EdgeInsets _padding = EdgeInsets.all(10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Φτιάξε το προφίλ σου'),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                    child: /*Container(
                      height: 170.0,
                      width: 170.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                          image: AssetImage('assets/images/camera.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle, */
                        CircleAvatar(
                      radius: 70, //radius is 5
                      backgroundImage: AssetImage(imagePath), //image url
                    ),
                  ),
                  //),
                  IconButton(
                    onPressed: () async {
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TakePictureScreen(
                            camera: firstCamera,
                            docProfilFormState: this,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.camera_enhance),
                  ),
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
                  hintText: 'Όνομα',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.cyan),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: _padding,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Επίθετο',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.cyan),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: _padding,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Τηλέφωνο',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.cyan),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: _padding,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Ειδικότητα',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.cyan),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: _padding,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'ΑΜΚΑ',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.cyan),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Align(
                alignment:
                    Alignment.bottomCenter, //aligns CircleAvatar to Top Center.
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop(
                      MaterialPageRoute(builder: (context) => PatientsWidget()),
                    );
                  },
                  child: const Text('Επόμενο'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
    required this.docProfilFormState,
  }) : super(key: key);

  final CameraDescription camera;
  final _DocProfilForm docProfilFormState;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            imagePath = image.path;

            print(imagePath);

            Navigator.of(context).pop();

            widget.docProfilFormState.setState(() {});
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
