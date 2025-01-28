import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reabilita_social/controller/camera_controller.dart';
import 'package:reabilita_social/screens/profissional/preview_page.dart';
import 'package:reabilita_social/utils/snack/snack_atencao.dart';

class ImageController {
  final picker = ImagePicker();
  Uint8List? fileBytes;

  Future<Uint8List?> getFileFromGallery() async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  Future<Uint8List?> showPreview(BuildContext context, Uint8List fileBytes) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewPage(fileBytes: fileBytes),
      ),
    );

    if (result != null) {
      return result;
    }
    return null;
  }

  Future<Uint8List?> pegarArquivo(BuildContext context) async {
    print("Iniciando a seleção do arquivo PDF...");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      print("Arquivo selecionado: ${result.files.single.name}");
      if (result.files.single.bytes != null) {
        print("Bytes do arquivo obtidos diretamente.");
        return result.files.single.bytes;
      } else {
        String? filePath = result.files.single.path;
        if (filePath != null) {
          print("Caminho do arquivo: $filePath");
          File selectedFile = File(filePath);
          var fileBytes = await selectedFile.readAsBytes();
          print("Bytes do arquivo lidos do caminho.");
          return fileBytes;
        }
      }
    } else {
      print("Nenhum arquivo selecionado.");
      snackAtencao(context, "Nenhum arquivo selecionado");
    }
    return null;
  }
}

class ImagePickerUtil {
  static Future<void> pegarFoto(
      BuildContext context, Function(Uint8List?)? setImage, Function(Uint8List?)? setPdf) async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCustomCameraScreen(
                            onPictureTaken: (Uint8List bytes) async {
                              final imageController = ImageController();
                              final foto = await imageController.showPreview(context, bytes);
                              if (foto == null) {
                                snackAtencao(context, "Selecione uma foto");
                                return;
                              }
                              setImage!(foto);
                              setPdf!(null);
                            },
                          ),
                        ),
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 70,
                        ),
                        Text(
                          "Tirar foto",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final imageController = ImageController();
                      final foto = await imageController.getFileFromGallery();
                      if (foto == null) {
                        snackAtencao(context, "Selecione uma foto");
                        return;
                      }
                      setImage!(foto);
                              setPdf!(null);

                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 70,
                        ),
                        Text(
                          "Escolher foto",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final imageController = ImageController();
                      final pdf = await imageController.pegarArquivo(context);

                      setPdf!(pdf!);
                      setImage!(null);

                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.document_scanner,
                          size: 70,
                        ),
                        Text(
                          "Escolher documento",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final Function(Uint8List) onPictureTaken;

  const TakePictureScreen({
    super.key,
    required this.camera,
    required this.onPictureTaken,
  });

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tirar foto')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            final bytes = await image.readAsBytes();
            widget.onPictureTaken(bytes);
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
