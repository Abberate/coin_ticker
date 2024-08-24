import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coin_ticker/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> currencySelectionList = [];
    for (String currency in currencyList) {
      currencySelectionList
          .add(DropdownMenuItem(value: currency, child: Text(currency)));
    }
     return DropdownButton<String>(
        dropdownColor: Colors.lightBlue,
        value: selectedCurrency,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
          });
        },
        items: currencySelectionList);
  }

  CupertinoPicker iosPiker(){
    List<Widget> pikerItems = [];
    for (String currency in currencyList) {
      pikerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
      },
      children: pikerItems,
    );
  }

  // Widget ?getPiker(){
  //   if(Platform.isIOS){
  //     return iosPiker();
  //   }
  //   else if(Platform.isAndroid){
  //     return androidDropdown();
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          '🤑 Coin Ticker',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPiker() : androidDropdown(), // ou fonction de de get picker
          ),
        ],
      ),
    );
  }
}


//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=C2B92570-4AB7-41E7-9F2A-1F9E286EFA4F//