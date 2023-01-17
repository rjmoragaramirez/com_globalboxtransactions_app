import 'package:com_globalboxtransactions_app/common/components.dart';
import 'package:com_globalboxtransactions_app/data/Transfer.dart';
import 'package:com_globalboxtransactions_app/transferdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'common/funtions.dart';
import 'common/mutationsandquerys.dart';
import 'common/varsandconts.dart';
import 'data/Beneficiary.dart';

class NewTransfer_Step2 extends StatefulWidget {
  final Beneficiary beneficiary;

  const NewTransfer_Step2({required this.beneficiary});

  @override
  _NewTransfer_Step2State createState() => _NewTransfer_Step2State();
}

class _NewTransfer_Step2State extends State<NewTransfer_Step2> {
  bool amountfieldrequiredColor = false;
  bool notefieldrequiredColor = false;

  var amountValueController = TextEditingController();
  var noteValueController = TextEditingController();

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

    return GraphQLProvider(
      client: clientVN,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            txt_amontnote,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          elevation: 0.0,
          actions: <Widget>[],
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(radius)),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        child: ClipOval(
                          child: Material(
                              color: Colors.transparent,
                              child: getImageWidget(widget.beneficiary)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(widget.beneficiary.name,
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.fade),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("No. de Cuenta",
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Center(
                        child: Text(widget.beneficiary.numberAccount,
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("Email",
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Center(
                        child: Text(widget.beneficiary.email,
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("Banco",
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Center(
                        child: Text(widget.beneficiary.bank.name,
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("Código SWIFT",
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Center(
                        child: Text(widget.beneficiary.bank.swiftCode,
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(radius)),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Cantidad",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          hintText: "1050.00",
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                        ),
                        controller: amountValueController,
                        onChanged: (String value) {
                          setState(() {
                            amountfieldrequiredColor = false;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nota",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          hintText: "Regalo para tu cumpleaños!",
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          contentPadding: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 20),
                        ),
                        controller: noteValueController,
                        onChanged: (String value) {
                          setState(() {
                            notefieldrequiredColor = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Mutation(
                  options: MutationOptions(
                    document: gql(addTransfer),
                    update: (cache, result) {
                      print("Add Transfer Result = " + result!.data.toString());
                      bool success = false;

                      if (result.data != null)
                        success = extractRepositoryData(
                            "createTransfer", result.data!)['success'];

                      print("Add Transfer = " + success.toString());

                      if (success) {
                        var list = extractRepositoryDataList("transferNode", result.data!['createTransfer']);
                        print("List Count " + list.length.toString() + " Tranfers.");

                        final Transfer transfer = extractRepositoryDataTransfer("TransferNode", list[0],);

                        showToastInfo(txt_createTransfersuccess);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TransferDetail(
                              transfer: transfer,
                            ),
                          ),
                        );
                      }
                      if (!success) showToast(txt_createtransferfail);
                      SmartDialog.dismiss();
                    },
                    onCompleted: (dynamic resultData) {},
                  ),
                  builder: (RunMutation runMutation, result) {
                    return Container(
                      //margin: EdgeInsets.all(5.0),
                      padding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                      child: GestureDetector(
                        onTap: () {
                          if (amountValueController.text.isNotEmpty) {
                            runMutation({
                              'beneficiary': widget.beneficiary.id,
                              'amount': amountValueController.text,
                              'note': noteValueController.text,
                            });
                            SmartDialog.showLoading(backDismiss: false);
                          } else {
                            showToast(
                                "El valor de Monto no puede estar vacio.");
                          }
                        },
                        child: PrimaryButton(bntText: "Finalizar"),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageWidget(Beneficiary beneficiary) {
    if (beneficiary.image != "") {
      return Image.network(imageURL + beneficiary.image,
          width: 96, height: 96, fit: BoxFit.fill);
    } else {
      return Image.asset(
        'assets/images/icon_nophotopeople.png',
        width: 96,
        height: 96,
      );
    }
  }
}
