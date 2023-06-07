import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
const coinAPIUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'ACA88991-74C7-413D-9CDB-AF0E117B3475';
class CoinData {
  var lastPrice;
  String g=' ';
  CoinData({required this.g});
  Future<dynamic> getCoinData() async {
    var requesteduri=Uri.parse('$coinAPIUrl/BTC/$g?apikey=$apiKey');
    http.Response response = await http.get(requesteduri);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
       lastPrice = decodedData['rate'];
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
    return lastPrice;
  }
}