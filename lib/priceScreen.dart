import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
 String selectedCurrency = 'USD';
class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}
class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      Text(currency);
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }
  // Widget getPicker() {
  //   if (Platform.isIOS) {
  //     return iOSPicker();
  //   } else if (Platform.isAndroid) {
  //     return androidDropdown();
  //   }
  //   return getPicker();
  // }
  String bitcoinValueInUSD = '?';
  void getData() async {
    try {
      double data = await CoinData(g: selectedCurrency).getCoinData();
      setState(() {
        bitcoinValueInUSD = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }
  Widget makeCard(String a){
   return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.pinkAccent,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $a = $bitcoinValueInUSD $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          //   child: Card(
          //     color: Colors.pinkAccent,
          //     elevation: 8.0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          //       child: Text(
          //         '1 BTC = $bitcoinValueInUSD USD',
          //         textAlign: TextAlign.center,
          //         style: const TextStyle(
          //           fontSize: 20.0,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          makeCard('BTC'),
          makeCard('USD'),
          // makeCard('USD', 'BTC'),
          Container(
            height: 125.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.pinkAccent,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}