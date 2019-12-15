import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
        onPressed: () {},
        child: const Icon(Icons.camera),
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
