import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reabilita_social/enum/enum_tipo_usuario.dart';
import 'package:reabilita_social/model/profissional/profissional_model.dart';
import 'package:reabilita_social/model/usuario_model.dart';
import 'package:reabilita_social/repository/FirebaseError/firebase_error_repository.dart';

class GerenciaProfissionalRepository {
  final db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future<ProfissionalModel> buscaProfissional(String uid) async {
    try {
      print('Buscando profissional com UID: $uid');
      final unidadeDoc = await db.collection('Profissionais').doc(uid).get();

      // Verificando se o documento existe
      if (unidadeDoc.exists) {
        print('Documento encontrado, processando dados...');
        final data = unidadeDoc.data()!;

        // Verificando os dados antes de criar o modelo
        print('Dados do profissional: $data');

        // Verificando cada campo para garantir que não esteja nulo
        print('Nome: ${data['nome']}');
        print('Email: ${data['email']}');
        print('Telefone: ${data['telefone']}');
        print('Gênero: ${data['genero']}');
        print('CPF: ${data['cpf']}');
        print('Raça: ${data['raça']}');
        print('Profissão: ${data['profissao']}');
        print('Local de Trabalho: ${data['localTrabalho']}');
        print('Endereço: ${data['endereco']}');
        print('Tipo de Usuário: ${data['tipoUsuario']}');
        print('Status de Conta: ${data['statusConta']}');
        print('URL da Foto: ${data['urlFoto']}');
        print('Data de Nascimento: ${data['dataNascimento']}');
        print('UID Profissional: ${data['uidProfissional']}');

        // Criando o modelo com os dados obtidos
        return ProfissionalModel.fromMap(data);
      } else {
        print('Documento não encontrado para o UID: $uid');
        throw 'Profissional não encontrado.';
      }
    } on FirebaseException catch (e) {
      print('Erro FirebaseException: $e');
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      print('Erro inesperado: $e');
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> criaProfissional(UserCredential usuario,
      ProfissionalModel profissional, Uint8List arquivo) async {
    WriteBatch batch = db.batch();
    try {
      // Cria o modelo de usuário
      UsuarioModel usuarioModel = UsuarioModel(
        uid: usuario.user!.uid,
        email: usuario.user!.email!,
        tipoUsuario: EnumTipoUsuario.profissional.name,
      );
      profissional.uidProfissional = usuario.user!.uid;

      // Upload da imagem
      final imagesRef =
          storageRef.child("Profissionais/${profissional.uidProfissional}.jpg");
      await imagesRef.putData(arquivo);

      // Obtém a URL da imagem
      String imageUrl = await imagesRef.getDownloadURL();
      profissional.urlFoto = imageUrl;

      // Adiciona as operações ao batch
      batch.set(db.collection("Profissionais").doc(usuario.user!.uid),
          profissional.toMap());
      batch.set(db.collection("Usuarios").doc(usuario.user!.uid),
          usuarioModel.toMap());

      // Comita o batch
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }

  Future<void> atualizaProfissional(
      ProfissionalModel profissional, Uint8List? arquivo) async {
    WriteBatch batch = db.batch();
    try {
      String? imageUrl;

      // Atualiza a imagem apenas se um novo arquivo for fornecido
      if (arquivo != null) {
        final imagesRef = storageRef
            .child("Profissionais/${profissional.uidProfissional}.jpg");
        await imagesRef.putData(arquivo);
        imageUrl = await imagesRef.getDownloadURL();
        profissional.urlFoto = imageUrl;
      }

      // Adiciona as operações ao batch
      batch.update(
          db.collection("Profissionais").doc(profissional.uidProfissional),
          profissional.toMap());

      // Comita o batch
      await batch.commit();
    } on FirebaseException catch (e) {
      throw FirebaseErrorRepository.handleFirebaseException(e);
    } catch (e) {
      throw 'Ops, algo deu errado. Tente novamente mais tarde!';
    }
  }
}
