import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db/functions/db_funtions.dart';
import '../db/model/data_model.dart';

class FormTextField extends StatefulWidget {
  FormTextField({
    super.key,
    // required this.passValue,
    // required this.passId,
  });
  // StudentModel passValue;
  // int passId;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _classController = TextEditingController();

  final _emailController = TextEditingController();

  String? imagePath;

  // XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();
  // void initState() {
  // //   // _nameController = TextEditingController(text: widget.student.name);
  // //   // _ageController = TextEditingController(text: widget.student.age);
  // //   // _emailController = TextEditingController(text: widget.student.email);
  // //   // _phoneController = TextEditingController(text: widget.student.phone);
  //   imagePath = widget.StudentModel.image;
  // //   super.initState();
  // }

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
                            ? const AssetImage('assets/pp3.jpg')
                                as ImageProvider
                            : FileImage(File(imagePath!)),
                    // if(PickedFile == null)
                    // {
                    //    AssetImage('assets/pro.jpg')
                    // }
                    // else
                    // {
                    //   FileImage(File(imagePath))
                    // }
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
                // hintText: 'Enter Your Name'
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
              onAddStudentButtonClicked();
              Navigator.pop(context);
            },
            child: Text('save'),
          ),
        ],
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
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
    addStudent(_student);
  }

  void takePhoto() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile == null) {
      return;
    }
    setState(() {
      this.imagePath = PickedFile.path;
    });
  }
}
