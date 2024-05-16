import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController billController = TextEditingController();
  TextEditingController customTipController = TextEditingController();


  Color globalColor = Color(0xFF01C1B5);

  String bold = 'ubuntu-bold';

  String currency = "₹";

  int split = 1;
  double totalPerson = 0;
  double billamt = 0.0;
  double tipPer = 0.0;
  double totalTipPer = 0.0;
  double totalBillAmt = 0.0;
  double perPerson = 0.0;
  double customTip = 0.0;
  bool isContainer = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFF3F0F1),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                    child: appLogo(),
                ),
                Expanded(
                  flex: 2,
                    child: billCard(),
                ),
                Expanded(
                    child: EnterAmt(),
                ),
                Expanded(
                    child: chooseTip()
                ),
                Expanded(
                    child: SplitBill(),
                ),
              ],
            ),
          ),
        )
    );
  }

  /// part 1 Logo
  Widget appLogo(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/hat.png", scale: 8),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                    text: "Mr ",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'ubuntu-bold'
                    ),
                    children: [
                      TextSpan(
                        text: "Tip",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ubuntu-bold'
                        ),
                      )
                    ]
                ),
              ),
              Text(
                "Calculator",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'ubuntu-bold'
                ),
              )
            ],
          )
        ]
    );
  }

  /// part 2 Bill Container
  Widget billCard(){
    return Card(
      elevation: 10,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total p/person",
              style: TextStyle(
                fontFamily: 'ubuntu-bold',
                fontSize: 20,
              ),
            ),
            Text.rich(
                TextSpan(
                    text: currency,
                    style: TextStyle(
                      fontFamily: 'ubuntu-bold',
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: "${perPerson == 0.0 ? "000" : perPerson.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontFamily: 'ubuntu-bold',
                          fontSize: 60,
                        ),
                      )
                    ]
                )
            ),
            Divider(
              indent: 30,
              endIndent: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "total bill",
                        style: TextStyle(
                          fontFamily: 'ubuntu-bold',
                          fontSize: 15,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                            text: currency,
                            style: TextStyle(
                              fontFamily: 'ubuntu-bold',
                              fontSize: 15,
                              color: globalColor,
                            ),
                            children: [
                              TextSpan(
                                text: "${billamt == 0.0 ? "000" : billamt}",
                                style: TextStyle(
                                  fontFamily: 'ubuntu-bold',
                                  fontSize: 25,
                                  color: globalColor,
                                ),
                              )
                            ]
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "total tip",
                        style: TextStyle(
                          fontFamily: 'ubuntu-bold',
                          fontSize: 15,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                            text: currency,
                            style: TextStyle(
                              fontFamily: 'ubuntu-bold',
                              fontSize: 15,
                              color: globalColor,
                            ),
                            children: [
                              TextSpan(
                                text: "${totalTipPer == 0.0 ? "000" : totalTipPer.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontFamily: 'ubuntu-bold',
                                  fontSize: 25,
                                  color: globalColor,
                                ),
                              )
                            ]
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// part 3 Enter amount
  Widget EnterAmt(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTexts(
              headText: 'Enter',
              subText: 'your bill'
          ),
          SizedBox(width: 30,),
          Expanded(
            child: TextField(
              style: TextStyle(
                  fontFamily: 'ubuntu-bold',
                  fontSize: 30,
                  color: Colors.black
              ),
              onChanged: (value) => calculations(),
              controller: billController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  suffixText: "₹",
                  hintStyle: TextStyle(
                      fontFamily: 'ubuntu-bold',
                      fontSize: 30,
                      color: Colors.black
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// part 4 Choose tip
  Widget chooseTip(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          customTexts(headText: "Choose", subText: "your tip"),
          SizedBox(width: 30,),
          Column(
            children: [
              Row (
                children: [
                  customContainerButton(percent: '10'),
                  SizedBox(width: 7,),
                  customContainerButton(percent: '15'),
                  SizedBox(width: 7,),
                  customContainerButton(percent: '20'),
                ],
              ),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  isContainer = true;
                  setState(() {

                  });
                },
                onDoubleTap: (){
                  isContainer = false;
                  setState(() {

                  });
                },
                child: Stack(
                  children: [
                    isContainer? SizedBox(
                      height : 50,
                      width: 200,
                      child: TextField(
                        style: TextStyle(
                            fontFamily: 'ubuntu-bold',
                            fontSize: 30,
                            color: Colors.black
                        ),
                        onChanged: (value) => calculations(),
                        controller: customTipController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            suffixText: currency,
                            hintStyle: TextStyle(
                                fontFamily: 'ubuntu-bold',
                                fontSize: 25,
                                color: Colors.black
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                    ) :
                    Container(
                      height : 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: globalColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                            "Custom Tip",
                            style: TextStyle(
                                fontFamily: bold,
                                fontSize: 25,
                                color: Colors.white
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /// part 5 split total
  Widget SplitBill(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTexts(headText: "Split", subText: "the total"),
          SizedBox(width: 30,),
          Expanded(
            /// minus
              child: InkWell(
                onTap: (){
                  if(split > 1) {
                    split--;
                    calculations();
                  }
                },
                child: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                      color: globalColor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft: Radius.circular(10))
                  ), child: Center(
                    child: Text(
                      "-",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: bold,
                      ),
                    )
                ),
                ),
              )                                ),

          /// digit
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
              color: Colors.white,
            ),
            child: Center(
                child: Text(
                  split.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: bold,

                  ),
                )
            ),
          ),

          /// plus
          Expanded(
              child: InkWell(
                onTap: (){
                  split++;
                  calculations();
                },
                child: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                      color: globalColor,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10))
                  ), child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: bold,
                      ),
                    )
                ),
                ),
              )
          ),
        ],
      ),
    );
  }

  customTexts({required String headText, required String subText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headText,
          style: TextStyle(
            fontFamily: 'ubuntu-bold',
            fontSize: 20,
          ),
        ),
        Text(
          subText,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  customContainerButton({required String percent}){
    return InkWell(
      onTap: (){
        tipPer = double.parse(percent);
        calculations();
      },
      child: Container(
        height : 50,
        width: 62,
        decoration: BoxDecoration(
          color: globalColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text.rich(
              TextSpan(
                  text: percent,
                  style: TextStyle(
                      fontFamily: bold,
                      fontSize: 30,
                      color: Colors.white
                  ),
                  children: [
                    TextSpan(
                      text: "\%",
                      style: TextStyle(
                          fontSize: 10
                      ),
                    )
                  ]
              )
          ),
        ),
      ),
    );
  }

  // void calculations(){
  //
  //  if(billController.text != ""){
  //
  //    billamt = double.parse(billController.text.toString());
  //
  //    log(billamt.toString());
  //
  //    totalTipPer = billamt * (tipPer / 100);
  //
  //    log(customTipController.text.toString());
  //
  //    totalBillAmt = billamt + totalTipPer;
  //
  //    customTip = double.parse(customTipController.text.toString());
  //
  //    perPerson = totalBillAmt / split + customTip;
  //
  //    setState(() {
  //
  //    });
  //
  //  } else {
  //    split = 1;
  //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Bill First")));
  //  }
  // }

  void calculations() {
    if (billController.text.isNotEmpty) {
      try {
        billamt = double.parse(billController.text);
       if(isContainer){
         totalTipPer = double.tryParse(customTipController.text) ?? 0.0;
       } else {
         totalTipPer = billamt * (tipPer / 100);
       }
        totalBillAmt = billamt + totalTipPer;
        perPerson = totalBillAmt / split;
        setState(() {});
      } catch (e) {
        // Handle the error, for example:
        print('Error parsing double: $e');
      }
    } else {
      split = 1;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Enter Bill First")),
      );
    }
  }


}