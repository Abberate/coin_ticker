
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coin_ticker/coin_data.dart';
import 'dart:io' show Platform;
import 'package:coin_ticker/services/networking.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key, required this.btcV, required this.ethV, required this.ltcV});
  final btcV;
  final ethV;
  final ltcV;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Networking networking = Networking();
  String selectedCurrency = "XOF";
  double? btcValue;
  double? ethValue;
  double? ltcValue;




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
            uiUpdate();
          });
        },
        items: currencySelectionList);
  }

  CupertinoPicker iosPiker() {
    List<Widget> pikerItems = [];
    for (String currency in currencyList) {
      pikerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
        selectedCurrency = currencyList[selectedIndex];
        uiUpdate();
        });
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


  void uiUpdate() async{
      var btc = await networking.getData(cryptoList[0].toString(), selectedCurrency);
      var eth = await networking.getData(cryptoList[1].toString(), selectedCurrency);
      var ltc = await networking.getData(cryptoList[2].toString(), selectedCurrency);
    setState((){
      btcValue = (btc['rate'] as num?)!.toDouble();  // Convert to double
      ethValue = (eth['rate'] as num?)!.toDouble();  // Convert to double
      ltcValue = (ltc['rate'] as num?)!.toDouble();  // Convert to double
    });
  }

  @override
  void initState() {
    super.initState();
    btcValue = widget.btcV;
    ethValue = widget.ethV;
    ltcValue = widget.ltcV;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          '🤑 VALEUR DE CRYPTO',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = ${btcValue?.toStringAsFixed(2) ?? '...'} $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = ${ethValue?.toStringAsFixed(2) ?? '...'} $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = ${ltcValue?.toStringAsFixed(2) ?? '...'} $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? iosPiker()
                : androidDropdown(), // ou fonction de de get picker
          ),
        ],
      ),
    );
  }
}
