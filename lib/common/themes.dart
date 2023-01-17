import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light
);

ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xff00ac12),
    secondaryHeaderColor: Color(0xff232b2d),
    backgroundColor: Color(0xff000000),
    hintColor: Color(0xffff0000),
    cardColor: Color(0xffbbbbbb),
    fontFamily: "Montserrat",
    textTheme: TextTheme(
    //Texto
      headline1: TextStyle(color: Color(0xff00ac12), fontSize: 28, fontWeight: FontWeight.bold),
      headline2: TextStyle(color: Color(0xff00ac12), fontSize: 22),
      headline3: TextStyle(color: Color(0xff00ac12), fontSize: 18),
      headline4: TextStyle(color: Color(0xfffafafa), fontSize: 14),
      headline6: TextStyle(color: Color(0xff000000), fontSize: 18),
      bodyText1: TextStyle(color: Color(0xfffafafa), fontSize: 18),
      bodyText2: TextStyle(color: Color(0xffd4d4d4), fontSize: 12, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(color: Color(0xffd4d4d4), fontSize: 12),
      subtitle2: TextStyle(color: Color(0xfffafafa), fontSize: 14, fontWeight: FontWeight.bold),
      //Botones
      button: TextStyle(color: Color(0xff00ac12), fontSize: 18, fontWeight: FontWeight.bold),
      headline5: TextStyle(color: Color(0xff00ac12), fontSize: 18, fontWeight: FontWeight.bold),
      caption: TextStyle(color: Color(0xff000000), fontSize: 18, fontWeight: FontWeight.bold),
    )
);

