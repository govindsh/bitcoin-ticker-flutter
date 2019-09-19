import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'custom_widget.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List<DropdownMenuItem<String>> dropdownMenuItems;
  List<Widget> pickerItems;
  var bitCoinPrice = 'Loading';
  var liteCoinPrice = 'Loading';
  var etheriumPrice = 'Loading';

  DropdownButton<String> androidDropdown() {
    dropdownMenuItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      dropdownMenuItems.add(
        DropdownMenuItem(
          child: Text(currenciesList[i]),
          value: currenciesList[i],
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownMenuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData(selectedCurrency);
          print(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    pickerItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      pickerItems.add(
        Text(currenciesList[i]),
      );
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        scrollController: FixedExtentScrollController(initialItem: 19),
        onSelectedItemChanged: (selectedIndex) {
          getData(currenciesList[selectedIndex]);
          print(selectedIndex);
        },
        children: pickerItems,
      );
  }

  void getData(String currency) async {
    CoinData coinData = CoinData();
    Map response = await coinData.getCoinData(currency);
    setState(() {
      bitCoinPrice = response['BTC'].toString();
      etheriumPrice = response['ETH'].toString();
      liteCoinPrice = response['LTC'].toString();
      selectedCurrency = currency;
      print('Bit coin price = $bitCoinPrice');
    });
  }

  @override
  void initState() {
    super.initState();
    getData(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomWidget(cryptoType: 'BTC', bitCoinPrice: bitCoinPrice, currency: selectedCurrency),
          CustomWidget(cryptoType: 'ETH', bitCoinPrice: etheriumPrice, currency: selectedCurrency),
          CustomWidget(cryptoType: 'LTC', bitCoinPrice: liteCoinPrice, currency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
