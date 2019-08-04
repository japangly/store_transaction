import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import 'themes/helpers/theme_colors.dart';

class GridProductSale extends StatelessWidget {
  const GridProductSale({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        centerTitle: true,
        title: AutoSizeText(
          'Sale Product',
          minFontSize: 30.0,
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://groceries.morrisons.com/productImages/381/381011011_0_640x640.jpg?identifier=30dc1370e517daf1fe1b9b269ad5d13a',
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: AutoSizeText(
                          ReCase('Carabao green apple').titleCase,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                          minFontSize: 16.0,
                          maxFontSize: 128.0,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
