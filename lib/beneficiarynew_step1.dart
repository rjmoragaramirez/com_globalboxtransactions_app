import 'package:com_globalboxtransactions_app/beneficiarynew_step2.dart';
import 'package:com_globalboxtransactions_app/common/components.dart';
import 'package:com_globalboxtransactions_app/common/mutationsandquerys.dart';
import 'package:com_globalboxtransactions_app/data/Bank.dart';
import 'package:com_globalboxtransactions_app/data/Beneficiary.dart';
import 'package:country_codes/country_codes.dart';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';


import 'common/funtions.dart';
import 'common/varsandconts.dart';

class BeneficiaryNew_Step1 extends StatefulWidget {
  final bool edit;
  final Beneficiary beneficiaryedit;

  BeneficiaryNew_Step1({required this.edit, required this.beneficiaryedit});

  @override
  _BeneficiaryNew_Step1State createState() => _BeneficiaryNew_Step1State();
}

class _BeneficiaryNew_Step1State extends State<BeneficiaryNew_Step1> {
  var nameValueController = TextEditingController();

  // var numberaccountValueController = TextEditingController();
  var emailValueController = TextEditingController();
  var phoneValueController = TextEditingController();

  // var swiftValueController = TextEditingController();

  bool namefieldrequiredColor = false;

  // bool numberaccountfieldrequiredColor = false;
  bool emailfieldrequiredColor = false;
  bool phonefieldrequiredColor = false;

  // bool swiftfieldrequiredColor = false;

  bool banksloaded = false;

  bool varloaded = false;

  String strName = "";
  String strEmail = "";
  String strPhone = "";
  late PhoneNumber editablePhoneNumber;

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

    PhoneNumber initialnumber = PhoneNumber(isoCode: "US");

    if (widget.edit) {
      if (!varloaded) {

        editablePhoneNumber = new PhoneNumber(
            phoneNumber: widget.beneficiaryedit.phone,
            dialCode: "+1",
            isoCode: "US");

        

        strName = widget.beneficiaryedit.name;
        strEmail = widget.beneficiaryedit.email;
        strPhone = widget.beneficiaryedit.phone;
        nameValueController.text = widget.beneficiaryedit.name;
        emailValueController.text = widget.beneficiaryedit.email;
        phoneValueController.text = widget.beneficiaryedit.phone;
        varloaded = true;
      }
    }

