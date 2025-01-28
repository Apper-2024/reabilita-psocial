import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reabilita_social/model/paciente/agenda/agenda_model.dart';
import 'package:reabilita_social/model/paciente/avaliacao/avaliacao_model.dart';
import 'package:reabilita_social/model/paciente/dadosPaciente/dados_paciente_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/desejo_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_modal.dart';
import 'package:reabilita_social/model/paciente/diagnostico/diagnostico_multiprofissional_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/dificuldade_pessoal_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/doencas_clinicas_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/medicacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/outras_informacoes_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/potencialidade_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/problema_model.dart';
import 'package:reabilita_social/model/paciente/diagnostico/recurso_individuais_model.dart';
import 'package:reabilita_social/model/paciente/evolucao/evolucao_model.dart';
import 'package:reabilita_social/model/paciente/intervencoes/intervencoes_model.dart';
import 'package:reabilita_social/model/paciente/metas/meta_model.dart';
import 'package:reabilita_social/model/paciente/paciente_model.dart';
import 'package:reabilita_social/model/paciente/pactuacoes/pactuacao_model.dart';
import 'package:reabilita_social/repository/FirebaseError/firebase_error_repository.dart';
import 'package:uuid/v4.dart';

class GerenciaPacienteRepository {
  final db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> cadastrarPacienteNovo(
      DadosPacienteModel paciente, Uint8List? arquivo, String extensao, String senha) async {
    final uuid = const UuidV4().generate();

    final batch = db.batch();
    try {
      if (arquivo != null) {
        final imagesRef = storageRef.child("Pacientes/${paciente.uidDocumento}/$uuid.$extensao");
        await imagesRef.putData(arquivo);

        String imageUrl = await imagesRef.getDownloadURL();
        paciente.urlFoto = imageUrl;
      }

      final pacienteRef = db.collection("Pacientes").doc();
      paciente.uidDocumento = pacienteRef.id;
      String primeiroNome = paciente.nome.split(' ').first;

      PacienteModel pacienteModel = PacienteModel(
          dadosPacienteModel: paciente,
          diagnosticoModal: DiagnosticoModal(
              desejoModel: null,
              historiaCasoModel: null,
              doencasClinicasModel: null,
              medicacoesModel: null,
              outrasInformacoesModel: null,
              potencialidadeModel: null,
              recursoIndividuaisModel: null),
          evolucoesModel: EvolucaoModel(evolucoesModel: null),
          intervencoesModel: IntervencoesModel(intervencoesModel: null),
          listaAgendaModel: AgendaModel(listaAgendaModel: null),
          metasModel: MetaModel(metas: null),
          pactuacoesModel: ListPactuacaoModel(pactuacoesModel: null),
          url: uuid + primeiroNome);

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

  Future<void> cadastrarImagemPaciente(DadosPacienteModel paciente, Uint8List? arquivo, String extensao) async {
    final uuid = const UuidV4().generate();

    final batch = db.batch();
    try {
      if (arquivo != null) {
        final imagesRef = storageRef.child("Pacientes/${paciente.uidDocumento}/$uuid.$extensao");
        await imagesRef.putData(arquivo);

        String imageUrl = await imagesRef.getDownloadURL();
        paciente.urlFoto = imageUrl;
      }

      final pacienteRef = db.collection("Pacientes").doc(paciente.uidDocumento);

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

      return {'paciente': pacienteModel, 'uidColletion': senhaDoc.docs.first.reference.id};
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

  Future<void> excluirPaciente(String uidPaciente) async {
    try {
      db.collection("Pacientes").doc(uidPaciente).delete();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> cadastrarHistoria(
      HistoriaCasoModel historia, List<Map<Uint8List, String>> arquivos, String uidPaciente) async {
    final uuid = const UuidV4().generate();
    final batch = db.batch();

    try {
      List<String> imageUrls = [];

      for (var arquivo in arquivos) {
        Uint8List fileData = arquivo.keys.first;
        String fileExtension = arquivo.values.first;
        final imagesRef = storageRef.child("DiagnosticoMultiprofissional/$uuid.$fileExtension");
        await imagesRef.putData(fileData);
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

  Future<void> cadastrarDesejosSonhos(DesejoModel desejo, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.desejoModel': desejo.toMap(),
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

  Future<void> cadastrarMedicacoes(ListaDeMedicacoes medicacoes, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.medicacoesModel': medicacoes.toMap(),
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

  Future<void> cadastrarDoenca(ListaDoencaClinica doenca, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.doencasClinicasModel': doenca.toMap(),
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

  Future<void> cadastrarDificuldades(DificuldadePessoalModal dificuldade, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.dificuldadePessoalModel': dificuldade.toMap(),
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

  Future<void> cadastrarOutrasInformacoes(ListaOutrasInformacoes outrasInfo, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.outrasInformacoesModel': outrasInfo.toMap(),
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

  Future<void> editarOutrasInformacoes(ListaOutrasInformacoes outrasInfo, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.outrasInformacoesModel': outrasInfo.toMap(),
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

  Future<void> cadastrarMetas(MetaModel meta, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'metasModel': meta.toMap(),
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

  Future<void> cadastrarIntervencao(IntervencoesModel intervencao, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'intervencoesModel': intervencao.toMap(),
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

  Future<void> cadastrarPactuacao(ListPactuacaoModel pactuacao, String uidPaciente, PactuacaoModel pactuacaoModel,
      Uint8List image, String extensao) async {
    final batch = db.batch();
    final uuid = const UuidV4().generate();

    try {
      final imagesRef = storageRef.child("Pactuacoes/$uuid.$extensao");
      await imagesRef.putData(image);
      String imageUrl = await imagesRef.getDownloadURL();

      pactuacaoModel.foto = imageUrl;

      pactuacao.pactuacoesModel?.add(pactuacaoModel);

      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'pactuacoesModel': pactuacao.toMap(),
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

  Future<void> editarPactuacao(String uidPaciente, ListPactuacaoModel pactuacaoModel) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'pactuacoesModel': pactuacaoModel.toMap(),
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

  Future<void> cadastrarAgenda(AgendaModel agenda, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'listaAgendaModel': agenda.toMap(),
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

  Future<void> cadastrarAvaliacao(AvaliacaoModel avaliacao, String uidPaciente, ListAvaliacao avaliacaoModel,
      Uint8List image, String extensao) async {
    final batch = db.batch();
    final uuid = const UuidV4().generate();

    try {
      final imagesRef = storageRef.child("Avaliacoes/$uuid.$extensao");
      await imagesRef.putData(image);
      String imageUrl = await imagesRef.getDownloadURL();

      avaliacaoModel.foto = imageUrl;

      avaliacao.avaliacoesModel?.add(avaliacaoModel);

      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'avaliacoesModel': avaliacao.toMap(),
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

  Future<void> editarAvaliacao(AvaliacaoModel avaliacao, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'avaliacoesModel': avaliacao.toMap(),
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

  Future<void> cadastrarSonhos(DesejoModel desejo, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);
      List<Map<String, dynamic>> sonhosVidaMap = desejo.sonhoVida?.map((sonho) => sonho.toMap()).toList() ?? [];

      batch.update(pacienteRef, {
        'diagnosticoModal.desejoModel.sonhosVida': sonhosVidaMap,
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

  Future<String> cadastrarFotoDiagnostico(
      HistoriaCasoModel historia, Uint8List arquivo, String uidPaciente, String extensao) async {
    final uuid = const UuidV4().generate();
    final batch = db.batch();

    try {
      final imagesRef = storageRef.child("DiagnosticoMultiprofissional/$uuid.$extensao");
      await imagesRef.putData(arquivo);
      String imageUrl = await imagesRef.getDownloadURL();

      historia.foto!.add(imageUrl);

      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.historiaCasoModel.foto': historia.foto,
      });

      // Commit do batch
      await batch.commit();
      return imageUrl;
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> updateDiagnostico(List<DiagnosticoMultiprofissionaisModel>? diagnosticos, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      // Converte a lista de DiagnosticoMultiprofissionaisModel para uma lista de mapas
      List<Map<String, dynamic>> diagnosticosMap =
          diagnosticos?.map((diagnostico) => diagnostico.toMap()).toList() ?? [];

      batch.update(pacienteRef, {
        'diagnosticoModal.historiaCasoModel.diagnosticos': diagnosticosMap,
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

  Future<void> updateRecursoIndividual(
      List<DiagnosticoMultiprofissionaisModel>? diagnosticos, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      // Converte a lista de DiagnosticoMultiprofissionaisModel para uma lista de mapas
      List<Map<String, dynamic>> diagnosticosMap =
          diagnosticos?.map((diagnostico) => diagnostico.toMap()).toList() ?? [];

      batch.update(pacienteRef, {
        'diagnosticoModal.historiaCasoModel.diagnosticos': diagnosticosMap,
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

  Future<void> updatehistoria(String historia, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.historiaCasoModel.historia': historia,
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

  Future<void> deleteImage(List<String> fotos, String url, String uidPaciente, String caminho) async {
    final batch = db.batch();

    final storageRef = FirebaseStorage.instance.ref();
    final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

    try {
      await storageRef.child(url).delete();

      batch.update(pacienteRef, {
        caminho: '',
      });
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> cadastraRecursoIndividual(RecursoIndividuaisModel recurso, String uidPaciente) async {
    final batch = db.batch();
    Map<String, dynamic> recursoMap = recurso.toMap();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {'diagnosticoModal.recursoIndividuaisModel': recursoMap});

      // Commit do batch
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> cadastraEvolucao(EvolucaoModel evolucao, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {'evolucoesModel': evolucao.toMap()});

      // Commit do batch
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print(e);
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> cadastraHabilidades(List<Habilidades> habilidades, String uidPaciente) async {
    final batch = db.batch();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      // Converta a lista de Habilidades para uma lista de mapas
      List<Map<String, dynamic>> habilidadesMap = habilidades.map((habilidade) => habilidade.toMap()).toList();

      batch.update(pacienteRef, {
        'diagnosticoModal.recursoIndividuaisModel.habilidades': habilidadesMap,
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

  Future<void> cadastraPotencialidade(PotencialidadeModel potencialidade, String uidPaciente) async {
    final batch = db.batch();
    Map<String, dynamic> potencialidadeMap = potencialidade.toMap();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.potencialidadeModel': potencialidadeMap,
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

  Future<void> cadastraProblema(ProblemaModel problema, String uidPaciente) async {
    final batch = db.batch();
    Map<String, dynamic> problemaMap = problema.toMap();

    try {
      final pacienteRef = db.collection("Pacientes").doc(uidPaciente);

      batch.update(pacienteRef, {
        'diagnosticoModal.problemaModel': problemaMap,
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
