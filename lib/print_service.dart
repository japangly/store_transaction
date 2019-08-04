import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/simple_line_icons.dart';

import 'dialog/print_service_dialog.dart';
import 'themes/helpers/buttons.dart';
import 'themes/helpers/fonts.dart';
import 'themes/helpers/theme_colors.dart';

class PrintServiceScreen extends StatefulWidget {
  @override
  _PrintServiceScreenState createState() => _PrintServiceScreenState();
}

class _PrintServiceScreenState extends State<PrintServiceScreen> {
  DateTime _startDate;
  DateTime _endDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
          title: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Service Report',
                  style: font20White,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    SimpleLineIcons.getIconData("printer"),
                    color: Colors.blue,
                    size: 100.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Choose a date!",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2019, 1, 1),
                                onChanged: (date) {}, onConfirm: (date) {
                              setState(() {
                                _startDate = DateTime.utc(
                                  date.year,
                                  date.month,
                                  date.day,
                                );
                                _endDate = DateTime.utc(
                                  date.year,
                                  date.month,
                                  date.day + 1,
                                );
                              });
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return PrintServiceDialog(
                                      setDate: _startDate,
                                      endDate: _endDate,
                                    );
                                  });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          textButton: 'Another Day',
                          colorButton: cancelColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                          onPressed: () {
                            setState(() {
                              _startDate = DateTime.utc(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              );
                            });
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return PrintServiceDialog(
                                    setDate: _startDate,
                                    endDate: DateTime.now(),
                                  );
                                });
                          },
                          textButton: 'Today',
                          colorButton: blueColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
