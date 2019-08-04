import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_transaction/service_card.dart';

import 'dialog/stock_dialog.dart';
import 'env.dart';
import 'functions/database.dart';
import 'helper/counter.dart';
import 'item_instock.dart';
import 'item_sale.dart';
import 'sale_card.dart';
import 'themes/helpers/theme_colors.dart';

int _defaultValue = 1;
String _selectedName = 'NAME';
List<String> employeesName = [];

class ConfirmDeductFromStock extends StatefulWidget {
  const ConfirmDeductFromStock({Key key}) : super(key: key);

  @override
  _ConfirmDeductFromStockState createState() => _ConfirmDeductFromStockState();
}

class _ConfirmDeductFromStockState extends State<ConfirmDeductFromStock> {
  List<Widget> cardItem = [];
  List<String> employeesName = [];
  TextEditingController _barcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        centerTitle: true,
        title: AutoSizeText(
          'Stock Deduted',
          minFontSize: 30.0,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  DeductStockCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FloatingActionButton(
              backgroundColor: pinkColor,
              heroTag: 's3',
              elevation: 5.0,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => GridProductInstock(),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                size: 24.0,
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: pinkColor,
            elevation: 5.0,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return StockDialog();
                  });
            },
            child: Icon(
              Icons.print,
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}

class DeductStockCard extends StatefulWidget {
  const DeductStockCard({
    Key key,
    // @required this.productDocument,
    // @required this.employeesName,
  }) : super(key: key);

  // final List<String> employeesName;
  // final DocumentSnapshot productDocument;

  @override
  _DeductStockCardState createState() => _DeductStockCardState();
}

class _DeductStockCardState extends State<DeductStockCard> {
  List<String> employeeName = [];
  int priceItem = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     priceItem = widget.productDocument.data['sale price'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 64.0, 0.0, 64.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(128.0, 200.0, 128.0, 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AutoSizeText(
                        // widget.productDocument.data['name'],
                        'Item Name',
                        minFontSize: 42.0,
                        maxFontSize: 256.0,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: CounterPlugin(
                          initialValue: _defaultValue,
                          minValue: 1,
                          maxValue: 12,
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
                        minFontSize: 24.0,
                        maxFontSize: 256.0,
                        style: TextStyle(color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: DropdownButton<String>(
                          hint: AutoSizeText(
                            _selectedName,
                            minFontSize: 24.0,
                          ),
                          items: employeesName.map((String value) {
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
                'https://groceries.morrisons.com/productImages/381/381011011_0_640x640.jpg?identifier=30dc1370e517daf1fe1b9b269ad5d13a',
                height: Environment().getHeight(height: 16.0),
                width: Environment().getWidth(width: 12.0),
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
    );
  }
}
