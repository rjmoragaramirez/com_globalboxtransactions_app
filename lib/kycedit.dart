import 'package:com_globalboxtransactions_app/common/mutationsandquerys.dart';
import 'package:com_globalboxtransactions_app/data/KYCData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'common/components.dart';
import 'common/funtions.dart';
import 'common/varsandconts.dart';
import 'kyc.dart';

class KYCEdit extends StatefulWidget {
  final KYCData kycData;

  const KYCEdit({required this.kycData});

  @override
  _KYCEditState createState() => _KYCEditState();
}

class _KYCEditState extends State<KYCEdit> {
  var controller;

  late String strFirstName;
  late String strLastName;
  late String strNoPassport;
  late String strPostAddress;
  late String strPostCode;
  late String strCity;
  late String strState;
  late String strCountry;
  late String strPhone;

  late String strImageIdentity;
  late String strImageAddress;

  late bool firstNamefieldrequiredColor;
  late bool lastNamefieldrequiredColor;
  late bool nopassportfieldrequiredColor;
  late bool postaddressfieldrequiredColor;
  late bool postcodefieldrequiredColor;
  late bool cityfieldrequiredColor;
  late bool statefieldrequiredColor;
  late bool countryfieldrequiredColor;
  late bool phonefieldrequiredColor;

  bool kycnoempty = false;

  var variableloaded = false;

