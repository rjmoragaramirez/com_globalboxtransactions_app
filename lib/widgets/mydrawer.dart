
import 'package:com_globalboxtransactions_app/beneficiaries.dart';

import 'package:com_globalboxtransactions_app/common/funtions.dart';
import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:com_globalboxtransactions_app/kyc.dart';
import 'package:com_globalboxtransactions_app/transfers.dart';
import 'package:flutter/material.dart';

import '../profile.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).secondaryHeaderColor,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black
                  // image: DecorationImage(
                  //     image: NetworkImage(imageURL + userData.profileImage.toString()),
                  //     fit: BoxFit.cover
                  // )
              ),
              accountName: Text("John Doe",
              //Text(kycData.firtsName + " " + kycData.lastName,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              accountEmail: Text(userData.username,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              currentAccountPicture: GestureDetector(
                onTap: () =>
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (_) => Profile(),
                    ),
                    ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageURL + userData.profileImage.toString()),
                ),
              ),
              onDetailsPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (_) => Profile(),
                    ),
                    );
              },
            ),
            new ListTile(
              title: new Text("Transferencias", style: Theme.of(context).textTheme.subtitle2,),
              leading : new Image.asset('assets/images/icon_transferencia_movil.png', width: 50, height: 50,),
              //new Icon(Icons.list, color: Theme.of(context).primaryColor,),
              onTap: () =>
                  Navigator.push(
                    context, MaterialPageRoute(
                    builder: (_) => Transfers(),
                    ),
                  ),
            ),
            new ListTile(
              title: new Text("Beneficiarios", style: Theme.of(context).textTheme.subtitle2,),

              leading: new Image.asset('assets/images/icon_familia.png', width: 50, height: 50,),
              //new Icon(Icons.supervised_user_circle_rounded, color: Theme.of(context).primaryColor,),
              onTap: () =>
                  Navigator.push(
                    context, MaterialPageRoute(
                    builder: (_) => Beneficiaries(),
                  ),
                  ),
            ),
            // new ListTile(
            //   title: new Text("Perfil", style: Theme.of(context).textTheme.headline4,),
            //   leading: new Icon(Icons.person, color: Theme.of(context).primaryColor,),
            //   onTap: () =>
            //       Navigator.push(
            //         context, MaterialPageRoute(
            //         builder: (_) => Profile(),
            //       ),
            //       ),
            // ),
            new ListTile(
              title: new Text("Verificación de Identidad", style: Theme.of(context).textTheme.subtitle2,),
              leading: new Image.asset('assets/images/icon_kyc.png', width: 50, height: 50,),
              // new Icon(Icons.document_scanner, color: Theme.of(context).primaryColor,),
              onTap: () =>
                  Navigator.push(
                    context, MaterialPageRoute(
                    builder: (_) => KYC(),
                  ),
                  ),
            ),
            // new ListTile(
            //   title: new Text("Configuración", style: Theme.of(context).textTheme.headline4,),
            //   leading: new Icon(Icons.settings, color: Theme.of(context).primaryColor,),
            //   // onTap: () =>
            //   //     Navigator.push(
            //   //       context, MaterialPageRoute(
            //   //       builder: (_) => Payment(),
            //   //     ),
            //   //     ),
            // ),
            Divider(height: 0.5, color: Colors.white70,),
            new ListTile(
              title: new Text("Salir", style: Theme.of(context).textTheme.subtitle2,),
              leading: new Image.asset('assets/images/icon_exit.png', width: 50, height: 50,),
            )
          ],
        ),
      ),
    );
  }
}