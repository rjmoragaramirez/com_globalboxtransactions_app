import 'package:com_globalboxtransactions_app/common/components.dart';
import 'package:flutter/material.dart';

class OldTransferDetail extends StatefulWidget {
  const OldTransferDetail({Key? key}) : super(key: key);

  @override
  _OldTransferDetailState createState() => _OldTransferDetailState();
}

class _OldTransferDetailState extends State<OldTransferDetail> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
          child: Text("GNode Guardian",
            style: Theme.of(context).textTheme.headline1,
          )
      ),
      children: <Widget>[
        Container(
            child:
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/icon.png"),
              backgroundColor: Colors.black,
              minRadius: 20,
              maxRadius: 120,
            )
        ),
        Center(
          child: Text("v1.0.0",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 20,),
        Center(
          child: Text("Developers",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 8,),
        Center(
          child: Text("Kevin Pérez Mandina",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 2,),
        Center(
          child: Text("Computer Science Engineer",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 2,),
        Center(
          child: Text("hunterbladek@gmail.com",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 8,),
        Center(
          child: Text("Rubén J Moraga Ramírez",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 2,),
        Center(
          child: Text("Developer, Investor and Networker",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 2,),
        Center(
          child: Text("rjmoragaramirez@gmail.com",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 20,),
        Center(
          child: Text("GNode Guardian®",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Center(
          child: Text("All rights reserved.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 20,),
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: OutlineBnt(bntText: "OK"),
        )
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.grey.shade900,
      titlePadding: EdgeInsets.only(top: 20),
      contentPadding: EdgeInsets.all(10),
    );
  }
}
