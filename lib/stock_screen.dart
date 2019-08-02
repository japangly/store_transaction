import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_transaction/env.dart';
import 'package:store_transaction/functions/firebase_firestore.dart';
import 'package:store_transaction/themes/helpers/theme_colors.dart';

import 'dialog/stock_dialog.dart';
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
        backgroundColor: pinkColor,
        centerTitle: true,
        title: AutoSizeText(
          'List Stock',
          minFontSize: 30.0,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 64.0, right: 64.0, top: 32.0, bottom: 32.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                elevation: 4.0,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Barcode",
                    labelStyle: TextStyle(fontSize: 24.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Database().getStreamCollection(
                    collection: 'products',
                    orderBy: 'name',
                    isDescending: false,
                  ),
                  builder: (BuildContext context, snapshot) {
                    List<Widget> listWidget = [];
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      listWidget.add(DeductStockCard(
                        productDocument: snapshot.data.documents[i],
                      ));
                    }

                    return ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: listWidget,
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}

class DeductStockCard extends StatefulWidget {
  final DocumentSnapshot productDocument;
  const DeductStockCard({
    Key key,
    @required this.productDocument,
  }) : super(key: key);

  @override
  _DeductStockCardState createState() => _DeductStockCardState();
}

class _DeductStockCardState extends State<DeductStockCard> {
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
                  padding: const EdgeInsets.fromLTRB(128.0, 16.0, 128.0, 42.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                        ),
                        child: AutoSizeText(
                          widget.productDocument.data['name'],
                          minFontSize: 24.0,
                          maxFontSize: 256.0,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: AutoSizeText(
                          widget.productDocument.data['category'],
                          minFontSize: 24.0,
                          maxFontSize: 256.0,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: CounterPlugin(
                          initialValue: _defaultValue,
                          minValue: 1,
                          maxValue: widget.productDocument.data['in stock'],
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
                widget.productDocument.data['image'],
                height: Environment().getHeight(height: 12.0),
                width: Environment().getWidth(width: 10.0),
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
