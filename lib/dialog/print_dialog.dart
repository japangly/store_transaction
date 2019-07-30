import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../env.dart';
import '../functions/firebase_firestore.dart';
import '../themes/helpers/buttons.dart';
import '../themes/helpers/theme_colors.dart';

class PrintDialog extends StatefulWidget {
  const PrintDialog({Key key, @required this.setDate, @required this.endDate})
      : super(key: key);

  final DateTime setDate;
  final DateTime endDate;

  @override
  _PrintDialogState createState() => _PrintDialogState();
}

class _PrintDialogState extends State<PrintDialog> {
  static const String htmlFooter =
      ' </tbody> <tfoot> </tfoot> </table></body><div class="space"></div><p align="center">Please Sign Here</p><div class="rectangle"></div></html>';

  static const String htmlHeader =
      '<!DOCTYPE html><html><head> <style> .rectangle { height: 128px; width: 50%; border-style: solid; border-color: #707B7C; border-radius: 25px; margin: 0 auto; } .space { height: 32px; width: 50%; background-color: #fff; } tfoot { display: table-footer-group; vertical-align: middle; border-color: inherit; } @page { margin: 2mm } table, td, th { border: 1px solid #566573; text-align: left; } table { font-size:1vw; border-collapse: collapse; width: 100%; } th, td { padding: 15px; } .header, .header-space, .footer, .footer-space { height: 10px; } .header { position: fixed; top: 0; } .footer { position: fixed; bottom: 10; } </style></head><body>';

  static const String htmlPaperTitle =
      '<body> <h2>Mickey and Honey Salon</h2> <h3>Daily Stock Report</h3> <p>Date: </p> <table> <thead>';

  static const String htmlTableTitle =
      ' <th>No.</th> <th>Product Name</th> <th>Quantity</th> <th>Action</th> <th>Action Description</th> <th>Employee ID</th> <th>Employee Name</th> <th>Date</th> </tr> </thead> <tbody class="content">';

  Future<String> getReportData() async {
    String result = '';

    List<DocumentSnapshot> documents = await Database().getHistoryProduction(
        collection: 'product_history',
        field: 'date',
        dateTime: Timestamp.fromDate(widget.setDate),
        endDate: Timestamp.fromDate(widget.endDate));

    if (documents != null) {
      for (int i = 0; i < documents.length; i++) {
        var date = DateFormat('d MMM y HH:mm a')
            .format(documents[i].data['date of birth'].toDate())
            .toString();
        print('print date' + documents[i].data['date'].toString());
        print('date format' + date);
        result +=
            '<tr> <td>${i++}</td> <td>${documents[i].data['product name']}</td> <td>${documents[i].data['quantity']}</td> <td>Sale</td> <td>Sale to customer</td> <td>${documents[i].data['employee id']}</td> <td>${documents[i].data['employee last name']}+'
            '+ ${documents[i].data['employee first name']} </td> <td>${documents[i].data['date']}</td> </tr>';
      }
    } else {
      result += '';
    }
    print('result ' + result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      contentPadding:
          const EdgeInsets.only(top: 20.0, right: 20, left: 20, bottom: 10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Container(
          width: Environment().getWidth(width: 13),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Ionicons.getIconData("md-paper"),
                    color: Colors.blue,
                    size: 70.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'You are printing a report of ${widget.setDate}',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomButton(
                          onPressed: () async {
                            await Printing.layoutPdf(
                              onLayout: (PdfPageFormat format) async {
                                return await Printing.convertHtml(
                                  format: format,
                                  html: htmlHeader +
                                      htmlPaperTitle +
                                      htmlTableTitle +
                                      await getReportData() +
                                      htmlFooter,
                                );
                              },
                            );
                          },
                          textButton: 'Print',
                          colorButton: confirmColor,
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
