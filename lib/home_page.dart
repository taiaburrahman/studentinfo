import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:student_information/model_class.dart';
import 'package:student_information/my_db_helper.dart';
import 'package:student_information/re_usable_widgets/re_usable_text_field_form.dart';
import 'package:student_information/student_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  Contact? contact;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  @override
  void initState() {
    _dobController.text = '';
    super.initState();
  }

  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;

  String? groupValue;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff8FFFA9),
        centerTitle: true,
        title: Text(
          'Student Registration Form',
          style: myStyle(18, FontWeight.bold, Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Choose Your Picture =>',
                      style: myStyle(20, FontWeight.bold, Colors.black),
                    ),
                    Container(
                      height: 70,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            width: 5,
                                            color: Color(0xff8FFFA9))),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Camera',
                                              style: myStyle(
                                                  18,
                                                  FontWeight.bold,
                                                  Colors.black),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  _imageSource =
                                                      ImageSource.camera;
                                                  _getImage();
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                icon: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 35,
                                                  color: Colors.black,
                                                ))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Gallery',
                                              style: myStyle(
                                                  18,
                                                  FontWeight.bold,
                                                  Colors.black),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  _imageSource =
                                                      ImageSource.gallery;
                                                  _getImage();
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                icon: Icon(
                                                  Icons.photo_outlined,
                                                  size: 35,
                                                  color: Colors.black,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              //padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff8FFFA9)),
                              child: _imagePath == null
                                  ? Image.asset(
                                      'images/users.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(
                                        _imagePath!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Positioned(
                                right: 17,
                                top: 41,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .50,
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff8FFFA9),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ReUsableTextFieldForm(
                        text: 'Please Enter your Name',
                        controller: _nameController,
                        inputType: TextInputType.text,
                      ),
                      ReUsableTextFieldForm(
                        text: 'Please Enter Your Phone',
                        controller: _phoneController,
                        inputType: TextInputType.phone,
                      ),
                      ReUsableTextFieldForm(
                        text: 'Please Enter Your Address',
                        controller: _addressController,
                        inputType: TextInputType.text,
                      ),
                      ReUsableTextFieldForm(
                        text: "Select Date of Birth",
                        controller: _dobController,
                        inputType: TextInputType.none,
                        icon: Icon(Icons.calendar_month),
                        onTap: () {
                          _selectDate(context, _dobController);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Select Gender :',
                            style: myStyle(16, FontWeight.bold, Colors.black),
                          ),
                          Row(
                            children: [
                              Radio(
                                  activeColor: Colors.red,
                                  value: 'Male',
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value;
                                    });
                                  }),
                              Text('Male',
                                  style: myStyle(
                                      12, FontWeight.bold, Colors.black)),
                              Radio(
                                  activeColor: Colors.red,
                                  value: 'Female',
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value;
                                    });
                                  }),
                              Text('Female',
                                  style: myStyle(
                                      12, FontWeight.bold, Colors.black))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    if (widget.contact == null) {
                      await MyDbHelper.inserContact(Contact(
                          name: _nameController.text,
                          phone: _phoneController.text,
                          address: _addressController.text,
                          dob: _dobController.text,
                          gender: groupValue.toString(),
                          images: _imagePath.toString()));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudentList()));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff8FFFA9)),
                    child: Text(
                      'Register',
                      style: myStyle(16, FontWeight.bold, Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(
    BuildContext context,
    TextEditingController _dobController,
  ) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1995),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
      setState(() {
        _dobController.text = formattedDate.toString();
      });
    }
  }

  void _getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: _imageSource);
    if (selectedImage != null) {
      setState(() {
        _imagePath = selectedImage.path;
      });
    }
  }
}

myStyle(double size, FontWeight weight, Color clr) {
  return TextStyle(fontSize: size, fontWeight: weight, color: clr);
}
