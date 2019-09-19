import 'dart:convert';
import 'package:http/http.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitCoinURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

class CoinData {

  dynamic getCoinData(String currencyIHave) async {
    Map prices = {};
    for (String crypto in cryptoList) {
      var url = bitCoinURL + crypto + currencyIHave;
      var apiResponse = await get(url);
      print(apiResponse.body);
      var res = jsonDecode(apiResponse.body);
      double lastPrice = res['last'];
      print('Last Price - $lastPrice');
      prices[crypto] = lastPrice;
    }
    return prices;

  }

}
