import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/paciente.dart';
import 'package:reabilita_social/utils/colors.dart';

class CardProjeto extends StatelessWidget {
  const CardProjeto({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PacienteScreen()));
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              const SizedBox(width: 18),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fernanda da Silva",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      color: AppColors.verde1,
                    ),
                  ),
                  Text(
                    "20 anos, depressão e ansiedade",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      color: AppColors.cinza1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
