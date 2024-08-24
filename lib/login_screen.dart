import 'package:coin_ticker/coin_data.dart';
import 'package:coin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:coin_ticker/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  Networking networking = Networking();
  var vBTC;
  var vETH;
  var vLTC;

  void getDatadebut() async {
    try {
      var btc = await networking.getData(cryptoList[0].toString(), 'XOF');
      var eth = await networking.getData(cryptoList[1].toString(), 'XOF');
      var ltc = await networking.getData(cryptoList[2].toString(), 'XOF');

      vBTC = (btc['rate'] as num?)?.toDouble();
      vETH = (eth['rate'] as num?)?.toDouble();
      vLTC = (ltc['rate'] as num?)?.toDouble();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return PriceScreen(btcV: vBTC, ethV: vETH, ltcV: vLTC);
        }),
      );
    } catch (e) {
      print('Erreur lors de la récupération des données: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getDatadebut();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
