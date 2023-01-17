import 'package:com_globalboxtransactions_app/beneficiarynew_step3.dart';
import 'package:com_globalboxtransactions_app/common/components.dart';
import 'package:com_globalboxtransactions_app/common/mutationsandquerys.dart';
import 'package:com_globalboxtransactions_app/data/Bank.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'common/funtions.dart';
import 'common/varsandconts.dart';
import 'data/Beneficiary.dart';

class BeneficiaryNew_Step2 extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final bool edit;
  final Beneficiary beneficiaryedit;

  BeneficiaryNew_Step2(
      {required this.name,
      required this.email,
      required this.phone,
      required this.edit,
      required this.beneficiaryedit});

  @override
  _BeneficiaryNew_Step2State createState() => _BeneficiaryNew_Step2State();
}

class _BeneficiaryNew_Step2State extends State<BeneficiaryNew_Step2> {
  var numberaccountValueController = TextEditingController();
  var _searchController = TextEditingController();

  bool numberaccountfieldrequiredColor = false;
  bool bankrequiredColor = false;

  var controller = TextEditingController();
  List<Bank> _items = [];

  late String name;
  late String id;
  late String strNumberAccount;

  bool varloaded = false;

  @override
  void initState() {
    super.initState();
    _initData();
    _searchController.addListener(() {
      _filter();
    });
  }

  _initData() {
    setState(() {
      _items.addAll(allbanks);
      selectedBank = new Bank(id: "", name: "", swiftCode: "");
    });
  }

  _filter() {
    _searchResult(_searchController.text.toLowerCase());
  }

  _searchResult(String query) {
    List<Bank> _tempList = [];
    _tempList.addAll(allbanks);

    if (query.isNotEmpty) {
      List<Bank> _tempLoop = [];
      _tempList.forEach((element) {
        if (element.name.toLowerCase().contains(query) ||
            element.swiftCode.toLowerCase().contains(query)) {
          _tempLoop.add(element);
        }
      });
      setState(() {
        _items.clear();
        _items.addAll(_tempLoop);
      });
    } else {
      setState(() {
        _items.clear();
        _items.addAll(_tempList);
      });
    }
  }

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

