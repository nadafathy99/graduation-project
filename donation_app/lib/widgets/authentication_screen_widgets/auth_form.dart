import 'package:donation_app/providers/user_provider.dart';
import 'package:donation_app/widgets/Buttom_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'auth_title.dart';

class AuthForm extends StatefulWidget {
  final Function toggleReset;
  AuthForm(this.toggleReset);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool hidePassword,
      hideConfirmPassword,
      loginMode,
      resetPass,
      loading,
      googleloading;
  double height;
  GlobalKey fieldkey;
  String email, password, confirm, phoneNumber;
  GlobalKey<FormState> form;
  FocusNode passwordNode, confirmNode, phoneNode;
  GoogleSignIn googleLogIn;

  @override
  void initState() {
    super.initState();
    hidePassword = hideConfirmPassword = loginMode = true;
    loading = false;
    googleloading = false;
    height = 0;
    fieldkey = GlobalKey();
    form = GlobalKey<FormState>();
    passwordNode = FocusNode();
    confirmNode = FocusNode();
    phoneNode = FocusNode();
    googleLogIn = GoogleSignIn();
  }

  void showError(String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red[900],
      ),
    );
  }

  void validateLogin() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });

      String error = await Provider.of<UserProvider>(context, listen: false)
          .signin(email, password);
      if (error == null) {
        Navigator.of(context).pushReplacementNamed(Bottomnavbar.routeName);
      } else {
        setState(() {
          loading = false;
        });
        showError(error);
      }
    }
  }

  void validateSignup() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });

      String error = await Provider.of<UserProvider>(context, listen: false)
          .signup(email, password);
      if (error == null) {
        Navigator.of(context).pushReplacementNamed(Bottomnavbar.routeName);
      } else {
        setState(() {
          loading = false;
        });
        showError(error);
      }
    }
  }

  Future<void> googleSignIn() async {
    setState(() {
      googleloading = true;
    });
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        googleloading = false;
      });
      Navigator.of(context).pushReplacementNamed(Bottomnavbar.routeName);
    }
    setState(() {
      googleloading = false;
    });
    print(googleUser);
  }

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (loginMode)
                    ? AuthTitle(UniqueKey(), "Log In")
                    : AuthTitle(UniqueKey(), "Create new account"),
                Form(
                  key: form,
                  child: Column(
                    children: [
                      TextFormField(
                        key: fieldkey,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          passwordNode.requestFocus();
                        },
                        validator: (value) {
                          setState(() {
                            email = value;
                          });
                          if (value.isEmpty) {
                            return 'Email is Required';
                          }

                          if (EmailValidator.validate(email)) {
                            return null;
                          }

                          return 'Invalid email address';
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: "abc@abc.com",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                            ),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          setState(() {
                            password = value;
                          });
                          if (value.isEmpty) {
                            return "Password is required";
                          }

                          if (value.length >= 8) {
                            return null;
                          } else
                            return "Password must be at least 8 characters.";
                        },
                        focusNode: passwordNode,
                        textInputAction: (loginMode)
                            ? TextInputAction.done
                            : TextInputAction.next,
                        onFieldSubmitted: (value) {
                          if (!loginMode) {
                            confirmNode.requestFocus();
                          }
                        },
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          hintText: '•••••••••',
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                            ),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red[900],
                          ),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: Icon(
                              (hidePassword)
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: height,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: (loginMode) ? 0 : 1,
                          child: TextFormField(
                            validator: (value) {
                              setState(() {
                                confirm = value;
                              });
                              if (loginMode || password == value) {
                                return null;
                              } else
                                return "Incorrect password";
                            },
                            focusNode: confirmNode,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              phoneNode.requestFocus();
                            },
                            obscureText: hideConfirmPassword,
                            decoration: InputDecoration(
                              hintText: '•••••••••',
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                ),
                              ),
                              errorStyle: TextStyle(
                                color: Colors.red[900],
                              ),
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    hideConfirmPassword = !hideConfirmPassword;
                                  });
                                },
                                child: Icon(
                                  (hideConfirmPassword)
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: height,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: (loginMode) ? 0 : 1,
                          child: TextFormField(
                            validator: (value) {
                              setState(() {
                                phoneNumber = value;
                              });
                              if (loginMode) return null;
                              if (value.length == 0) {
                                return 'Phone number is required';
                              }
                              if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                  .hasMatch(value)) {
                                return "Please enter valid mobile number";
                              }
                              return null;
                            },
                            focusNode: phoneNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Phone number",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                ),
                              ),
                              errorStyle: TextStyle(
                                color: Colors.red[900],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      widget.toggleReset();
                    },
                    child: Text(
                      "Reset password",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: (loading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : RaisedButton(
                          shape: StadiumBorder(),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            child: (loginMode)
                                ? Text(
                                    'Login',
                                    key: UniqueKey(),
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  )
                                : Text(
                                    'Register',
                                    key: UniqueKey(),
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            (loginMode) ? validateLogin() : validateSignup();
                          },
                        ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: (googleloading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : DecoratedBox(
                          decoration: ShapeDecoration(
                            shape: StadiumBorder(),
                            color: Color.fromRGBO(207, 67, 50, 1),
                          ),
                          child: OutlineButton.icon(
                            shape: StadiumBorder(),
                            label: Text(
                              'Continue with google',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            textColor: Theme.of(context).accentColor,
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                              size: 21,
                            ),
                            onPressed: () async {
                              await googleSignIn();
                            },
                          ),
                        ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: (loginMode)
                      ? Row(
                          key: UniqueKey(),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            FlatButton(
                              onPressed: () {
                                final ctx = fieldkey.currentContext;
                                final box = ctx.findRenderObject() as RenderBox;
                                setState(() {
                                  loginMode = false;
                                  height = box.size.height + 1;
                                });
                              },
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          key: UniqueKey(),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  loginMode = true;
                                  height = 0;
                                });
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
