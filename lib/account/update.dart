import 'package:skiiya_admin/Responsive/responsive_widget.dart';
import 'package:skiiya_admin/account/login.dart';
import 'package:skiiya_admin/app/skiiyaBet.dart';
import 'package:skiiya_admin/database/selection.dart';
import 'package:skiiya_admin/mywindow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool lenOld = false;
  bool lenNew = false;
  bool lenConNew = false;

  // bool invOld = false;
  // bool invNew = false;
  // bool invConNew = false;

  String oldPassword = '';
  String newPassword = '';
  String newConfirmPassword = '';
  // messages variables
  String messOld = '';
  String messNew = '';
  String messConNew = '';
  // display loding state of button
  bool displayUpdateLoading = false;

  @override
  Widget build(BuildContext context) {
    if (Selection.user == null) {
      return Expanded(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
          padding: new EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5),
              bottom: BorderSide(color: Colors.grey, width: 0.5),
              left: BorderSide(color: Colors.grey, width: 0.5),
              right: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: Center(
            child: Text(
              'S\'il vous plaît! Connectez-Vous d\'abord.',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(
              left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
          padding: new EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5),
              bottom: BorderSide(color: Colors.grey, width: 0.5),
              left: BorderSide(color: Colors.grey, width: 0.5),
              right: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.only(top: 0.0),
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Changer Mot de Passe',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Divider(color: Colors.grey, thickness: 0.4),
              SizedBox(height: 20.0),
              // Divider(color: Colors.grey, thickness: 0.4),
              // SizedBox(height: 10.0),
              Text(
                'Ancien Mot de Passe',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      top:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      bottom:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      left:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      right:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                    )),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      if (isNoData(value)) {
                        lenOld = false;
                      }
                      // execute if the lenght is >6 and <15
                      else if (isNoSized(value)) {
                        lenOld = true;
                        messOld = 'Longueur de mot de passe non accepté';
                        return false;
                      } else {
                        lenOld = false;
                        messOld = '';
                        oldPassword = value;
                        return true;
                      }
                    });
                  },
                  obscureText: true,
                  cursorColor: Colors.lightGreen,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        new RegExp(r'[a-zA-Z0-9]')),
                  ],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ancien Mot de Passe',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ),
              ),
              SizedBox(height: 3.0),
              if (lenOld)
                Text(
                  messOld,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
              SizedBox(height: 20.0),
              // Divider(color: Colors.grey, thickness: 0.4),
              // SizedBox(height: 10.0),
              Text(
                'Nouveau Mot de Passe',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      top:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      bottom:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      left:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      right:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                    )),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      if (isNoData(value)) {
                        lenNew = false;
                      }
                      // execute if the lenght is >6 and <15
                      else if (isNoSized(value)) {
                        lenNew = true;
                        messNew = 'Longueur de mot de passe non accepté';
                        return false;
                      } else {
                        lenNew = false;
                        messNew = '';
                        newPassword = value;
                        return true;
                      }
                    });
                  },
                  obscureText: true,
                  cursorColor: Colors.lightGreen,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        new RegExp(r'[a-zA-Z0-9]')),
                  ],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // fillColor: Colors.deepOrange[400],
                      // contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Nouveau Mot de Passe',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ),
              ),
              SizedBox(height: 3.0),
              if (lenNew)
                Text(
                  messNew,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
              SizedBox(height: 20.0),
              // Divider(color: Colors.grey, thickness: 0.4),
              // SizedBox(height: 10.0),
              Text(
                'Confirmer Mot de Passe',
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
              ),
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      top:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      bottom:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      left:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                      right:
                          BorderSide(color: Colors.lightGreen[400], width: 2.0),
                    )),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      if (isNoData(value)) {
                        lenConNew = false;
                      }
                      // execute if the lenght is >6 and <15
                      else if (isNoSized(value)) {
                        lenConNew = true;
                        messConNew = 'Longueur de mot de passe non accepté';
                        return false;
                      } else {
                        lenConNew = false;
                        messConNew = '';
                        newConfirmPassword = value;
                        return true;
                      }
                    });
                  },
                  obscureText: true,
                  cursorColor: Colors.lightGreen,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        new RegExp(r'[a-zA-Z0-9]')),
                  ],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // fillColor: Colors.deepOrange[400],
                      // contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Confirmer Mot de Passe',
                      hintMaxLines: 1,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ),
              ),
              SizedBox(height: 3.0),
              if (lenConNew)
                Text(
                  messConNew,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
              SizedBox(height: 30.0),
              Container(
                width: double.infinity,
                child: displayUpdateLoading
                    ? RawMaterialButton(
                        padding: new EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: null,
                        fillColor: Colors.lightGreen[200],
                        disabledElevation: 1.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Chargement',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                            SizedBox(width: 3.0),
                            SpinKitCircle(
                              color: Colors.white,
                              size: 13.0,
                            ),
                          ],
                        ),
                      )
                    : RawMaterialButton(
                        padding: EdgeInsets.all(15.0),
                        onPressed: () {
                          setState(() {
                            // show the loading status of the button
                            displayUpdateLoading = true;
                            if (oldPassword.length < 6 ||
                                oldPassword.length > 15) {
                              // check if the old input password is well formatted
                              lenOld = true;
                              messOld = 'Mot de Passe Invalide';
                              // hide the loading status of the button
                              displayUpdateLoading = false;
                            } else {
                              lenOld = false;
                              if (newPassword.length < 6 ||
                                  newPassword.length > 15) {
                                // confirm the lenght of the new password
                                lenNew = true;
                                messNew = 'Mot de Passe Invalide';
                                // hide the loading status of the button
                                displayUpdateLoading = false;
                              } else {
                                lenNew = false;
                                if (newConfirmPassword.length < 6 ||
                                    newConfirmPassword.length > 15) {
                                  // if the confirm new password is right
                                  lenConNew = true;
                                  messConNew = 'Mot de Passe Invalide';
                                  // hide the loading status of the button
                                  displayUpdateLoading = false;
                                } else {
                                  // check if old and new password match
                                  if (newPassword
                                          .compareTo(newConfirmPassword) ==
                                      0) {
                                    lenConNew = false;
                                    // do update password process in here
                                    // check if the user has logged in first
                                    if (Selection.user == null) {
                                      // hide the loading status of the button
                                      displayUpdateLoading = false;
                                      showMessage(Colors.red,
                                          'S\'enregistrer d\'abord');
                                    } else {
                                      // initialize the firebase instance
                                      // FirebaseUser _auth =  FirebaseAuth.instance.currentUser() as FirebaseUser;
                                      String phone = Selection.userTelephone
                                          .substring(1, 10);
                                      // print(phone);
                                      String code = '243';
                                      String generatedEmail =
                                          (code + phone + '@gmail.com');
                                      // print('generated Email: $generatedEmail');
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: generatedEmail,
                                              password: oldPassword)
                                          .then((value) async {
                                        // if this account exists then change the user password
                                        // FirebaseUser _auth = new FirebaseAuth.instance.currentUser();
                                        //Create an instance of the current user.
                                        FirebaseUser _auth = await FirebaseAuth
                                            .instance
                                            .currentUser();
                                        _auth
                                            .updatePassword(newPassword)
                                            .then((value) {
                                          // if the user has successfully updated the password
                                          showMessage(Colors.lightGreen[400],
                                              'Mot de passe changé');
                                          // sign the user out to test the new password
                                          Login.doLogout();
                                          // redirect the user to login page
                                          Window.showWindow = 8;
                                          // set the show change status to true
                                          Selection.isPasswordChanged = true;
                                          // sleep for some time before changing the window
                                          // sleep(Duration(seconds: 4));
                                          // hide the loading status of the button
                                          displayUpdateLoading = false;
                                          // reload the main frame so that we can be redirected to the login page
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => SkiiyaBet()));
                                        }).catchError((e) {
                                          setState(() {
                                            // hide the loading status of the button
                                            displayUpdateLoading = false;
                                            // if password reset failed
                                            // print('update password error is: $e');
                                            showMessage(Colors.red,
                                                'Mise à jour a échoué');
                                          });
                                        });
                                        // print('sign in successfully');
                                      }).catchError((e) {
                                        setState(() {
                                          // hide the loading status of the button
                                          displayUpdateLoading = false;
                                          // display if the account was found or any other error
                                          // print('the login error is: $e');
                                          showMessage(Colors.red,
                                              'Ancien mot de passe incorrect');
                                        });
                                      });
                                    }
                                  } else {
                                    // hide the loading status of the button
                                    displayUpdateLoading = false;
                                    messConNew =
                                        'Les mots de passe ne correspondent pas';
                                    lenConNew = true;
                                    return false;
                                  }
                                }
                              }
                            }
                          });
                        },
                        fillColor: Colors.lightGreen[400],
                        disabledElevation: 3.0,
                        child: Text(
                          'Changer mot de passe'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );
    }
  }

  bool isNoSized(String input) {
    if (input.length < 6 || input.length > 15) {
      return true;
    }
    return false;
  }

  bool isNoData(String input) {
    if (input.isEmpty) {
      return true;
    }
    return false;
  }

  showMessage(Color color, String message) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: color,
        duration: Duration(seconds: 3),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}

// class Firebase {}
