import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  ArCoreController? coreController;

  void augmentedRealityViewCreated(ArCoreController controller) {
    coreController = controller;

    displayCube(coreController!);
    displayCylinder(coreController!);
  }

  displayCube(ArCoreController controller) {
    final materials = ArCoreMaterial(
      color: Colors.amberAccent,
      metallic: 2,
    );
    final cube = ArCoreCube(
      size: vector64.Vector3(0.5, 0.5, 0.5),
      materials: [materials],
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector64.Vector3(0.0, 0.0, 0.0),
    );
    coreController!.addArCoreNode(node);
  }

  displayCylinder(ArCoreController controller) {
    final materials = ArCoreMaterial(
      color: Colors.deepOrange,
      reflectance: 2,
    );
    final cylinder = ArCoreCylinder(
      radius: 0.5,
      height: 0.4,
      materials: [materials],
    );
    final node = ArCoreNode(
      shape: cylinder,
      position: vector64.Vector3(0.0, -0.5, -2.0),
    );
    coreController!.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UAM AR Demo"),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: augmentedRealityViewCreated,
      ),
    );
  }
}
