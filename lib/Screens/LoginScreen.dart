import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jettaexstores/Provider/Localapp.dart';
import 'package:jettaexstores/config/Constant.dart';
import 'package:jettaexstores/config/log_in.dart';
import 'package:jettaexstores/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homepage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController StoreEmail = new TextEditingController();
  TextEditingController StorePassword = new TextEditingController();
  GlobalKey<FormState> EmailState = new GlobalKey<FormState>();
  GlobalKey<FormState> PasswordState = new GlobalKey<FormState>();
  var lang = sharedPreferences.getString("lang");
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PrimaryColor,
        body: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loginlogocontainer(context),
                logintextwelcomecontainer(context),
                loginstoreconterinr(
                    context,
                    StoreEmail,
                    EmailState,
                    TextInputType.emailAddress,
                    Icons.email,
                    getLang(context, "LogStoreName")),
                logignpasscontiner(context),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    final SharedPreferences logprefs =
                        await SharedPreferences.getInstance();
                    logprefs.setString('e', StoreEmail.text);
                    logprefs.setString('p', StorePassword.text);
                    sharedPreferences.setBool("Remember", true);

                    loginp(
                            email: logprefs.getString('e'),
                            password: logprefs.getString('p'))
                        .login(context)
                        .then((value) {
                      setState(() {});
                    });
                    // print(logprefs.getString('e'));
                    // print(logprefs.getString('p'));
                  },
                  child: loginsavebutton(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container logignpasscontiner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      height: MediaQuery.of(context).size.height * .07,
      width: MediaQuery.of(context).size.width * .85,
      child: TextFormField(
        obscureText: _passwordVisible,
        controller: StorePassword,
        key: PasswordState,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          icon: IconButton(
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            icon: Icon(
              _passwordVisible ? Icons.visibility_sharp : Icons.visibility_off,
              color: SecondryColor,
            ),
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          hintText: getLang(context, "LogStorePass"),
          hintStyle: TextStyle(
            color: SecondryColor,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
