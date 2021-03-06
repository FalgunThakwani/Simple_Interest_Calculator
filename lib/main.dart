import 'dart:ffi';

import "package:flutter/material.dart";


void main() {
  runApp(MaterialApp(
      title: "Simple Interest Calculator",
      home: SIForm()
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIForm();
  }
}

class _SIForm extends State<SIForm> {
  var principalAmount = "";
  var rateOfInterest = "";
  var term = "";
  var currencies = ["Rupees", "Dollar", "Pound"];
  var currentItemSelected = "Rupees";
  var _displaytext = "";
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Center(child: imageWidget()),
            TextField(
                decoration: InputDecoration(
                    hintText: "Enter principal amount. eg:12000",
                    border: OutlineInputBorder(),
                    labelText: "Principal Amount"),
              controller:principalController ,
                ),
            TextField
              (decoration: InputDecoration(
                hintText: "In Percent",
                border: OutlineInputBorder(),
                labelText: "Rate of interest %"),
                controller: roiController,
                ),

      Row(
        children: [
          Expanded(
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Duration of the loan",
                    border: OutlineInputBorder(), labelText: "Term"),
                    controller:termController
                ,
              )),
          Expanded(
              child: DropdownButton<String>(
                items: currencies.map((String dropDownSelectedItem) {
                  return DropdownMenuItem<String>(
                    child: Text(dropDownSelectedItem),
                    value: dropDownSelectedItem,
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    this.currentItemSelected = newValue;
                  });
                },
                value: currentItemSelected,
              ))
        ],
      ),
            Row(children: [
              Expanded(
                child: RaisedButton(
                  child: Text("Calculate"),
                  color: Colors.blue,
                  elevation: 6.0,
                  onPressed: () {
                    setState(() {
                      this._displaytext=calculateInterest();
                      debugPrint(_displaytext);
                    });

                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  child: Text("Reset"),
                  color: Colors.grey,
                  elevation: 6.0,
                  onPressed: null,
                ),
              )
            ]
            ),
            Padding(
              padding:EdgeInsets.all(10.0),
              child:Text(this._displaytext)
            )
          ],
        ),),
    );
  }
  String calculateInterest (){
    double principal=double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term=double.parse(termController.text);
    double totalAmountPayable = principal + (principal*roi*term)/100;
    String result = "Your amount of interest for $term years will be $totalAmountPayable";
    return result;
  }
}

Widget imageWidget() {
  AssetImage assetImage = AssetImage('images/interest.png');
  Image image = Image(image: assetImage, height: 150.0, width: 150.0);
  return Container(
    child: image,
  );
}



