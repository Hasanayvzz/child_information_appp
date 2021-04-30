import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username;
  String password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 100.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Çocuk Bilgilendirme Sistemine Hoşgeldiniz",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                    //style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic,
                    // fontSize: 32,fontWeight: FontWeight.bold
                  ),
                  Container(
                    width: 10,
                    child: Divider(
                      height: 15,
                      color: Colors.brown,
                    ),
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: "Kullanıcı Adı",
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Kullanıcı adını giriniz.";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (pass) {
                        username = pass;
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: "Şifre",
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Şifrenizi giriniz.";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (pass) {
                        password = pass;
                      }),
                  loginButton(),
                  Buildimage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.black54, onPrimary: Colors.white),
      child: Text("Giriş Yap"),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          Navigator.pushReplacementNamed(context, "/Home");
        }
      });
  Widget Buildimage() {
    return Column(
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            //mainAxisAlignment: MainAxisAlignment,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset("assets/images/login.png"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
