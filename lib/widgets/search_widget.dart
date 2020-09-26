import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:weather_app/styles.dart';
import 'package:weather_app/widgets/search_city_dialog.dart';

class SearchWidget extends StatelessWidget {
  final _textInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          FlutterI18n.translate(context, "main_page.favorite_loc"),
          style: bodyLabelTextStyle,
        ),
        const Divider(color: greyColor),
        Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
                controller: _textInputController,
                style: TextStyle(color: primaryColor),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    hintText:
                        FlutterI18n.translate(context, "main_page.search_hint"),
                    suffixIcon: IconButton(
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SearchCityDialog(
                                  _textInputController.text);
                            });
                      },
                      icon: const Icon(Icons.search,
                          color: primaryColor, size: 24),
                    ),
                    filled: true,
                    fillColor: Colors.white))),
      ],
    );
  }
}
