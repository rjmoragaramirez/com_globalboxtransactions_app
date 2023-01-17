import 'package:com_globalboxtransactions_app/common/components.dart';
import 'package:com_globalboxtransactions_app/common/funtions.dart';
import 'package:com_globalboxtransactions_app/data/Transfer.dart';
import 'package:com_globalboxtransactions_app/transfers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common/mutationsandquerys.dart';
import 'common/varsandconts.dart';
import 'data/Beneficiary.dart';

class TransferDetail extends StatefulWidget {
  final Transfer transfer;

  const TransferDetail({required this.transfer});

  @override
  _TransferDetailState createState() => _TransferDetailState();
}

class _TransferDetailState extends State<TransferDetail> {
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
      child: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Transfers(),
            ),
          );
          return true;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(
              txt_transferdetail,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            elevation: 0.0,
            actions: <Widget>[],
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(margingcomponents),
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(radius)),
                  child: Column(
                    children: [
                      Container(
                        width: 128,
                        height: 128,
                        child: ClipOval(
                          child: Material(
                              color: Colors.transparent,
                              child:
                                  getImageWidget(widget.transfer.beneficiary)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(widget.transfer.beneficiary.name,
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
                        child: Text(widget.transfer.beneficiary.numberAccount,
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
                        child: Text(widget.transfer.beneficiary.email,
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
                        child: Text(widget.transfer.beneficiary.bank.name,
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
                        child: Text(widget.transfer.beneficiary.bank.swiftCode,
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("Monto",
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Center(
                        child: Text(moneyFormatter(widget.transfer.amount),
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("Nota",
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Center(
                        child: Text(widget.transfer.note,
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("Fecha",
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Center(
                        child: Text(getTime(widget.transfer.date).toString(),
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("Estado",
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Center(
                        child: Text(widget.transfer.status,
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                if(widget.transfer.status != "CANCELED") Container(
                  margin: EdgeInsets.all(5.0),
                  padding:
                      EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(radius)),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            launch(widget.transfer.paymentLink);
                          },
                          child: PrimaryButton(
                            bntText: "Pagar ahora!",
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                          onTap: () async {
                            final urlPreview = widget.transfer.paymentLink;
                            await Share.share(
                                'GlobalBox – Comparta este enlace de pago con su familiar o amigo.\n\n $urlPreview');
                          },
                          child: PrimaryButton(
                            bntText: "Compartir Enlace",
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Mutation(
                        options: MutationOptions(
                          document: gql(cancelTranfer),
                          update: (cache, result){
                            print("Cancel Transfer Result = " + result!.data.toString());
                            bool success = false;

                            if (result.data != null)
                              success = extractRepositoryData(
                                  "updateTransfer", result.data!)['success'];

                            print("Cancel Transfer = " + success.toString());

                            if (success) {
                              showToastInfo(txt_cancelTransfersuccess);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Transfers(),
                                ),
                              );
                            }
                            if (!success) showToast(txt_createtransferfail);
                            SmartDialog.dismiss();
                          },
                          onCompleted: (dynamic resultData) {},
                        ),
                        builder: (RunMutation runMutation, result){
                          return GestureDetector(
                            onTap: (){
                              runMutation({
                                'id': widget.transfer.id,
                              });
                              SmartDialog.showLoading(backDismiss: false);
                            },
                            child: OutlineBnt(
                              bntText: "Cancelar Transferencia",
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
