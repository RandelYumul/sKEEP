// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
       image: DecorationImage(
         image: AssetImage('lib/assets/Opening.png'),
          fit:BoxFit.cover,
        ),
       ),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/Logo.png', width: 130,),
          const SizedBox(height: 40,),
          Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0x80F0F8FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Container(
                    width: double.infinity, 
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center, 
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity, 
                    child: const Text(
                      'Email/Username',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity, 
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Enter email/username here', 
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8), 
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity, 
                    child: const Text(
                      'Password',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.left, 
                    ),
                  ),
                  Container(
                    width: double.infinity, 
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Enter password here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
       ),
      ),
    );
  }
}