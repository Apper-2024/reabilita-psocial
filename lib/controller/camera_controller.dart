import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/preview_page.dart';
import 'package:reabilita_social/utils/snack/snack_atencao.dart';

class MyCustomCameraScreen extends StatefulWidget {
  final Function(Uint8List) onPictureTaken;

  const MyCustomCameraScreen({
    Key? key,
    required this.onPictureTaken,
  }) : super(key: key);

  @override
  _MyCustomCameraScreenState createState() => _MyCustomCameraScreenState();
}

class _MyCustomCameraScreenState extends State<MyCustomCameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(
          cameras.first,
          ResolutionPreset.high,
          enableAudio: false, // Desabilita o áudio se não for necessário
        );
        await _controller.initialize();
        setState(() {});
      } else {
        snackAtencao(context, "Nenhuma câmera disponível");
      }
    } catch (e) {
      snackAtencao(context, "Erro ao inicializar a câmera: $e");
    }
  }

  @override
  void dispose() {
    if (_controller.value.isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background preto para melhor contraste
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && _controller.value.isInitialized) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // Botão para tirar foto
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  try {
                    await _initializeControllerFuture;
                    final image = await _controller.takePicture();
                    final bytes = await image.readAsBytes();
                    widget.onPictureTaken(bytes);
                  } catch (e) {
                    print(e);
                    snackAtencao(context, "Erro ao tirar foto: $e");
                  }
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.7),
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
          // Botão de voltar (opcional)
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
