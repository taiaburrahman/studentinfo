import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_information/home_page.dart';
import 'package:student_information/model_class.dart';
import 'package:student_information/my_db_helper.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff8FFFA9),
        centerTitle: true,
        title: Text(
          'Student List',
          style: myStyle(18, FontWeight.bold, Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: MyDbHelper.readContact(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Loading.........')
                ],
              ),
            );
          }

          return snapshot.data!.isEmpty
              ? Center(
                  child: Image.asset(
                  'images/nodata.png',
                  fit: BoxFit.fitHeight,
                ))
              : ListView(
                  children: snapshot.data!.map((e) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              width: 5,
                                              color: Color(0xff8FFFA9))),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Are you want to delete?',
                                            style: myStyle(18, FontWeight.bold,
                                                Colors.black),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                  },
                                                  child: Text('Cancel')),
                                              TextButton(
                                                  onPressed: () async {
                                                    await MyDbHelper
                                                        .deleteContact(e.id!);
                                                    setState(() {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                    });
                                                  },
                                                  child: Text('Delete')),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                          },
                          child: ListTile(
                              tileColor: Color(0xff8FFFA9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 50,
                                  backgroundImage: FileImage(File(e.images))),
                              title: Text('${e.name} DOB:${e.dob}',
                                  style: myStyle(
                                      14, FontWeight.bold, Colors.black)),
                              subtitle: Text(
                                'Phone:${e.phone} Gender:${e.gender}',
                                style:
                                    myStyle(14, FontWeight.normal, Colors.grey),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  // await MyDbHelper.deleteContact(e.id!);
                                  // setState(() {});
                                },
                                icon: Icon(
                                  Icons.update,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
          setState(() {});
        },
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Color(0xff8FFFA9),
      ),
    );
  }
}
