import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'globals.dart' as globals;

class Select extends StatelessWidget {
  const Select({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: ["vioo", "vioo1", "vioo2"].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: "vioo",
      icon: const Icon(Icons.arrow_downward),
      onChanged: (dynamic) {
        Fluttertoast.showToast(
          msg: dynamic.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: globals.mainColor,
          fontSize: 16.0
        );
      }
    );
  }
}