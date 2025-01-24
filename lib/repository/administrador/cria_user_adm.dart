import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserService {
  List<String> generos = ['Masculino', 'Feminino', 'Outro'];
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;

  static Future<Uint8List?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera) ??
        await picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? await pickedFile.readAsBytes() : null;
  }

  static Future<String> _uploadImage(String uid, Uint8List file) async {
    final ref = _storage.ref().child('users').child('$uid.jpg');
    await ref.putData(file);
    return await ref.getDownloadURL();
  }

  static Future<void> createUser({
    required String userType,
    required Map<String, dynamic> userData,
    required Uint8List imageFile,
  }) async {
    final lowerCaseUserType = userType.toLowerCase();

    UserCredential cred = await _auth.createUserWithEmailAndPassword(
      email: userData['email'],
      password: '123456',
    );

    String imageUrl = await _uploadImage(cred.user!.uid, imageFile);

    Map<String, dynamic> firestoreData = {
      'nome': userData['nome'],
      'email': userData['email'],
      'telefone': userData['telefone'],
      'statusConta': 'ativo',
      'urlFoto': imageUrl,
      'tipoUsuario': lowerCaseUserType,
      'dataCriacao': FieldValue.serverTimestamp(),
      'genero': userData['genero'],
      'dataNascimento': userData['dataNascimento'],
    };

    String collectionPath = '';
    if (lowerCaseUserType == 'profissional') {
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
        },
        'uidProfissional': cred.user!.uid,
      });
    } else if (lowerCaseUserType == 'administrador') {
      collectionPath = 'Administrador';
      firestoreData.addAll({
        'uidAdministrador': cred.user!.uid,
      });
    }

    if (collectionPath.isNotEmpty) {
      await _firestore
          .collection(collectionPath)
          .doc(cred.user!.uid)
          .set(firestoreData);

      await _firestore.collection('Usuarios').doc(cred.user!.uid).set({
        'email': userData['email'],
        'tipoUsuario': lowerCaseUserType,
        'uid': cred.user!.uid,
      });
    } else {
      throw Exception('Tipo de usuário inválido');
    }
  }
}
