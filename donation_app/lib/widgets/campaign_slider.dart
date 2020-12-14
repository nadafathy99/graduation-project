import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class Campaignslider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: PageIndicatorContainer(
        length: 4,
        indicatorColor: Colors.white,
        // padding: EdgeInsets.all(1),

        shape: IndicatorShape.circle(size: 8),
        child: PageView.builder(itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'assets/images/8ESFH.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              
              
            ],
          );
        }),
      ),
    );
  }
}
