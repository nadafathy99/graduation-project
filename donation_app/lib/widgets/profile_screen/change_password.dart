import 'package:donation_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../buttom_bar.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  String password;
  FocusNode passNode = FocusNode();
  FocusNode confirmNode = FocusNode();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool loading = false;

  void showError(String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red[900],
      ),
    );
  }

  void changePassword() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });

      String error = await Provider.of<UserProvider>(context, listen: false)
          .changePassword(password);
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(children: [
        Form(
          key: form,
          child: Column(children: [
            TextFormField(
              validator: (value) {
                setState(() {
                  password = value;
                });
                if (value.isEmpty) {
                  return "required to fill";
                }
                if (value.length >= 8) {
                  return null;
                } else
                  return "Password must be at least 8 characters.";
              },
              focusNode: passNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                confirmNode.requestFocus();
              },
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: '•••••••••',
                labelText: "Enter new password",
                labelStyle: TextStyle(
                  fontSize: 16,
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
                    (hidePassword) ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (password == value) {
                  return null;
                } else
                  return "Doesn't match";
              },
              focusNode: confirmNode,
              textInputAction: TextInputAction.done,
              obscureText: hideConfirmPassword,
              decoration: InputDecoration(
                hintText: '•••••••••',
                labelText: "Confirm Password",
                labelStyle: TextStyle(
                  fontSize: 16,
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
          ]),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: (loading)
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                )
              : FlatButton(
                  onPressed: () {
                    changePassword();
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
        ),
      ]),
    );
  }
}
