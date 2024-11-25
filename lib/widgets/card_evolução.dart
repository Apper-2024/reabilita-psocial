import 'package:flutter/material.dart';
import 'package:reabilita_social/screens/evolucao_paciente.dart';
import 'package:reabilita_social/utils/colors.dart';

class CardEvolucao extends StatelessWidget {
  const CardEvolucao({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EvolucaoPacientePage()));
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Text(
                  "Fernanda da Silva",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    color: verde1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 18),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: verde2,
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
                child: const Center(
                  child: Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
