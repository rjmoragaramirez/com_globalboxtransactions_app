import 'package:com_globalboxtransactions_app/common/funtions.dart';
import 'package:com_globalboxtransactions_app/common/mutationsandquerys.dart';
import 'package:com_globalboxtransactions_app/common/varsandconts.dart';
import 'package:com_globalboxtransactions_app/data/Beneficiary.dart';
import 'package:com_globalboxtransactions_app/widgets/beneficiariesitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BeneficiariesList extends StatefulWidget {

  final ValueNotifier<GraphQLClient> clientVN;

  const BeneficiariesList({required this.clientVN});

  @override
  _BeneficiariesListState createState() => _BeneficiariesListState();
}

class _BeneficiariesListState extends State<BeneficiariesList> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(getallBeneficiary),
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

        print("Result getallBeneficiary = " + result.data.toString());

        var code  = extractRepositoryDataCode("allBeneficiary", result.data!);
        print("Data Respons Code Beneficiarys List = " + code.toString());

        if(code == 401){
            print("Result getallBeneficiary Exception = " + result.exception.toString());
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
          print("Result getallBeneficiary Exception = " + result.exception.toString());
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
          var list = extractRepositoryDataList("allBeneficiary", result.data!);
          print("List Count " + list.length.toString() + " Beneficiaries.");

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
                      Text("We have not found any Beneficiaries to display, please add a new Beneficiaries by clicking on the Add (+) button.",
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index){
                final Beneficiary beneficiary = extractRepositoryDataBeneficiary("BeneficiaryNode", list[index],);
                return BeneficiariesItem(beneficiary: beneficiary, clientVM: widget.clientVN);
              }
          );
        } else {
          return Container();
        }
      },
    );
  }
}
