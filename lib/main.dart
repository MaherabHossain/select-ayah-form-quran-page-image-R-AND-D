import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:yourtodo/LiveText.dart';
import 'package:yourtodo/quran_view.dart';
import 'package:yourtodo/temp_view.dart';

void main() {
  sqfliteFfiInit();
  runApp(MyApp());
}

class Todo {
  final String title;
  final bool isDone;

  Todo({
    required this.title,
    required this.isDone,
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Todo> _todos = [];

  final _textEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
      title: 'Todo App',
      home: Scaffold(
          appBar: AppBar(
            title: Text("Quran"),
          ),
         body: Container(
           decoration: BoxDecoration(
             border: Border.all(
               color: Colors.grey,
               width: 1,
             ),
             borderRadius: BorderRadius.circular(8),
             color: Colors.white,
             boxShadow: [
               BoxShadow(
                 color: Colors.grey.withOpacity(0.5),
                 spreadRadius: 2,
                 blurRadius: 5,
                 offset: Offset(0, 3),
               ),
             ],
           ),
           padding: EdgeInsets.all(16),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Column(
                 children: [
                   Container(
                     height: 100,
                     width: 100,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: NetworkImage('Product 1 Image URL'),
                         fit: BoxFit.cover,
                       ),
                       borderRadius: BorderRadius.circular(8),
                     ),
                   ),
                   SizedBox(height: 8),
                   Text(
                     'Product 1 Name',
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   SizedBox(height: 4),
                   Text(
                     'Product 1 Price',
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                       color: Colors.green,
                     ),
                   ),
                 ],
               ),
               Column(
                 children: [
                   Container(
                     height: 100,
                     width: 100,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image: NetworkImage('Product 2 Image URL'),
                         fit: BoxFit.cover,
                       ),
                       borderRadius: BorderRadius.circular(8),
                     ),
                   ),
                   SizedBox(height: 8),
                   Text(
                     'Product 2 Name',
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   SizedBox(height: 4),
                   Text(
                     'Product 2 Price',
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                       color: Colors.green,
                     ),
                   ),
                 ],
               ),
             ],
           ),
         )
        ,
         // body: Center(
         //   child: GestureDetector(
         //       onTapUp: (details) {
         //         setState(() {
         //           var _tapPosition = details.localPosition;
         //           print(_tapPosition);
         //         });
         //       },child: Image.asset("assets/page8.png")),
         // ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            log("Hello");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyWidget()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
