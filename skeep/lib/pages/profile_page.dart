import 'package:flutter/material.dart';
import 'widgets/bottom_nav.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 3),
    );
}
}