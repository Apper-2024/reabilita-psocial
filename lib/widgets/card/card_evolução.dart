import 'package:flutter/material.dart';
import 'package:reabilita_social/utils/colors.dart';

class CardEvolucao extends StatelessWidget {
  final String nome;
  final String imageUrl;
  final void Function()? onTap;
  const CardEvolucao({super.key, required this.nome, required this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: InkWell(
        onTap:onTap,
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
                decoration:  BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(200)),
                ),
              ),
              const SizedBox(width: 18),
               Expanded(
                child: Text(
                 nome,
                  style: const TextStyle(
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
