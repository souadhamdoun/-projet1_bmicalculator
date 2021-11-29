import 'dart:io';

import 'package:bmicalculator/core/notifiers/bmi_calculate.notifiers.dart';
import 'package:bmicalculator/meta/views/hint_page.dart';
import 'package:bmicalculator/meta/views/OptionsFood.dart';

import 'package:bmicalculator/theme/theme.dart';
import 'package:bmicalculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  final String assetName = 'assets/girl.svg';


  @override
  void initState() {
    heightController = TextEditingController();
    weightController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BmiNotifier bmiNotifier =
        Provider.of<BmiNotifier>(context, listen: false);

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 10,
            toolbarHeight: 70,
            centerTitle: true,
            title: Text(
              "BMI Calculator",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding: kIsWeb
                    ? EdgeInsets.symmetric(horizontal: 50)
                    : EdgeInsets.all(10),
                child: IconButton(
                  onPressed: () {
                    displayModalHint(context);
                  },
                  icon: Icon(
                    Icons.help,
                    color: activeColor,
                    size: 30,
                  ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
          ),
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: kIsWeb ? 500 : 350,
                      width: kIsWeb ? 450 : double.infinity,
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                  assetName,
                                  semanticsLabel: 'Acme Logo',
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.width*0.3,
                              ),
                            ),
                            TextField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Color(0xFFEEEEEE)),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9.]"))
                              ],
                              decoration: InputDecoration(
                                hintText: "Enter Height",
                                hintStyle: TextStyle(color: Color(0xFFEEEEEE)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: fieldColor, width: 5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: fieldColor, width: 5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Height",
                                labelStyle: TextStyle(
                                    color: Color(0xFFEEEEEE), fontSize: 18),
                                suffixText: 'Meters',
                              ),
                            ),
                            TextField(
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Color(0xFFEEEEEE)),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9.]"))
                              ],
                              decoration: InputDecoration(
                                hintText: "Enter Weight",
                                hintStyle: TextStyle(color: Color(0xFFEEEEEE)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: fieldColor, width: 5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: fieldColor, width: 5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Weight",
                                labelStyle: TextStyle(
                                    color: Color(0xFFEEEEEE), fontSize: 18),
                                suffixText: 'Kg',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: 200,
                    child: InkWell(
                      onTap: () async {
                        if (heightController.text.isEmpty ||
                            weightController.text.isEmpty ||
                            heightController.text == '.' ||
                            heightController.text == '..' ||
                            weightController.text == '.' ||
                            weightController.text == '..' ||
                            heightController.text.contains("..") ||
                            weightController.text.contains("..")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Enter you correct height and weight!",
                                  style: TextStyle(fontSize: 16)),
                              backgroundColor: activeColor,
                              duration: Duration(seconds: 3),
                              action: SnackBarAction(
                                label: 'DONE',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                                textColor: primaryColor,
                              ),
                            ),
                          );
                        } else {
                          var height = double.parse(heightController.text);
                          var weight = double.parse(weightController.text);
                          var bmiValue =
                              await bmiNotifier.bmiCalculate(height, weight);
                          var healthStatus;
                          setState(() {
                            bmiValue =
                                double.parse((bmiValue).toStringAsFixed(2));
                            if (bmiValue <= 18.5) {
                              healthStatus = 'Oops!\nYou are underweight.';
                            }
                            if (18.5 <= bmiValue && bmiValue <= 24.9) {
                              healthStatus = 'Awesome!\nYou are healthy.';
                            }
                            if (25 <= bmiValue && bmiValue <= 29.9) {
                              healthStatus = 'Eee!\nYou are over weight.';
                            }
                            if (30 <= bmiValue) {
                              healthStatus = 'Seesh!\nYou are obese.';
                            }


                          });

                          displayModalBottomSheet(
                              context, bmiValue.toString(), healthStatus);
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),


                        child: Text(
                          "Calculate BMI",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 2),
                        ),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: 200,
                    child: InkWell(
                      onTap: () async {
                        if (heightController.text.isEmpty ||
                            weightController.text.isEmpty ||
                            heightController.text == '.' ||
                            heightController.text == '..' ||
                            weightController.text == '.' ||
                            weightController.text == '..' ||
                            heightController.text.contains("..") ||
                            weightController.text.contains("..")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Enter you correct height and weight!",
                                  style: TextStyle(fontSize: 16)),
                              backgroundColor: activeColor,
                              duration: Duration(seconds: 3),
                              action: SnackBarAction(
                                label: 'DONE',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                                textColor: primaryColor,
                              ),
                            ),
                          );
                        } else {
                          var height = double.parse(heightController.text);
                          var weight = double.parse(weightController.text);
                          var bmiValue =
                          await bmiNotifier.bmiCalculate(height, weight);
                          var healthStatus;
                          setState(() {
                            bmiValue =
                                double.parse((bmiValue).toStringAsFixed(2));
                            if (bmiValue <= 18.5) {
                              healthStatus = 'Oops!\nYou are underweight.';
                            }
                            if (18.5 <= bmiValue && bmiValue <= 24.9) {
                              healthStatus = 'Awesome!\nYou are healthy.';
                            }
                            if (25 <= bmiValue && bmiValue <= 29.9) {
                              healthStatus = 'Eee!\nYou are over weight.';
                            }
                            if (30 <= bmiValue) {
                              healthStatus = 'Seesh!\nYou are obese.';
                            }
                          });

                          displayModalBottomSheet(
                              context, bmiValue.toString(), healthStatus);
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),


                        child: Text(
                          "upload image",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 2),
                        ),

                      ),
                    ),
                  ),

                ],
              ),
            ),
          )),
    );
  }
}

void displayModalBottomSheet(context, String bmiValue, healthStatus) {
  showModalBottomSheet(
      context: context,
      backgroundColor: primaryColor,
      builder: (BuildContext bc) {
        return Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Your BMI is: $bmiValue",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEEEEEE)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      healthStatus,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: activeColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute<void>(
                                builder:(BuildContext context) {
                                  return OptionsFood();
                                }));},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Healthy Option ",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )));
      });
}

void displayModalHint(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: primaryColor,

      builder: (BuildContext bc) {
        return Container(height: 300, child: HintPage());
      });
}
