import 'dart:convert' show json;

import 'package:http/http.dart' as http;

const apiKey = "301EE9C3-C01C-43E0-986D-3FD9E39B70D6";

class Networking{
  Future<dynamic> getData(String coin, String currency) async{
    var url = Uri.https("rest.coinapi.io","v1/exchangerate/$coin/$currency",{'apikey': apiKey});
    var response = await http.get(url);

    if(response.statusCode == 200){
      return(json.decode(response.body));
    } else{
      throw Exception("Erreur de récupération de données: ${response.statusCode}");    }
  }

}


//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=C2B92570-4AB7-41E7-9F2A-1F9E286EFA4F//