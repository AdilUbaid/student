// import 'dart:io';
// import 'package:datalist/database/functions/db_function.dart';
// import 'package:datalist/database/models/data_model.dart';
// import 'package:datalist/screens/addscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:image_picker/image_picker.dart';

// class editScreen extends StatefulWidget {
//   final String name;
//   final String age;
//   final String adm;
//   final String? path;
//   int index;
//   editScreen(
//       {super.key,
//       required this.name,
//       required this.age,
//       required this.adm,
//       required this.path,
//       required this.index});

//   @override
//   State<editScreen> createState() => _editScreenState();
// }

// class _editScreenState extends State<editScreen> {
//   final _nameControler = TextEditingController();

//   final _ageControler = TextEditingController();

//   final _adControler = TextEditingController();
//   String? path = 'hi';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: ListView(children: [
//         CircleAvatar(
//           radius: 100,
//           backgroundImage: FileImage(File('${widget.path}')),
//         ),
//         Text(
//           'Name:${widget.name}',
//           style:
//               TextStyle(color: Color.fromARGB(234, 255, 193, 7), fontSize: 25),
//         ),
//         Text(
//           'Age:${widget.age}',
//           style:
//               TextStyle(color: Color.fromARGB(234, 255, 193, 7), fontSize: 25),
//         ),
//         Text(
//           'Ad: number:${widget.adm}',
//           style:
//               TextStyle(color: Color.fromARGB(234, 255, 193, 7), fontSize: 25),
//         ),
//         ElevatedButton(
//             onPressed: () {
//               showEditSheet(context);
//               // showBottomSheet(ctx: context);
//             },
//             child: Text('edit'))
//       ]),
//     ));
//   }

//   Future<void> showEditSheet(BuildContext ctx) async {
//     showModalBottomSheet(
//         context: ctx,
//         builder: (ctx1) {
//           return Container(
//             width: double.infinity,
//             height: 700,
//             color: const Color.fromARGB(255, 243, 229, 179),
//             child: ListView(
//               children: [
//                 Column(
//                   children: [
//                     TextField(
//                       controller: _nameControler,
//                       decoration: InputDecoration(
//                         hintText: (''),
//                         border: const OutlineInputBorder(),
//                       ),
//                     ),
//                     TextField(
//                       controller: _adControler,
//                       decoration: InputDecoration(
//                         hintText: ('admission number'),
//                         border: const OutlineInputBorder(),
//                       ),
//                     ),
//                     TextField(
//                       controller: _ageControler,
//                       decoration: InputDecoration(
//                         hintText: ('age'),
//                         border: const OutlineInputBorder(),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             onPressed: () {
//                               Navigator.of(ctx1).pop();
//                             },
//                             icon: const Icon(Icons.close),
//                             label: const Text('close'),
//                           ),
//                         ),
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             onPressed: () {
//                               setState(() {
//                                 onEditButtonClidked(widget.index);
//                                 Navigator.of(context).pushAndRemoveUntil(
//                                     MaterialPageRoute(builder: (ctx)=> AddScreen()), (route) => false);
//                               });
//                             },
//                             icon: const Icon(Icons.add),
//                             label: const Text('Done'),
//                           ),
//                         ),
//                       ],
//                     ),
//                     ElevatedButton.icon(
//                         onPressed: () async {
//                           pickImage();
//                           print('${widget.path}');
//                         },
//                         icon: Icon(Icons.image),
//                         label: Text('Add image')),
//                   ],
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   pickImage<String>() async {
//     final pickedimage = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     print('image');
//     if (pickedimage == null) {
//       print('return zero');
//       return;
//     } else {
//       print(pickedimage.path);
//       setState(() {
//         this.path = pickedimage.path;
//       });
//     }
//   }

//   Future<void> onEditButtonClidked(int index) async {
//     final _name = _nameControler.text.trim();
//     final _age = _ageControler.text.trim();
//     final _adm = _adControler.text.trim();
//     final _id = DateTime.now().toString();
//     print(path);
//     final _path = path;
//     if (_name.isEmpty || _age.isEmpty || _adm.isEmpty) {
//       return;
//     }
//     final _student =
//         StudentModel(name: _name, age: _age, adm: _adm, path: _path, id: _id);
//     final studentDB = await Hive.openBox<StudentModel>('student_db');
//     studentDB.putAt(index, _student);
//     // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AddScreen()), (route) => false);
//     getAllStudents();
//   }
// }