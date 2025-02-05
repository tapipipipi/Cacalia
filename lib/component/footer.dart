import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // グラデーション背景
        Container(
          height: 80, // BottomNavigationBarの高さに合わせる
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(17, 90, 132, 1),
                Color.fromRGBO(40, 158, 225, 1)
              ], // グラデーション色
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  context.go('/home');
                },
                icon: const Icon(Icons.home),
                iconSize: 40,
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  context.go('/timeLine');
                },
                icon: const Icon(Icons.ballot_rounded),
                iconSize: 40,
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  context.go('/setting');
                },
                icon: const Icon(Icons.person),
                iconSize: 40,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
