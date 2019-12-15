// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/screens/register/upload/photo_id.dart';

// class UploadChoice extends StatefulWidget {
//   @override
//   UploadChoiceState createState() {
//     return UploadChoiceState();
//   }
// }

// class UploadChoiceState extends State<UploadChoice> {

//   Future<void> _navigateToCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//     TakePictureScreen(camera: firstCamera,);
//     Navigator.pushNamed(context, '/home');
//   }

//   Future<void> _navigateToVideo() async {
//     try {
//       Navigator.pushNamed(context, '/home');
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//     Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//         color: Colors.white,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               RichText(
//                 text: TextSpan(
//                   style: DefaultTextStyle.of(context).style,
//                   children: <TextSpan>[
//                     TextSpan(text: 'Now, we just need some Photo ID', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20)),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
//               RaisedButton(
//                 onPressed: _navigateToCamera,
//                 child: const Text(
//                   'Upload a picture',
//                   style: TextStyle(fontSize: 20)
//                 ),
//               ),
//               const SizedBox(height: 30),
//               RaisedButton(
//                 onPressed: _navigateToVideo,
//                 textColor: Colors.white,
//                 padding: const EdgeInsets.all(0.0),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: <Color>[
//                         Color(0xFF0D47A1),
//                         Color(0xFF1976D2),
//                         Color(0xFF42A5F5),
//                       ],
//                     ),
//                   ),
//                   padding: const EdgeInsets.all(10.0),
//                   child: const Text(
//                     'To Map',
//                     style: TextStyle(fontSize: 20)
//                   ),
//                 ),
//               ),
//               MaterialButton(
//                   minWidth: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                   onPressed: () {
//                       Navigator.pop(context);
//                   },
//                   child: Text("Back",
//                       textAlign: TextAlign.center
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }