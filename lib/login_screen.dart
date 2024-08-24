import 'package:coin_ticker/coin_data.dart';
import 'package:coin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:coin_ticker/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  Networking networking = Networking();
  late double vBTC;
  late double vETH;
  late double vLTC;

  void getDatadebut() async {
      var btc = await networking.getData(cryptoList[0].toString(), 'XOF');
      var eth = await networking.getData(cryptoList[1].toString(), 'XOF');
      var ltc = await networking.getData(cryptoList[2].toString(), 'XOF');
      vBTC = (btc['rate'] as num?)!.toDouble();
      vETH = (eth['rate'] as num?)!.toDouble();
      vLTC = (ltc['rate'] as num?)!.toDouble();

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PriceScreen(btcV: vBTC, ethV: vETH, ltcV: vLTC);
      }));
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
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
