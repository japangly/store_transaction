import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'helper/counter.dart';

int _defaultValue = 0;

class SalePickItem extends StatefulWidget {
  @override
  _SalePickItemState createState() => _SalePickItemState();
}

class _SalePickItemState extends State<SalePickItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sale Item'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(64.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 64.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            'Item Name',
                            minFontSize: 36.0,
                            maxFontSize: 256.0,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          AutoSizeText(
                            'Category',
                            minFontSize: 24.0,
                            maxFontSize: 256.0,
                            style: TextStyle(color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CounterPlugin(
                              initialValue: _defaultValue,
                              minValue: 0,
                              maxValue: 11,
                              buttonSize: 32.0,
                              decimalPlaces: 2,
                              onChanged: (value) {
                                setState(() {
                                  _defaultValue = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  '\$',
                                  minFontSize: 32.0,
                                  maxFontSize: 256.0,
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                                AutoSizeText(
                                  '25',
                                  minFontSize: 64.0,
                                  maxFontSize: 256.0,
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(),
                ),
              ],
            ),
          ),
          Image.network(
            'https://www.beatsbydre.com/content/dam/beats/web/pcp/headphones/pro/_0002_overear-pro-black-rgb-thrqrtleft.png.small.2x.png',
            height: 300.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(312.0, 0.0, 312.0, 32.0),
                child: RaisedButton(
                  elevation: 11.0,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                          'Print',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.print,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