  @override
  Widget build(BuildContext context) {
    httpLink = new HttpLink(
        "https://api.globalboxtransactions.com/graphql/",
        defaultHeaders: <String, String>{
          'Authorization': 'JWT ' + userData.token,
        });

    final ValueNotifier<GraphQLClient> clientVN = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    if(widget.kycData.firtsName.isNotEmpty && widget.kycData.lastName.isNotEmpty && widget.kycData.postaddress.isNotEmpty){
      kycnoempty = true;
    }


    if (variableloaded == false) {
      print("Cargando vaariables para inicar!");
      strFirstName = widget.kycData.firtsName;
      strLastName = widget.kycData.lastName;
      strNoPassport = widget.kycData.nopassport;
      strPostAddress = widget.kycData.postaddress;
      strPostCode = widget.kycData.postcode;
      strCity = widget.kycData.city;
      strState = widget.kycData.state;
      strCountry = widget.kycData.country;
      strPhone = widget.kycData.phone;

      strImageIdentity = "";
      strImageAddress = "";
      variableloaded = true;
    }
    return GraphQLProvider(
      client: clientVN,
      child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .backgroundColor,
            title: Text(
              "Modificar KYC",
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline3,
            ),
            elevation: 0.0,
          ),
          body: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    margin: EdgeInsets.all(margingcomponents),
                    padding: EdgeInsets.all(paddingcomponents),
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(radius)),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: widget.kycData.firtsName,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "John",
                            label: Text("Nombre"),
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                            contentPadding:
                            EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strFirstName = value;
                            firstNamefieldrequiredColor = false;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.kycData.lastName,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Doe",
                            label: Text("Apellidos"),
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                            contentPadding:
                            EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strLastName = value;
                            lastNamefieldrequiredColor = false;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.kycData.nopassport,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.dashboard_customize),
                            hintText: "L456789 o 78954632188",
                            label: Text("No. de Pasaporte o DNI"),
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                            contentPadding:
                            EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strNoPassport = value;
                            nopassportfieldrequiredColor = false;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.kycData.phone,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "+15648897855",
                            label: Text("Teléfono"),
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                            contentPadding:
                            EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strPhone = value;
                            phonefieldrequiredColor = false;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.kycData.postaddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.home),
                            hintText: "Paseo No 825 entre Santa Rita y San Gregorio",
                            label: Text("Dirección Postal"),
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                            contentPadding:
                            EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strPostAddress = value;
                            postaddressfieldrequiredColor = false;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.kycData.postcode,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.code),
                            hintText: "95100",
                            label: Text("Código Postal"),
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                            contentPadding:
                            EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strPostCode = value;
                            postcodefieldrequiredColor = false;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.kycData.city,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            hintText: "Hialeah",
                            label: Text("Ciudad"),
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                            contentPadding:
                            EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strCity = value;
                            cityfieldrequiredColor = false;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.kycData.state,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            hintText: "Florida",
                            label: Text("Estado"),
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                            contentPadding:
                            EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strState = value;
                            statefieldrequiredColor = false;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.kycData.country,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_balance_rounded),
                            hintText: "Estados Unidos",
                            label: Text("País"),
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                            contentPadding:
                            EdgeInsets.only(left: 20, right: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(radius),
                            ),
                          ),
                          onChanged: (String value) {
                            strCountry = value;
                            countryfieldrequiredColor = false;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if(!kycnoempty) Mutation( //Crear un KYC
                  options: MutationOptions(
                    document: gql(createKYC),
                    update: (cache, result) {
                      print("CreateKYC Result = " +
                          result!.data.toString());
                      bool success = false;
                      if (result.data != null)
                        success = extractRepositoryData(
                            "createKyc", result.data!)['success'];
                      print("CreateKYC success = " +
                          success.toString());
                      if (success) {
                        showToastInfo(txt_createKYCsuccess);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => KYC(),
                          ),
                        );
                      }
                      if (!success) showToast(txt_createKYCfail);
                      SmartDialog.dismiss();
                    },
                    onCompleted: (dynamic resultData) {},
                  ),
                  builder: (RunMutation runMutation, result) {
                    return Container(
                      margin: EdgeInsets.all(margingcomponents),
                      child: GestureDetector(
                        onTap: () {
                          if(strFirstName.isNotEmpty){
                            if(strLastName.isNotEmpty){
                              if(strNoPassport.isNotEmpty){
                                if(strPostAddress.isNotEmpty){
                                  if(strPostCode.isNotEmpty){
                                    if(strPhone.isNotEmpty){
                                      if(strCity.isNotEmpty){
                                        if(strState.isNotEmpty){
                                          if(strCountry.isNotEmpty){
                                            SmartDialog.showLoading(backDismiss: false);
                                            runMutation({
                                              'name':strFirstName,
                                              'lastname':strLastName,
                                              'dni':strNoPassport,
                                              'postaddress':strPostAddress,
                                              'postcode':strPostCode,
                                              'phone':strPhone,
                                              'city':strCity,
                                              'state':strState,
                                              'country':strCountry,
                                              'imageIdentity':strImageIdentity,
                                              'imageAddress':strImageAddress,
                                            });
                                          } else {
                                            showToast("El campo País no puede estar vacio.");
                                          }
                                        } else {
                                          showToast("El campo Estado no puede estar vacio.");
                                        }
                                      } else {
                                        showToast("El campo Ciudad no puede estar vacio.");
                                      }
                                    } else {
                                      showToast("El campo Telefono no puede estar vacio.");
                                    }
                                  } else {
                                    showToast("El campo Código Postal no puede estar vacio.");
                                  }
                                } else {
                                  showToast("El campo Dirección Postal no puede estar vacio.");
                                }
                              } else {
                                showToast("El campo No. Passporte o DNI no puede estar vacio.");
                              }
                            } else {
                              showToast("El campo Apellido no puede estar vacio.");
                            }
                          } else {
                            showToast("El campo Nombre no puede estar vacio.");
                          }

                        },
                        child: PrimaryButton(bntText: "Subir KYC"),
                      ),
                    );
                  }),
              if(kycnoempty) Mutation( //Modificación de KYC
                  options: MutationOptions(
                    document: gql(updateKyc),
                    update: (cache, result) {
                      print("UpdateKYC Result = " +
                          result!.data.toString());
                      bool success = false;
                      if (result.data != null)
                        success = extractRepositoryData(
                            "updateKyc", result.data!)['success'];
                      print("UpdateKYC success = " +
                          success.toString());
                      if (success) {
                        showToastInfo(txt_updateKYCsuccess);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => KYC(),
                          ),
                        );
                      }
                      if (!success) showToast(txt_updateKYCfail);
                      SmartDialog.dismiss();
                    },
                    onCompleted: (dynamic resultData) {},
                  ),
                  builder: (RunMutation runMutation, result) {
                    return Container(
                      margin: EdgeInsets.all(margingcomponents),
                      child: GestureDetector(
                        onTap: () {
                          SmartDialog.showLoading(backDismiss: false);
                          runMutation({
                            'id':widget.kycData.id,
                            'name':strFirstName,
                            'lastname':strLastName,
                            'dni':strNoPassport,
                            'postaddress':strPostAddress,
                            'postcode':strPostCode,
                            'phone':strPhone,
                            'city':strCity,
                            'state':strState,
                            'country':strCountry,
                            'imageIdentity':strImageIdentity,
                            'imageAddress':strImageAddress,
                          });
                        },
                        child: PrimaryButton(bntText: "Modificar KYC"),
                      ),
                    );
                  }),
            ],
          )
      ),
    );
  }
}
