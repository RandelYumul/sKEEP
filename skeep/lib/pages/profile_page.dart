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
                              padding: EdgeInsetsGeometry.all(20),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.view_list_outlined,
                                      size: 25,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                    Text(
                                      "Edit profile information",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.notifications_outlined,
                                          size: 25,
                                          color: Colors.grey[600],
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                          Text(
                                            "Notifications",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15
                                            ),
                                          )
                                        ],
                                    ),
                                    Text(
                                      "On",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Color(0xFF8D47FF)
                                      ),
                                    ),  
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.language_outlined,
                                          size: 25,
                                          color: Colors.grey[600],
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                          Text(
                                            "Language",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15
                                            ),
                                          )
                                        ],
                                    ),
                                    Text(
                                      "English",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Color(0xFF8D47FF)
                                      ),
                                    ),  
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.security,
                                      size: 25,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                    Text(
                                      "Security",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.help_outline,
                                      size: 25,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                    Text(
                                      "Help & Support",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.chat_outlined,
                                      size: 25,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                    Text(
                                      "Contact us",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.lock_outline,
                                      size: 25,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                    Text(
                                      "Privacy policy",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15
                                      ),
                                    )
                                  ],
                                ),                                
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
}