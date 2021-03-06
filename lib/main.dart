import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        title: 'Simple Interest Calculator App',
        home: SIForm(),
      ) //Material App
  );
 }
 
 class SIForm extends StatefulWidget{

 
   @override
   State<StatefulWidget> createState() {git

     return _SIFormState();
    }
 }

 class _SIFormState extends State<SIForm> {

  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
final double _minimumPadding = 5.0;

 var _currentItemsSelected = 'Rupees';

 TextEditingController principalController = TextEditingController();
 TextEditingController roiController = TextEditingController();
 TextEditingController termController = TextEditingController();

 var displayResult = '';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text('Simple Interest Calculator'),

      ),

      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),


        child: ListView(
           children: <Widget>[

             getImageAsset(),
             Padding(
               padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
             child: TextField(
               keyboardType: TextInputType.number,
               controller: principalController,
               decoration: InputDecoration(
                 labelText: 'Principal',
                 hintText: 'Enter Principal eg 1200',
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(5.0)
                 )
               ),
             )),
             Padding(
                 padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                 child: TextField(
               keyboardType: TextInputType.number,
               controller: roiController,
               decoration: InputDecoration(
                   labelText: 'Rate of Simple Interest',
                   hintText: 'In Percent',
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(5.0)
                   )
               ),
             )),
             Padding(
               padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
               child: Row(
               children: <Widget>[
                 Expanded(child:TextField(
                   keyboardType: TextInputType.number,
                   controller: termController,
                   decoration: InputDecoration(
                       labelText: 'Term',
                       hintText: 'Time in years',
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5.0)
                       )
                   ),
                 )),

                 Container(width: _minimumPadding*5),

                 Expanded(child: DropdownButton<String>(
                     items: _currencies.map((String value) {
                       return DropdownMenuItem<String>(
                           value: value,
                           child: Text(value),
                       );
                     }).toList(),

                       value: _currentItemsSelected,




                 ))
             ],

        )),

          Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),

              child: Row(children: <Widget>[
            
                Expanded(
                child: RaisedButton(
                  child: Text('Calculate'),
                  onPressed: () {
                    setState(() {
                      this.displayResult = _calculateTotalReturns();
                    });

                  },

                ),
                 ),
                 Expanded(
                  child: RaisedButton(
                  child: Text('Reset'),
                  onPressed: () {
                    setState(() {
                      _reset();
                    });

                  },

                ),
            ),
          ],)),

             Padding(
                 padding: EdgeInsets.all(_minimumPadding*2),
                 child: Text(this.displayResult),
             )
      ],
    ),
      ),
    );

  }
  Widget getImageAsset() {

    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 10),);
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemsSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentItemsSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemsSelected = _currencies[0];
  }
 }

