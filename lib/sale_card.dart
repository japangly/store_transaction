import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'env.dart';
import 'helper/counter.dart';

int _defaultValue = 1;
String _selectedName = 'Name';
List<String> _listEmployee = [
  'SBT',
  'TVFB',
];

class SaleItemCard extends StatefulWidget {
  // final DocumentSnapshot item;
  const SaleItemCard({
    Key key,
  }) : super(key: key);

  @override
  _SaleItemCardState createState() => _SaleItemCardState();
}

class _SaleItemCardState extends State<SaleItemCard> {
  int priceItem = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     priceItem = widget.item.data['sale price'];
  //   });
  // }

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
                padding: const EdgeInsets.fromLTRB(0.0, 64.0, 0.0, 64.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(128.0, 170.0, 128.0, 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        AutoSizeText(
                          // widget.productDocument.data['name'],
                          'Item Name',
                          minFontSize: 36.0,
                          maxFontSize: 256.0,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CounterPlugin(
                            initialValue: _defaultValue,
                            minValue: 1,
                            maxValue: 12,
                            step: 1,
                            buttonSize: 32.0,
                            decimalPlaces: 3,
                            onChanged: (value) {
                              setState(() {
                                _defaultValue = value;
                                // priceItem =
                                //     value * widget.item.data['sale price'];
                              });
                            },
                          ),
                        ),
                        DropdownButton<String>(
                          hint: AutoSizeText(
                            _selectedName,
                            minFontSize: 24.0,
                          ),
                          items: _listEmployee.map((String value) {
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                '\$',
                                minFontSize: 24.0,
                                maxFontSize: 256.0,
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              AutoSizeText(
                                priceItem.toString(),
                                minFontSize: 64.0,
                                maxFontSize: 256.0,
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            elevation: 5.0,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              child: Image.network(
                // widget.item.data['image'],
                'https://groceries.morrisons.com/productImages/381/381011011_0_640x640.jpg?identifier=30dc1370e517daf1fe1b9b269ad5d13a',
                height: Environment().getHeight(height: 16.0),
                width: Environment().getWidth(width: 12.0),
                fit: BoxFit.fill,
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
