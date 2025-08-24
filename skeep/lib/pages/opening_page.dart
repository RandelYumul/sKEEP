import 'package:flutter/material.dart';
import 'login_page.dart';

class OpeningPage extends StatefulWidget{
  const OpeningPage({super.key});

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage>
      with SingleTickerProviderStateMixin {
    late AnimationController _controller;
    late Animation<double> _animation;

    @override
    void initState() {
      super.initState();

      _controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      )..forward();

      _animation = CurvedAnimation(
        parent: _controller, 
        curve: Curves.easeIn,
        );

      Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
    }

@override
  void dispose() {
    _controller.dispose(); // clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/Opening.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation, 
            child: Image.asset(
              'lib/assets/Logo.png',
              width: 500,
            ),
          ),
        ),
      ),
    );
  }
}