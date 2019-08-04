import 'dart:convert';

import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

import 'connect_printer.dart';
import 'dialog/printe_not_found.dart';
import 'print_product.dart';
import 'print_service.dart';
import 'stock_screen.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/theme_colors.dart';
import 'total_calculate.dart';
import 'user_profile.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String bluetoothAddress;
  BluetoothConnection connection;
  int waitingSimpleNumber = 0;
  int waitingVIPNumber = 0;

  DateTime _endDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 1,
  );

  DateTime _startDate = DateTime.utc(
    DateTime.fromMicrosecondsSinceEpoch(0).year,
    DateTime.fromMicrosecondsSinceEpoch(0).month,
    DateTime.fromMicrosecondsSinceEpoch(0).day,
  );

  // @override
  // void dispose() {
  //   // Avoid memory leak (`setState` after dispose) and disconnect
  //   if (isConnected) {
  //     connection.dispose();
  //     connection = null;
  //     print('we are disconnecting locally!');
  //   }
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    // try {
    //   BluetoothConnection.toAddress('DC:0D:30:75:B3:C4').then(
    //     (_connection) {
    //       print('Connected to the device');
    //       connection = _connection;
    //     },
    //   );
    // } on PlatformException catch (e) {
    //   // PlatformException to be handled
    //   print(e);
    //   showDialog(
    //     context: context,
    //     builder: (_) {
    //       return PrinterNotFoundDialog();
    //     },
    //   );
    // }
  }

  bool get isConnected {
    return connection != null && connection.isConnected;
  }

  _sendMessage(String templateString) async {
    connection.output.add(
      utf8.encode(templateString),
    );
  }

  String waitingNumberFormatter(int number) {
    String prefixNum = '';
    int prefixAmount = 7 - number.toString().length;
    for (var i = 0; i < prefixAmount; i++) {
      prefixNum += '0';
    }
    return prefixNum + number.toString();
  }

  Widget sale() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ConfirmDeductFromStock(),
            ),
          );
        },
        heroTag: 's1',
        tooltip: 'sale',
        child: Icon(Icons.store),
      ),
    );
  }

  Widget service() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ListTotal(),
            ),
          );
        },
        backgroundColor: Colors.amber,
        heroTag: 's2',
        tooltip: 'service',
        child: Icon(Icons.content_cut),
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell(
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null
            ? () => onTap()
            : () {
                print('Not set yet');
              },
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.pinkAccent,
        title: Text(ReCase('dashboard').titleCase,
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return UserProfile();
                },
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ConnectPrinterScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ReCase('today earnings').titleCase,
                        style: font25Black,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('income')
                              .where('date', isGreaterThanOrEqualTo: _startDate)
                              .where('date', isLessThanOrEqualTo: _endDate)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              default:
                                return Text(
                                  'USD ' +
                                      ' ' +
                                      snapshot
                                          .data.documents.first.data['amount']
                                          .toString(),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 50.0,
                                  ),
                                );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ReCase('products sold').titleCase,
                        style: font25Black,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('products')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            default:
                              int soldNum = 0;
                              for (var i = 0;
                                  i < snapshot.data.documents.length;
                                  i++) {
                                soldNum +=
                                    snapshot.data.documents[i]['sold_out'];
                              }
                              return Text(
                                soldNum.toString(),
                                style: TextStyle(
                                  color: confirmColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 50.0,
                                ),
                              );
                          }
                        },
                      ),
                      Text(
                        'items',
                        style: font25Black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ReCase('products in use').titleCase,
                        style: font25Black,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('products')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            default:
                              int useNum = 0;
                              for (var i = 0;
                                  i < snapshot.data.documents.length;
                                  i++) {
                                useNum += snapshot.data.documents[i]['in_use'];
                              }
                              return Text(
                                useNum.toString(),
                                style: TextStyle(
                                  color: pinkColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 50.0,
                                ),
                              );
                          }
                        },
                      ),
                      Text(
                        'items',
                        style: font25Black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      ReCase('product').titleCase,
                                      style: TextStyle(
                                        color: Colors.blue[500],
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  RawMaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PrintProductScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.print,
                                      color: Colors.white,
                                      size: 35.0,
                                    ),
                                    shape: CircleBorder(),
                                    elevation: 2.0,
                                    fillColor: Colors.blue,
                                    padding: const EdgeInsets.all(15.0),
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('product_history')
                          .where('action', isEqualTo: 'sold')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            return snapshot.data.documents.length == 0
                                ? Center(
                                    child: Text(
                                      ReCase('no recent history.').sentenceCase,
                                    ),
                                  )
                                : ListView(
                                    children: snapshot.data.documents
                                        .map((DocumentSnapshot document) {
                                      return ListTile(
                                        title: Text(
                                          ReCase(
                                            document['name'],
                                          ).titleCase,
                                          style: font20Black,
                                        ),
                                        subtitle: Text(
                                          'sold:' +
                                              ' ' +
                                              ReCase(
                                                document['quantity'].toString(),
                                              ).titleCase,
                                          style: font15Grey,
                                        ),
                                        trailing: Text(
                                          'USD' +
                                              ' ' +
                                              (document['quantity'] *
                                                      document['price'])
                                                  .toString(),
                                          style: font20Black,
                                        ),
                                      );
                                    }).toList(),
                                  );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    ReCase('service').titleCase,
                                    style: TextStyle(
                                      color: Colors.blue[500],
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                RawMaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return PrintServiceScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.print,
                                    color: Colors.white,
                                    size: 35.0,
                                  ),
                                  shape: CircleBorder(),
                                  elevation: 2.0,
                                  fillColor: Colors.blue,
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('service_history')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            return snapshot.data.documents.length == 0
                                ? Center(
                                    child: Text(
                                      ReCase('no recent history.').sentenceCase,
                                    ),
                                  )
                                : ListView(
                                    children: snapshot.data.documents
                                        .map((DocumentSnapshot document) {
                                      return ListTile(
                                        title: Text(
                                          ReCase(
                                            document['name'],
                                          ).titleCase,
                                          style: font20Black,
                                        ),
                                        subtitle: Text(
                                          'QTY:' +
                                              ' ' +
                                              ReCase(
                                                document['quantity'].toString(),
                                              ).titleCase,
                                          style: font15Grey,
                                        ),
                                        trailing: Text(
                                          'USD' +
                                              ' ' +
                                              (document['quantity'] *
                                                      document['price'])
                                                  .toString(),
                                          style: font20Black,
                                        ),
                                      );
                                    }).toList(),
                                  );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ReCase('your waiting number is').sentenceCase,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    'VIP ' + (waitingVIPNumber + 1).toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 80.0,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/y').format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            onTap: isConnected
                ? () {
                    setState(() {
                      waitingVIPNumber = waitingVIPNumber + 1;
                    });
                    String waitingVIP = '\x1B@\x1DV1\r\n' +
                        '------------------------------------------------' +
                        '             Your waiting number is             ' +
                        '            VIP Customer No. ${waitingNumberFormatter(waitingVIPNumber)}            ' +
                        '        Date:  ${DateFormat.yMEd().add_jms().format(DateTime.now())}        ' +
                        '------------------------------------------------' +
                        '\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n' +
                        '\x1B@\x1DV1';
                    return _sendMessage(waitingVIP);
                  }
                : () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return PrinterNotFoundDialog();
                      },
                    );
                  },
          ),
          _buildTile(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ReCase('your waiting number is').sentenceCase,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    (waitingSimpleNumber + 1).toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 80.0,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/y').format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            onTap: isConnected
                ? () {
                    setState(() {
                      waitingSimpleNumber = waitingSimpleNumber + 1;
                    });
                    String waitingSimple = '\x1B@\x1DV1\r\n' +
                        '------------------------------------------------' +
                        '             Your waiting number is             ' +
                        '              Customer No. ${waitingNumberFormatter(waitingSimpleNumber)}              ' +
                        '        Date:  ${DateFormat.yMEd().add_jms().format(DateTime.now())}        ' +
                        '------------------------------------------------' +
                        '\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n' +
                        '\x1B@\x1DV1';
                    return _sendMessage(waitingSimple);
                  }
                : () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return PrinterNotFoundDialog();
                      },
                    );
                  },
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 200.0),
          StaggeredTile.extent(1, 200.0),
          StaggeredTile.extent(1, 200.0),
          StaggeredTile.extent(1, 450.0),
          StaggeredTile.extent(1, 450.0),
          StaggeredTile.extent(1, 219.0),
          StaggeredTile.extent(1, 219.0),
        ],
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: <Widget>[
          sale(),
          service(),
        ],
        colorStartAnimation: confirmColor,
        colorEndAnimation: removeColor,
        animatedIconData: AnimatedIcons.menu_close,
      ),
    );
  }
}
