import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/administrador/detalheAdministrador.dart';

class CardProfissionaisAdm extends StatelessWidget {
  final String nome;
  final String email;
  final String telefone;
  final String urlFoto;
  final String status;
  final String uidDocumento;
  final String tipoUsuario; // Adicionado tipoUsuario
  final VoidCallback onTap;

  const CardProfissionaisAdm({
    super.key,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.urlFoto,
    required this.status,
    required this.uidDocumento,
    required this.tipoUsuario, // Recebe o tipoUsuario
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheAdministrador(
              uidDocumento: uidDocumento,
              userType: tipoUsuario, // Passa o tipoUsuario correto
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Foto
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  urlFoto,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person,
                        size: 60, color: Colors.grey);
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Informações principais
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nome,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(email,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                    Text(telefone,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                    Text(
                        'Tipo: ${tipoUsuario.toUpperCase()}'), // Mostra o tipoUsuario
                  ],
                ),
              ),
              // Status
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: _getStatusColor(status),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'analise':
      return Colors.orangeAccent;
    case 'ativo':
      return Colors.greenAccent;
    case 'recusada':
      return Colors.redAccent;
    case 'suspenso':
      return Colors.grey;
    default:
      return Colors.blueGrey;
  }
}
