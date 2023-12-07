import 'dart:async';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class EarthPage extends StatefulWidget {
  const EarthPage({super.key});

  @override
  _EarthPageState createState() => _EarthPageState();
}

class _EarthPageState extends State<EarthPage> {
  late ARKitController arkitController;
  Timer? timer;

  @override
  // Limpar os recursos
  void dispose() {
    timer?.cancel();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Exemplo da Terra')),
        body: Container(
          child: ARKitSceneView(
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.lambert,
      diffuse: ARKitMaterialProperty.image('assets/earth_night.jpg'),
      doubleSided: true
    );

    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.2,
    );

    final node = ARKitNode(
      geometry: sphere,
      position: Vector3(0, 0, -0.5),
      eulerAngles: Vector3.zero(),
    );
    
    // Adiciona o nó a cena ARKit através do ARKitController.
    this.arkitController.add(node);

    // Timer realizar uma animação de rotação da Terra.
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final rotation = node.eulerAngles; // Obtém rotação atual
      rotation.x += 0.01;
      node.eulerAngles = rotation; // Atualizar a rotação
    });
  }
}