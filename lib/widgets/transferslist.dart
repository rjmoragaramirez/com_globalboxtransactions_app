import 'package:com_globalboxtransactions_app/common/funtions.dart';
import 'package:com_globalboxtransactions_app/common/mutationsandquerys.dart';
import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:com_globalboxtransactions_app/data/Transfer.dart';
import 'package:com_globalboxtransactions_app/widgets/transferitem.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TransfersList extends StatefulWidget {
  final ValueNotifier<GraphQLClient> clientVN;

  const TransfersList({required this.clientVN});

  @override
  _TransfersListState createState() => _TransfersListState();
}

class _TransfersListState extends State<TransfersList> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(getallTransfer),
      ),
      builder: (result, {fetchMore, refetch}){

        if(result.isLoading){
          return Container(
            child: Center(
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
                height: 50, width: 50,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 2.0,
                ),
              ),
            ),
          );
        }

        print("Result getallTransfer = " + result.data.toString());

        var code  = extractRepositoryDataCode("allTransfer", result.data!);
        print("Data Respons Code Tranfers List = " + code.toString());

        if(code == 401){
          print("Result getallTransfer Exception = " + result.exception.toString());
          return Container(
            child: Center(
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
                child: Text(txt_errorUserNoAuth,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
          );
        }

        if(code == 500){
          print("Result getallTransfer Exception = " + result.exception.toString());
          return Container(
            child: Center(
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
                child: Text(txt_errorServer,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
          );
        }

        if(code == 200){
          var list = extractRepositoryDataList("allTransfer", result.data!);
          print("List Count " + list.length.toString() + " Tranfers.");

          if(list.length == 0){
            return Container(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(color: Colors.black),
                  margin: EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.warning, color: Theme.of(context).primaryColor, size: 60,),
                      Text("We have not found any Transfer to display, please create a new Tranfer by clicking on the Add (+) button.",
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index){
                final Transfer transfer = extractRepositoryDataTransfer("TransferNode", list[index],);
                return TransferItem(transfer: transfer, clientVN: widget.clientVN);
              }
          );
        } else {
          return Container();
        }
      },
    );
  }
}
