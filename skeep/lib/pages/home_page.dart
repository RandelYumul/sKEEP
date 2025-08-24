import 'package:flutter/material.dart';
import 'package:skeep/pages/login_page.dart';
import 'widgets/bottom_nav.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        extendBody: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Image.asset(
                'lib/assets/Logo.png',
                width: 500,
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      );
    }
  }