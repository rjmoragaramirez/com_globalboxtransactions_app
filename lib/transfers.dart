import 'package:com_globalboxtransactions_app/newtransfer_step1.dart';
import 'package:com_globalboxtransactions_app/widgets/favoritebeneficiaries.dart';
import 'package:com_globalboxtransactions_app/widgets/mydrawer.dart';
import 'package:com_globalboxtransactions_app/widgets/transferslist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'common/funtions.dart';
import 'common/varsandconts.dart';

class Transfers extends StatefulWidget {
  const Transfers({Key? key}) : super(key: key);

  @override
  _TransfersState createState() => _TransfersState();
}

class _TransfersState extends State<Transfers> {
  @override
  Widget build(BuildContext context) {

    final ValueNotifier<GraphQLClient> clientVN = ValueNotifier(
      GraphQLClient(
        link: getAuthLink(),
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return GraphQLProvider(
      client: clientVN,
      child: WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if(isExitWarning){
            showToastInfo("Press back again to exit!");
            return false;
          } else {
            SystemNavigator.pop();
            Fluttertoast.cancel();

            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(txt_tranfers,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            elevation: 0.0,
            actions: <Widget>[
              if(maxNode > 0) IconButton(
                icon: Icon(Icons.add),
                iconSize: 30.0,
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  //_showDialogAddNode(context, clientVN);
                },
              ),
              // IconButton(
              //   icon: Icon(Icons.settings),
              //   iconSize: 30.0,
              //   color: Theme.of(context).primaryColor,
              //   onPressed: (){
              //     //gotoSettings(userData);
              //   },
              // ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/images/business-intelligence-1.png"),
                  Text("Beneficiarios favoritos"),
                  Container(
                      height: 150,
                      child: FavoriteBeneficiaries(clientVN: clientVN)),
                  const SizedBox(height: 2,),
                  TransfersList(clientVN: clientVN),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Theme.of(context).primaryColor,),
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewTransfer_Step1(),
                  ),
                ),
          ),
          drawer: MyDrawer(),
        ),
      ),
    );
  }
}