    if (widget.edit) {
      if (!varloaded) {
        strNumberAccount = widget.beneficiaryedit.numberAccount;
        numberaccountValueController.text =
            widget.beneficiaryedit.numberAccount;
        varloaded = true;
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          txt_addbeneficiariesstep2,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
        elevation: 0.0,
      ),
      body: GraphQLProvider(
        client: clientVN,
        child: ListView(
          padding: EdgeInsets.all(paddingcomponents),
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Text(widget.name,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.fade),
            ),
            Center(
              child: Text(widget.phone,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis),
            ),
            Center(
              child: Text(widget.email,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              //margin: EdgeInsets.all(margingcomponents),
              padding: EdgeInsets.all(paddingcomponents),
              decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(radius)),
              child: Column(
                children: <Widget>[
                  Text(
                    "No. de Cuenta",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 8),
                  if (!widget.edit)
                    TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        hintText: "No. de Cuenta",
                        hintStyle: Theme.of(context).textTheme.subtitle1,
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                      ),
                      controller: numberaccountValueController,
                      onChanged: (String value) {
                        setState(() {
                          strNumberAccount = value.toString();
                          numberaccountfieldrequiredColor = false;
                        });
                      },
                    ),
                  if (widget.edit)
                    TextFormField(
                      initialValue: widget.beneficiaryedit.numberAccount,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.comment_bank_outlined),
                        hintText: "8888888888888",
                        hintStyle: Theme.of(context).textTheme.subtitle1,
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                      ),
                      onChanged: (String value) {
                        strNumberAccount = value.toString();
                        numberaccountValueController.text = strNumberAccount;
                        numberaccountfieldrequiredColor = false;
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            selectedBank.name.isEmpty
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    //margin: EdgeInsets.all(margingcomponents),
                    padding: EdgeInsets.all(paddingcomponents),
                    decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(radius)),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Busque y seleccione el Swift",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                              hintText: "Search",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(radius)),
                              contentPadding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: _items.length > 0
                                ? ListView.builder(
                                    itemCount: _items.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          showToastInfo(
                                              _items[index].swiftCode);

                                          setState(() {
                                            selectedBank = _items[index];
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(5.0),
                                          padding: EdgeInsets.only(
                                              top: 15,
                                              bottom: 15,
                                              left: 5,
                                              right: 5),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      radius)),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                _items[index].name,
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                _items[index].swiftCode,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Container(
                                    child: Center(
                                      child: Text(
                                        "No hay Datos",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ),
                                  )),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    //margin: EdgeInsets.all(margingcomponents),
                    padding: EdgeInsets.all(paddingcomponents),
                    decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(radius)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(selectedBank.name,
                              style: Theme.of(context).textTheme.subtitle2,
                              overflow: TextOverflow.fade),
                        ),
                        Center(
                          child: Text(selectedBank.swiftCode,
                              style: Theme.of(context).textTheme.subtitle1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchController.text = "";
                              selectedBank =
                                  new Bank(id: "", name: "", swiftCode: "");
                            });
                          },
                          child: OutlineBnt(
                            bntText: "Eliminar Banco Selecionado",
                          ),
                        )
                      ],
                    ),
                  ),
            if (widget.edit)
              Mutation(
                  options: MutationOptions(
                    document: gql(updateBeneficiary),
                    update: (cache, result) {
                      print("Update Beneficiary Result = " +
                          result!.data.toString());
                      bool success = false;

                      if (result.data != null)
                        success = extractRepositoryData(
                            "updateBeneficiary", result.data!)['success'];

                      id = extractRepositoryData("updateBeneficiary",
                          result.data!)['beneficiaryNode']['id'];
                      name = extractRepositoryData("updateBeneficiary",
                          result.data!)['beneficiaryNode']['name'];

                      print("ID => " + id);
                      print("NAME => " + name);

                      print("Update Beneficiary = " + success.toString());

                      if (success) {
                        showToastInfo(txt_addbeneficiarysuccess);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BeneficiaryNew_Step3(
                                id: id,
                                name: name,
                                edit: widget.edit,
                                beneficiaryedit: widget.beneficiaryedit),
                          ),
                        );
                      }
                      if (!success) showToast(txt_addbeneficiaryfail);
                      SmartDialog.dismiss();
                    },
                    onCompleted: (dynamic resultData) {},
                  ),
                  builder: (RunMutation runMutation, result) {
                    return Container(
                      //margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.only(
                          top: paddingcomponents, bottom: paddingcomponents),
                      child: GestureDetector(
                        onTap: () {
                          if (selectedBank.name.isNotEmpty &&
                              selectedBank.swiftCode.isNotEmpty &&
                              selectedBank.id.isNotEmpty) {
                            if (numberaccountValueController.text.isNotEmpty) {

                              print('widget.beneficiaryedit.image = ' + widget.beneficiaryedit.image);

                              runMutation({
                                'id': widget.beneficiaryedit.id,
                                'name': widget.name,
                                'numberAccount': strNumberAccount.toString(),
                                'email': widget.email,
                                'phone': widget.phone,
                                'bankId': selectedBank.id.toString(),
                              });
                              SmartDialog.showLoading(backDismiss: false);
                            } else {
                              showToast(
                                  "El campo de No. de Cuenta no puede estar vacio.");
                            }
                          } else {
                            showToast(
                                "El campo de Banco no puede estar vacio.");
                          }
                        },
                        child: PrimaryButton(bntText: "Siguiente"),
                      ),
                    );
                  }),
            if (!widget.edit)
              Mutation(
                  options: MutationOptions(
                    document: gql(addBeneficiary),
                    update: (cache, result) {
                      print("Add Beneficiary Result = " +
                          result!.data.toString());
                      bool success = false;

                      if (result.data != null)
                        success = extractRepositoryData(
                            "createBeneficiary", result.data!)['success'];

                      id = extractRepositoryData("createBeneficiary",
                          result.data!)['beneficiaryNode']['id'];
                      name = extractRepositoryData("createBeneficiary",
                          result.data!)['beneficiaryNode']['name'];

                      print("ID => " + id);
                      print("NAME => " + name);

                      print("Add Beneficiary = " + success.toString());

                      if (success) {
                        showToastInfo(txt_addbeneficiarysuccess);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BeneficiaryNew_Step3(
                                id: id,
                                name: name,
                                edit: widget.edit,
                                beneficiaryedit: widget.beneficiaryedit),
                          ),
                        );
                      }
                      if (!success) showToast(txt_addbeneficiaryfail);
                      SmartDialog.dismiss();
                    },
                    onCompleted: (dynamic resultData) {},
                  ),
                  builder: (RunMutation runMutation, result) {
                    return Container(
                      //margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.only(
                          top: paddingcomponents, bottom: paddingcomponents),
                      child: GestureDetector(
                        onTap: () {
                          if (selectedBank.name.isNotEmpty &&
                              selectedBank.swiftCode.isNotEmpty &&
                              selectedBank.id.isNotEmpty) {
                            if (numberaccountValueController.text.isNotEmpty) {
                              runMutation({
                                'name': widget.name,
                                'numberAccount':
                                    numberaccountValueController.text,
                                'email': widget.email,
                                'bankId': selectedBank.id.toString(),
                                'phone': widget.phone,
                              });
                              SmartDialog.showLoading(backDismiss: false);
                            } else {
                              showToast(
                                  "El campo de No. de Cuenta no puede estar vacio.");
                            }
                          } else {
                            showToast(
                                "El campo de Banco no puede estar vacio.");
                          }
                        },
                        child: PrimaryButton(bntText: "Siguiente"),
                      ),
                    );
                  }),
          ],
        ),
      ),
    );
  }
}

