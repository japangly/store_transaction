import 'package:flutter/material.dart';

import 'dialog/add_service_dialog.dart';
import 'dialog/receipt_dialog.dart';
import 'sale_card.dart';
import 'service_card.dart';

class ListTotal extends StatefulWidget {
  @override
  _ListTotalState createState() => _ListTotalState();
}

class _ListTotalState extends State<ListTotal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('List Calculate Money'),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ServicePriceCard(),
          SaleItemCard(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FloatingActionButton(
              heroTag: 's1',
              elevation: 5.0,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AddServices();
                    });
              },
              child: Icon(
                Icons.add,
                size: 24.0,
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: 's2',
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
        ],
      ),
    );
  }
}
