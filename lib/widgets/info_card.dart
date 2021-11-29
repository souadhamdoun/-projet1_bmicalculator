import 'package:flutter/material.dart';

Widget InfoCard({required String title, required String info, required String unit}) {
  return InkWell(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF21BFBD),
        border: Border.all(
            color: Colors.transparent, style: BorderStyle.solid, width: 0.75),
      ),
      height: 100,
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15.0),
            child: Text(title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12.0,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 8),
            child: Column(
              children: <Widget>[
                Text(
                  info,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  unit,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