    return GraphQLProvider(
        client: clientVN,
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                txt_addbeneficiariesstep1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
              elevation: 0.0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.all(margingcomponents),
                  padding: EdgeInsets.all(paddingcomponents),
                  decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(radius)),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Nombre del Beneficiario",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 8),
                      if (!widget.edit)
                        TextField(
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                            hintText: "John Doe",
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20),
                          ),
                          controller: nameValueController,
                          onChanged: (String value) {
                            setState(() {
                              strName = value.toString().toUpperCase();
                              namefieldrequiredColor = false;
                            });
                          },
                        ),
                      if (widget.edit)
                        TextFormField(
                          initialValue: widget.beneficiaryedit.name,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "John Doe",
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strName = value.toString().toUpperCase();
                            nameValueController.text = strName.toUpperCase();
                            namefieldrequiredColor = false;
                          },
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 8),
                      if (!widget.edit)
                        TextField(
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                            hintText: "johndoe@mail.com",
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20),
                          ),
                          controller: emailValueController,
                          onChanged: (String value) {
                            setState(() {
                              strEmail = value.toString();
                              emailfieldrequiredColor = false;
                            });
                          },
                        ),
                      if (widget.edit)
                        TextFormField(
                          initialValue: widget.beneficiaryedit.email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email),
                            hintText: "johndoe@mail.com",
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strEmail = value;
                            emailValueController.text = strEmail;
                            emailfieldrequiredColor = false;
                          },
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Teléfono",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 8),
                      if (!widget.edit)
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(radius)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (value) {
                                strPhone = value.toString();
                                //print(strPhone);
                              },
                              //initialValue: initialnumber,
                              formatInput: true,
                              inputDecoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 15),
                                border: InputBorder.none,
                                hintText: 'Escriba Teléfono',
                                hintStyle:
                                    Theme.of(context).textTheme.subtitle1,
                              ),
                              selectorConfig: SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DIALOG),
                              textStyle: Theme.of(context).textTheme.subtitle1,
                              keyboardType: TextInputType.phone,
                              selectorTextStyle:
                                  Theme.of(context).textTheme.subtitle1,
                              searchBoxDecoration: InputDecoration(
                                fillColor: Colors.black45,
                                labelText: "Seleccione un País",
                                hoverColor: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                      // if (widget.edit)
                      //   Container(
                      //     decoration: BoxDecoration(
                      //         border: Border.all(),
                      //         borderRadius: BorderRadius.circular(radius)),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 10),
                      //       child: InternationalPhoneNumberInput(
                      //         onInputChanged: (value) {
                      //           print(value.toString());
                      //         },
                      //         formatInput: true,
                      //         initialValue: editablePhoneNumber,
                      //         inputDecoration: InputDecoration(
                      //           contentPadding: EdgeInsets.only(bottom: 15),
                      //           border: InputBorder.none,
                      //           hintText: 'Escriba Teléfono',
                      //           hintStyle:
                      //               Theme.of(context).textTheme.subtitle1,
                      //         ),
                      //         selectorConfig: SelectorConfig(
                      //             selectorType:
                      //                 PhoneInputSelectorType.BOTTOM_SHEET),
                      //         textStyle: Theme.of(context).textTheme.subtitle1,
                      //         keyboardType: TextInputType.phone,
                      //         selectorTextStyle:
                      //             Theme.of(context).textTheme.subtitle1,
                      //       ),
                      //     ),
                      //   ),
                      const SizedBox(height: 8),
                      // if(!widget.edit) TextField(
                      //   maxLines: 1,
                      //   keyboardType: TextInputType.phone,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(radius),
                      //     ),
                      //     hintText: "123 456 7890",
                      //     hintStyle: Theme.of(context).textTheme.subtitle1,
                      //     contentPadding:
                      //     EdgeInsets.only(left: 20, right: 20),
                      //   ),
                      //   controller: phoneValueController,
                      //   onChanged: (String value) {
                      //     setState(() {
                      //       strPhone = value.toString();
                      //       phonefieldrequiredColor = false;
                      //     });
                      //   },
                      // ),

                      if(widget.edit) TextFormField(
                        initialValue: widget.beneficiaryedit.phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: "123 456 7890",
                          hintStyle: Theme.of(context).textTheme.subtitle1,
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius),
                          ),
                        ),
                        onChanged: (String value){
                          strPhone = value;
                          phoneValueController.text = strPhone;
                          phonefieldrequiredColor = false;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (!banksloaded)
                        Query(
                            options: QueryOptions(
                              document: gql(getallBank),
                            ),
                            builder: (result, {fetchMore, refetch}) {

                              if (result.isLoading) {
                                return Container(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                        strokeWidth: 2.0,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              print("Result getallBank = " +
                                  result.data.toString());

                              var code  = extractRepositoryDataCode("allBank", result.data!);
                              print("Data Respons Code Banks List = " + code.toString());

                              if (code == 401) {
                                print("Result getallBank Exception = " +
                                    result.exception.toString());
                                return Container(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .backgroundColor),
                                      child: Text(txt_errorUserNoAuth,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if (code == 500) {
                                print("Result getallBank Exception = " +
                                    result.exception.toString());
                                return Container(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .backgroundColor),
                                      child: Text(txt_errorServer,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if(code == 200){
                                var list = extractRepositoryDataList(
                                    "allBank", result.data!);
                                print("List Count " +
                                    list.length.toString() +
                                    " Banks.");

                                allbanks.clear();

                                for (int i = 0; i < list.length; i++) {
                                  //print(i.toString());
                                  final Bank bank = extractRepositoryDataBank(
                                    "BankNode",
                                    list[i],
                                  );
                                  //print(bank.name);
                                  allbanks.add(bank);
                                }

                                if (allbanks.length > 0) {
                                  banksloaded = true;
                                }

                                if (list.length == 0) {
                                  return Container(
                                    child: Center(
                                      child: Container(
                                        decoration:
                                        BoxDecoration(color: Colors.black),
                                        margin: EdgeInsets.all(50),
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.warning,
                                              color:
                                              Theme.of(context).primaryColor,
                                              size: 60,
                                            ),
                                            Text(
                                              "We have not found any Banks to display.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return Container();
                              } else {
                                return Container();
                              }
                            }
                            ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (banksloaded) {
                        if (nameValueController.text.isNotEmpty) {
                          if (emailValueController.text.isNotEmpty) {
                            if (strPhone.isNotEmpty) {
                              var route = new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new BeneficiaryNew_Step2(
                                        name: strName,
                                        email: strEmail,
                                        phone: strPhone,
                                        edit: widget.edit,
                                        beneficiaryedit: widget.beneficiaryedit,
                                      ));
                              Navigator.of(context).push(route);
                            } else {
                              showToast(
                                  "El campo de Teléfono no puede estar vacio.");
                            }
                          } else {
                            showToast(
                                "El campo de Email no puede estar vacio.");
                          }
                        } else {
                          showToast("El campo de Nombre no puede estar vacio.");
                        }
                      }
                    },
                    child: PrimaryButton(bntText: "Siguiente"),
                  ),
                )
              ],
            )));
  }

// getPhone(String phone) {
//   PhoneNumber phoneNumber;
//   phoneNumber = FlutterLibphonenumber().parse(phone, region: "+53");
//   setState(() {
//     editablePhoneNumber = phoneNumber;
//   });
// }
}
