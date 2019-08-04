import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:recase/recase.dart';
import 'package:store_transaction/functions/database.dart';

import '../env.dart';
import '../themes/helpers/buttons.dart';
import '../themes/helpers/theme_colors.dart';

const String defaultHtml =
    '<!DOCTYPE html><div lang="en"> <head> <meta charset="UTF-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <meta http-equiv="X-UA-Compatible" content="ie=edge"> <title>Document</title> </head> <style> @media print { table { page-break-after: auto } tr { page-break-inside: avoid; page-break-after: auto } td { page-break-inside: avoid; page-break-after: auto } thead { display: table-header-group } tfoot { display: table-footer-group } } body { margin: 2em; } table, td, th { border: 1px solid #ddd; text-align: left; } table { border-collapse: collapse; width: 100%; } th, td { padding: 15px; } </style> <body>';

const String htmlPaperTitle =
    '<tfoot style="margin: 100px;"> <tr> <td></td> </tr> </tfoot> <tr> <td> <div></div> </td> </tr> <tr> <td> <div></div> </td> </tr> <table>';

const String htmlTableTitle =
    '<tr> <th>No.</th> <th>Product</th> <th>Category</th> <th>Quantity</th> <th>Description</th> <th>Employee</th> </tr>';

class PrintServiceDialog extends StatelessWidget {
  const PrintServiceDialog({
    Key key,
    @required this.setDate,
    @required this.endDate,
  }) : super(key: key);

  final DateTime endDate;
  final DateTime setDate;

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
                      'You are printing a report of $setDate',
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
                            String date = DateFormat('yMMMMEEEEd')
                                .format(setDate)
                                .toString();
                            String htmlHeader =
                                '<thead> <tr> <th>Date: $date</th> </tr> </thead> <h2>Mickey Salon Daily Report</h2> <p>The report is about the in-going and out-going of the Mickey Salon.</p>';
                            String htmlFooter =
                                ' </table> <div style="margin-top: 50px;"></div> <div style="display: flex; justify-content: space-around"> <div></div> <div></div> <div></div> <div> <p>Salon Administrator Signature</p> <div style="margin-top: 100px;"></div> <p>Date: $date</p> </div> </div> </body></div>';
                            String result = '';

                            List<DocumentSnapshot> documents = await Database()
                                .getHistoryProduction(
                                    collection: 'product_history',
                                    field: 'date',
                                    dateTime: Timestamp.fromDate(setDate),
                                    endDate: Timestamp.fromDate(endDate));

                            if (documents != null) {
                              for (int i = 0; i < documents.length; i++) {
                                DocumentSnapshot document =
                                    await Database().getCollectionByField(
                                  collection: 'employees',
                                  field: 'uid',
                                  value: documents[i].data['uid'],
                                );
                                int no = i + 1;
                                result +=
                                    '<tr> <td>${ReCase(no.toString()).titleCase}</td> <td>${ReCase(documents[i].data['product name'].toString()).titleCase}</td> <td>${ReCase(documents[i].data['product category'].toString()).titleCase}</td> <td>${ReCase(documents[i].data['quantity'].toString()).titleCase}</td> <td>${ReCase(documents[i].data['action'].toString()).titleCase}</td> <td>${ReCase(document['first name'].toString()).titleCase} ${ReCase(document['last name'].toString()).titleCase}</td> </tr>';
                              }
                            }
                            await Printing.layoutPdf(
                              onLayout: (PdfPageFormat format) async {
                                return await Printing.convertHtml(
                                  format: format,
                                  html: defaultHtml +
                                      htmlHeader +
                                      htmlPaperTitle +
                                      htmlTableTitle +
                                      result +
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
