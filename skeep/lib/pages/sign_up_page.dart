import 'package:flutter/material.dart';
import 'package:skeep/pages/login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/Logo.png', width: 110),
            const SizedBox(height: 40),
            Container(
              width: 300,
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
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF311A60),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 3),
                  SizedBox(
                    width: double.infinity,
                    child: const Text(
                      'Email/Username',
                      style: TextStyle(fontSize: 12, color: Color(0xFF634795)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Enter email/username here',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
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
                  SizedBox(
                    width: double.infinity,
                    child: const Text(
                      'Password',
                      style: TextStyle(fontSize: 12, color: Color(0xFF634795)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Enter password here',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
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
                  SizedBox(
                    width: double.infinity,
                    child: const Text(
                      'Confirm Password',
                      style: TextStyle(fontSize: 12, color: Color(0xFF634795)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Re-enter password here',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF311A60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 5),
                  // Container(
                  //   width: double.infinity,
                  //   child: const Text(
                  //     'Forgot your password?',
                  //     style: TextStyle(fontSize: 12),
                  //     textAlign: TextAlign.right,
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: const Text(
                      'or continue with',
                      style: TextStyle(fontSize: 12, color: Color(0xFF311A60)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF9E79D6).withOpacity(0.4),
                            border: Border.all(
                              color: Color(0xFF634795),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'lib/assets/facebook.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF9E79D6).withOpacity(0.4),
                            border: Border.all(
                              color: Color(0xFF634795),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'lib/assets/gmail.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF9E79D6).withOpacity(0.4),
                            border: Border.all(
                              color: Color(0xFF634795),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'lib/assets/github.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Login here!",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8D47FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
