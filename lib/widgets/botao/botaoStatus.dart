import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  final String status;
  final bool isLoading;
  final VoidCallback onPressed;

  const StatusButton({
    super.key,
    required this.status,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: status == 'suspenso' ? Colors.green : Colors.redAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          child: Text(
            isLoading ? 'Atualizando...' : (status == 'suspenso' ? 'Reativar Usuário' : 'Suspender Usuário'),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
