import 'dart:io';

import 'package:student/screens/screen_home.dart';

import '../db/functions/db_funtions.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import '../db/model/data_model.dart';

// int passId;

class editStudent extends StatefulWidget {
  editStudent({
    super.key,
    required this.passValue1,
    required this.index,
    // required Box<StudentModel> studentList
    // this.studentList,
  });
  StudentModel passValue1;
  int index;
  // final Box<StudentModel>? studentList;
  //  final Box<StudentModel> studentBox;

  @override
  State<editStudent> createState() => _editStudentState();
}
// Future<void> updateNew(StudentModel value) async {
//     final studentDB = await Hive.openBox<StudentModel>('student_db');
//     final _id = await studentDB.add(value);
//     value.id = _id;

//     studentListNotfier.value.add(value);
//     studentListNotfier.notifyListeners();
//   }

class _editStudentState extends State<editStudent> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _classController = TextEditingController();

  final _emailController = TextEditingController();

  String? imagePath;

  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
              padding:
                  EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 45),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          // AssetImage('assets/pro.jpg'),
                          imagePath == null
                              ? FileImage(File(widget.passValue1.image))
                              : FileImage(File(imagePath!))
                      //
                      ),
                  Positioned(
                    bottom: 10,
                    right: 25,
                    child: InkWell(
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onTap: () {
                        takePhoto();
                      },
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // InputBorder(borderSide:BorderSide(width: 1)),
                //
                labelText: 'Name',
                
                // hintText: '${widget.passValue1.name}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // InputBorder(borderSide:BorderSide(width: 1)),
                //
                labelText: 'Age',
                // hintText: 'Enter Your Name'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _classController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // InputBorder(borderSide:BorderSide(width: 1)),
                //
                labelText: 'Class',
                // hintText: 'Enter Your Name'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // InputBorder(borderSide:BorderSide(width: 1)),
                //
                labelText: 'Email',
                // hintText: 'Enter Your Name'
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onAddStudentButtonClicked(widget.index);
              // Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => ScreenHome()),
                  (route) => false);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(int index) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _sClass = _classController.text.trim();
    final _email = _emailController.text.trim();
    final _image = imagePath;
    final _id = DateTime.now().toString();
    if (_name.isEmpty || _age.isEmpty) {
      return;
    }
    // print('$_name $_age');

    final _student = StudentModel(
        name: _name,
        age: _age,
        sClass: _sClass,
        email: _email,
        image: imagePath!,
        id: _id);
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.putAt(index, _student);
    getAllStudents();

    // addStudent(_student);
  }

  void takePhoto() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile == null) {
      return;
    }
    setState(
      () {
        this.imagePath = PickedFile.path;
      },
    );
  }

  // final upStudent = StudentModel(
  //     name: _name,
  //     age: _age,
  //     sClass: sClass,
  //     email: email,
  //     image: image,
  //     id: id);
}
