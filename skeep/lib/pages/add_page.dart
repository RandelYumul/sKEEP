import 'package:flutter/material.dart';
import 'widgets/bottom_nav.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _prodname = TextEditingController();
  final TextEditingController _prodsupp = TextEditingController();
  final TextEditingController _prodprice = TextEditingController();
  final TextEditingController _produnit = TextEditingController();
  final TextEditingController _prodquantity = TextEditingController();
  String savedproname = "";
  String savedsupp = "";
  int savedprice = 0;
  String savedunit = "";
  int savedquantity = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        color: const Color(0xFFC4C3F5),
        child: Center(
          child: Container(
          height: MediaQuery.of(context).size.height * 0.67,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4)
              )
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(20)
            )
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Add Product",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                
                Center(
                  child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4)
                      )
                    ]
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add_a_photo,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Product Name",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 1,
                  child: TextField(
                    controller: _prodname,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter product name here...",
                      hintStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Supplier",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 1,
                  child: TextField(
                    controller: _prodsupp,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter supplier here...",
                      hintStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Price",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 1,
                  child: TextField(
                    controller: _prodprice,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter price here...",
                      hintStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Unit",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.015,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.32,
                        child: TextField(
                          controller: _produnit,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.015,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: "0",
                            hintStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.015,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.015,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.32,
                      child: TextField(
                        controller: _prodquantity,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.015,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      ),
                      ],
                    )
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height * 0.015,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        savedproname = _prodname.text;
                        savedsupp = _prodsupp.text;
                        savedprice = int.tryParse (_prodprice.text)?? 0;
                        savedunit = _produnit.text;
                        savedquantity = int.tryParse (_prodquantity.text)?? 0;
                        print("$savedproname, $savedsupp, $savedprice, $savedunit, $savedquantity");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF634795),
                      ),
                      child: Text("Save",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.015,
                        color: Colors.white
                      ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }
}
