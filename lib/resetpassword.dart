import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'common/components.dart';
import 'common/funtions.dart';
import 'common/mutationsandquerys.dart';
import 'common/varsandconts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  var codeValueController = TextEditingController();
  var emailValueController = TextEditingController();
  var passValueController = TextEditingController();
  var repassValueController = TextEditingController();

  bool codefieldrequiredColor = false;
  bool emailfieldrequiredColor = false;
  bool passfieldrequiredColor = false;
  bool repassfieldrequiredColor = false;

  bool mutationinprogress = false;

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
              "Reset Password",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            elevation: 0.0,
          ),
          body: ListView(
            children: <Widget>[
              Center(
                  child: Icon(
                    Icons.password_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 100,)
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
                              if(mutationinprogress) Container(height: 2, width: 300,
                                child: LinearProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                  backgroundColor: Theme.of(context).backgroundColor,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("A security token has been sent to your email address. You must copy it, paste it into the field below and click Check.",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(height: 25,),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: emailfieldrequiredColor ? Theme.of(context).hintColor : Theme.of(context).secondaryHeaderColor,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(radius)),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 60,
                                      child: Icon(
                                        Icons.alternate_email_rounded,
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
                                          hintText: "email",
                                          hintStyle: Theme.of(context).textTheme.subtitle1,
                                        ),
                                        controller: emailValueController,
                                        onChanged: (String value) {
                                          setState(() {
                                            emailfieldrequiredColor = false;
                                          });
                                        },//controller: ,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 25,),
                              // Text("If you have lost your token, you can click on the button below.",
                              //   style: Theme.of(context).textTheme.headline4,
                              // ),
                              Mutation(
                                  options: MutationOptions(
                                    document: gql(ResetPasswordCode),
                                    update: (cache, result) {
                                      if (result!.data == null) {
                                        showToast("Error! Please check your Internet connection.");
                                      }

                                      bool success = false;

                                      print("Result sendPasswordResetEmail = " + result.data.toString());
                                      print("Confirm sendPasswordResetEmail success??? -> " + (extractRepositoryData("sendPasswordResetEmail", result.data!)['success'].toString()));
                                      success = extractRepositoryData("sendPasswordResetEmail", result.data!)['success'];

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

                                                setState(() {});
                                                if(emailValueController.text.isNotEmpty){
                                                  mutationinprogress = true;
                                                  runMutation({
                                                    'email':emailValueController.text
                                                  });
                                                } else {
                                                  emailfieldrequiredColor = true;
                                                }
                                              },
                                              child: PrimaryButton(
                                                  bntText: "Send code to email")
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
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Column(children: <Widget>[
                        SizedBox(height: 25,),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: codefieldrequiredColor ? Theme.of(context).hintColor : Theme.of(context).secondaryHeaderColor,
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
                                    hintText: "code",
                                    hintStyle: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  controller: codeValueController,
                                  onChanged: (String value) {
                                    setState(() {
                                      codefieldrequiredColor = false;
                                    });
                                  },//controller: ,
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    getClipboardData(codeValueController);
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
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: passfieldrequiredColor ? Theme.of(context).hintColor : Theme.of(context).secondaryHeaderColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(radius)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                child: Icon(
                                  Icons.password,
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
                                    hintText: "password",
                                    hintStyle: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  obscureText: true,
                                  controller: passValueController,
                                  onChanged: (String value) {
                                    setState(() {
                                      passfieldrequiredColor = false;
                                    });
                                  },//controller: ,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: repassfieldrequiredColor ? Theme.of(context).hintColor : Theme.of(context).secondaryHeaderColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(radius)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                child: Icon(
                                  Icons.password,
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
                                    hintText: "repeat password",
                                    hintStyle: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  obscureText: true,
                                  controller: repassValueController,
                                  onChanged: (String value) {
                                    setState(() {
                                      repassfieldrequiredColor = false;
                                    });
                                  },//controller: ,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Mutation(
                        options: MutationOptions(
                          document: gql(SetNewPassword),
                          update: (cache, result) {
                            if (result!.data == null) {
                              showToast("Error! Please check your Internet connection.");
                            }

                            bool success = false;

                            print("Result resetPasswordEmail = " + result.data.toString());
                            print("Confirm resetPasswordEmail success??? -> " + (extractRepositoryData("resetPasswordEmail", result.data!)['success'].toString()));
                            success = extractRepositoryData("resetPasswordEmail", result.data!)['success'];

                            if (success) {
                                showToastInfo("The password has been changed successfully. Go to the previous page and please try to log in again.");
                                // var route = new MaterialPageRoute(
                                //     builder: (BuildContext context) => new Tran());
                                // Navigator.of(context).push(route);
                            } else {
                              mutationinprogress = false;
                              showToast("Error! Please try again.");
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
                                      if(codeValueController.text.isNotEmpty){
                                        if(passValueController.text.isNotEmpty){
                                          if(repassValueController.text.isNotEmpty){
                                            if(passValueController.text == repassValueController.text){
                                              mutationinprogress = true;
                                              runMutation({
                                                'code':codeValueController.text,
                                                'password1':passValueController.text,
                                                'password2':repassValueController.text
                                              });
                                            } else {
                                              showToast("Passwords do not match. Please try again.");
                                            }
                                          } else {
                                            showToast("The Repeat Password field cannot be empty.");
                                          }
                                        } else {
                                          showToast("The Password field cannot be empty.");
                                        }
                                      } else {
                                        showToast("The Code field cannot be empty.");
                                      }

                                      setState(() {});
                                    },
                                    child: PrimaryButton(
                                        bntText: "Change Password")
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
