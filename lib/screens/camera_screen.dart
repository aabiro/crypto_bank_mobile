import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_app/helpers/bike_helper.dart';
import 'package:flutter_app/models/bike.dart';

class CameraScreen extends StatefulWidget {
  static final routeName = '/camera';
  final List<CameraDescription> cameras;

  CameraScreen(this.cameras);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController =
        new CameraController(widget.cameras[0], ResolutionPreset.high);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  void _addNewBike(int id) {
    Bike newBike = Bike(id, "nsnsn", 1919, true, true, false, "www.image");
    //use http request to send the data
        // final body = "{\"username\":\"$username\", \"password\": \"$password\", \"grant_type\": \"password\"}";
        // final body = "username=$username&password=$password&grant_type=password";
    final body = "model=sksksk";
    BikeHelper.addBike(body, context);

  }

  @override
  Widget build(BuildContext context) {
    // if (!_isReady) return new Container();
    if (!cameraController.value.isInitialized) return new Container();

    return new Scaffold(
      body: new Container(
        child: new AspectRatio(
          aspectRatio: cameraController.value.aspectRatio,
          child: new CameraPreview(cameraController),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _addNewBike(22);
        },
        child: const Icon(Icons.center_focus_strong),
        //  onPressed:
        //  _isReady ? capture : null,
        // child: const Icon(
        //   Icons.camera,
        //   color: Colors.white,
        // ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
