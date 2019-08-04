import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'env.dart';
import 'themes/helpers/theme_colors.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

String _selectedName = 'Ok';
String _selectedService = 'OK';
List<String> _listService = ['Ok', 'Ok', 'Ok', 'Ok'];
List<String> _listEmployee = [
  'Ok',
  'Ok',
  'Ok',
  'Ok',
];
int _count = 1;

class _AddServiceState extends State<AddService> {
  void _addNewContactRow() {
    setState(() {
      _count = _count + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _contatos = List.generate(_count, (int i) => ListStaff());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: pinkColor,
        title: AutoSizeText(
          'Service',
          minFontSize: 30.0,
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: Environment().getWidth(width: 24.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                'Service Name',
                                minFontSize: 24.0,
                              ),
                              Container(
                                width: double.infinity,
                                child: DropdownButton<String>(
                                  hint: AutoSizeText(
                                    _selectedService,
                                    minFontSize: 24.0,
                                  ),
                                  items: _listService.map((String value) {
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
                                      _selectedService = selected;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    AutoSizeText(
                                      'Staff Name',
                                      minFontSize: 24.0,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: confirmColor,
                                      ),
                                      onPressed: _addNewContactRow,
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: ListView(
                                    children: _contatos,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                padding: const EdgeInsets.fromLTRB(
                                    32.0, 16.0, 32.0, 16.0),
                                color: pinkColor,
                                child: AutoSizeText(
                                  'ADD',
                                  minFontSize: 24.0,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ListStaff extends StatefulWidget {
  const ListStaff({
    Key key,
  }) : super(key: key);

  @override
  _ListStaffState createState() => _ListStaffState();
}

class _ListStaffState extends State<ListStaff> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: DropdownButton<String>(
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
    );
  }
}
