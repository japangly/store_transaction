import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import 'dialog/add_service_dialog.dart';
import 'dialog/receipt_dialog.dart';
import 'functions/firebase_firestore.dart';
import 'helper/search_library.dart';
import 'sale_card.dart';
import 'themes/helpers/theme_colors.dart';

class ListTotal extends StatefulWidget {
  const ListTotal({
    Key key,
  }) : super(key: key);

  @override
  _ListTotalState createState() => _ListTotalState();
}

List<Widget> addService = [];

class _ListTotalState extends State<ListTotal> {
  final _formKey = new GlobalKey<FormState>();
  List<Widget> cardItem = addService;

  String _name = 'No one';

  _buildMaterialSearchPage(
      BuildContext context, List<DocumentSnapshot> documents) {
    return new MaterialPageRoute<String>(
        settings: RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return StreamBuilder<QuerySnapshot>(
              stream: Database().getStreamCollection(
                collection: 'products',
                orderBy: 'name',
                isDescending: false,
              ),
              builder: (context, snapshot) {
                return Material(
                  child: MaterialSearch<String>(
                    placeholder: 'Search',
                    results: documents
                        .map((DocumentSnapshot v) =>
                            MaterialSearchResult<String>(
                              imageSrc: v.data['image'],
                              value: v,
                              text: ReCase(v.data['name']).titleCase,
                            ))
                        .toList(),
                    filter: (DocumentSnapshot value, String criteria) {
                      return value.data['name'].toLowerCase().trim().contains(
                          RegExp(r'' + criteria.toLowerCase().trim() + ''));
                    },
                    onSelect: (DocumentSnapshot value) {
                      cardItem.add(SaleItemCard(item: value));
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    onSubmit: (String value) =>
                        Navigator.of(context).pop(value),
                  ),
                );
              });
        });
  }

  _showMaterialSearch(BuildContext context, List<DocumentSnapshot> documents) {
    Navigator.of(context)
        .push(_buildMaterialSearchPage(context, documents))
        .then((dynamic value) {
      setState(() => _name = value as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: pinkColor,
        title: AutoSizeText(
          'List Calculate Money',
          minFontSize: 30.0,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              List<DocumentSnapshot> documents =
                  await Database().getAllCollection(
                collection: 'products',
                sortBy: 'name',
                order: false,
              );
              _showMaterialSearch(context, documents);
            },
          )
        ],
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: cardItem,
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
              heroTag: 's1',
              elevation: 5.0,
              onPressed: () async {
                List<DocumentSnapshot> servicesDocument = await Database()
                    .getAllCollection(
                        collection: 'services', order: false, sortBy: 'name');
                List<DocumentSnapshot> employeesDocument =
                    await Database().getAllCollection(
                  collection: 'employees',
                  order: false,
                  sortBy: 'role',
                );
                showDialog(
                    context: context,
                    builder: (_) {
                      return AddServices(
                          documentService: servicesDocument,
                          documentEmployees: employeesDocument);
                    });
              },
              child: Icon(
                Icons.add,
                size: 24.0,
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: pinkColor,
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
