import 'package:com_globalboxtransactions_app/beneficiaries.dart';
import 'package:com_globalboxtransactions_app/common/components.dart';
import 'package:com_globalboxtransactions_app/common/funtions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'beneficiarynew_step1.dart';
import 'common/mutationsandquerys.dart';
import 'common/varsandconts.dart';
import 'data/Beneficiary.dart';

class BeneficiaryDetail extends StatefulWidget {
  final Beneficiary beneficiary;

  const BeneficiaryDetail({required this.beneficiary});

  @override
  _BeneficiaryDetailState createState() => _BeneficiaryDetailState();
}

class _BeneficiaryDetailState extends State<BeneficiaryDetail> {

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
          title: Text(txt_beneficiarydetail,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
          elevation: 0.0,
          actions: <Widget>[
          ],
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(radius)
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 128,
                        height: 128,
                        child: ClipOval(
                          child: Material(
                              color: Colors.transparent,
                              child: getImageWidget(widget.beneficiary)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          widget.beneficiary.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Email:",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        widget.beneficiary.email,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "No. de cuenta:",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        widget.beneficiary.numberAccount,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Teléfono:",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        widget.beneficiary.phone,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Banco:",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        widget.beneficiary.bank.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle2,
                        overflow: TextOverflow.fade,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "SWIFT:",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        widget.beneficiary.bank.swiftCode,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(radius)
                ),
                child: Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showDialogBeneficiaryDelete(context, widget.beneficiary, clientVN);
                        },
                        child: RedOutlineBnt(bntText: "Eliminar"),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BeneficiaryNew_Step1(edit: true, beneficiaryedit: widget.beneficiary),
                            ),
                          );
                        },
                        child: OutlineBnt(bntText: "Editar"),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: PrimaryButton(bntText: "Back"),
                      )
                    ],
                  ),
                ),
              ),
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

void _showDialogBeneficiaryDelete(BuildContext context, Beneficiary beneficiary,
    ValueNotifier<GraphQLClient> clientVM) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return GraphQLProvider(
          client: clientVM,
          child: SimpleDialog(
            title: Center(
                child: Text(
                  "Eliminar Beneficiario",
                  style: Theme.of(context).textTheme.headline3,
                )),
            children: <Widget>[
              Center(
                child: Text(
                  "¿Desea eliminar a " +
                      beneficiary.name +
                      " de su lista de beneficiarios?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Mutation(
                  options: MutationOptions(
                      document: gql(delBeneficiary),
                      update: (cache, result) {
                        print("Result deleteBeneficiary = " +
                            result!.data.toString());
                        if (result.data != null) {
                          bool success = extractRepositoryData(
                              "deleteBeneficiary", result.data!)['success'];
                          if (success) {
                            showToastInfo("Se ha eliminado a " +
                                beneficiary.name +
                                " de su lista de beneficiarios.");
                            // Navigator.pop(context);
                            // Navigator.pop(context);
                            var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                new Beneficiaries());
                            Navigator.of(context).push(route);

                            print("route - Beneficiaries");
                          } else {
                            showToast("Error, please try again!");
                          }
                        }

                        if (result.data == null) {
                          showToast("Error, please try again!");
                        }

                        SmartDialog.dismiss();
                      },
                      onCompleted: (dynamic resultaData) {}),
                  builder: (RunMutation runMutation, result) {
                    return Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                SmartDialog.showLoading(backDismiss: false);
                                print("ID Beneficiary " +
                                    beneficiary.id +
                                    " to delete.");
                                runMutation({'id': beneficiary.id});
                              },
                              child: PrimaryButton(bntText: "Eliminar"),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: OutlineBnt(bntText: "Cancel"),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            titlePadding: EdgeInsets.only(top: 20),
            contentPadding: EdgeInsets.all(20),
          ),
        );
      },
      barrierDismissible: true);
}