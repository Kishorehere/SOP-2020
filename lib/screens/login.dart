import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Files imported
import 'package:inductions_20/screens/widgets/custom_button.dart';
import 'package:inductions_20/screens/widgets/custom_input.dart';
import 'package:inductions_20/theme/styling.dart';

final _formKey = GlobalKey<FormState>();
final _rollnocontroller = TextEditingController();
final _passwordcontroller = TextEditingController();

class LoginScreen extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginScreen> {
  double headingfontsize;
  double inputfieldwidth;
  double signinwidth;
  double signinheight;
  double padding;
  double fontsize;
  double imagesize;
  double containerwidth;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (width <= 400) {
      headingfontsize = 25;
      imagesize = 190;
      containerwidth = 300;
      inputfieldwidth = 250;
      signinwidth = 250;
      signinheight = 50;
      padding = 15.0;
      fontsize = 18.0;
    } else if (width <= 600) {
      headingfontsize = 25;
      imagesize = 190;
      containerwidth = 300;
      inputfieldwidth = 250;
      signinwidth = 250;
      signinheight = 50;
      padding = 15.0;
      fontsize = 18.0;
    } else if (width <= 900) {
      headingfontsize = 25;
      imagesize = 200;
      containerwidth = 350;
      inputfieldwidth = 300;
      signinwidth = 250;
      signinheight = 50;
      padding = 15.0;
      fontsize = 20.0;
    } else {
      headingfontsize = 25;
      imagesize = 230;
      containerwidth = 350;
      inputfieldwidth = 300;
      signinwidth = 300;
      signinheight = 50;
      padding = 15.0;
      fontsize = 20.0;
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[
              theme.secondaryColor,
              theme.primaryColor,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                ),
                Image(
                  image: AssetImage(
                    'assets/images/SpiderLogo.webp',
                  ),
                  height: imagesize,
                  width: imagesize,
                ),
                Container(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Container(
                    width: containerwidth,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: inputfieldwidth,
                              child: Padding(
                                padding: EdgeInsets.all(padding),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Sign',
                                      style: TextStyle(
                                        color: theme.fontColor,
                                        fontSize: headingfontsize,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    Text(
                                      'In',
                                      style: TextStyle(
                                        color: theme.tertiaryColor,
                                        fontSize: headingfontsize,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(padding),
                            child: CustomInput(
                              Icons.person,
                              "Roll number",
                              (value) {
                                if (value.isEmpty) {
                                  return 'Enter roll number';
                                } else if (!isNumeric(value)) {
                                  return 'Enter a valid roll number';
                                } else if (value.toString().length > 9 ||
                                    value.toString().length < 9) {
                                  return 'Enter a valid roll number';
                                }
                                return null;
                              },
                              false,
                              TextInputType.number,
                              inputfieldwidth,
                              fontsize,
                              _rollnocontroller,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(padding),
                            child: CustomInput(
                              Icons.lock,
                              "Password",
                              (value) {
                                if (value.isEmpty) {
                                  return 'Enter password';
                                }
                                return null;
                              },
                              true,
                              TextInputType.text,
                              inputfieldwidth,
                              fontsize,
                              _passwordcontroller,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(padding, 0.0, padding, 0.0),
                            child: CustomButton(
                              'Sign In',
                              () async {
                                if (_formKey.currentState.validate()) {
                                  // set up POST request arguments
                                  String url =
                                      "https://spider.nitt.edu/inductions20/login";
                                  Map<String, String> headers = {
                                    "Content-type": "application/json",
                                  };
                                  String rollno =
                                      _rollnocontroller.text.toString();
                                  String password = _passwordcontroller.text;
                                  String Json =
                                      '{"rollno": "$rollno", "password": "$password"}';
                                  Response response = await post(url,
                                      headers: headers, body: Json);
                                  int statusCode = response.statusCode;
                                  var parsedJson = json.decode(response.body);
                                  if (parsedJson["success"] == true) {
                                    // direct to mentor page or mentee page based on jwt
                                    final String jwt = parsedJson["token"];
                                    final storage = new FlutterSecureStorage();
                                    await storage.write(
                                        key: "jwt", value: "$jwt");
                                    if (parsedJson["is_first_time"] == true) {
                                      Navigator.pushNamed(
                                          context, '/github_username');
                                    } else {
                                      String stored_jwt =
                                          await storage.read(key: "jwt");
                                      final decoded_jwt =
                                          base64.decode(stored_jwt);
                                      print(decoded_jwt);
                                    }
                                  } else {
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Spider Orientation"),
                                      content: Text(
                                          "Incorrect roll number and password"),
                                      actions: [
                                        FlatButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('dialog');
                                          },
                                        ),
                                      ],
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  }
                                }
                              },
                              signinwidth,
                              signinheight,
                              fontsize,
                            ),
                          ),
                          Container(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
