import 'package:flutter/material.dart';
import 'package:coin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  List<DropdownMenuItem<String>> currencySelectionList = [];

  @override
  void initState() {
    super.initState();
    int i;
    for (i = 0; i < currenciesList.length; i++) {
      currencySelectionList.add(DropdownMenuItem(
          value: currenciesList[i].toString(),
          child: Text(currenciesList[i].toString())));
    }
    ;
  }

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
            child: DropdownButton<String>(
              dropdownColor: Colors.lightBlue,
                value: selectedCurrency,
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                },
                items: currencySelectionList),
          ),
        ],
      ),
    );
  }
}
