import 'package:flutter/material.dart';
import 'package:skeep/pages/home_page.dart';
import 'sign_up_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: (MediaQuery.of(context).size.height * 0.07).clamp(1, 600)),
              Image.asset('lib/assets/Logo.png', width: (MediaQuery.of(context).size.width * 0.3).clamp(50.0, 100.0)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0x80F0F8FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF311A60),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                    const Text(
                      'Email/Username',
                      style: TextStyle(fontSize: 12, color: Color(0xFF634795)),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Enter email/username here',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: MediaQuery.of(context).size.width * 0.02,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 12, color: Color(0xFF634795)),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Enter password here',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: MediaQuery.of(context).size.width * 0.02,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          String username = _usernameController.text.trim();
                          if (username.isEmpty) username = "Guest";
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(username: username)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF311A60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(fontSize: 12, color: Color(0xFF8D47FF)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'or continue with',
                        style: TextStyle(fontSize: 12, color: Color(0xFF311A60)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF9E79D6).withOpacity(0.4),
                              border: Border.all(color: const Color(0xFF634795), width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('lib/assets/facebook.png', fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF9E79D6).withOpacity(0.4),
                              border: Border.all(color: const Color(0xFF634795), width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('lib/assets/gmail.png', fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF9E79D6).withOpacity(0.4),
                              border: Border.all(color: const Color(0xFF634795), width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('lib/assets/github.png', fit: BoxFit.contain),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06.clamp(0.01, 0.02)),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Don't have an account yet?",
                            style: TextStyle(fontSize: (MediaQuery.of(context).size.width * 0.025).clamp(3.0, 10.0)),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpPage()),
                              );
                            },
                            child: Text(
                              "Register here!",
                              style: TextStyle(
                                fontSize: (MediaQuery.of(context).size.width * 0.025).clamp(3.0, 10.0),
                                color: Color(0xFF8D47FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
