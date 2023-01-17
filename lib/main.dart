import 'package:com_globalboxtransactions_app/common/themes.dart';
import 'package:com_globalboxtransactions_app/resetpassword.dart';
import 'package:com_globalboxtransactions_app/transfers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activate.dart';
import 'common/components.dart';
import 'common/funtions.dart';
import 'common/mutationsandquerys.dart';
import 'common/varsandconts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: apptitle,
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
              child: LoginPage()
          ),
        )
      ),
    );
  }
}

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailValueController = TextEditingController();
  var passValueController = TextEditingController();

  var mailSignUpValueController = TextEditingController();
  var pass1SignUpValueController = TextEditingController();

  int _pageState = 0;

  double _headingTop = 100;

  double _windowWidth = 0;
  double _windowHeigth = 0;

  double _loginWidth = 0;
  double _loginHeigth = 0;

  double _loginYOffset = 0;
  double _loginXOffset = 0;

  double _registerYOffset = 0;
  double _registerHeigth = 0;

  double _loginOpacity = 1;
  bool success =  false;
  bool _keyboardVisible = false;

  //Campo requerido
  bool _fieldrequiredEmailSignUp = false;
  bool _fieldrequiredPass1SignUp = false;

  // Variables de control para los ProgressIndicators
  bool _loading = false;
  bool _loadingSignUp = false;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: ${visible}');
      setState(() {
        _keyboardVisible = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _windowHeigth = MediaQuery.of(context).size.height;
    _windowWidth = MediaQuery.of(context).size.width;

    _loginHeigth = _windowHeigth - 270;
    _registerHeigth = _windowHeigth - 270;

    switch (_pageState) {
      case 0:
        _loginWidth = _windowWidth;
        _loginYOffset = _windowHeigth;
        _loginHeigth = _keyboardVisible ? _windowHeigth : _windowHeigth - 270;
        _loginXOffset = 0;
        _registerYOffset = _windowHeigth;
        _loginOpacity = 1;
        _headingTop = 50;
        break;
      case 1:
        _loginWidth = _windowHeigth;
        _loginYOffset = _keyboardVisible ? 150 : 200;
        _loginHeigth = _keyboardVisible ? _windowHeigth : _windowHeigth - 170;
        _loginXOffset = 0;
        _registerYOffset = _windowHeigth;
        _loginOpacity = 1;
        _headingTop = 40;
        break;
      case 2:
        _loginWidth = _windowWidth - 40;
        _loginYOffset = 240;
        _loginXOffset = 20;
        _loginYOffset = _keyboardVisible ? 60 : 160;
        _loginHeigth = _keyboardVisible ? _windowHeigth : _windowHeigth - 100;
        _registerYOffset = _keyboardVisible ? 100 : 200;
        _registerHeigth = _keyboardVisible ? _windowHeigth : _windowHeigth - 200;
        _loginOpacity = 0.8;
        _headingTop = 10;
        break;
    }

    return Stack(
      children: <Widget>[
        /////////////////////Splash/////////////////////////
        AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 100),
            color: Theme.of(context).backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageState = 0;
                      FocusScope.of(context).unfocus();
                    });
                  },
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 50,),
                          Column(
                            children: <Widget> [
                              Container(
                                //padding: EdgeInsets.only(top: 2, bottom: 20),
                                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                                  child: Image.asset("assets/images/logo_white.png")),
                              Text(appversion,
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.center,),
                            ],
                          ),
                          // AnimatedContainer(
                          //   curve: Curves.fastLinearToSlowEaseIn,
                          //   duration: Duration(milliseconds: 500),
                          //   margin: EdgeInsets.only(top: _headingTop),
                          //   child: Text(
                          //     apptitle,
                          //     style: Theme.of(context).textTheme.headline1
                          //   ),
                          // ),


                          // GestureDetector(
                          //   onTap: () {
                          //     //launchHelp();
                          //   },
                          //   child: Container(
                          //     margin: const EdgeInsets.all(32),
                          //     child: Text(
                          //       "Touch here to read more...",
                          //       textAlign: TextAlign.center,
                          //       style: Theme.of(context).textTheme.subtitle1
                          //     ),
                          //   ),
                          // )
                        ],
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(32),
                  child: Text(
                      appslogan,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1
                  ),
                ),
                // if (!_keyboardVisible) Container(
                //   padding: EdgeInsets.symmetric(horizontal: 120),
                //   child: Center(
                //     child: Image.asset("assets/images/icon_white.png"),
                //   ),
                // ),
                SizedBox(
                  //height: 500,
                    //width: 500,
                    child: Image.asset("assets/images/business-intelligence-1.png")),
                if (!_keyboardVisible) Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 1;
                        });

                      },
                      child: Container(
                          margin: EdgeInsets.all(32),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(radius)),
                          child: Center(
                            child: Text(
                              "Let's start",
                              style: Theme.of(context).textTheme.caption
                              ,
                            ),
                          )
                      ),
                    )
                ),
              ],
            )
        ),
        /////////////////////Login/////////////////////////
        Mutation(
            options: MutationOptions(
              document: gql(userAuth),
              update: (cache, result) {
                print("Result userAuth = " + result!.data.toString());

                if(result.data != null){
                  print("success??? -> " + (extractRepositoryData("tokenAuth", result.data!)['success'].toString()));
                  success = extractRepositoryData("tokenAuth", result.data!)['success'];
                  _loading = false;
                  if (success) {
                    // UserData
                    userData = extractRepositoryUserData("tokenAuth", result.data!);
                    print("UserData username: " + userData.username);
                    print("UserData email: " + userData.email);
                    print("UserData token: " + userData.token);
                    print("UserData verified: " + userData.verified.toString());
                    print("UserData refreshToken: " + userData.refreshToken);

                    if(userData.verified){
                      var route = new MaterialPageRoute(
                          builder: (BuildContext context) => new Transfers());
                      Navigator.of(context).push(route);
                    } else {
                      var route = new MaterialPageRoute(
                          builder: (BuildContext context) => new Activate());
                      Navigator.of(context).push(route);
                    }
                  } else {
                    var messages = (extractRepositoryData("tokenAuth", result.data!)['errors']);
                    var _msgErrorLogin = "";

                    try {
                      _msgErrorLogin =
                          messages["nonFieldErrors"][0]['message']!.toString();
                    }catch(e){}
                    if(_msgErrorLogin.isNotEmpty) {
                      _msgErrorLogin = " Login: " + _msgErrorLogin;
                      if (_msgErrorLogin.isNotEmpty) {
                        //_fieldrequiredEmailSignUp = true;
                        print(_msgErrorLogin);
                      }
                    }

                    showToast(_msgErrorLogin);

                  }
                }

                if(result.data == null){
                  setState(() {
                    _loading = false;
                  });
                  showToast("Error, please try again.");
                }


              },
              onCompleted: (dynamic resultData) {
              },
            ),
            builder: (RunMutation runMutation, result) {
              return Container(
                child: AnimatedContainer(
                  padding: EdgeInsets.all(32),
                  width: _loginWidth,
                  height: _loginHeigth,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 500),
                  transform: Matrix4.translationValues(
                      _loginXOffset, _loginYOffset, 1),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(_loginOpacity),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius),
                          topRight: Radius.circular(radius))),
                  child: Column(
                    mainAxisAlignment: _keyboardVisible ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Login",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).secondaryHeaderColor, width: 2),
                                borderRadius: BorderRadius.circular(radius)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: widthcomponents,
                                  child: Icon(
                                    Icons.email_rounded,
                                    size: 20,
                                    color: Theme.of(context).secondaryHeaderColor,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    style: Theme.of(context).textTheme.subtitle1,
                                    decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: paddingcomponents),
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    controller: emailValueController, //controller: ,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).secondaryHeaderColor, width: 2),
                                borderRadius: BorderRadius.circular(radius)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: widthcomponents,
                                  child: Icon(
                                    Icons.vpn_key,
                                    size: 20,
                                    color: Theme.of(context).secondaryHeaderColor,
                                  ),
                                ),
                                Expanded(
                                    child: TextFormField(
                                      style: Theme.of(context).textTheme.subtitle1,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.symmetric(vertical: paddingcomponents),
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: Theme.of(context).textTheme.subtitle1,
                                      ),
                                      obscureText: true,
                                      controller: passValueController,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: (){
                              var route = new MaterialPageRoute(
                                  builder: (BuildContext context) => new ResetPassword());
                              Navigator.of(context).push(route);
                            },
                            child: Text("Forgot your password, please click here.",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      if(_loading) Container(height: 2, width: 300,
                        child: LinearProgressIndicator(
                          color: Theme.of(context).secondaryHeaderColor,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              onTap: () {

                                // var route = new MaterialPageRoute(
                                //     builder: (BuildContext context) => new Transfers());
                                // Navigator.of(context).push(route);

                                if(emailValueController.text.isNotEmpty){
                                  if(passValueController.text.isNotEmpty){
                                    setState(() {
                                      FocusScope.of(context).unfocus();
                                      _loading = true;
                                    });
                                    runMutation({
                                      'email':emailValueController.text,
                                      'pass':passValueController.text,
                                      //'user':"atproenzalores",
                                      //'user':"demi",
                                      // 'user':"rjmoraga",
                                      // 'pass':"Gold12345",
                                    });
                                  }else{
                                    showToast("The password field cannot be empty.");
                                  }
                                }else{
                                  showToast("The username field cannot be empty.");
                                }
                              } ,
                              child: PrimaryButton(
                                bntText: "Accept",
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                  _pageState = 2;
                                });
                              },
                              child: OutlineBnt(bntText: "Create New Account"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
        /////////////////////Sign Up/////////////////////////
        Mutation(
          options: MutationOptions(
            document: gql(registerUser),
            update: (cache, result) {
              print("registerUser result");
              print(result!.data);
              print("1 step");

              if(result.data.toString() != "null") {
                print("success??? -> " +
                    (extractRepositoryData("register", result.data!)['success']
                        .toString()));
              } else {
                showToast("Error, please try again.");
              }

              _loadingSignUp = false;

              bool success = extractRepositoryData("register", result.data!)['success'];

              if (success) {
                setState(() {
                  _pageState = 1;
                });

                showToast("You have registered on our platform. Now you must authenticate and activate your user, you will receive an activation code by email to use the first time you enter the application.");

              } else {
                var messages = (extractRepositoryData("register", result.data!)['errors']);

                String _msgErrorUsername = "";
                String _msgErrorEmail = "";
                String _msgErrorPassword1 = "";
                String _msgErrorPassword2 = "";

                try {
                  _msgErrorEmail =
                      messages["email"][0]['message']!.toString();
                }catch(e){}
                if(_msgErrorEmail.isNotEmpty) {
                  _msgErrorEmail = " Email: " + _msgErrorEmail;
                  if (_msgErrorEmail.isNotEmpty) {
                    _fieldrequiredEmailSignUp = true;
                    print(_msgErrorEmail);
                  }
                }

                try {
                  _msgErrorUsername =
                      messages["username"][0]['message']!.toString();
                }catch(e){}
                if(_msgErrorUsername.isNotEmpty) {
                  _msgErrorUsername = " Username: " + _msgErrorUsername;
                  if (_msgErrorUsername.isNotEmpty) {
                     print(_msgErrorUsername);
                  }
                }

                try {
                  _msgErrorPassword1 =
                      messages["password1"][0]['message']!.toString();
                }catch(e){}
                if(_msgErrorPassword1.isNotEmpty) {
                  _msgErrorPassword1 = " Password: " + _msgErrorPassword1;
                  if (_msgErrorPassword1.isNotEmpty) {
                    _fieldrequiredPass1SignUp = true;
                    pass1SignUpValueController.clear();
                    print(_msgErrorPassword1);
                  }
                }

                try {
                  _msgErrorPassword2 =
                      messages["password2"][0]['message']!.toString();
                }catch(e){}
                if(_msgErrorPassword2.isNotEmpty) {
                  _msgErrorPassword2 = " Password: " + _msgErrorPassword2;
                  if (_msgErrorPassword2.isNotEmpty) {
                    _fieldrequiredPass1SignUp = true;
                    pass1SignUpValueController.clear();
                    print(_msgErrorPassword2);
                  }
                }

                showToast(_msgErrorEmail + _msgErrorUsername + _msgErrorPassword1 + _msgErrorPassword2);

              }
            },
            onCompleted: (dynamic resultData) {
            },
          ),
          builder: (RunMutation runMutation, result) {
            return Container(
              child: AnimatedContainer(
                height: _registerHeigth,
                padding:
                EdgeInsets.only(bottom: 30, top: 20, left: 30, right: 30),
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 1000),
                transform: Matrix4.translationValues(0, _registerYOffset, 1),
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius))),
                child: Column(
                  mainAxisAlignment: _keyboardVisible ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Create New Account",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: _fieldrequiredEmailSignUp ? Theme.of(context).hintColor : Theme.of(context).secondaryHeaderColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(radius)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: widthcomponents,
                                child: Icon(
                                  Icons.mail,
                                  size: 20,
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  style: Theme.of(context).textTheme.subtitle1,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                    border: InputBorder.none,
                                    hintText: "email",
                                    hintStyle: Theme.of(context).textTheme.subtitle1
                                  ),
                                  controller:
                                  mailSignUpValueController,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (String value) {
                                    setState(() {
                                      _fieldrequiredEmailSignUp = false;
                                    });
                                  },//controller: ,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: _fieldrequiredPass1SignUp ? Theme.of(context).hintColor : Theme.of(context).secondaryHeaderColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(radius)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: widthcomponents,
                                child: Icon(
                                  Icons.vpn_key,
                                  size: 20,
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  style: Theme.of(context).textTheme.subtitle1,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                    border: InputBorder.none,
                                    hintText: "password",
                                    hintStyle: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  obscureText: true,
                                  controller:
                                  pass1SignUpValueController,
                                  onChanged: (String value) {
                                    setState(() {
                                      _fieldrequiredPass1SignUp = false;
                                    });
                                  },//controller: ,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        if(_loadingSignUp) Container(
                          height: 2,
                          margin: EdgeInsets.only(left: radius, right: radius),
                          child: LinearProgressIndicator(
                            color: Theme.of(context).secondaryHeaderColor,
                            backgroundColor: Theme.of(context).primaryColor,
                            semanticsLabel: "Sign In in progress",
                          ),
                        ),
                        //SizedBox(height: 10),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap:() {
                            if(mailSignUpValueController.text.isNotEmpty) {
                                if(pass1SignUpValueController.text.isNotEmpty){
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    _loadingSignUp = true;
                                  });
                                  runMutation({
                                    'email':mailSignUpValueController.text,
                                    'password':pass1SignUpValueController.text,
                                  });
                                } else {
                                  _fieldrequiredPass1SignUp = true;
                                }
                            } else {
                              _fieldrequiredEmailSignUp = true;
                            }
                          },
                          child: PrimaryButton(
                            bntText: "Create Account",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).unfocus();
                              _pageState = 1;
                            });
                          },
                          child: OutlineBnt(bntText: "Back"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> saveUserData(String token, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('refreshToken', refreshToken);

    print("Saved token:" + prefs.getString('token').toString());
    print("Saved refreshToken:" + prefs.getString('refreshToken').toString());
  }
}