import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'dialog/receipt_dialog.dart';
import 'helper/counter.dart';

int _defaultValue = 1;
String _selectedName = 'NAME';

class ConfirmDeductFromStock extends StatefulWidget {
  @override
  _ConfirmDeductFromStockState createState() => _ConfirmDeductFromStockState();
}

class _ConfirmDeductFromStockState extends State<ConfirmDeductFromStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          'List Stock',
          minFontSize: 30.0,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          DeductStockCard(),
          DeductStockCard(),
          DeductStockCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5.0,
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return ReceiptDialog();
              });
        },
        child: Icon(
          Icons.print,
          size: 24.0,
        ),
      ),
    );
  }
}

class DeductStockCard extends StatefulWidget {
  const DeductStockCard({
    Key key,
  }) : super(key: key);

  @override
  _DeductStockCardState createState() => _DeductStockCardState();
}

class _DeductStockCardState extends State<DeductStockCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 64.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(128.0, 64.0, 128.0, 64.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        AutoSizeText(
                          'Head & Shoulder',
                          minFontSize: 32.0,
                          maxFontSize: 256.0,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 56.0),
                          child: AutoSizeText(
                            'Shampoo',
                            minFontSize: 24.0,
                            maxFontSize: 256.0,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0),
                          child: CounterPlugin(
                            initialValue: _defaultValue,
                            minValue: 1,
                            maxValue: 11,
                            buttonSize: 32.0,
                            decimalPlaces: 3,
                            onChanged: (value) {
                              setState(() {
                                _defaultValue = value;
                              });
                            },
                          ),
                        ),
                        AutoSizeText(
                          'By',
                          minFontSize: 32.0,
                          maxFontSize: 256.0,
                          style: TextStyle(color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: DropdownButton<String>(
                            hint: AutoSizeText(
                              _selectedName,
                              minFontSize: 24.0,
                            ),
                            items: <String>['Nou TithPanha', 'Num Pang Sach']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: AutoSizeText(
                                  value,
                                  minFontSize: 24.0,
                                ),
                              );
                            }).toList(),
                            onChanged: (selected) {
                              setState(() {
                                _selectedName = selected;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              elevation: 4.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                child: Image.network(
                  'https://images-na.ssl-images-amazon.com/images/I/71QTkaXtxjL._SY355_.jpg',
                  height: 230.0,
                  width: 230.0,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(200.0, 8.0, 200.0, 36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  elevation: 11.0,
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AutoSizeText(
                          'Delete',
                          minFontSize: 24.0,
                          maxFontSize: 256.0,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Icon(
                        Icons.delete,
                        size: 32.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
