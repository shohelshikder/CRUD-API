import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

const colorRed = Color.fromRGBO(231, 28, 36, 1);
const colorGreen = Color.fromRGBO(34, 139, 34, 1);
const colorWhite = Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1);

SliverGridDelegateWithFixedCrossAxisCount ProductGridViewStyle() {
  return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, mainAxisSpacing: 2, mainAxisExtent: 250);
}

void ErrorToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colorRed,
      textColor: colorWhite,
      fontSize: 16.0);
}

void SuccessToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colorGreen,
      textColor: colorWhite,
      fontSize: 16.0);
}

ScreenBackground() {
  return SvgPicture.asset(
    'assets/images/screen-back.svg',
    alignment: Alignment.center,
    width: double.infinity,
    height: double.infinity,
    fit: BoxFit.cover,
  );
}

InputDecoration AppInputDecoration(label) {
  return InputDecoration(
      focusedBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: colorGreen, width: 1)),
      fillColor: colorWhite,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 20),
      enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: colorWhite, width: 0)),
      border: OutlineInputBorder(),
      labelText: label);
}

DecoratedBox AppDecoratedBox(child) {
  return DecoratedBox(
    decoration: BoxDecoration(
        color: colorWhite,
        border: Border.all(color: colorWhite, width: 1),
        borderRadius: BorderRadius.circular(4)),
    child: Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: child,
    ),
  );
}

ButtonStyle AppButtonStyle() {
  return ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)));
}

Ink SuccessButtonChild(buttonText) {
  return Ink(
    decoration: BoxDecoration(
        color: colorGreen, borderRadius: BorderRadius.circular(10)),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
      ),
    ),
  );
}
