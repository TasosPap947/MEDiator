import 'package:flutter/material.dart';
import 'package:mediator/schedule.dart';
import 'package:mediator/patBottomNavBar.dart';
import 'package:camera/camera.dart';

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

class PatProfilForm extends StatefulWidget {
  const PatProfilForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PatProfilForm();
}

class _PatProfilForm extends State<PatProfilForm> {
  /*final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _amkaController = TextEditingController(); */
  final EdgeInsets _padding = EdgeInsets.all(10.0);

  /* @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _phoneController.dispose();
    _amkaController.dispose();
    super.dispose();
  } */

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
                    child: CircleAvatar(
                      radius: 70, //radius is 5
                      backgroundImage: AssetImage(imagePath),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TakePictureScreen(
                            camera: firstCamera,
                            patProfilFormState: this,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.camera_enhance),
                  ),
                ],
              ),
            ),
            /* Padding(
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => PatBottomNavBar()),
                    );
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
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

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
    required this.patProfilFormState,
  }) : super(key: key);

  final CameraDescription camera;
  final _PatProfilForm patProfilFormState;

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
            // If the picture was taken, display it on a new screen.
            Navigator.of(context).pop();

            widget.patProfilFormState.setState(() {});
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
