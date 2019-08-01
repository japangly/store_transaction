import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store_transaction/service_card.dart';
import 'package:store_transaction/total_calculate.dart';

import '../env.dart';
import '../themes/helpers/fonts.dart';
import '../themes/helpers/theme_colors.dart';

String _selectedService = 'SERVICE';
String _selectedName = 'PERSON NAME';

class AddServices extends StatefulWidget {
  AddServices(
      {Key key,
      @required this.documentService,
      @required this.documentEmployees})
      : super(key: key);

  final List<DocumentSnapshot> documentEmployees;
  final List<DocumentSnapshot> documentService;

  @override
  _AddServicesState createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  List<String> _listEmployee = [];
  List<String> _listService = [];

  @override
  void initState() {
    super.initState();

    for (int service = 0; service < widget.documentService.length; service++) {

      setState(() {
        String servicename = widget.documentService[service].data['name'];
        _listService.add(servicename);
      });
    }

    for (int employee = 0;
        employee < widget.documentService.length;
        employee++) {
      String employName =
          '${widget.documentEmployees[employee].data['last name']} ${widget.documentEmployees[employee].data['first name']}';
      _listEmployee.add(employName);
      // _listEmployee = List.from(employName);
    }
    setState(() {
      _listService.sort();
      _listEmployee.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding: const EdgeInsets.only(
          top: 64.0, right: 64.0, left: 64.0, bottom: 64.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 12.0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  AutoSizeText(
                    "Add Service",
                    minFontSize: 32.0,
                    maxFontSize: 128.0,
                    style: font20Black,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
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
              Padding(
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
                      padding:
                          const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                      color: pinkColor,
                      child: AutoSizeText(
                        'ADD',
                        minFontSize: 24.0,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: addCardService,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addCardService() {
    if (_selectedName != 'PERSON NAME' && _selectedService != 'SERVICE') {
      List<String> name = _selectedName.split(" ");
      String _lname = name[0];
      String _fname = name[1];

      DocumentSnapshot _documentService;
      DocumentSnapshot _documentEmployee;

      for (int doc = 0; doc < widget.documentService.length; doc++) {
        if (widget.documentService[doc].data['name'] == _selectedService) {
          setState(() {
            _documentService = widget.documentService[doc];
          });
        }
      }

      for (int em = 0; em < widget.documentEmployees.length; em++) {
        if (widget.documentEmployees[em].data['last name'] == _lname &&
            widget.documentEmployees[em].data['first name'] == _fname) {
          setState(() {
            _documentEmployee = widget.documentEmployees[em];
          });
        }
      }
      setState(() {
        addService.add(ServicePriceCard(
          documentService: _documentService,
          documentEmployee: _documentEmployee,
        ));
        // ListTotal();
        Navigator.of(context, rootNavigator: true).pop('');
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _listEmployee = [];
    _listService = [];
  }
}
