import 'dart:typed_data';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reabilita_social/screens/preview_page.dart';
import 'package:reabilita_social/utils/snack/snack_atencao.dart';

class ImageController {
  final picker = ImagePicker();

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
}

class ImagePickerUtil {
  static Future<void> pegarFoto(BuildContext context, Function setImage) async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: Colors.white, // Substitua 'branco' por Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CameraCamera(onFile: (file) async {
                            final bytes = await file.readAsBytes();
                            final foto = await ImageController().showPreview(context, bytes);
                            if (foto == null) {
                              snackAtencao(context, "Selecione uma foto");
                              return;
                            }
                            setImage(foto);
                            Navigator.pop(context);
                          }),
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
                      final foto = await ImageController().getFileFromGallery();
                      if (foto == null) {
                        snackAtencao(context, "Selecione uma foto");
                        return;
                      }
                      setImage(foto);
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
