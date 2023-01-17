import 'dart:async';
import 'package:flutter/material.dart';

class InformationPanel extends StatefulWidget {

  @override
  _InformationPanelState createState() => _InformationPanelState();
}

class _InformationPanelState extends State<InformationPanel> {

  // Timer? _timer;
  //
  // @override
  // void initState(){
  //   super.initState();
  //
  //   _timer = Timer.periodic(
  //     const Duration(seconds: 500),
  //         (Timer r) => update(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: Column(
                children: <Widget>[
                  Text("En proceso",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: 2,),
                  Text("1000.00",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              )
          ),
          Container(
              child: Column(
                children: <Widget>[
                  Text("Completados",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: 2,),
                  Text("5052.55",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  // update() {
  //   if(userData.premiumsUser.isPaied) {
  //     _voidSetState();
  //   }
  // }

  // void _voidSetState() {
  //   setState(() {
  //     print("--------------> Actualizando el Panel de Información <--------------");
  //   });
  // }
}



