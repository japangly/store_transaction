import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ServicePriceCard extends StatefulWidget {
  final String serviceName;
  final String makerName;
  final String price;
  const ServicePriceCard({
    Key key,
    @required this.serviceName,
    @required this.makerName,
    @required this.price,
  }) : super(key: key);

  @override
  _ServicePriceCardState createState() => _ServicePriceCardState();
}

class _ServicePriceCardState extends State<ServicePriceCard> {
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
                padding: const EdgeInsets.fromLTRB(0.0, 128.0, 0.0, 64.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(128.0, 16.0, 128.0, 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: AutoSizeText(
                            widget.serviceName,
                            minFontSize: 36.0,
                            maxFontSize: 256.0,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: AutoSizeText(
                            'Head & Hair',
                            minFontSize: 24.0,
                            maxFontSize: 256.0,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 42.0),
                          child: AutoSizeText(
                            widget.makerName,
                            minFontSize: 24.0,
                            maxFontSize: 256.0,
                          ),
                        ),
                        AutoSizeText(
                          'Price',
                          minFontSize: 24.0,
                          maxFontSize: 256.0,
                          style: TextStyle(color: Colors.grey),
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
                                widget.price,
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 5.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                child: Image.network(
                  'https://sleepmatters.ie/wp-content/uploads/2018/05/Child-Bath-Every-Night.jpg',
                  height: 230.0,
                  width: 230.0,
                  fit: BoxFit.fitHeight,
                  scale: 30.0,
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
