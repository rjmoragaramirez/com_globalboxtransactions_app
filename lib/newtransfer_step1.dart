import 'package:com_globalboxtransactions_app/widgets/beneficiariesitem.dart';
import 'package:com_globalboxtransactions_app/widgets/beneficiariesitemdetail.dart';
import 'package:com_globalboxtransactions_app/widgets/beneficiarieslisttoselect.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'common/funtions.dart';
import 'common/mutationsandquerys.dart';
import 'common/varsandconts.dart';
import 'data/Beneficiary.dart';

class NewTransfer_Step1 extends StatefulWidget {
  const NewTransfer_Step1({Key? key}) : super(key: key);

  @override
  _NewTransfer_Step1State createState() => _NewTransfer_Step1State();
}

class _NewTransfer_Step1State extends State<NewTransfer_Step1> {
  @override
  Widget build(BuildContext context) {

    httpLink = new HttpLink(
        "https://api.globalboxtransactions.com/graphql/", defaultHeaders: <String, String>{
      'Authorization': 'JWT ' + userData.token,
    });

    final ValueNotifier<GraphQLClient> clientVN = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return GraphQLProvider(
      client: clientVN,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(txt_selbeneficiaries,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          elevation: 0.0,
          actions: <Widget>[
          ],
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Container(
            //height: 100.0,
            decoration: BoxDecoration(
              //color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
            ),
            child: BeneficiariesListToSelect(clientVN: clientVN),
          ),
        ),
      ),
    );
  }
}
