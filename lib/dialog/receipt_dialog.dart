import 'package:flutter/material.dart';
import 'package:store_transaction/themes/helpers/fonts.dart';

import '../env.dart';

class ReceiptDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding:
          const EdgeInsets.only(top: 40.0, right: 20, left: 20, bottom: 20.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 35),
          height: Environment().getHeight(height: 40),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Purchase Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Date: 20/09/2019",
                            style: font20Black,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Consumer No. 000001",
                            style: font20Black,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.black,
                          height: 36,
                        )),
                    Column(
                      children: <Widget>[
                        Table(
                          children: [
                            _buildTableRow("No.,Description, Qty, Subtotal"),
                            _buildTableRow("1.,Sunsilk, 20, \$200.00"),
                            _buildTableRow("2.,Head&Shoulder, 10, \$20.00"),
                            _buildTableRow("3.,Pantene, 40, \$35.00"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              new Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: Divider(
                    color: Colors.black,
                    height: 36,
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '\$35.00',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        )),
                        textColor: Colors.white,
                        color: Colors.pinkAccent,
                        padding: const EdgeInsets.all(15.0),
                        child: new Text(
                          "Print",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TableRow _buildTableRow(String listOfNames) {
  return TableRow(
    children: listOfNames.split(',').map((name) {
      return Container(
        alignment: Alignment.center,
        child: Text(name, style: TextStyle(fontSize: 20.0)),
        padding: EdgeInsets.all(8.0),
      );
    }).toList(),
  );
}
