


import 'package:flutter/material.dart';

class InputDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String initialvalue;
  final String conformText;
  final Function (String) onconform;
  final textcontroller = TextEditingController();
   InputDialog({super.key, required this.title, required this.subTitle, required this.onconform,  this.initialvalue='',  this.conformText='Add'});

  @override
  Widget build(BuildContext context) {
    textcontroller.text=initialvalue;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(title),
      content: TextField(controller: textcontroller,decoration: InputDecoration(label: Text(subTitle)),),
      actions: [
      SizedBox(width: double.infinity,child: ElevatedButton(onPressed:(){onconform.call(textcontroller.text);}, child:Text(conformText,style: TextStyle(fontWeight: FontWeight.bold),)))
      ],
    );
  }
}