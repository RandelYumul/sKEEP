import 'package:flutter/material.dart';
import 'widgets/bottom_nav.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFC4C3F5),
              ),
              // Profile Picture Circle
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // First (big) circle
                      Transform.translate(
                        offset: Offset(0, -60),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add_a_photo_rounded,
                              size: 40,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),

                      // Second (small) circle overlapping
                      Transform.translate(
                        offset: Offset(40, -25),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Profile Texts
                  Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: Offset(0, -65),
                          child: Text(
                          "John Ryan L. Valderrama",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -65),
                          child: Text(
                          "keithalmanzor@gmail.com | +63 976 428 8338",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ),
                        ),
                        // Box profile
                        Transform.translate(
                          offset: Offset(0, -40),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20)
                              )
                            ),
                            // Inside box of profile information
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  _buildRow(icon: Icons.view_list_outlined, text: "Edit profile information"),                                
                                  _buildRowwithStatus(icon: Icons.notifications_outlined, text: "Notifications", status: "On"),
                                  _buildRowwithStatus(icon: Icons.language_outlined, text: "Language", status: "English"),
                                  _buildRow(icon: Icons.security, text: "Security"),
                                  _buildRow(icon: Icons.help_outline, text: "Help & Support"),
                                  _buildRow(icon: Icons.chat_outlined, text: "Contact us"),
                                  _buildRow(icon: Icons.lock_outline, text: "Privacy policy"),
                                ],
                              ),
                            ),
                          )
                        )
                      ],
                    )
                  ),
                ],
              ),
            )
          ],
        ),
        
        ),
        bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 3),
    );
}

Widget _buildRow({required IconData icon, required String text}){
  return Padding(
    padding: EdgeInsetsGeometry.symmetric(horizontal: 0, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 25,
          color: Colors.grey[600],
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15
          ),
        )
      ],
    ),
  );
}

Widget _buildRowwithStatus ({required IconData icon, required String text, required String status}){
  return Padding(
    padding: EdgeInsetsGeometry.symmetric(horizontal: 0, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 25,
              color: Colors.grey[600],
            ),
            SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15
                ),
              )
            ],
        ),
        Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Color(0xFF8D47FF)
          ),
        ),  
      ],
    ),
  );
}
}