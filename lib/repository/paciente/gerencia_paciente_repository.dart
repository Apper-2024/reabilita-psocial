import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/repository/FirebaseError/firebase_error_repository.dart';
import 'package:uuid/v4.dart';

class GerenciaPacienteRepository {
  final db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> cadastrarPacienteNovo(DadosPacienteModel paciente, Uint8List arquivo, String senha) async {
    final uuid = const UuidV4().generate();

    try {
      final imagesRef = storageRef.child("Pacientes/$uuid.jpg");
      await imagesRef.putData(arquivo);

      String imageUrl = await imagesRef.getDownloadURL();

      paciente.urlFoto = imageUrl;

      final pacienteRef = db.collection("Pacientes").doc();

      final batch = db.batch();

      batch.set(pacienteRef, {
        ...paciente.toMap(),
        "senha": senha,
      });

      // Commit do batch
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<Map<String, Object>?> verificaSenha(String senha, String email, String cns) async {
    try {
      final senhaRef = db
          .collection("Pacientes")
          .where("email", isEqualTo: email)
          .where("cns", isEqualTo: cns)
          .where("senha", isEqualTo: senha)
          .limit(1);
      final senhaDoc = await senhaRef.get();

      if (senhaDoc.docs.isEmpty) {
        throw 'Email ou CNS inválidos';
      }

      return {
        'paciente': DadosPacienteModel.fromMap(senhaDoc.docs.first.data()),
        'uidColletion': senhaDoc.docs.first.reference.id
      };
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Email ou CNS inválidos';
    }
  }

  // Future<void> excluirFoto(String uuid) async {
  //   try {
  //     final imagesRef = storageRef.child("PacientesNovos/$uuid.jpg");
  //     await imagesRef.delete();
  //   } on FirebaseException catch (e) {
  //     throw FirebaseErrorRepository.handleFirebaseException(e);
  //   } catch (e) {
  //     print(e);
  //     throw 'Ops, algo deu errado. Tente novamente mais tarde!';
  //   }
  // }

  Future<void> cadastrarPaciente(DadosPacienteModel paciente, Uint8List arquivo, String senha) async {
    final uuid = const UuidV4().generate();

    try {
      final imagesRef = storageRef.child("PacientesNovos/$uuid.jpg");
      await imagesRef.putData(arquivo);

      String imageUrl = await imagesRef.getDownloadURL();

      paciente.urlFoto = imageUrl;

      final pacienteRef = db.collection("PacientesNova").doc();

      final batch = db.batch();

      batch.set(pacienteRef, {
        ...paciente.toMap(),
        "uidFoto": uuid,
        "senha": senha,
      });

      // Commit do batch
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> editarPaciente(DadosPacienteModel paciente, String uid) async {
    try {
      final pacienteRef = db.collection("Pacientes").doc(paciente.uidPaciente);
      paciente.uidPaciente = pacienteRef.id;

      final batch = db.batch();

      batch.set(pacienteRef, paciente.toMap());

      final pacienteExcluirRef = db.collection("Pacientes").doc(uid);
      batch.delete(pacienteExcluirRef);

      // Commit do batch
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }
}
