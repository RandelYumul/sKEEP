import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/add_product_validation.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/add_product_validation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final ImagePicker _picker = ImagePicker(); 
  final TextEditingController _prodname = TextEditingController();
  final TextEditingController _prodsupp = TextEditingController();
  final TextEditingController _prodprice = TextEditingController();
  final TextEditingController _produnit = TextEditingController();
  final TextEditingController _prodquantity = TextEditingController();
  String savedproname = "";
  String savedsupp = "";
  double savedprice = 0;
  String savedunit = "";
  int savedquantity = 0;
  File? _selectedImage;

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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Title
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Add Product",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Image Picker
                  Center(
                    child: GestureDetector(
                      onTap: _pickImageFromGallery,
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
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: _selectedImage != null
                              ? Image.file(
                                  _selectedImage!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.grey[600],
                                ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  
                  // Product Details Form
                  Expanded(
                    child: 
                      ListView(
                        shrinkWrap: true,
                        children: [
                          // Product Name
                          FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Product Name",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.015,
                                fontWeight: FontWeight.bold,
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
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          
                          // Supplier
                          FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Supplier",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.015,
                                fontWeight: FontWeight.bold,
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
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          
                          // Price
                          FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Price",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.height * 0.015,
                                fontWeight: FontWeight.bold,
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
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                           
                          // Unit and Quantity
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
                                        fontSize:
                                            MediaQuery.of(context).size.height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.04,
                                    width: MediaQuery.of(context).size.width * 0.32,
                                    child: TextField(
                                      controller: _produnit,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Enter unit here...",
                                        hintStyle: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.height *
                                              0.015,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
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
                                        fontSize:
                                            MediaQuery.of(context).size.height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.04,
                                    width: MediaQuery.of(context).size.width * 0.32,
                                    child: TextField(
                                      controller: _prodquantity,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "0",
                                        hintStyle: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.height *
                                              0.015,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
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
                            ],
                          ),
                          
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        ],
                      ),
                  ),

                  // Save and Cancel Buttons
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
                            fontSize:
                                MediaQuery.of(context).size.height * 0.015,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        // onPressed: () {
                        //   savedproname = _prodname.text;
                        //   savedsupp = _prodsupp.text;
                        //   savedprice = double.tryParse(_prodprice.text) ?? 0;
                        //   savedunit = _produnit.text;
                        //   savedquantity = int.tryParse(_prodquantity.text) ?? 0;
                        //   print(
                        //     "$savedproname, $savedsupp, $savedprice, $savedunit, $savedquantity",
                        //   );
                        // },
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddProductValidation();
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF634795),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.015,
                            color: Colors.white,
                          ),
                        ),
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

  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final returnedImage = await _picker.pickImage(source: ImageSource.gallery);
    
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }
}
