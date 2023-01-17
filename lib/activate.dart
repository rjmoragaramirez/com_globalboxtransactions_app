import 'package:com_globalboxtransactions_app/transfers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'common/components.dart';
import 'common/funtions.dart';
import 'common/mutationsandquerys.dart';
import 'common/varsandconts.dart';

class Activate extends StatefulWidget {
  const Activate({Key? key}) : super(key: key);

  @override
  _ActivateState createState() => _ActivateState();
}

class _ActivateState extends State<Activate> {

  bool paymentInProgress = false;

  var tokenValueController = TextEditingController();

  bool tokenfieldrequiredColor = false;
  bool mutationinprogress = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

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
              "Account Verification",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            elevation: 0.0,
          ),
          body: ListView(
            children: <Widget>[
              Center(
                  child: Icon(
                    Icons.verified_user_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 130,)
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.all(margingcomponents),
                padding: EdgeInsets.all(paddingcomponents),
                decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: BorderRadius.circular(radius)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20,),
                              // Row(children: <Widget>[
                              //   Text("Username: ",
                              //     style: Theme.of(context).textTheme.subtitle1),
                              //   Text(userData.username,
                              //     style: Theme.of(context).textTheme.subtitle1)
                              // ],),
                              //SizedBox(height: 5,),
                              Row(children: <Widget>[
                                Text("Email: ",
                                  style: Theme.of(context).textTheme.subtitle1),
                                Text(userData.email,
                                  style: Theme.of(context).textTheme.subtitle1)
                              ],),
                              SizedBox(height: 10,),
                              if(mutationinprogress) Container(height: 2, width: 300,
                                child: LinearProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                  backgroundColor: Theme.of(context).backgroundColor,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("A security token has been sent to your email address. You must copy it, paste it into the field Code and click Check.",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(height: 25,),
                              Text("If you have lost your token, you can click on the button below.",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              Mutation(
                                  options: MutationOptions(
                                    document: gql(resendActivationEmail),
                                    update: (cache, result) {
                                      if (result!.data == null) {
                                        showToast("Error! Please check your Internet connection.");
                                        mutationinprogress = false;
                                      }

                                      bool success = false;

                                      print("Result resendActivationEmail = " + result.data.toString());
                                      print("Confirm resendActivationEmail success??? -> " + (extractRepositoryData("resendEmailActivateAccount", result.data!)['success'].toString()));
                                      success = extractRepositoryData("resendEmailActivateAccount", result.data!)['success'];

                                      if (success) {
                                        showToastInfo("We have sent an email to your address, please check your inbox. ");
                                      } else {
                                        showToast("Error! Please try again.");
                                      }

                                      mutationinprogress = false;
                                      setState(() {});
                                    },
                                    onCompleted: (dynamic resultData) {},
                                  ),
                                  builder: (RunMutation runMutation, result) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 20, bottom: 20),
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                mutationinprogress = true;
                                                setState(() {});
                                                runMutation({
                                                  'email':userData.email
                                                });
                                              },
                                              child: PrimaryButton(
                                                  bntText: "Resend token to email")
                                          )
                                        ],
                                      ),
                                    );
                                  }
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: tokenfieldrequiredColor ? Theme.of(context).hintColor : Theme.of(context).secondaryHeaderColor,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(radius)),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 60,
                                      child: Icon(
                                        Icons.code,
                                        size: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        style: Theme.of(context).textTheme.bodyText1,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.symmetric(vertical: 15),
                                          border: InputBorder.none,
                                          hintText: "Code",
                                          hintStyle: Theme.of(context).textTheme.subtitle1,
                                          ),
                                        controller: tokenValueController,
                                        onChanged: (String value) {
                                          setState(() {
                                            tokenfieldrequiredColor = false;
                                          });
                                        },//controller: ,
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          getClipboardData(tokenValueController);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 20),
                                          child: Icon(
                                              Icons.paste_rounded,
                                              color: Theme.of(context).primaryColor,
                                              size: 20),
                                        )
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Mutation(
                        options: MutationOptions(
                          document: gql(ActivateAccount),
                          update: (cache, result) {
                            if (result!.data == null) {
                              showToast("Error! Please check your Internet connection.");
                              mutationinprogress = false;
                            }

                            bool success = false;

                            print("Result ActivateAccount = " + result.data.toString());
                            print("Confirm ActivateAccount success??? -> " + (extractRepositoryData("activateAccount", result.data!)['success'].toString()));
                            success = extractRepositoryData("activateAccount", result.data!)['success'];

                            if (success) {
                              userData.verified = true;
                              if(userData.verified){
                                showToastInfo("Successful user verification!");
                                var route = new MaterialPageRoute(
                                    builder: (BuildContext context) => new Transfers());
                                Navigator.of(context).push(route);
                              }
                            } else {
                              showToast("Error! Invalid Token.");
                            }

                            mutationinprogress = false;
                            setState(() {});
                          },
                          onCompleted: (dynamic resultData) {},
                        ),
                        builder: (RunMutation runMutation, result) {
                          return Container(
                            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      if(tokenValueController.text.isNotEmpty){
                                        mutationinprogress = true;
                                        runMutation({
                                          'code':tokenValueController.text
                                        });
                                      } else {
                                        tokenfieldrequiredColor = true;
                                        showToast("The Token field cannot be empty.");
                                      }
                                      setState(() {});
                                    },
                                    child: PrimaryButton(
                                        bntText: "Check")
                                )
                              ],
                            ),
                          );
                        }
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  Future<String> getClipboardData(TextEditingController tokenValueController) async {
    String data = "";
    ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    data = clipboardData!.text!;
    if(data.isEmpty){
      showToast("Clipboard is empty!");
    } else {
      tokenValueController.text = data;
    }
    return data;
  }
}