// void _selBank(BuildContext context, ValueNotifier<GraphQLClient> clientVN, ) {
//   showDialog(context: context, builder: (BuildContext context) {
//
//
//
//     return SimpleDialog(
//       title: Center(
//           child: Text("Seleccione el Banco",
//             style: Theme.of(context).textTheme.headline3,
//           )
//       ),
//       children: <Widget>[
//         // SearchWidget(
//         //   text: query,
//         //   hintText: "Banco o Swift",
//         //   onChanged: searchBank(query),
//         // ),
//         Container(
//           width: MediaQuery.of(context).size.width * 0.6,
//           height: MediaQuery.of(context).size.height * 0.6,
//           child: GraphQLProvider(
//             client: clientVN,
//             child: Query(
//               options: QueryOptions(document: gql(getallBank),
//               ),
//               builder: (result, {fetchMore, refetch}){
//
//                 if(result.hasException){
//                   print("Result getallBank Exception = " + result.exception.toString());
//                   return Container(
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
//                         child: Text(result.exception.toString(),
//                           style: Theme.of(context).textTheme.subtitle2,
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//
//                 if(result.isLoading){
//                   return Container(
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
//                         height: 50, width: 50,
//                         child: CircularProgressIndicator(
//                           color: Theme.of(context).primaryColor,
//                           strokeWidth: 2.0,
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//
//                 print("Result getallBank = " + result.data.toString());
//                 var list = extractRepositoryDataList("allBank", result.data!);
//                 print("List Count " + list.length.toString() + " Banks.");
//
//
//
//                 for(int i=0; i < list.length; i++){
//                   print(i.toString());
//                   final Bank bank = extractRepositoryDataBank("BankNode", list[i],);
//                   print(bank.name);
//                   banks.add(bank);
//                 }
//
//                 if(list.length == 0){
//                   return Container(
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(color: Colors.black),
//                         margin: EdgeInsets.all(50),
//                         alignment: Alignment.center,
//                         child: Column(
//                           children: <Widget>[
//                             Icon(Icons.warning, color: Theme.of(context).primaryColor, size: 60,),
//                             Text("We have not found any Transfer to display, please create a new Tranfer by clicking on the Add (+) button.",
//                               style: Theme.of(context).textTheme.headline4,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//
//                 return ListView.builder(
//                     itemCount: banks.length,
//                     itemBuilder: (BuildContext context, int index){
//
//                       return BankItem(bank: banks[index]);
//                       //return Container();
//                     }
//                 );
//               },
//             ),
//           ),
//         )
//
//       ],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
//       backgroundColor: Theme.of(context).secondaryHeaderColor,
//       titlePadding: EdgeInsets.only(top: 20),
//       contentPadding: EdgeInsets.all(20),
//     );
//   },
//       barrierDismissible: true
//   );
// }

// searchBank(String query) {
//   var banks = allbanks.where((bank) {
//     final nameLower = bank.name.toLowerCase();
//     final swiftCodeLower = bank.swiftCode.toLowerCase();
//     final searchLower = query.toLowerCase();
//
//     return nameLower.contains(searchLower) ||
//         swiftCodeLower.contains(searchLower);
//   }).toList();
//
//   query = query;
//   banks = banks;
//
// }
