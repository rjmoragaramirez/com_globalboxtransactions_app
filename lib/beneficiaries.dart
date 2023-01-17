import 'package:com_globalboxtransactions_app/beneficiarynew_step1.dart';
import 'package:com_globalboxtransactions_app/data/Bank.dart';
import 'package:com_globalboxtransactions_app/data/Beneficiary.dart';
import 'package:com_globalboxtransactions_app/widgets/beneficiarieslist.dart';
import 'package:com_globalboxtransactions_app/widgets/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'common/funtions.dart';
import 'common/varsandconts.dart';

class Beneficiaries extends StatefulWidget {
  const Beneficiaries({Key? key}) : super(key: key);

  @override
  _BeneficiariesState createState() => _BeneficiariesState();
}

class _BeneficiariesState extends State<Beneficiaries> {
  @override
  Widget build(BuildContext context) {
    httpLink = new HttpLink("https://api.globalboxtransactions.com/graphql/",
        defaultHeaders: <String, String>{
          'Authorization': 'JWT ' + userData.token,
        });

    final ValueNotifier<GraphQLClient> clientVN = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    //SmartDialog.showLoading(backDismiss: false);

    return GraphQLProvider(
      client: clientVN,
      child: WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if (isExitWarning) {
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
            title: Text(
              txt_beneficiaries,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            elevation: 0.0,
            actions: <Widget>[
              if (maxNode > 0)
                IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 30.0,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    //_showDialogAddNode(context, clientVN);
                  },
                ),
              // IconButton(
              //   icon: Icon(Icons.settings),
              //   iconSize: 30.0,
              //   color: Theme.of(context).primaryColor,
              //   onPressed: () {
              //     //gotoSettings(userData);
              //   },
              // ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: <Widget>[
                // SizedBox(height: 5,),
                // Container(
                //   //height: 100.0,
                //   decoration: BoxDecoration(
                //       color: Theme.of(context).secondaryHeaderColor,
                //       borderRadius: BorderRadius.all(Radius.circular(radius))
                //   ),
                //   child: InformationPanel(),
                // ),
                // SizedBox(height: 5,),
                Expanded(
                  child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      //color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      ),
                    ),
                    child: BeneficiariesList(clientVN: clientVN),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              onPressed: () {
                Beneficiary bene = new Beneficiary(
                    id: "",
                    name: "",
                    numberAccount: "",
                    email: "",
                    phone: "",
                    bank: new Bank(id: "", name: "", swiftCode: ""),
                    image: "");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          BeneficiaryNew_Step1(edit: false, beneficiaryedit: bene)),
                );
              }),
          drawer: MyDrawer(),
        ),
      ),
    );
  }
}
