import 'package:donation_app/screens/authentication_screen.dart';
import 'package:donation_app/widgets/campaign_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Homescreen extends StatefulWidget {
  static const routeName = "/Home";
  @override
  _Homescreen createState() => _Homescreen();
}

class _Homescreen extends State<Homescreen> {

  
  int money = 180;
  final int totalmoney = 220;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child:
          Container(
            child: RaisedButton(
        onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context)
                .pushReplacementNamed(AuthenticationScreen.routeName);
        },
        child: Text(
            "logout",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
        ) ,
      ),
          ),
        ),
      
    
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ساعد',
          style: TextStyle(
              fontFamily: 'Reem Kufi',
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.teal, Colors.blue])),
        ),
       
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Campaign',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Reem Kufi',
                      ),
                    ),
                    Container(
                      width: 75,
                      height: 25,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.black,
                        onPressed: () {},
                        child: Text(
                          'SEEAll',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                child: Text(
                  'A donation is a gift for charity, humanitarian aid, or to benefit a cause. A donation may take various forms, including money, alms, services, or goods such as clothing, toys, food, or vehicles. ',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Campaignslider(),
              Column(
                children: [
                  Slider(
                      value: money.toDouble(),
                      min: 0,
                      max: totalmoney.toDouble(),
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      onChanged: (double newvalue) {
                        setState(() {
                          money = newvalue.round();
                        });
                      }),
                  Container(
                    margin: EdgeInsets.only(bottom: 60,right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '$money-$totalmoney',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
