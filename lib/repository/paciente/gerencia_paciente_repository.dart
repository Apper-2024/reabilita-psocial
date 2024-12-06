import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reabilita_social/model/paciente/agenda/agenda_model.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_modal.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_multiprofissional_model.dart';
import 'package:reabilita_social/model/paciente/evolucao/evolucao_model.dart';
import 'package:reabilita_social/model/paciente/intervencoes/intervencoes_model.dart';
import 'package:reabilita_social/model/paciente/metas/meta_model.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/repository/FirebaseError/firebase_error_repository.dart';
import 'package:uuid/v4.dart';

class GerenciaPacienteRepository {
  final db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> cadastrarPacienteNovo(DadosPacienteModel paciente, Uint8List arquivo, String senha) async {
    final uuid = const UuidV4().generate();
    final batch = db.batch();
    try {
      final imagesRef = storageRef.child("Pacientes/${paciente.uidPaciente}/$uuid.jpg");
      await imagesRef.putData(arquivo);

      String imageUrl = await imagesRef.getDownloadURL();

      paciente.urlFoto = imageUrl;

      final pacienteRef = db.collection("Pacientes").doc();
      paciente.uidDocumento = pacienteRef.id;

      PacienteModel pacienteModel = PacienteModel(
          dadosPacienteModel: paciente,
          diagnosticoModal: DiagnosticoModal(
              desejoModel: null,
              historiaCasoModel: null,
              doencasClinicas: null,
              medicacoesModel: null,
              outrasInformacoesModel: null,
              potencialidadeModel: null,
              recursoIndividuaisModel: null),
          evolucoes: EvolucaoModel(comentario: null, dataCriancao: null, foto: null, nome: null),
          intervencoesModel: IntervencoesModel(listIntervencoes: null),
          listaAgenda: AgendaModel(agendas: null),
          metas: MetaModel(metas: null));

      batch.set(pacienteRef, {
        ...pacienteModel.toMap(),
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
          .where("dadosPacienteModel.email", isEqualTo: email)
          .where("dadosPacienteModel.cns", isEqualTo: cns)
          .where("senha", isEqualTo: senha)
          .limit(1);
      final senhaDoc = await senhaRef.get();
      print(senhaDoc.docs.first.data());

      if (senhaDoc.docs.isEmpty) {
        throw 'Email ou CNS inválidos';
      }
    final pacienteData = senhaDoc.docs.first.data();
    final pacienteModel = PacienteModel.fromMap(pacienteData);
      

      return {
        'paciente': pacienteModel,
        'uidColletion': senhaDoc.docs.first.reference.id
      };
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Email ou CNS inválidos';
    }
  }

  Future<void> editarPaciente(DadosPacienteModel paciente, String uid) async {
    try {
      final pacienteRef = db.collection("Pacientes").doc(uid);

      final batch = db.batch();

      batch.update(pacienteRef, {
        'dadosPacienteModel': paciente.toMap(),
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

  Future<void> cadastrarHistoria(HistoriaCasoModel historia, List<Uint8List> arquivos, String uidPaciente) async {
    final uuid = const UuidV4().generate();
    final batch = db.batch();

    try {
      List<String> imageUrls = [];

      for (var arquivo in arquivos) {
        final imagesRef = storageRef.child("DiagnosticoMultiprofissional/$uuid.jpg");
        await imagesRef.putData(arquivo);
        String imageUrl = await imagesRef.getDownloadURL();
        imageUrls.add(imageUrl);
      }

      historia.foto = imageUrls;

      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.historiaCasoModel': historia.toMap(),
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

  // Future<void> cadastrarPaciente(DadosPacienteModel paciente, Uint8List arquivo, String senha) async {
  //   final uuid = const UuidV4().generate();

  //   try {
  //     final imagesRef = storageRef.child("PacientesNovos/$uuid.jpg");
  //     await imagesRef.putData(arquivo);

  //     String imageUrl = await imagesRef.getDownloadURL();

  //     paciente.urlFoto = imageUrl;

  //     final pacienteRef = db.collection("PacientesNova").doc();

  //     final batch = db.batch();

  //     batch.set(pacienteRef, {
  //       ...paciente.toMap(),
  //       "uidFoto": uuid,
  //       "senha": senha,
  //     });

  //     // Commit do batch
  //     await batch.commit();
  //   } on FirebaseException catch (e) {
  //     throw FirebaseErrorRepository.handleFirebaseException(e);
  //   } catch (e) {
  //     print(e);
  //     throw 'Ops, algo deu errado. Tente novamente mais tarde!';
  //   }
  // }