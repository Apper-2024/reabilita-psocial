import 'package:flutter/material.dart';
import 'package:reabilita_social/repository/auth/auth_repository.dart';
import '../utils/colors.dart';

class Header extends StatelessWidget {
  final String imageUrl;
  final int notificationCount;

  const Header({super.key, required this.imageUrl, required this.notificationCount});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 24,
            ),
            InkWell(
              onTap: () {
                AuthRepository().signOut();
                Navigator.pushNamed(context, '/login');
              },
              child: Stack(
                children: [
                  const Icon(
                    Icons.notification_add_outlined,
                    size: 38,
                    color: preto1,
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: verde1,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '$notificationCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
