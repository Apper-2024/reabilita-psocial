import 'dart:async';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';

class ImagePickerUtil {
  static Future<void> pegarFoto(
      BuildContext context, Function(Uint8List) setImage) async {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Escolha uma opção",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOption(
                      context,
                      icon: Icons.camera_alt_outlined,
                      label: "Tirar foto",
                      onTap: () async {
                        print("Botão 'Tirar foto' clicado");
                        Navigator.pop(context);
                        // Navegação para a câmera ou outra funcionalidade
                      },
                    ),
                    _buildOption(
                      context,
                      icon: Icons.photo_library_outlined,
                      label: "Escolher foto",
                      onTap: () async {
                        print("Botão 'Escolher foto' clicado");
                        final foto = await _pickFile();
                        if (foto != null) {
                          print("Foto selecionada com sucesso");
                          setImage(foto);
                          Navigator.pop(context);
                        } else {
                          print("Nenhuma foto foi selecionada");
                        }
                      },
                    ),
                    _buildOption(
                      context,
                      icon: Icons.document_scanner_outlined,
                      label: "Escolher documento",
                      onTap: () async {
                        print("Botão 'Escolher documento' clicado");
                        final documento = await _pickFile(isDocument: true);
                        if (documento != null) {
                          print("Documento selecionado com sucesso");
                          setImage(documento);
                          Navigator.pop(context);
                        } else {
                          print("Nenhum documento foi selecionado");
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<Uint8List?> _pickFile({bool isDocument = false}) async {
    print("Abrindo FileUploadInputElement");
    final input = html.FileUploadInputElement()
      ..accept = isDocument ? '.pdf, .doc, .docx' : 'image/*'
      ..click();

    final completer = Completer<Uint8List?>();

    input.onChange.listen((e) async {
      final files = input.files;
      print("Arquivos selecionados: ${files?.length}");
      if (files?.isEmpty ?? true) {
        print("Nenhum arquivo foi selecionado");
        completer.complete(null);
        return;
      }
      final file = files!.first;
      print("Nome do arquivo selecionado: ${file.name}"); // Nome do documento

      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((e) {
        print("Leitura do arquivo concluída");
        completer.complete(reader.result as Uint8List?);
      });
    });

    return completer.future;
  }

  static Widget _buildOption(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.blueGrey[700],
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
