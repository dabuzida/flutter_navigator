import 'package:flutter/material.dart';

InputDecoration customInputDecoration({String? hint}) {
  return InputDecoration(
    //contentPadding: const EdgeInsets.all(10.0),
    filled: true,
    fillColor: Colors.grey[100],
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    //focusedBorder: OutlineInputBorder.,
    border: OutlineInputBorder(),
    //border: InputBorder.none,
    // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), gapPadding: 0.0),
    // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.green), gapPadding: 0.0),
    hintText: hint,
  );
}
