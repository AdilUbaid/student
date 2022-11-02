import 'dart:io';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:student/db/functions/db_funtions.dart';
import 'package:student/screens/viewEdit.dart';
// import 'package:student/widget/deleteAlertBox.dart';

import '../db/model/data_model.dart';

// var gData;

class ListViewStudent extends StatefulWidget {
  const ListViewStudent({super.key});

  @override
  State<ListViewStudent> createState() => _ListViewStudentState();
}

class _ListViewStudentState extends State<ListViewStudent> {
  bool alertVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: studentListNotfier,
          builder: (
            BuildContext ctx,
            List<StudentModel> studentList,
            Widget? child,
          ) {
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                final Box<StudentModel> studentBox;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(data.image)),
                    // backgroundColor: Colors.greenAccent[400],
                    radius: 20,
                  ),
                  title: Text("Name : ${data.name}"),
                  // subtitle: Text("Age :${data.age}"),
                  onTap: () {
                    if (index != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewEdit(
                                passId: index,
                                passValue: data,

                                // studentList:studentBox
                              )));
                    } else {
                      print('student id is null unable to access ');
                    }
                    // print(''index);
                  },
                  trailing: IconButton(
                      onPressed: () {
                        alertDelete(ctx, index);
                        //  const DeleteAlert();
                        // setState(() {
                        //   alertVisibility = true;
                        // });
                        // if (index != null) {
                        //   deleteStudent(index);
                        // } else {
                        //   print('student id is null unable to delete ');
                        // }
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: studentList.length,
            );
          },

          // return Scaffold(
          //   body: SafeArea(
          //     child:
          //   ),
        ),
        // Visibility(
        //   visible: alertVisibility,
        //   child: const DeleteAlert(),
        // ),
      ],
    );
  }

  alertDelete(BuildContext ctx, index) {
    showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            // title: Text('Delete'),
            content: Text('Do you want to permanently delete the user ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (index != null) {
                    deleteStudent(index);
                    Navigator.pop(ctx);
                  } else {
                    print('student id is null unable to delete ');
                  }
                },
                child: const Text('Delete'),
              ),
            ],
          );
        });
  }
}
