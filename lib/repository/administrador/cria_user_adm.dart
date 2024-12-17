import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;

  // Função para pegar imagem
  static Future<Uint8List?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera) ??
        await picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? await pickedFile.readAsBytes() : null;
  }

  // Upload da imagem no Storage
  static Future<String> _uploadImage(String uid, Uint8List file) async {
    final ref = _storage.ref().child('users').child('$uid.jpg');
    await ref.putData(file);
    return await ref.getDownloadURL();
  }

  // Cria usuário no Firebase
  static Future<void> createUser({
    required String userType,
    required Map<String, dynamic> userData,
    required Uint8List imageFile,
  }) async {
    // Criação no Auth
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: userData['email'],
      password: '123456',
    );

    // Upload da imagem
    String imageUrl = await _uploadImage(cred.user!.uid, imageFile);

    // Dados base
    Map<String, dynamic> firestoreData = {
      'nome': userData['nome'],
      'email': userData['email'],
      'telefone': userData['telefone'],
      'statusConta': 'ativo',
      'urlFoto': imageUrl,
      'tipoUsuario': userType,
    };

    // Ajusta os dados e collection com base no tipo de usuário
    String collectionPath = '';
    if (userType == 'Profissional') {
      collectionPath = 'Profissionais';
      firestoreData.addAll({
        'cpf': userData['cpf'],
        'raça': userData['raça'],
        'profissao': userData['profissao'],
        'localTrabalho': userData['localTrabalho'],
        'endereco': {
          'cep': userData['cep'],
          'rua': userData['rua'],
          'numero': userData['numero'],
          'bairro': userData['bairro'],
          'cidade': userData['cidade'],
          'estado': userData['estado'],
          'complemento': userData['complemento'],
        }
      });
    } else if (userType == 'Administrador') {
      collectionPath = 'Administrador';
    }

    // Salva os dados no Firestore
    if (collectionPath.isNotEmpty) {
      await _firestore
          .collection(collectionPath)
          .doc(cred.user!.uid)
          .set(firestoreData);
    } else {
      throw Exception('Tipo de usuário inválido');
    }
  }
}
