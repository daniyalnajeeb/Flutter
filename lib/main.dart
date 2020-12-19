import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Core Flutter Plugin Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AR Core Flutter Plugin Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
    final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ArCoreController arCoreController;

  void _onArCoreViewCreated(ArCoreController _arcoreController){
    arCoreController = _arcoreController;
//    _arcoreController.onNodeTap = (name) => onTapHandler(name);
     arCoreController.onPlaneTap = _onPlaneTapHandler;
    //_addSphere(arCoreController);
  }

   Future _addSphere(ArCoreHitTestResult hit) async {
     final ByteData earthTexture = await await rootBundle.load("images/earth.jpg");
     final material = ArCoreMaterial(color: Colors.lightBlueAccent, textureBytes: earthTexture.buffer.asUint8List());
    final sphere = ArCoreSphere(materials: [material], radius: 0.2);
     final earth = ArCoreNode(
       shape: sphere,
       position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
       rotation: hit.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
     );

     arCoreController.addArCoreNodeWithAnchor(earth);

//
//    final bytes = (await rootBundle.load("images/earth.jpg");
//    final material = ArCoreMaterial(color: Colors.lightBlueAccent, textureBytes: earthTexture.buffer.asUint8List());
//    final sphere = ArCoreSphere(materials: [material], radius: 0.2);
//    final node = ArCoreNode(shape: sphere, position: vector.Vector3(0, 0, -2.5));
//     final earth = ArCoreNode(
//       image: ArCoreImage(bytes: bytes, width: 500, height: 500),
//       position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
//       rotation: hit.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
//     );
//     arCoreController.addArCoreNode(earth);
//     );
  }

  void _onPlaneTapHandler(List<ArCoreHitTestResult> hits){
    final hit = hits.first;
    _addSphere(hit);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
      ),
    );
  }




//  void onTapHandler(String name){
//    showDialog<void>(
//      context: context,
//      builder: (BuildContext context) =>
//          AlertDialog(content: Text('onNodeTap on $name')),
//    );
//  }

//  void _onPlaneTapHandler(List<ArCoreHitTestResult> hits){
//    final hit = hits.first;
//    final moonMaterial = ArCoreMaterial(color: Colors.grey);
//    final moonShape = ArCoreSphere(
//      materials: [moonMaterial],
//      radius: 0.03,
//    );
//    final moon = ArCoreNode(
//      shape: moonShape,
//      position: vector.Vector3(0.2, 0, 0),
//      rotation: vector.Vector4(0,0,0,0),
//    );
//    final earthMaterial =  ArCoreMaterial(
//        color: Color.fromARGB(120, 66, 134, 244),
//    );
//    final earthShape = ArCoreSphere(
//    materials: [earthMaterial],
//    radius: 0.1,
//    );
//    final earth = ArCoreNode(
//    shape: earthShape,
//    children: [moon],
//    position: hit.pose.translation + vector.Vector3(0.0, 1.0, 0.0),
//    rotation: hit.pose.rotation
//    );
//    arCoreController.addArCoreNodeWithAnchor(earth);
//  }
  @override
  void dispose(){
    arCoreController.dispose();
    super.dispose();
  }
}
