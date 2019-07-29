import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:store_transaction/print.dart';
import 'package:store_transaction/stock_screen.dart';
import 'package:store_transaction/themes/helpers/fonts.dart';
import 'package:store_transaction/themes/helpers/theme_colors.dart';
import 'package:store_transaction/total_calculate.dart';
import 'package:store_transaction/user_profile.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: blueColor,
        title: Text('Dashboard',
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
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          todayEarnings(
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
                        Text('Today Earnings', style: font25Black),
                        Text('\$2,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 50.0))
                      ],
                    ),
                  ]),
            ),
          ),
          history(
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
                                    Text('History',
                                        style: TextStyle(
                                            color: Colors.blue[500],
                                            fontSize: 25.0)),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  new RawMaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PrintScreen();
                                          },
                                        ),
                                      );
                                    },
                                    child: new Icon(
                                      Icons.print,
                                      color: Colors.white,
                                      size: 35.0,
                                    ),
                                    shape: new CircleBorder(),
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
                    child: ListView(children: <Widget>[
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Shampoo',
                              style: font20Black,
                            ),
                            subtitle: Text(
                              'sold: 20',
                              style: font15Grey,
                            ),
                            trailing: Text('\$200.0', style: font20Black),
                          ),
                          ListTile(
                            title: Text(
                              'Shampoo',
                              style: font20Black,
                            ),
                            subtitle: Text(
                              'used: 20',
                              style: font15Grey,
                            ),
                            trailing: Text('\$0.0', style: font20Black),
                          ),
                          ListTile(
                            title: Text(
                              'Nail Cut',
                              style: font20Black,
                            ),
                            subtitle: Text(
                              'qty: 1',
                              style: font15Grey,
                            ),
                            trailing: Text('\$10.0', style: font20Black),
                          ),
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
          productInUse(
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
                        Text('Products Sold', style: font25Black),
                        Text('2000',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 50.0)),
                        Text('items', style: font25Black),
                      ],
                    ),
                  ]),
            ),
          ),
          vipQueue(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('សម្រាប់ភ្ញៀវពិសេស',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0)),
                    Text('លេខរង់ចាំរបស់អ្នកគឺ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0)),
                    Text('1',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 80.0)),
                    Text('27/09/2019',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0)),
                  ]),
            ),
          ),
          normalQueue(
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('លេខរង់ចាំរបស់អ្នកគឺ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0)),
                    Text('1',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 80.0)),
                    Text('27/09/2019',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0)),
                  ]),
            ),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 200.0),
          StaggeredTile.extent(1, 410.0),
          StaggeredTile.extent(1, 200.0),
          StaggeredTile.extent(1, 250.0),
          StaggeredTile.extent(1, 250.0),
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
        heroTag: "s1",
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
        heroTag: "s2",
        tooltip: 'service',
        child: Icon(Icons.content_cut),
      ),
    );
  }

  Widget normalQueue(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  Widget productInUse(Widget child, {Function() onTap}) {
    return Material(
        color: Colors.orange,
        elevation: 14.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  Widget vipQueue(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  Widget history(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }

  Widget todayEarnings(Widget child, {Function() onTap}) {
    return Material(
        color: Colors.lightBlueAccent,
        elevation: 14.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
