import 'dart:async';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class SaturnPage extends StatefulWidget {
  const SaturnPage({super.key});

  @override
  _SaturnPageState createState() => _SaturnPageState();
}

class _SaturnPageState extends State<SaturnPage> {
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
        appBar: AppBar(title: const Text('Exemplo de Saturno')),
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
      diffuse: ARKitMaterialProperty.image('assets/saturn.jpg'),
      doubleSided: true
    );

    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.4,
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