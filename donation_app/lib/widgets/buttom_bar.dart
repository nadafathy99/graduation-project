
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donation_app/screens/add_donation.dart';
import 'package:donation_app/screens/add_request.dart';
import 'package:donation_app/screens/categories.dart';
import 'package:donation_app/screens/home_screen.dart';
import 'package:donation_app/screens/lost.dart';
import 'package:flutter/material.dart';

class Bottomnavbar extends StatefulWidget {
  static const routeName = "/navbar";
  @override
  _BottomnavbarState createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int pageindex=0;

  final Donation _donation=Donation();

  final Lost _more=Lost();

  final Categories _categories = Categories();

  final Request _notification = Request();
   final Homescreen _myHomePage = Homescreen();


  Widget _showpage=Homescreen();

  Widget pagechosser(int page){
    switch(page){
      case 0:
      return _myHomePage ;
      break;
      case 1:
      return _notification;
      break;
      case 2:
      return _donation;
      break;
      case 3:
      return _more;
      break;
      case 4:
      return _categories;
      break;
      default:return Container(child: Text('no pages'),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 400),
        color: Colors.blueAccent,
        height: 50,
        backgroundColor:  Colors.white,
        index: pageindex,
        
        items: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                   fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle,
                size: 30,
                color: Colors.white,
              ),
              Text(
                'Request',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_box,
                size: 30,
                color: Colors.white,
              ),
              Text(
                'Donation',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
      
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              Text(
                'losts',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category,
                size: 30,
                color: Colors.white,
              ),
              Text(
                'categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
        onTap: (int tappedindex) {
        setState(() {
          _showpage =pagechosser(tappedindex);
        });
         

          //Handle button tap
        },
      ),
      body: Center(
        child: _showpage,
      ),
      
      
    );
  }
}

