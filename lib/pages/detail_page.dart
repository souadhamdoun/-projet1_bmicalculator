import 'package:flutter/material.dart';
import 'package:bmicalculator/model/food.dart';
import 'package:bmicalculator/widgets/info_card.dart';

class DetailPage extends StatefulWidget {
  final Food item;

  DetailPage(this.item);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Details',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 100),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        )),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: ListView(
                children: <Widget>[
                  Hero(
                    tag: widget.item.image,
                    child: Image(
                      image: AssetImage(widget.item.image),
                      height: 250,
                      width: 250,
                    ),
                  ),
                  Text(
                    widget.item.name,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${widget.item.calorie} Calorie',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                              color: Colors.grey)),
                      Container(
                        height: 25,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 125,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.0),
                          color: Color(0xFF21BFBD),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 25.0,
                                width: 25.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ),
                            Text('2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.0)),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 25.0,
                                width: 25.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.white),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xFF7A9BEE),
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        InfoCard(title: 'WEIGHT', info: '300', unit: 'G'),
                        SizedBox(
                          width: 10,
                        ),
                        InfoCard(title: 'CALORIE', info: '100', unit: 'CAL'),
                        SizedBox(
                          width: 10,
                        ),
                        InfoCard(title: 'VITAMINS', info: 'A, B6', unit: 'VIT'),
                        SizedBox(
                          width: 10,
                        ),
                        InfoCard(title: 'Weight', info: '300', unit: 'G'),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
